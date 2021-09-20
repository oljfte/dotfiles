#!/bin/zsh

[ ! -e $HOME/.config/fd ] && mkdir -p $HOME/.config/fd
ln -fs $DOTFILES/cli/fd/ignore $HOME/.config/fd/ignore
