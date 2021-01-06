#!/bin/zsh

while read row; do
    eval defaults write $row
done < macos_defaults

[ ! -e $HOME/Library/LaunchAgents ] && mkdir -p $HOME/Library/LaunchAgents
ln -f $DOTFILES/macos/com.example.KeyRemapping.plist $HOME/Library/LaunchAgents
