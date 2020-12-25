function update_brew() {
    brew update
    brew upgrade
    brew cleanup
    cd $DOTFILES/brew && brew bundle dump -f
}

function update_vim() {
    nvim +PlugUpgrade +PlugUpdate +PlugClean! +qall >/dev/null
}

function update_tmux() {
    cd ~/.tmux/plugins/tpm/bin
    sh install_plugins
    sh update_plugins all
    sh clean_plugins
}

function update_pip() {
    pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

function update_venv_pip() {
    for venv_requirements_path in `find $PERSONAL/python/requirements/venvs/*`; do
        pyv up $(basename $venv_requirements_path)
        update_pip
        pip freeze > $venv_requirements_path
        deactivate
    done
}

function update_gcloud() {
    gcloud components update
}

function update_all() {
    update_brew
    update_vim
    update_tmux
    update_pip
    update_venv_pip
    update_gcloud
}
