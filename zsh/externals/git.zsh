# Environmental variables
export GIT_EDITOR=$EDITOR

# Functions
function gst() {
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

function gadd() {
    git -c color.status=always status --short | fzf -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' | cut -c4- | sed 's/.* -> //' | xargs -o git add -p
}
