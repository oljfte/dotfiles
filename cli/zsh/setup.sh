#!/bin/zsh

touch $HOME/.hushlogin

ln -fs $DOTFILES/cli/zsh/.zshrc $HOME
ln -fs $DOTFILES/cli/zsh/.zlogin $HOME

echo "Done zsh setup."
