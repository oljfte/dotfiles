#!/bin/zsh

touch $HOME/.hushlogin

ln -fs $DOTFILES/zsh/.zshrc $HOME
ln -fs $DOTFILES/zsh/.zlogin $HOME

echo "Done zsh setup."
