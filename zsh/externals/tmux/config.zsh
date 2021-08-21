# Functions
autoload -z $(dirname $0)/functions/*

# ZLE
zle -N show-tmux-sessions
bindkey -M vicmd "^o" show-tmux-sessions
bindkey -M viins "^o" show-tmux-sessions

zle -N toggle-tmux-popup
bindkey -M vicmd "^p" toggle-tmux-popup
bindkey -M viins "^p" toggle-tmux-popup
