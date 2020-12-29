# Aliases
alias vi="vim"
alias vim="nvim"

# Functions
function update-nvim() {
    nvim +PlugUpgrade +PlugUpdate +PlugClean! +qall >/dev/null
}

# For ARM (may be temporary)
alias nvim="VIMRUNTIME=$HOME/neovim/runtime $HOME/neovim/build/bin/nvim"
