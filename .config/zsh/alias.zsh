## Modern Alternatives of Command-Line Tools
alias ls='eza --icons -gho --time-style=long-iso --git --group-directories-first --color=always'
alias du='dust'
alias eza-tree='eza --icons --tree --git-ignore'

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

# zoxide
alias zz='z'
#alias zi='zi'
alias za='zoxide add'
alias zq='zoxide query'
alias zr='zoxide remove'

## other
alias history='history -iD'
alias h='cd ~'
alias c='clear'
alias npm-list-global="npm list -g --json | jq -r '.dependencies|keys|join(\" \")'"
alias 7z='7zz'
alias finder-kill='killall Finder'
alias diff='diff -u --color'
alias ff='fastfetch'
alias of='onefetch'
alias myip="curl -s https://ipinfo.io/json"
alias sqlite="sqlite3"
alias env-path="echo \$PATH | tr ':' '\n'"
alias brew-dump="brew bundle dump --global --force"
alias grep='grep --color=always'
alias grep-ver='\grep -o -E "([0-9]+\.){1}[0-9]+(\.[0-9]+)?$"'
alias mise-update='mise up --interactive'
alias caffeinate='caffeinate -dimsu'

alias zprofile='zed ${ZDOTDIR}/.zprofile'
alias zshrc='zed ${ZDOTDIR}/.zshrc'
alias dotfiles='zed ${HOME}/Repos/j1nn0.github/dotfiles/'
alias dotconfig='zed ${XDG_CONFIG_HOME}'
alias hosts='bat /etc/hosts'

# alias.local.zshを呼び出す
if [ -f ${ZDOTDIR:-$HOME}/alias.local.zsh ]; then
    source ${ZDOTDIR:-$HOME}/alias.local.zsh
fi
