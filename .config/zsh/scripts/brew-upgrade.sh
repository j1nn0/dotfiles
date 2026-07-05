#!/usr/bin/env bash
set -Eeuo pipefail

BREW_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/brew"
mkdir -p "$BREW_CACHE_DIR"

# ログファイル
BREW_LOG="$BREW_CACHE_DIR/update.log"

# エラーが発生したらnotify_error関数を呼び出す
trap 'notify_error $LINENO "$BASH_COMMAND"' ERR

notify_error() {
    set +e
    echo "Upgrade failed at $(date '+%Y-%m-%d %H:%M:%S %Z')" >>"$BREW_LOG"
    echo "Error at line $1: $2" >>"$BREW_LOG"

    if command -v terminal-notifier >/dev/null 2>&1; then
        terminal-notifier \
            -title "Homebrew" \
            -message "Upgrade failed. Check log." \
            -open "file://$BREW_LOG"
    fi

    exit 1
}

# brew upgrade 実行 & ログ保存
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "brew not found at /opt/homebrew/bin/brew" >>"$BREW_LOG"
    exit 1
fi

export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"

{
    echo "----------------------------------------"
    echo "Upgrade started at $(date '+%Y-%m-%d %H:%M:%S %Z')"
    brew upgrade -y
    echo "Upgrade finished at $(date '+%Y-%m-%d %H:%M:%S %Z')"
} >>"$BREW_LOG" 2>&1

# 完了通知（ログファイルを表示）
if command -v terminal-notifier >/dev/null 2>&1; then
    terminal-notifier \
        -title "Homebrew" \
        -message "Upgrade finished." \
        -open "file://$BREW_LOG"
fi
