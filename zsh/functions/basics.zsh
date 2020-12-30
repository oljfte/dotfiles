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

function setup() {
    if [ "$1" = "all" ]; then
        for setup_script in $DOTFILES/*/setup.sh; do zsh $setup_script; done
        for setup_script in $PERSONAL/*/setup.sh; do zsh $setup_script; done
    elif [ ! -z "$1" ]; then
        [ -f $DOTFILES/$1/setup.sh ] && zsh $DOTFILES/$1/setup.sh
        [ -f $PERSONAL/$1/setup.sh ] && zsh $PERSONAL/$1/setup.sh
    fi
    [[ "$1" = "zsh" || "$1" = "all" ]] && source $HOME/.zshrc
    [[ "$1" = "tmux" || "$1" = "all" ]] && (tmux ls &>/dev/null && tmux source-file $HOME/.tmux.conf)
    [ "$2" = "restart" ] && restart
}

function cf() {
    for target_file in `builtin cd $DOTFILES && find . -type f | rg --files --hidden --no-ignore --follow --glob '!.git/*' --glob '!personal/.git/*' | sed 's/^.\///' | fzf`; do
        local target_fullpath=$DOTFILES/$target_file
        local target_type=${${${target_fullpath#$PERSONAL/}#$DOTFILES/}%%/*}
        [ -f $target_fullpath ] && ( vim "$target_fullpath"; setup $target_type)
    done
    relogin
}

function update-all() {
    update-brew
    update-nvim
    update-tmux
    update-pip
    update-venv-pip
    update-gcloud
}
