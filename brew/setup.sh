#!/bin/zsh

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --file "$DOTFILES/brew/Brewfile"

echo "Done brew setup."
