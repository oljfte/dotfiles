# Dependencies
source $DOTFILES/zsh/__constants.zsh

alias shutdown="sudo shutdown -h now"
alias restart="sudo shutdown -r now"
alias screensaver="open -b com.apple.ScreenSaver.Engine"

# Alias key string in lower-case to its value only if it is a valid path
# for every environment key-value pairs.
while IFS="=" read -A i; do
  if [[ $i[1]:l =~ ^.*[a-z].*$ && $i[2] =~ ^\/[^:]*$ ]] && [ -e $i[2] ]; then
    eval "alias $i[1]:l=\"cd $i[2]\""
  fi
done <<< $(env)
