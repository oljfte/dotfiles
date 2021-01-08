# Environmental variables
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Functions
function poev() {
    local venv_dir=$(fd 'pyvenv.cfg' ~ | sed -r 's/(.*)\/\.venv.*/\1/' | fzf -w 80 -h 20)
    [ ! -z "$venv_dir" ] && source $venv_dir/.venv/bin/activate
}

