#!/bin/zsh

function test_zshrc_compiled() {
  exec zsh -l &! lsof -p $! +r 1 &>/dev/null
  [ -e ~/.zshrc.zwc ]
}

function test_zcompdump_compiled() {
  exec zsh -l &! lsof -p $! +r 1 &>/dev/null
  [ -e ~/.zcompdump.zwc ]
}

function test_dotfiles_path_set() {
  [ $DOTFILES ]
}
