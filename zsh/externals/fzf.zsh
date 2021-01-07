# External sources
source $(brew --prefix)/opt/fzf/shell/completion.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh

# Environmental variables
export PATH="$(brew --prefix)/opt/fzf/bin:$PATH"
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p 80%'
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --exclude .DS_Store'
export FZF_DEFAULT_OPTS="--reverse --color 16 --inline-info --multi --bind tab:toggle,shift-tab:toggle-all,ctrl-j:down,ctrl-k:up,ctrl-l:preview-down,ctrl-h:preview-up"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Aliases
alias fzf="fzf-tmux -p 80%"

# Bind alt-c widget to option-c
bindkey "ç" fzf-cd-widget
