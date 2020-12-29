# External sources
source $(brew --prefix)/opt/fzf/shell/completion.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh

# Environmental variables
export PATH="$(brew --prefix)/opt/fzf/bin:$PATH"
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p'
export FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore --follow --glob '!.git/*' --glob '*.DS_Store*'"
export FZF_DEFAULT_OPTS="--reverse --inline-info --multi --bind tab:toggle,shift-tab:toggle-all,∆:down,˚:up,Ô:preview-down,:preview-up"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Aliases
alias fzf="fzf-tmux -p"

# Bind alt-c widget to option-c
bindkey "ç" fzf-cd-widget
