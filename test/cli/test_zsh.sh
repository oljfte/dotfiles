#!/bin/zsh

function test_zshrc_conpiled() {
  [ -e ~/.zshrc.zwc ]
}

function test_zcompdump_conpiled() {
  [ -e ~/.zcompdump.zwc ]
}

function test_dotfiles_path_set() {
  [ $DOTFILES ]
}
