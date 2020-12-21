# Dependencies
source ${$(readlink $HOME/.zshrc)%/*}/__variables.zsh

alias sudo="sudo "
alias python="python3"
alias pip="pip3"
alias ll="rm .DS_Store &>/dev/null; ls -alG"
alias vi="vim"
alias vim="nvim"
alias mv="mv -i"
alias psg="ps aux | grep"
alias delds="find ~ -type f -name .DS_Store -delete"
alias kilt="tmux kill-server"
alias desktop="cd $DESKTOP"
alias documents="cd $DOCUMENTS"
alias dotfiles="cd $DOTFILES"
alias personal="cd $PERSONAL"
alias sshcf="vim $PERSONAL/ssh/config"
alias croncf="vim $DOTFILES/cron/crontab && crontab $DOTFILES/cron/crontab"

# For ARM (may be temporary)
alias nvim="VIMRUNTIME=$HOME/neovim/runtime $HOME/neovim/build/bin/nvim"
