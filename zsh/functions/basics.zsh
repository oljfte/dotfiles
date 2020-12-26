function neaten() {
    printf '\033[5 q\r'
    printf '\n%.0s' {1..$(( $LINES + 10 ))}
}

function clear() {
    printf "\033c"
    neaten
}

function reset() {
    /usr/bin/reset
    neaten
}

function cd()
{
    if [ $# = 0 ]; then
        builtin cd && ll
    elif [ "$1" = "-" ]; then
        builtin cd -
    elif [ -d $1 ]; then
        builtin cd "$1" && ll
    else
        echo "No such directory." && return 1
    fi
}

function keep() {
    cp -r $1 $KEEP_DIR
}

function checkmod() {
    stat -f "%Lp" "$1"
}

function colors() {
    for c in {000..255}; do
        echo -n "\e[38;5;${c}m $c" ; [ $(($c%8)) -eq 7 ] && echo;
    done;
    echo
}

function rgitstatus() {
    for x in $(find . -type d -name ".git"); do
        pushd $(dirname $x) >/dev/null
        repeat $COLUMNS printf "\e[37;1m-\e[m"
        printf "\e[37;1m\n$(pwd)\n\e[m"
        git status -s 2>/dev/null
        [ -z "$(git status -s)" ] && echo "Nothing to commit, working tree clean."
        popd >/dev/null
        echo
    done
}

function localhost() {
    open http://localhost:$1
}

function _editcf() {
    target_files=`eval "find $1 -type f -wholename \"*/$2/*\" -wholename \"*${(j:*" -wholename "*:)@:3}*\""`
    if [[ ! `echo $target_files | sed '/^$/d' | wc -l` -eq 0 ]]; then
        for target_file in `echo $target_files`; do vim $target_file; done
        return 0
    else
        return 1
    fi
}

function tmuxcf() {
    if [ $# = 0 ]; then
        vim $DOTFILES/tmux/.tmux.conf
    else
        _editcf $DOTFILES tmux $* || ( echo "No such file."; return 1 )
    fi && ( tmux ls &>/dev/null && tmux source-file $HOME/.tmux.conf; echo "TMUX configurations have been successfully reloaded." )
}

function vimcf() {
    if [ $# = 0 ]; then
        vim $DOTFILES/nvim/init.vim
    else
        _editcf $DOTFILES nvim $* || ( echo "No such file."; return 1 )
    fi && ( echo "Changes will be take effect when you open Vim next time." )
}

function zshcf() {
    if [ $# = 0 ]; then
        vim $DOTFILES/zsh/.zshrc
    else
        _editcf $DOTFILES zsh $* || ( echo "No such file."; return 1 )
    fi && ( source $HOME/.zshrc; zsh; echo "ZSH configurations have been successfully reloaded." )
}

function _tmux_session() {
    config_source="$PERSONAL/tmux/.tmux.$1.conf"
    if [ -f $config_source ]; then
        tmux new-session -d -s $1 &>/dev/null && tmux send-keys -t $1 "tmux source-file $config_source" C-m
    else
        tmux new-session -d -s $1 &>/dev/null
    fi
    if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ]; then
        tmux switch-client -t $1 &>/dev/null && tmux detach-client
    else
        tmux a -t $1 &>/dev/null || tmux switch-client -t $1 &>/dev/null
    fi
}

function room() {
    if [ "$(tmux display-message -p -F "#{session_name}" 2>/dev/null)" = "popup" ]; then
        eval $(tmux showenv -gs TMUX_LAST_DETECTED_SESSION)
        parent_session=$TMUX_LAST_DETECTED_SESSION
        tmux new-window -n 'room_exec_tmp' -t $parent_session &>/dev/null && zsh_pane_index='room_exec_tmp'
        tmux send-keys -t "${parent_session}:${zsh_pane_index}" "_tmux_session $1" C-m &>/dev/null
        for i in `seq 100`; do # Timeout after 5 seconds
            if [ "$(tmux list-client -F \#S | sed '/popup/d')" = "$1" ]; then
                tmux kill-window -t "${parent_session}:room_exec_tmp" &>/dev/null
                break
            fi
            sleep 0.05
        done
        tmux detach-client
    else
        _tmux_session $1
    fi
}

function pyv() {
    if [ "$1" = "create" ]; then
        if [ ! -z "$2" ]; then
            python -m venv $PYVENVS/$2 --system-site-packages
            ln -fs $PERSONAL/python/sitecustomize.py $PYVENVS/$2/lib/python*/site-packages
        else
            echo "Specify venv name."
        fi
    elif [ "$1" = "list" ]; then
        ls $PYVENVS | sort
    elif [ "$1" = "up" ]; then
        if [ ! -z "$2" ]; then
            source $PYVENVS/$2/bin/activate
        else
            echo "Specify venv name."
        fi
    elif [ "$1" = "delete" ]; then
        if [ ! -z "$2" ]; then
            trash $PYVENVS/$2 && echo "Deleted venv $2 successfully."
        else
            echo "Specify venv name."
        fi
    else
        echo "Invalid arguments."
    fi
}
