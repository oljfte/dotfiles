# Environment Variables
export DOTFILES=${DOTFILES:-"$CONFIG/local/dotfiles"}
export DOCUMENTS="$HOME/Documents"
export DESKTOP="$HOME/Desktop"
export CONFIG="$DOCUMENTS/.config"
export WORK="$DOCUMENTS/work"
export STUDY="$DOCUMENTS/study"
export PERSONAL="$DOTFILES/personal"
export TEMP_DIR="/tmp"
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
