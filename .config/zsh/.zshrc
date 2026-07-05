eval "$(sheldon source)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    "$ZDOTDIR/scripts/brew-update.sh"
fi

if [[ -z "$TMUX" && -z "$ZELLIJ" ]]; then
    fastfetch
    check_directory_for_new_repository
    #ccusage daily -s "$(TZ=JST-9 date -v-1d '+%Y%m%d')" --compact
fi
