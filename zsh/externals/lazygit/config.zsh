# ZLE
function open-lazygit {
  git rev-parse HEAD > /dev/null 2>&1 || return

  # NOTE: Calling lazygit from zle causes syscall error
  BUFFER="lazygit"
  zle transient-line
  zle reset-prompt
}

zle -N open-lazygit
bindkey -M vicmd '^f' open-lazygit
bindkey -M viins '^f' open-lazygit
