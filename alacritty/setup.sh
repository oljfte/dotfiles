#!/bin/zsh

[ ! -e $HOME/.config/alacritty ] && mkdir -p $HOME/.config/alacritty
ln -fs $DOTFILES/alacritty/alacritty.yml $HOME/.config/alacritty

echo "Done Alacritty setup."
