# Dependencies
source $DOTFILES/zsh/__constants.zsh

alias shutdown="sudo shutdown -h now"
alias restart="sudo shutdown -r now"
alias screensaver="open -b com.apple.ScreenSaver.Engine"

# Alias key string in lower-case to its value only if it is a valid path
# for every environment key-value pairs.
while IFS="=" read -A i; do
  local alias_name=$i[1]:l
  local alias_value=$i[2]
  if ! type $alias_name &>/dev/null && [ -e $alias_value ] && [[ $alias_name =~ ^.*[a-z].*$ && $alias_value =~ ^\/[^:]*$ ]]; then
    eval "alias $alias_name=\"cd $alias_value\""
  fi
done <<< $(env)
