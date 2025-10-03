#!/usr/bin/env bash
set -euo pipefail

BREW_CACHE_DIR="$XDG_CACHE_HOME/brew"
mkdir -p "$BREW_CACHE_DIR"

# 古いログを自動削除（30日以上前）
find "$BREW_CACHE_DIR" -type f -name "upgrade_*.log" -mtime +30 -delete

# 日付ごとにログファイル（時刻付き）
LOG_FILE="$BREW_CACHE_DIR/upgrade_$(date +%Y%m%d_%H%M).log"

# brew upgrade 実行 & ログ保存
brew upgrade >"$LOG_FILE" 2>&1

# 完了通知（ログファイル名を表示）
terminal-notifier \
  -title "Homebrew Upgrade" \
  -message "Upgrade finished. Log saved to: $(basename "$LOG_FILE")" \
  -group "brew-upgrade-finished"
