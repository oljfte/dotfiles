# Dependencies
source $DOTFILES/zsh/__variables.zsh

alias sudo="sudo "
alias ll="rm .DS_Store &>/dev/null; ls -alG"
alias mv="mv -i"
alias psg="ps aux | grep"
alias delds="find ~ -type f -name .DS_Store -delete"
alias shutdown="sudo shutdown -h now"
alias restart="sudo shutdown -r now"
alias desktop="cd $DESKTOP"
alias documents="cd $DOCUMENTS"
alias dotfiles="cd $DOTFILES"
alias personal="cd $PERSONAL"
