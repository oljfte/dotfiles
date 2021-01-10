# Basic configs
bindkey -v

# Functions
autoload -z $(dirname $0)/functions/*

# ZLE
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Aliases
alias vi="vim"
alias vim="nvim"

# For ARM (may be temporary)
alias nvim="VIMRUNTIME=$HOME/neovim/runtime $HOME/neovim/build/bin/nvim"
