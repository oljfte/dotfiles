# Dependencies
source ${$(readlink $HOME/.zshrc)%/*}/__aliases.zsh

# Git info
autoload -Uz vcs_info

setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b' '%c%u%m'
zstyle ':vcs_info:git:*' actionformats '%b' '%c%u%m' '%a'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "~"

function git-branch() {
    git_branch="${vcs_info_msg_0_}"
    [ $git_branch ] && echo "$git_branch"
}

function git-status() {
    git_status="${vcs_info_msg_1_}"
    [ $git_status ] && echo "$git_status"
}

function git-action() {
    git_action="${vcs_info_msg_2_}"
    [ $git_action ] && echo "$git_action"
}

# Virtual env info 
function venv-name() {
    if [ $VIRTUAL_ENV ]; then
        if [ $VIRTUAL_ENV_NAME ]; then
            echo $VIRTUAL_ENV_NAME
        else
            if [ "$(basename $VIRTUAL_ENV)" = ".venv" ]; then
                echo $(basename ${VIRTUAL_ENV%/*})
            else
                echo $(basename $VIRTUAL_ENV)
            fi
        fi
    fi
}

# Change cursor by vim mode
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
        BOTTOM_LEFT="%F{7}● %f"
        [ -z $(venv-name) ] || BOTTOM_LEFT="%F{7}$(venv-name)%f $BOTTOM_LEFT"
        set-prompt
        zle reset-prompt
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || \
        [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
        BOTTOM_LEFT="%F{2}● %f"
        [ -z $(venv-name) ] || BOTTOM_LEFT="%F{2}$(venv-name)%f $BOTTOM_LEFT"
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
    PROMPT=$([ ! -z $BUFFER ] && echo "%F{7}● %f" || echo)
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
    vcs_info > /dev/null 2>&1 || return
    local top_left="%F{7}%~%f"
    [ -z $(git-branch) ] || top_left+="%F{8} on %f%F{7}$(git-branch)%f"
    [ -z $(git-status) ] || top_left+=" %F{7}$(git-status)%f"
    [ -z $(git-action) ] || top_left+="%F{8} | %f%F{7}$(git-action)%f"

    PROMPT="$top_left"$'\n'"$BOTTOM_LEFT"
}

function insert-new-line-before-prompt() {
    $NEW_LINE_BEFORE_PROMPT && echo "\n" || NEW_LINE_BEFORE_PROMPT=true
}

function insert-new-line-before-exec() {
    echo
}

autoload -Uz add-zsh-hook
setopt no_prompt_{bang,subst} prompt_{cr,percent,sp}
add-zsh-hook precmd set-prompt
add-zsh-hook precmd insert-new-line-before-prompt
add-zsh-hook preexec insert-new-line-before-exec

# Reset prompt on window resize
TRAPWINCH () {
    set-prompt
    zle reset-prompt &>/dev/null
}
