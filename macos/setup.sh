#!/bin/zsh

while read row; do
    eval defaults write $row
done < $DOTFILES/macos/macos_defaults

[ ! -e $HOME/Library/LaunchAgents ] && mkdir -p $HOME/Library/LaunchAgents
[ ! -e $HOME/Library/KeyBindings ] && mkdir -p $HOME/Library/KeyBindings
ln -f $DOTFILES/macos/com.example.KeyRemapping.plist $HOME/Library/LaunchAgents
ln -f $DOTFILES/macos/DefaultKeyBinding.dict $HOME/Library/KeyBindings

echo "Done macos setup."
