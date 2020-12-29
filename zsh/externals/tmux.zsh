# Aliases
alias kilt="tmux kill-server"

# Functions
function _tmux_session() {
    if [ -z "$1" ]; then
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux switch-client -t "$session" || echo "No sessions found."
    else
        [ -f $DOTFILES/tmux/session-init/.tmux.$1.conf ] && config_source="$DOTFILES/tmux/.tmux.$1.conf"
        [ -f $PERSONAL/tmux/session-init/.tmux.$1.conf ] && config_source="$PERSONAL/tmux/.tmux.$1.conf"
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
    fi
}

function tm() {
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

function update-tmux() {
    cd ~/.tmux/plugins/tpm/bin &>/dev/null
    sh install_plugins
    sh update_plugins all
    sh clean_plugins
}
