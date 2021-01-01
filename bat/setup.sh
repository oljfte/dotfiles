#!/bin/zsh

mkdir -p "$(bat --config-dir)/themes"
ln -fs $DOTFILES/bat/inheritor.tmTheme $(bat --config-dir)/themes

bat cache --build
