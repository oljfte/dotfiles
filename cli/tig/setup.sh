#!/bin/zsh

[ ! -e $HOME/.config/tig ] && mkdir -p $HOME/.config/tig
ln -fs $DOTFILES/cli/tig/config $HOME/.config/tig/config

echo "Done tig setup."
