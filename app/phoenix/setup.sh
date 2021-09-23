#!/bin/zsh

[ ! -e $HOME/.config/phoenix ] && mkdir -p $HOME/.config/phoenix
ln -fs $DOTFILES/app/phoenix/config/*.js $HOME/.config/phoenix

# Use layout for wide screen as default
ln -fs $DOTFILES/app/phoenix/layout/home.js ~/.config/phoenix/layout.js

echo "Done phoenix setup."
