#!/bin/zsh

local poetry_config_dir=$HOME/Library/Application\ Support/pypoetry
[ ! -e $poetry_config_dir ] && mkdir -p $poetry_config_dir
ln -fs $DOTFILES/cli/poetry/config.toml $poetry_config_dir

echo "Done poetry setup."
