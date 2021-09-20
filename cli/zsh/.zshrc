# Basic configs
export DOTFILES=${$(readlink $HOME/.zshrc)%/*/*/*}
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt nonomatch

# Additional configs
for config in `ls -1 $DOTFILES/cli/zsh/_[^_]*\.zsh`; do
    source $config
done

# Personal configs
if [ -e ${PERSONAL:-' '} ]; then
    for config in `ls -1 $PERSONAL/cli/zsh/_[^_]*\.zsh`; do
        source $config
    done
fi
