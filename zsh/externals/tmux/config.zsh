# Aliases
alias kiltm="echo 'Are you sure you want to kill all tmux sessions? (y/n)'; read -q && (echo; tmux kill-server)"
alias kiltms="echo 'Are you sure you want to kill this tmux session? (y/n)'; read -q && (echo; tmux kill-session)"

# Functions
autoload -z $(dirname $0)/functions/*
