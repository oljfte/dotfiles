# Environment variables
export GIT_EDITOR=$EDITOR

# Aliases
alias gft="git fetch"
alias gcb="git branch --show-current"
alias gtp="cd $(git rev-parse --show-toplevel)"

# Functions
autoload -z $(dirname $0)/functions/* 

# ZLE
bindkey -r '^]'

function _join-lines {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

for c in hash file branch tag; do
    eval "fg$c-widget() { local result=\$(_fg$c | _join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fg$c-widget"
    eval "bindkey '^]${c:0:1}' fg$c-widget"
done
