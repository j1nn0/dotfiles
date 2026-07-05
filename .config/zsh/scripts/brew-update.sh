#!/usr/bin/env bash
set -Eeuo pipefail

BREW_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/brew"
mkdir -p "$BREW_CACHE_DIR"

BREW_UPDATE_FLAG="$BREW_CACHE_DIR/update_$(date +%Y-%m-%d)"
BREW_LOG="$BREW_CACHE_DIR/update.log"

trap 'notify_error $LINENO "$BASH_COMMAND"' ERR

notify_error() {
    set +e
    {
        echo "Update failed at $(date '+%Y-%m-%d %H:%M:%S %Z')"
        echo "Error at line $1: $2"
    } >>"$BREW_LOG"

    if command -v terminal-notifier >/dev/null 2>&1; then
        terminal-notifier \
            -title "Homebrew" \
            -message "Update failed. Check log." \
            -open "file://$BREW_LOG"
    fi

    exit 1
}

# 古いログ削除
find "$BREW_CACHE_DIR" -type f -name "update_*" -mtime +30 -delete
find "$BREW_CACHE_DIR" -type f -name "*.log" -mtime +30 -delete

if [[ ! -f "$BREW_UPDATE_FLAG" ]]; then
    : >"$BREW_LOG"

    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "brew not found" >>"$BREW_LOG"
        exit 1
    fi

    echo "[brew] Running update in background..."

    nohup bash <<EOF >>"$BREW_LOG" 2>&1 &
set -Eeuo pipefail

BREW_LOG="$BREW_LOG"

log() {
  echo "\$@" >>"\$BREW_LOG"
}

notify_error() {
  set +e
  log "Background update failed at \$(date '+%Y-%m-%d %H:%M:%S %Z')"

  if command -v terminal-notifier >/dev/null 2>&1; then
    terminal-notifier \
      -title "Homebrew" \
      -message "Update failed. Check log." \
      -open "file://\$BREW_LOG"
  fi

  exit 1
}

trap notify_error ERR

log "----------------------------------------"
log "Update started at \$(date '+%Y-%m-%d %H:%M:%S %Z')"

brew update >>"\$BREW_LOG" 2>&1

OUTDATED=\$(brew outdated 2>>"\$BREW_LOG" || true)

log "\$OUTDATED"

if [[ -z "\$OUTDATED" ]]; then
  MSG="All formulae are up-to-date 🎉"

  if command -v terminal-notifier >/dev/null 2>&1; then
    terminal-notifier \
      -title "Homebrew Update" \
      -message "\$MSG"
  fi
else
  COUNT=\$(echo "\$OUTDATED" | wc -l | tr -d ' ')
  MSG="Outdated (\$COUNT):"
  MSG+="
\$OUTDATED"

  if command -v terminal-notifier >/dev/null 2>&1; then
    terminal-notifier \
      -title "Homebrew" \
      -message "\$MSG" \
      -execute "zsh -c \$ZDOTDIR/scripts/brew-upgrade.sh"
  fi
fi

log "Update finished at \$(date '+%Y-%m-%d %H:%M:%S %Z')"
EOF

    disown

    touch "$BREW_UPDATE_FLAG"

fi
