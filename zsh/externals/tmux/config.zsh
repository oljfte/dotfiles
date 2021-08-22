# Functions
autoload -z $(dirname $0)/functions/*

# ZLE
function select-tmux-session-in-term() {
  if [ $TMUX ]; then
    select-tmux-session
  else
    BUFFER="select-tmux-session"
    zle transient-line
    zle reset-prompt
  fi
}

zle -N select-tmux-session-in-term
bindkey -M vicmd "^o" select-tmux-session-in-term
bindkey -M viins "^o" select-tmux-session-in-term

zle -N toggle-tmux-popup
bindkey -M vicmd "^p" toggle-tmux-popup
bindkey -M viins "^p" toggle-tmux-popup
