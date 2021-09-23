#!/bin/zsh

function test_phoenix_installed() {
  [ -n "$(mdfind -name 'Phoenix')" ]
}
