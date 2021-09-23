#!/bin/zsh

[ ! -e $HOME/.config/term ] && mkdir -p $HOME/.config/term
ln -fs $DOTFILES/app/term/*.yml $HOME/.config/term

echo "Done Term setup."
