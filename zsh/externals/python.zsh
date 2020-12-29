# Environmental variables
export PYVENVS="$ENV_UTILS/local/python/venvs"
export PYTHONDONTWRITEBYTECODE=1

# Aliases
alias python="python3"
alias pip="pip3"

# Functions
function pyv() {
    if [ "$1" = "create" ]; then
        if [ ! -z "$2" ]; then
            python -m venv $PYVENVS/$2 --system-site-packages
            ln -fs $PERSONAL/python/sitecustomize.py $PYVENVS/$2/lib/python*/site-packages
        else
            echo "Specify venv name."
        fi
    elif [ "$1" = "list" ]; then
        ls -A1 $PYVENVS
    elif [ "$1" = "up" ]; then
        venv_name=$(ls -A1 $PYVENVS | fzf)
        [ ! -z "$venv_name" ] && source $PYVENVS/$venv_name/bin/activate
    elif [ "$1" = "delete" ]; then
        venv_name=$(ls -A1 $PYVENVS | fzf)
        [ ! -z "$venv_name" ] && trash $PYVENVS/$venv_name && echo "Deleted venv $venv_name successfully."
    else
        echo "Invalid arguments."
    fi
}

function update-pip() {
    pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

function update-venv-pip() {
    for venv_requirements_path in `find $personal/python/requirements/venvs/*`; do
        pyv up $(basename $venv_requirements_path)
        update-pip
        pip freeze > $venv_requirements_path
        deactivate
    done
}
