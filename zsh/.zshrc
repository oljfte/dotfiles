# Basic configs 
autoload -Uz compinit && compinit
zstyle ':completion::complete:*' use-cache true
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"
bindkey -v
setopt share_history
setopt list_packed
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
unsetopt prompt_sp
unsetopt correct_all

# Global configs
for config in `ls -1 ${$(readlink $HOME/.zshrc)%/*}/_[^_]*\.zsh`; do
    source $config
done

# Personal configs
if [ -e ${PERSONAL:-' '} ]; then
    for config in `ls -1 $PERSONAL/zsh/_[^_]*\.zsh`; do
        source $config
    done
fi

# Additional sources
additional_sources=( \
    $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
    $HOME/.poetry/env \
    $HOME/google-cloud-sdk/path.zsh.inc \
    $HOME/google-cloud-sdk/completion.zsh.inc \
    $HOME/.fzf.zsh \
)

for additional_source in $additional_sources; do
    [ -f $additional_source ] && source $additional_source
done
