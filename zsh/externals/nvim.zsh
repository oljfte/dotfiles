# Basic configs
bindkey -v

# Aliases
alias vi="vim"
alias vim="nvim"

# For ARM (may be temporary)
alias nvim="VIMRUNTIME=$HOME/neovim/runtime $HOME/neovim/build/bin/nvim"

# Functions
function update-nvim() {
    nvim +PlugUpgrade +PlugUpdate +PlugClean! +qall >/dev/null
}
