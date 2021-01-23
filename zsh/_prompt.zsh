# Dependencies
source ${$(readlink $HOME/.zshrc)%/*}/__aliases.zsh

# Git info
autoload -Uz vcs_info

setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b' '%c%u%m'
zstyle ':vcs_info:git:*' actionformats '%b' '%c%u%m' '%a'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+ "
zstyle ':vcs_info:git:*' unstagedstr "~ "

function git-branch() {
    git_branch="${vcs_info_msg_0_}"
    [ $git_branch ] && echo "   $git_branch  "
}

function git-status() {
    git_status="${vcs_info_msg_1_}"
    [ $git_status ] && echo "  $git_status "
}

function git-action() {
    git_action="${vcs_info_msg_2_}"
    [ $git_action ] && echo "  $git_action "
}

# Virtual env info 
function venv-name() {
    if [ $VIRTUAL_ENV ]; then
        if [ "$(basename $VIRTUAL_ENV)" = ".venv" ]; then 
            echo ' '$(basename ${VIRTUAL_ENV%/*})' '
        else
            echo ' '$(basename $VIRTUAL_ENV)' '
        fi
    fi
}

# Status bar
function string-width() {
    emulate -L zsh
    local -i COLUMNS=${2:-COLUMNS}
    local -i x y=${#1} m
    if (( y )); then
        while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
            x=y
            (( y *= 2 ))
        done
        while (( y > x + 1 )); do
            (( m = x + (y - x) / 2 ))
            (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
        done
    fi
    echo $x
}

function fill-line() {
    emulate -L zsh
    local -i left_len=$(string-width $1)
    local -i right_len=$(string-width $2 9999)
    local -i pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-0}))
    if (( pad_len < 1 )); then
        echo $1
    else
        if [[ -v 3 ]]; then
            local pad="%K{$3}${(pl.$pad_len.. .)}%k"
        else
            local pad="${(pl.$pad_len.. .)}"
        fi
        echo ${1}${pad}${2}
    fi
}

# Change cursor by vim mode
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
        BOTTOM_LEFT="%F{7}$(venv-name)❮ %f"
        set-prompt
        zle reset-prompt
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || \
        [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
        BOTTOM_LEFT="%F{2}$(venv-name)❯ %f"
        set-prompt
        zle reset-prompt
    fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}

zle -N zle-line-init

# Construct prompt
function transient-line() {
    PROMPT=$'\n'$'\n'"%F{7}$(fill-line '%~' '%T ')"$'\n'"$([ -z "$(venv-name)" ] || echo ${"$(venv-name)":1})❯ %f"
    zle reset-prompt
    zle accept-line
}
zle -N transient-line
bindkey '^M' transient-line
bindkey -M vicmd '^M' transient-line

ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(transient-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)

TRAPINT() {
    transient-line &>/dev/null
    return $(( 128 + $1 ))
}

function set-prompt() {
    emulate -L zsh
    vcs_info
    local top_left="%K{8} %~ %k"
    local top_right="%K{8}$(git-action)$(git-status)%k%K{7}$(git-branch)%k"

    PROMPT=$'\n'$'\n'$(fill-line "$top_left" "$top_right" "8")$'\n'"$BOTTOM_LEFT"
}

autoload -Uz add-zsh-hook
setopt no_prompt_{bang,subst} prompt_{cr,percent,sp}
add-zsh-hook precmd set-prompt

# Reset prompt on window resize
TRAPWINCH () {
    set-prompt
    zle reset-prompt &>/dev/null
}
 
