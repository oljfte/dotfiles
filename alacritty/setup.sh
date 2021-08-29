#!/bin/zsh

[ ! -e $HOME/.config/alacritty ] && mkdir -p $HOME/.config/alacritty
ln -fs $DOTFILES/alacritty/*.yml $HOME/.config/alacritty

echo "Done Alacritty setup."
