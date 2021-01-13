# Environment variables
export GIT_EDITOR=$EDITOR

# Aliases
alias gst="git status"
alias gdf="git diff"
alias gdc="git diff --cached"
alias ggr="git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'"
alias gft="git fetch"
alias GPS="git push"
alias GPF="git push -f"

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
