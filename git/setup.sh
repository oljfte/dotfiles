#!/bin/zsh

command -v brew >/dev/null || zsh $DOTFILES/brew/setup.sh

if [ `command -v gh >/dev/null` ]; then
    gh config set git_protocol ssh && gh auth login --hostname github.com --with-token < $DOTFILES/git/gh/token.txt \
        && rm $DOTFILES/git/gh/token.txt
fi

ln -fs $DOTFILES/git/.gitignore_global $HOME
