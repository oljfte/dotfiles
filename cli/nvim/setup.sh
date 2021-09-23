#!/bin/zsh

rm -rf $HOME/.config/nvim
mkdir $HOME/.config/nvim

ln -fs $DOTFILES/cli/nvim/init.lua $HOME/.config/nvim/init.lua
ln -fs $DOTFILES/cli/nvim/lua $HOME/.config/nvim/lua

echo "Done nvim setup."
