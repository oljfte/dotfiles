# Functions
autoload -z $(dirname $0)/functions/*

# ZLE
zle -N tm
bindkey -M vicmd '^o' tm
bindkey -M viins '^o' tm

zle -N tp
bindkey -M vicmd '^p' tp
bindkey -M viins '^p' tp
