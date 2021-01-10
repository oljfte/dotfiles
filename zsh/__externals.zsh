# Dependencies
source $DOTFILES/zsh/__aliases.zsh

for config in `ls -1 $DOTFILES/zsh/externals/*/config.zsh`; do
    source $config;
done
