#!/bin/zsh

while read row; do
    eval defaults write $row
done < $DOTFILES/macos/macos_defaults

# LaunchAgents
[ ! -e $HOME/Library/LaunchAgents ] && mkdir -p $HOME/Library/LaunchAgents
ln -f $DOTFILES/macos/LaunchAgents/* $HOME/Library/LaunchAgents

# Key Modifications
[ ! -e $HOME/Library/KeyBindings ] && mkdir -p $HOME/Library/KeyBindings
ln -f $DOTFILES/macos/DefaultKeyBinding.dict $HOME/Library/KeyBindings

# Misc
sudo systemsetup -setdisplaysleep "Never"

echo "Done macos setup."
