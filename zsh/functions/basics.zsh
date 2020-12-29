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

}

function update-all() {
    update-brew
    update-nvim
    update-tmux
    update-pip
    update-venv-pip
    update-gcloud
}
