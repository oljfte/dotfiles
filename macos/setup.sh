#!/bin/zsh

while read row; do
    eval defaults write $row
done < $DOTFILES/macos/macos_defaults

ln -fs $DOTFILES/macos/apps/* /Applications

[ ! -e $HOME/Library/LaunchAgents ] && mkdir -p $HOME/Library/LaunchAgents
ln -f $DOTFILES/macos/com.example.KeyRemapping.plist $HOME/Library/LaunchAgents

[ ! -e $HOME/Library/KeyBindings ] && mkdir -p $HOME/Library/KeyBindings
ln -f $DOTFILES/macos/DefaultKeyBinding.dict $HOME/Library/KeyBindings

[ ! -e $HOME/.config/Totonoe ] && mkdir -p $HOME/.config/Totonoe
ln -fs $DOTFILES/macos/arrangement.xml $HOME/.config/Totonoe

echo "Done macos setup."
