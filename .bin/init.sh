#!/bin/bash

if [ "$(uname)" != "Darwin" ]; then
    echo "Not macOS!"
    exit 1
fi

# Install Xcode
echo "Install Xcode"
xcode-select --install

# Install Rosetta 2
echo "Install Rosetta 2"
softwareupdate --install-rosetta --agree-to-license

./link.sh
./brew.sh
./vscode.sh
./git.sh
