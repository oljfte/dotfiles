#!/bin/zsh

ln -fs $DOTFILES/cli/tmux/.tmux.conf $HOME
ln -fs $DOTFILES/cli/tmux/session-specific/.* ~/.tmux/.config

echo "Done tmux setup."
