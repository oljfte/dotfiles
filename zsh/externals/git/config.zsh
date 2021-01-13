# Environment variables
export GIT_EDITOR=$EDITOR

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
    eval "fg$c-widget() { local result=\$(fg$c | _join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fg$c-widget"
    eval "bindkey '^]${c:0:1}' fg$c-widget"
done
