eval "$(sheldon source)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

fastfetch

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    "$XDG_CONFIG_HOME/zsh/brew-update.sh"
fi
