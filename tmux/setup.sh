#!/bin/zsh

[ ! -d $HOME/.tmux/plugins/tpm ] && (mkdir -p $HOME/.tmux/plugins && \
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins)
ln -fs $DOTFILES/tmux/.tmux.conf $HOME
