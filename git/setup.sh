#!/bin/zsh

[ ! -e $HOME/.config/git ] && mkdir -p $HOME/.config/git
ln -fs $DOTFILES/git/ignore $HOME/.config/git/ignore

echo "Done git setup."
