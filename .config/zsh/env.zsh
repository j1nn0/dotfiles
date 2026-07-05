export LANG=ja_JP.UTF-8
export EDITOR="zed -w"
export GIT_EDITOR="zed -w"

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
# 依存パッケージ：brew install argon2 autoconf bison bzip2 curl git gpg htop libgd libiconv libpq libxml2 libzip libsodium neovim oniguruma openssl pkgconf readline re2c tidy-html5 tmux wget zlib icu4c
export PHP_CONFIGURE_OPTIONS="
--with-zlib=$(brew --prefix zlib)
--with-bz2=$(brew --prefix bzip2)
--with-readline=$(brew --prefix readline)
--with-tidy=$(brew --prefix tidy-html5)
--with-iconv=$(brew --prefix libiconv)
--with-openssl=$(brew --prefix openssl@3)
--with-curl=$(brew --prefix curl)
--with-password-argon2=$(brew --prefix argon2)
--with-sodium=$(brew --prefix libsodium)
--with-zip
--enable-intl
--enable-gd
--with-freetype
--with-jpeg
--with-webp
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
"
export PKG_CONFIG_PATH="$(brew --prefix icu4c)/lib/pkgconfig:$(brew --prefix libzip)/lib/pkgconfig:$PKG_CONFIG_PATH"

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6d189'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#a6d189'
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6d189'
ZSH_HIGHLIGHT_STYLES[function]='fg=#a6d189'

# PATH
typeset -U path PATH
export path=(
    $HOME/.local/bin
    $HOME/.uv-tools/.venv/bin
    $HOME/.rd/bin
    $HOME/.cargo/bin
    # mise-php依存
    $(brew --prefix bison)/bin
    $(brew --prefix icu4c)/bin
    $(brew --prefix icu4c)/sbin
    # brewコマンドを優先
    #$(brew --prefix mysql-client@8.0)/bin
    $(brew --prefix openssl@3.0)/bin
    $(brew --prefix zip)/bin
    $(brew --prefix unzip)/bin
    $(brew --prefix curl)/bin
    $(brew --prefix gzip)/bin
    $path
)
typeset -U manpath MANPATH
export manpath=(
    /usr/share/man
    /usr/local/share/man
    $manpath
)

# AI
export CONTEXT7_API_KEY=""
export OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS=true
export SERENA_HOME="$XDG_CONFIG_HOME/serena"

export DRAW_POKER_DATA_DIR="$XDG_DATA_HOME/draw-poker"
