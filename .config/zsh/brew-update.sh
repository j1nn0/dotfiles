#!/usr/bin/env bash
set -euo pipefail

BREW_CACHE_DIR="$XDG_CACHE_HOME/brew"
mkdir -p "$BREW_CACHE_DIR"

# 古いフラグ・ログを自動削除（30日以上前）
find "$BREW_CACHE_DIR" -type f -name "update_*" -mtime +30 -delete
find "$BREW_CACHE_DIR" -type f -name "update.log" -mtime +30 -delete
find "$BREW_CACHE_DIR" -type f -name "upgrade.log" -mtime +30 -delete

BREW_UPDATE_FLAG="$BREW_CACHE_DIR/update_$(date +%Y-%m-%d)"
BREW_LOG="$BREW_CACHE_DIR/update.log"

if [[ ! -f "$BREW_UPDATE_FLAG" ]]; then
    echo "[brew] Running update in background..."
    nohup bash -c "
        brew update >\"$BREW_LOG\" 2>&1
        OUTDATED=\$(brew outdated)
        echo \"\$OUTDATED\" >>\"$BREW_LOG\"

        if [[ -z \"\$OUTDATED\" ]]; then
            MSG='All formulae are up-to-date 🎉'
        else
            COUNT=\$(echo \"\$OUTDATED\" | wc -l | tr -d ' ')
            SUMMARY=\$(echo \"\$OUTDATED\" | head -n 5)
            if (( COUNT > 5 )); then
                SUMMARY=\"\$SUMMARY\"$'\n'\"... and \$((COUNT - 5)) more\"
            fi
            MSG=\"Outdated (\$COUNT):\"$'\n'\"\$SUMMARY\"
        fi

        terminal-notifier \
            -title 'Homebrew' \
            -message \"\$MSG\" \
            -open \"file://$BREW_LOG\"
    " >/dev/null 2>&1 & disown

    touch "$BREW_UPDATE_FLAG"
fi
