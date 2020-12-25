function update-brew() {
    brew update
    brew upgrade
    brew cleanup
    cd $DOTFILES/brew && brew bundle dump -f
}

function update-vim() {
    nvim +PlugUpgrade +PlugUpdate +PlugClean! +qall >/dev/null
}

function update-tmux() {
    cd ~/.tmux/plugins/tpm/bin
    sh install_plugins
    sh update-plugins all
    sh clean_plugins
}

function update-pip() {
    pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

function update-venv_pip() {
    for venv_requirements_path in `find $PERSONAL/python/requirements/venvs/*`; do
        pyv up $(basename $venv_requirements_path)
        update-pip
        pip freeze > $venv_requirements_path
        deactivate
    done
}

function update-gcloud() {
    gcloud components update
}

function update-all() {
    update-brew
    update-vim
    update-tmux
    update-pip
    update-venv_pip
    update-gcloud
}
