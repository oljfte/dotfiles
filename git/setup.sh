#!/bin/zsh

command -v brew >/dev/null || zsh $DOTFILES/brew/setup.sh

gh config set git_protocol ssh && gh auth login --hostname github.com --with-token < $DOTFILES/git/gh/token.txt
rm $DOTFILES/git/gh/token.txt

ln -fs $DOTFILES/git/.gitignore_global $HOME
