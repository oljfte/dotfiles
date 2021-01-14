# Dependencies
source $DOTFILES/zsh/__variables.zsh

alias sudo="sudo "
alias ll="rm .DS_Store &>/dev/null; exa -alh --git"
alias mv="mv -i"
alias psg="ps aux | grep"
alias delds="fd -H '^\.DS_Store$' -tf -X rm"
alias shutdown="sudo shutdown -h now"
alias restart="sudo shutdown -r now"
alias relogin="exec $SHELL -l"
alias desktop="cd $DESKTOP"
alias documents="cd $DOCUMENTS"
alias dotfiles="cd $DOTFILES"
alias personal="cd $PERSONAL"
