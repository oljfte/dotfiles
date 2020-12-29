# Functions
function update-brew() {
    brew update
    brew upgrade
    brew cleanup
    cd $DOTFILES/brew &>/dev/null && brew bundle dump -f
}

# For ARM (may be temporary)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
