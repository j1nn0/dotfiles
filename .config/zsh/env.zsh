export LANG=ja_JP.UTF-8
export EDITOR="code -w"

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# homebrew
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"
export HOMEBREW_EDITOR="code"

export GREP_COLOR="1;33"
export DOCKER_DEFAULT_PLATFORM=linux/amd64
export LOCAL_HOST_IP=$(ifconfig en0 | grep inet | grep -v inet6 | sed -E "s/inet ([0-9]{1,3}.[0-9]{1,3}.[0-9].{1,3}.[0-9]{1,3}) .*$/\1/" | tr -d "\t")

typeset -U path PATH
export path=(
    $(brew --prefix mysql-client@8.0)/bin
    $(brew --prefix openssl@3.0)/bin
    $(brew --prefix zip)/bin
    $(brew --prefix unzip)/bin
    $(brew --prefix curl)/bin
    $(brew --prefix gzip)/bin
    # Unix(BSD)コマンドよりLinux(GNU)コマンドを優先
    # https://qiita.com/kkdd/items/e9c8b46a89dea7862661
    # https://qiita.com/eumesy/items/3bb39fc783c8d4863c5f
    $(brew --prefix grep)/libexec/gnubin
    $(brew --prefix gnu-tar)/libexec/gnubin
    $(brew --prefix gnu-sed)/libexec/gnubin
    $(brew --prefix gawk)/libexec/gnubin
    $(brew --prefix findutils)/libexec/gnubin
    $path
)
typeset -U manpath MANPATH
export manpath=(
    $(brew --prefix grep)/libexec/gnuman
    $(brew --prefix gnu-tar)/libexec/gnuman
    $(brew --prefix gnu-sed)/libexec/gnuman
    $(brew --prefix gawk)/libexec/gnuman
    $(brew --prefix findutils)/libexec/gnuman
    /usr/share/man
    /usr/local/share/man
    $manpath
)
