NEW_LINE_BEFORE_PROMPT=false

{
  [ $HOME/.zcompdump -nt $HOME/.zcompdump.zwc ] && zcompile $HOME/.zcompdump
  [ $HOME/.zshrc -nt $HOME/.zshrc.zwc ] && zcompile $HOME/.zshrc
} &!
