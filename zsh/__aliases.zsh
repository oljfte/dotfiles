# Dependencies
source $DOTFILES/zsh/__variables.zsh

alias sudo="sudo "
alias mv="mv -i"
alias psg="ps aux | grep"
alias delat="xattr -c"
alias shutdown="sudo shutdown -h now"
alias restart="sudo shutdown -r now"
alias re="exec $SHELL -l"
alias dt="cd $DESKTOP"
alias docs="cd $DOCUMENTS"
alias dots="cd $DOTFILES"
alias pers="cd $PERSONAL"
alias memo="$EDITOR $MEMO_DIR/$(date +'%Y/%m/%d.md')"
