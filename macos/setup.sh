#!/bin/zsh

while read row; do
    eval defaults write $row
done < $DOTFILES/macos/macos_defaults

# Misc
sudo systemsetup -setdisplaysleep "Never"

echo "Done macos setup."
