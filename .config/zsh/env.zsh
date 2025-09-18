export LANG=ja_JP.UTF-8
export EDITOR="code -w"

# history
#export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# homebrew
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"

export GREP_COLOR="1;33"
#export DOCKER_DEFAULT_PLATFORM=linux/amd64
#export LOCAL_HOST_IP=$(ifconfig en0 | grep inet | grep -v inet6 | sed -E "s/inet ([0-9]{1,3}.[0-9]{1,3}.[0-9].{1,3}.[0-9]{1,3}) .*$/\1/" | tr -d "\t")

# mise-php
# 依存パッケージ：brew install libsodium gpg git tmux neovim htop curl wget re2c bison zlib libgd libiconv oniguruma bzip2 readline libedit tidy-html5 openssl libzip libxml2 pkgconf autoconf libpq argon2
export PHP_CONFIGURE_OPTIONS="--with-zlib-dir=$(brew --prefix zlib) --with-bz2=$(brew --prefix bzip2) --with-readline=$(brew --prefix readline) --with-libedit=$(brew --prefix libedit) --with-tidy=$(brew --prefix tidy-html5) --with-iconv=$(brew --prefix libiconv) --with-openssl=$(brew --prefix openssl@3.0) --with-curl=$(brew --prefix curl) --with-password-argon2=$(brew --prefix argon2)"

# Gemini
#export GEMINI_API_KEY=""

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6d189'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#a6d189'
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6d189'
ZSH_HIGHLIGHT_STYLES[function]='fg=#a6d189'

# PATH
typeset -U path PATH
export path=(
    $HOME/.rd/bin
    # mise-php依存
    $(brew --prefix bison)/bin
    $(brew --prefix icu4c)/bin
    $(brew --prefix icu4c)/sbin
    # brewコマンドを優先
    $(brew --prefix mysql-client@8.0)/bin
    $(brew --prefix openssl@3.0)/bin
    $(brew --prefix zip)/bin
    $(brew --prefix unzip)/bin
    $(brew --prefix curl)/bin
    $(brew --prefix gzip)/bin
    # Unix(BSD)コマンドよりLinux(GNU)コマンドを優先
    # https://qiita.com/kkdd/items/e9c8b46a89dea7862661
    # https://qiita.com/eumesy/items/3bb39fc783c8d4863c5f
    #$(brew --prefix grep)/libexec/gnubin
    #$(brew --prefix gnu-tar)/libexec/gnubin
    #$(brew --prefix gnu-sed)/libexec/gnubin
    #$(brew --prefix gawk)/libexec/gnubin
    #$(brew --prefix findutils)/libexec/gnubin
    $path
)
typeset -U manpath MANPATH
export manpath=(
    #$(brew --prefix grep)/libexec/gnuman
    #$(brew --prefix gnu-tar)/libexec/gnuman
    #$(brew --prefix gnu-sed)/libexec/gnuman
    #$(brew --prefix gawk)/libexec/gnuman
    #$(brew --prefix findutils)/libexec/gnuman
    /usr/share/man
    /usr/local/share/man
    $manpath
)
