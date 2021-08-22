# ZLE
function open-lazygit-in-popup {
    [ $TMUX ] && tmux popup -d '#{pane_current_path}' -E 'lazygit' || lazygit
}

zle -N open-lazygit-in-popup
bindkey -M vicmd '^f' open-lazygit-in-popup
bindkey -M viins '^f' open-lazygit-in-popup
