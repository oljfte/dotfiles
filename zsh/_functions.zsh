# Dependencies
source ${$(readlink $HOME/.zshrc)%/*}/__externals.zsh

for function_source in `ls -1 $DOTFILES/zsh/functions/*`; do
    source $function_source;
done
