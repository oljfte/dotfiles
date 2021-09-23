#!/bin/zsh

# Install Xcode
xcode-select --install

# Clone dotfiles
[[ $SHLVL -le 2 ]] && dotfiles_parent_dir=$PWD \
    || dotfiles_parent_dir=$(cd $(dirname $0) &>/dev/null && pwd)
export DOTFILES=${dotfiles_parent_dir}/dotfiles
echo "export DOTFILES=\"$DOTFILES\"" > ~/.zshenv

[ -d $DOTFILES ] && rm -rf $DOTFILES

cd $dotfiles_parent_dir && git clone https://github.com/oljfte/dotfiles.git

# Run setup scripts for global configs
for setup_script in $DOTFILES/*/setup.sh; do zsh $setup_script; done
