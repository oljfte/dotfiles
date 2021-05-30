#!/bin/zsh

[ ! -e $HOME/.config/nvim/colors ] && mkdir -p $HOME/.config/nvim/colors
[ ! -e $HOME/.config/nvim/snippets ] && mkdir -p $HOME/.config/nvim/snippets
ln -fs $DOTFILES/nvim/init.vim $HOME/.config/nvim
ln -fs $DOTFILES/nvim/coc-settings.json $HOME/.config/nvim
ln -fs $DOTFILES/nvim/colors/* $HOME/.config/nvim/colors

echo "Done nvim setup."
