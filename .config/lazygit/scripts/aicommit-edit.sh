#!/usr/bin/env bash
set -Eeuo pipefail

MSG="${1:-}"

SUBJ="${MSG%%<SEP>*}"
BODY="${MSG#*<SEP>}"

if [[ "$BODY" == "$MSG" ]]; then
    BODY=""
fi

TMP="$(mktemp "${TMPDIR:-/tmp}/lazygit-commit.XXXXXX")"
trap 'rm -f "$TMP"' EXIT

{
    printf '%s\n' "$SUBJ"
    if [[ -n "$BODY" ]]; then
        printf '\n%s\n' "$BODY"
    fi
} >"$TMP"

EDITOR_CMD="${VISUAL:-${EDITOR:-vi}}"
read -r -a EDITOR_ARGS <<<"$EDITOR_CMD"

"${EDITOR_ARGS[@]}" "$TMP"

if [[ ! -s "$TMP" ]] || ! grep -q '[^[:space:]]' "$TMP"; then
    echo "Commit cancelled: empty message"
    exit 1
fi

git commit -F "$TMP"
