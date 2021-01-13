#!/bin/zsh

# Environment variables
export FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

# Functions
autoload -Uz compinit && compinit
autoload -Uz colors && colors

# Options
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt complete_in_word
setopt list_packed
