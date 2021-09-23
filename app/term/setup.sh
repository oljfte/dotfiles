#!/bin/zsh

[ ! -e $HOME/.config/term ] && mkdir -p $HOME/.config/term
ln -fs $DOTFILES/app/term/*.yml $HOME/.config/term

# Use larger font size as default
ln -fs $DOTFILES/app/term/font-size/home.yml ~/.config/term/font-size.yml

echo "Done Term setup."
