# Aliases
alias killtm="tmux kill-server"

# Functions
function _tmux-target-session() {
    local prespecified_session=$1
    local current_session=$(tmux display -p -F "#{session_name}" 2>/dev/null)
    if [ "$current_session" = "popup" ]; then
        eval $(tmux showenv -gs TMUX_LAST_DETECTED_SESSION)
        local from_session=$TMUX_LAST_DETECTED_SESSION
    else
        local from_session=$current_session
    fi
    local sessions_with_configs=$(rg $DOTFILES/**/tmux/session-init | sed 's!^.*/!!' | cut -f 3 -d .)
    local active_sessions=$(tmux ls -F "#{session_name}" 2>/dev/null | grep -v "popup")
    local active_sessions_with_configs=$({ echo "${active_sessions[*]}"; echo "${sessions_with_configs[*]}"; } | sort | uniq -d | awk NF)
    local inactive_sessions_with_configs=$({ echo "${sessions_with_configs[*]}"; echo "${active_sessions_with_configs[*]}"; } | sort | uniq -u | awk NF)
    local session_options=$({ echo $active_sessions; \
        [ ! -z $inactive_sessions_with_configs ] && echo $inactive_sessions_with_configs | sed 's/.*/(&)/' } | grep -v ${from_session:-' '} | awk NF)
    local n_session_options=$(echo $session_options | wc -l)

    if [ -z "$prespecified_session" ]; then
        if [[ $n_session_options -gt 0 ]]; then
            local target_session=$(echo $session_options | fzf -w 40 -h 15 | sed 's/[()]//g')
        else
            local target_session="default"
        fi
    else
        local target_session="$prespecified_session"
    fi
    echo $target_session
}

function _tmux-attach-session() {
    local target_session=$1
    local matched_config_sources=$(find $DOTFILES -path "*/session-init/.tmux.$target_session.conf" | sort -n)
    local target_config_source=$(echo $matched_config_sources | grep $PERSONAL || \
        echo $matched_config_sources | head -n 1)
    echo $targe_config_source
    if [ ! -z $target_config_source ]; then
        tmux new -d -s $target_session &>/dev/null && tmux send -t $target_session "tmux source-file $target_config_source" C-m
    else
        tmux new -d -s $target_session &>/dev/null
    fi
    tmux a -t $target_session &>/dev/null || tmux switchc -t $target_session &>/dev/null
}

function tm() {
    local target_session=$(_tmux-target-session $1)
    [ -z "$target_session" ] && return 1
    if [ "$(tmux display -p -F "#{session_name}" 2>/dev/null)" = "popup" ]; then
        eval $(tmux showenv -gs TMUX_LAST_DETECTED_SESSION)
        local from_session=$TMUX_LAST_DETECTED_SESSION
        if [ ! "$target_session" = "$from_session" ]; then
            tmux neww -n 'tm_exec_tmp' -t $from_session &>/dev/null && local working_window='tm_exec_tmp'
            tmux send -t "${from_session}:${working_window}" "_tmux-attach-session $target_session" C-m &>/dev/null
            for i in `seq 100`; do # Timeout after 3 seconds
                if [ "$(tmux list-client -F \#S | sed '/popup/d')" = "$target_session" ]; then
                    tmux killw -t "${from_session}:tm_exec_tmp" &>/dev/null
                    break
                fi
                sleep 0.03
            done
            tmux detach
        fi
    else
        _tmux-attach-session $target_session
    fi
}

function update-tmux() {
    cd ~/.tmux/plugins/tpm/bin &>/dev/null
    sh install_plugins
    sh update_plugins all
    sh clean_plugins
}
