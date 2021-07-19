#!/bin/zsh

[ ! -e $HOME/.config/rg ] && mkdir -p $HOME/.config/rg
ln -fs $DOTFILES/rg/.ignore $HOME/.config/rg/.ignore
