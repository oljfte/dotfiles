#!/bin/zsh

function test_term_installed() {
  [ -n "$(mdfind -name 'Term')" ]
}
