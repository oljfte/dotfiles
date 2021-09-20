#!/bin/zsh

[ ! -e $HOME/.config/bat ] && mkdir -p $HOME/.config/bat
ln -fs $DOTFILES/cli/bat/bat.conf $HOME/.config/bat

echo "Done bat setup."
