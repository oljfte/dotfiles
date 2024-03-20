# Environment Variable
export PERSONAL="$DOTFILES/personal"
export DOCUMENTS="$HOME/Documents"
export DESKTOP="$HOME/Desktop"
export WORK="$HOME/work"
export TEMP_DIR="/tmp"
export LOG_DIR="/var/log"
export PATH="/usr/local/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export KEYTIMEOUT=1
export SHELL_SESSION_HISTORY=0

while IFS="=" read -A i; do
  eval "export ${(U)i}=$WORK/$i"
done <<< $(ls $WORK)
