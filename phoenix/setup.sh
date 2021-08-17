#!/bin/zsh

[ ! -e $HOME/.config/phoenix ] && mkdir -p $HOME/.config/phoenix
ln -f $DOTFILES/phoenix/config/*.js $HOME/.config/phoenix

echo "Done phoenix setup."
