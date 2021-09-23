# Dependencies
source $DOTFILES/cli/zsh/__aliases.zsh

for config in `ls -1 $DOTFILES/cli/zsh/externals/*/config`; do
    source $config;
done
