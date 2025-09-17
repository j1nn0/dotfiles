eval "$(sheldon source)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

fastfetch

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    brew update && brew outdated
fi
