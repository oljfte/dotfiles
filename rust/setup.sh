#!/bin/zsh

[ ! -e $HOME/.cargo ] && mkdir -p $HOME/.cargo
ln -fs $DOTFILES/rust/config $HOME/.cargo/config

echo "Done rust setup."
