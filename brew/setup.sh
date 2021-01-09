#!/bin/zsh

if [ `command -v brew >/dev/null` ]; then
    cd /opt
    sudo mkdir homebrew
    sudo chown oljfte:admin homebrew
    sudo curl -L https://github.com/Homebrew/brew/tarball/master | sudo tar xz --strip 1 -C homebrew
fi

brew bundle --file "$DOTFILES/brew/Brewfile"

echo "Done brew setup."
