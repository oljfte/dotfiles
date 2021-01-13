# External sources
source $(brew --prefix)/opt/fzf/shell/completion.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh

# Environment variables
export PATH="$(brew --prefix)/opt/fzf/bin:$PATH"
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p 70%'
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --exclude .DS_Store'
export FZF_DEFAULT_OPTS="--reverse --color 16 --inline-info --multi \
    --bind tab:toggle,shift-tab:toggle-all,ctrl-j:down,ctrl-k:up,ctrl-l:preview-down,ctrl-h:preview-up --preview-window wrap"
export FZF_CTRL_T_COMMAND='fd --follow --hidden --exclude .git --exclude .DS_Store'
export FZF_CTRL_T_OPTS="--preview 'bat {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Aliases
alias fzf="fzf-tmux -p 70%"

# ZLE
function custom-fzf-cd-widget {
    local cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
        -o -type d -print 2> /dev/null | cut -b3-"}"
    setopt localoptions pipefail no_aliases 2> /dev/null
    local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
    if [[ -z "$dir" ]]; then
        zle redisplay
        return 0
    fi
    BUFFER="cd ${(q)dir}"
    zle transient-line

    local ret=$?
    unset dir
    return $ret
}

zle -N custom-fzf-cd-widget
bindkey "ç" custom-fzf-cd-widget
