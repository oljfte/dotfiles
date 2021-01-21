# External source
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Environment variables
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
export FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

# Functions
autoload -Uz compinit && compinit
autoload -Uz colors && colors

# Options
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt complete_in_word
setopt list_packed
