# Environmental variables
export GIT_EDITOR=$EDITOR

# Functions
function is_in_git_repo {
    git rev-parse HEAD > /dev/null 2>&1
}

function grst { # Recursive status
    for x in $(\fd -t d -H ".git" .); do
        pushd $(dirname $x) >/dev/null
        printf "\e[37;1m\n$(pwd)\n\e[m"
        git status -s 2>/dev/null
        [ -z "$(git status -s)" ] && echo "Nothing to commit, working tree clean."
        popd >/dev/null
        echo
    done
}

function fgadd {  # Add helper
    is_in_git_repo || return
    git -c color.status=always status --short | fzf -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' | cut -c4- | sed 's/.* -> //' | xargs -o git add -p
}

function fghash {  # Find commit hash
    is_in_git_repo || return
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
        fzf --ansi --no-sort --reverse --multi \
        --preview 'echo {} | sed "s/[^a-z0-9 ]//g" | sed "s/  */ /g" | sed "s/^  *//g" | cut -f 2 -d " " | xargs git show --color=always' |
        sed "s/[^a-z0-9 ]//g" | sed "s/  */ /g" | sed "s/^  *//g" | cut -f 2 -d " "
}

function fgfile {  # Find file
    is_in_git_repo || return
    git -c color.status=always status --short |
        fzf -m --ansi --nth 2..,.. --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
        cut -c4- | sed 's/.* -> //'
}

function fgbranch {  # Find branch
    is_in_git_repo || return
    git branch -a --color=always | grep -v '/HEAD\s' | sort |
        fzf --ansi --multi --tac --preview-window right:70% \
        --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
        sed 's/^..//' | cut -d' ' -f1 |
        sed 's#^remotes/##'
}

function fgtag {  # Find tag
    is_in_git_repo || return
    git tag --sort -version:refname |
        fzf --multi --preview-window right:70% \
        --preview 'git show --color=always {}'
}

bindkey -r '^]'

function join-lines {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

for c in hash file branch tag; do
    eval "fg$c-widget() { local result=\$(fg$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fg$c-widget"
    eval "bindkey '^]${c:0:1}' fg$c-widget"
done
