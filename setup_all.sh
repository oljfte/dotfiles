#!/bin/zsh

# Receive GitHub token and check if it's valid
while [[ $(curl https://api.github.com/ -u oljfte:$github_token -o /dev/null -w '%{http_code}\n' -s) -eq 200 ]]; do
    echo "Paste GitHub personal access token:"
    read github_token
done

# Install Xcode
xcode-select --install

# Clone dotfiles
dotfiles_parent_dir=`cd $(dirname $0) &>/dev/null && pwd`
export DOTFILES=${dotfiles_parent_dir}/dotfiles
[ -d $DOTFILES ] && rm -rf $DOTFILES

git clone https://github.com/oljfte/dotfiles.git $dotfiles_parent_dir

# Save github token to gh directory
echo $github_token > $DOTFILES/git/gh/token.txt

# Run setup scripts for global configs
for setup_script in $DOTFILES/*/setup.sh; do zsh $setup_script; done

# Run setup scripts for personal stuff
[ -d $PERSONAL ] && zsh $PERSONAL/setup_all.sh

