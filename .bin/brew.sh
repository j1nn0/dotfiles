#!/bin/bash

if [ "$(uname)" != "Darwin" ]; then
    echo "Not macOS!"
    exit 1
fi

# Install Homebrew
echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"
# brew bundle dump --global -f
brew bundle --global
