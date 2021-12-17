#!/bin/zsh

function test_zshrc_compiled() {
  exec zsh -l &!
  [ -e ~/.zshrc.zwc ]
}

function test_zcompdump_compiled() {
  exec zsh -l &!
  [ -e ~/.zcompdump.zwc ]
}

function test_dotfiles_path_set() {
  [ $DOTFILES ]
}
