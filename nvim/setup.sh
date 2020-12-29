#!/bin/zsh

[ ! -e ~/.config/nvim/colors ] && mkdir -p ~/.config/nvim/colors 
ln -fs $DOTFILES/nvim/init.vim ~/.config/nvim
ln -fs $DOTFILES/nvim/coc-settings.json ~/.config/nvim
ln -fs $DOTFILES/nvim/colors/* ~/.config/nvim/colors
