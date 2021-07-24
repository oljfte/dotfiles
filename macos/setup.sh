#!/bin/zsh

while read row; do
    eval defaults write $row
done < $DOTFILES/macos/macos_defaults

echo "Done macos setup."
