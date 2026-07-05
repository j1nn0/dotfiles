#!/usr/bin/env bash
set -euo pipefail

# aicommit2 がインストールされているか確認
if ! command -v "aicommit2" >/dev/null 2>&1; then
    echo "aicommit2 is required"
    exit 1
fi

# ステージングされた変更があるか確認
if git diff --cached --quiet; then
    if git diff --quiet; then
        echo "No changes found." >&2
    else
        echo "No staged changes found." >&2
    fi
    exit 1
fi

aicommit2 --output json
