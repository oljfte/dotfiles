#!/bin/zsh

# Install Vim-Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

[ ! -e ~/.config/nvim/colors ] && mkdir -p ~/.config/nvim/colors 
ln -fs $DOTFILES/nvim/init.vim ~/.config/nvim
ln -fs $DOTFILES/nvim/coc-settings.json ~/.config/nvim
ln -fs $DOTFILES/nvim/colors/* ~/.config/nvim/colors
