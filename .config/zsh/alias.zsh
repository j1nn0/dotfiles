## Modern Alternatives of Command-Line Tools
alias ls='eza --icons --time-style=long-iso -g --header --git -o'
alias du='dust'
alias top='btm'
alias tree='eza --icons --tree'

## ls
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

## vim
alias vi='nvim'
alias vim='nvim'

# gron
alias norg="gron --ungron"
alias ungron="gron --ungron"

# git
## 直前のコミットをなかったことにする。
alias git-reset='git reset --soft HEAD^'

# python
alias python='python3'
alias pip='pip3'

# rancher desktop
alias rdstart='rdctl start --application.start-in-background'
alias rdstop='rdctl shutdown'

# tmux
alias tmux='tmux attach-session || tmux'

## other
alias history='history -iD'
alias h='cd ~'
alias c='clear'
alias npm-list-global="npm list -g --json | jq -r '.dependencies|keys|join(\" \")'"
alias 7z='7zz'
alias finder-kill='killall Finder'
alias diff='diff -u --color'
alias zshrc='code ~/.zshrc'
alias ff='fastfetch'
alias myip="curl -s https://ipinfo.io/json"
alias sqlite="sqlite3"
