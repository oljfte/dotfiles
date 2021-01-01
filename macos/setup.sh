#!/bin/zsh

while read row; do
    defaults write $row
done < macos_defaults
