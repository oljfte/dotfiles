# Exports
export CONFIG="$HOME/.config"
export DOCUMENTS="$HOME/Documents"
export DESKTOP="$HOME/Desktop"
export ENV_UTILS="$DOCUMENTS/env-utils"
export DOTFILES=${DOTFILES:-"$ENV_UTILS/local/dotfiles"}
export PERSONAL="$DOTFILES/personal"
export TEMP_DIR="/tmp"
export KEEP_DIR="$DESKTOP"
export LOG_DIR="/var/log"
export PATH="/usr/local/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export KEYTIMEOUT=1
export SHELL_SESSION_HISTORY=0

# For ARM (may be temporary)
export VIMRUNTIME="$HOME/neovim/runtime"
export EDITOR="$HOME/neovim/build/bin/nvim"
