# Dependencies
source $DOTFILES/zsh/__aliases.zsh

for external_source in `ls -1 $DOTFILES/zsh/externals/*`; do
    source $external_source;
done
