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

# Terminal
terminal_profile_dir=$DOTFILES/macos/terminal_profiles
terminal_profile_name=`basename $(ls -rt $terminal_profile_dir/*.terminal | tail -n 1) | cut -f 1 -d '.'`
terminal_profile=$(<$terminal_profile_dir/$terminal_profile_name.terminal)
plutil -insert Window\ Settings.$terminal_profile_name -xml "$terminal_profile" ~/Library/Preferences/com.apple.Terminal.plist
defaults write com.apple.Terminal "Default Window Settings" -string "$terminal_profile_name"
defaults write com.apple.Terminal "Startup Window Settings" -string "$terminal_profile_name"

# Misc
sudo systemsetup -setdisplaysleep "Never"

echo "Done macos setup."
