# Dependencies
source $DOTFILES/zsh/__aliases.zsh

for config in `ls -1 $DOTFILES/zsh/externals/*/config`; do
    source $config;
done
