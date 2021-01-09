#!/bin/zsh

terminal_profile_name=`basename $(ls -rt $DOTFILES/terminal/*.terminal | tail -n 1) | cut -f 1 -d '.'`
terminal_profile=$(<$DOTFILES/terminal/$terminal_profile_name.terminal)
plutil -insert Window\ Settings.$terminal_profile_name -xml "$terminal_profile" ~/Library/Preferences/com.apple.Terminal.plist
defaults write com.apple.Terminal "Default Window Settings" -string "$terminal_profile_name"
defaults write com.apple.Terminal "Startup Window Settings" -string "$terminal_profile_name"

echo "Done terminal setup."
