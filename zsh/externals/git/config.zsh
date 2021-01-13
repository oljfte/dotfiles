# Environment variables
export GIT_EDITOR=$EDITOR

# Aliases
alias gst="git status"
alias gdf="git diff"
alias gdc="git diff --cached"
alias ggr="git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'"
alias gft="git fetch"
alias gcb="git branch --show-current"
alias gps='[[ $(git diff @{upstream}) ]] && (git log origin/$(git branch --show-current)..$(git branch --show-current); \
  echo "\n---\nAre you sure you want to push? (y/n): "; read -q && git push origin HEAD || echo "\nAbort.") || echo "Everything up-to-date."'
alias gpf='[[ $(git diff @{upstream}) ]] && (git log origin/$(git branch --show-current)..$(git branch --show-current); \
  echo "\n---\nAre you sure you want to FORCE-push? (y/n): "; read -q && git push origin HEAD -f || echo "\nAbort.") || echo "Everything up-to-date."'

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
