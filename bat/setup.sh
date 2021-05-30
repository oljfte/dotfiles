#!/bin/zsh

[ ! -e $HOME/.config/bat/themes ] && mkdir -p $HOME/.config/bat/themes
ln -fs $DOTFILES/bat/inheritor.tmTheme $HOME/.config/bat/themes

bat cache --build
