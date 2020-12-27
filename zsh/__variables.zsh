# Exports
export CONFIG="$HOME/.config"
export DOCUMENTS="$HOME/Documents"
export DESKTOP="$HOME/Desktop"
export ENV_UTILS="$DOCUMENTS/env-utils"
export DOTFILES=${DOTFILES:-"$ENV_UTILS/local/dotfiles"}
export PERSONAL="$DOTFILES/personal"
export PYVENVS="$ENV_UTILS/local/python/venvs"
export TEMP_DIR="/tmp"
export KEEP_DIR="$DESKTOP"
export LOG_DIR="/var/log"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="~/.poetry/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="~/.nodebrew/current/bin/:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export COMPOSE_DOCKER_CLI_BUILD=1
export PYTHONDONTWRITEBYTECODE=1
export KEYTIMEOUT=1
export SHELL_SESSION_HISTORY=0
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore --follow --glob "!.git/*"'

# For ARM (may be temporary)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export EDITOR="VIMRUNTIME=$HOME/neovim/runtime $HOME/neovim/build/bin/nvim"
export GIT_EDITOR=$EDITOR
