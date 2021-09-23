#!/bin/zsh

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle install --file "$DOTFILES/cli/brew/Brewfile"

echo "Done brew setup."
