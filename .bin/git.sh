#!/bin/bash

# shellcheck source=/dev/null
source .env

git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"
git config --global core.excludesfile "$HOME/.gitignore_global"
