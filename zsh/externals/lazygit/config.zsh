# ZLE
function open-lazygit-in-popup {
    tmux popup -E "lazygit"
}

zle -N open-lazygit-in-popup
bindkey -M vicmd '^f' open-lazygit-in-popup
bindkey -M viins '^f' open-lazygit-in-popup
