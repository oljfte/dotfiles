NEW_LINE_BEFORE_PROMPT=false

{
  [ $HOME/.zcompdump ] && [ $HOME/.zcompdump -nt $HOME/.zcompdump.zwc ] || [ ! -f $HOME/.zshcompdump.zwc ] && zcompile $HOME/.zcompdump
  [ $HOME/.zshrc -nt $HOME/.zshrc.zwc ] || [ ! -f $HOME/.zshrc.zwc ] && zcompile $HOME/.zshrc
} &!
