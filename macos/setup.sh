#!/bin/zsh

while read row; do
    eval defaults write $row
done < $DOTFILES/macos/macos_defaults

ln -fs $DOTFILES/macos/apps/* /Applications

[ ! -e $HOME/.config/Totonoe ] && mkdir -p $HOME/.config/Totonoe
ln -fs $DOTFILES/macos/arrangement.xml $HOME/.config/Totonoe

echo "Done macos setup."
