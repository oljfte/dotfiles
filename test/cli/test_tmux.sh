#!/bin/zsh

function test_brew_installed() {
  command -v brew &> /dev/null
}
