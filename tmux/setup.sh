#!/bin/zsh

[ ! -d $HOME/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
ln -fs $DOTFILES/tmux/.tmux.conf $HOME
