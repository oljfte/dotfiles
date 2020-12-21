#!/bin/zsh

while read row; do
    defaults write $row
done < osx_defaults
