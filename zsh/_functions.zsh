# Dependencies
source ${$(readlink $HOME/.zshrc)%/*}/__aliases.zsh

for function_source in `ls -1 $PERSONAL/zsh/functions/*`; do
    source $function_source;
done
