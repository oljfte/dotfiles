function _add-todo {
    local todo_string=$1
    [ -z $todo_string ] && return 1
    osascript << EOS &>/dev/null
        tell application "Reminders"
            tell list "todo"
                set newReminder to make new reminder
                set name of newReminder to "$todo_string" as string
            end tell
        end tell
EOS
    (($?)) || echo "Added $todo_string"
}

function _show-todo {
    osascript << EOS 2>&1
        tell application "Reminders"
            set todoList to reminders in list "todo"
            repeat with n from 1 to count of todoList 
                log "[" & n & "] " & name of item n of todoList
            end repeat
        end tell
EOS
}

function _done-todo {
    local prespecified_index=$1
    [ ! -z $prespecified_index ] && \
        local prespecified_todo_item="[$prespecified_index] $(osascript -e \
        "tell application \"Reminders\" to return name of reminder $prespecified_index in list \"todo\"")"

    IFS=$'\n'
    for todo_item in `[ -z $prespecified_index ] && _show-todo | fzf -w 80 -h 20 || \
        echo $prespecified_todo_item`; do
        local index=$(echo $todo_item | sed -n 's/^\[\([0-9]*\)\].*$/\1/p')
        osascript << EOS 2>&1
            tell application "Reminders"
                delete (reminder $index in list "todo")
            end tell
EOS
    (($?)) || echo "Complete: $todo_item"
    done
    IFS=$' \t\n'
}

function _edit-todo {
    local prespecified_index=$1
    [ ! -z $prespecified_index ] && \
        local prespecified_todo_item="[$prespecified_index] $(osascript -e \
        "tell application \"Reminders\" to return name of reminder $prespecified_index in list \"todo\"")"

    IFS=$'\n'
    for todo_item in `[ -z $prespecified_index ] && _show-todo | fzf -w 80 -h 20 || \
        echo $prespecified_todo_item`; do
        local index=$(echo $todo_item | sed -n 's/^\[\([0-9]*\)\].*$/\1/p')
        [ -z $index ] && return 0
        local temp_file=$(mktemp $TEMP_DIR/todo.XXXXXX)
        osascript << EOS > $temp_file 2>&1
            tell application "Reminders"
                return name of reminder $index in list "todo" as string
            end tell
EOS
        nvim $temp_file
        [ ! -s $temp_file ] && _done-todo $index || osascript << EOS 2>&1
        tell application "Reminders"
            log "Before: [" & $index & "] " & name of reminder $index in list "todo"
            set name of reminder $index in list "todo" to "$(cat $temp_file)"
            log "After : [" & $index & "] " & name of reminder $index in list "todo"
        end tell
EOS
    done
    IFS=$' \t\n'
}

function todo() {
    if (! (($#)) || [ "$1" = "show" ]); then
        _show-todo
    elif [ "$1" = "add" ]; then
        _add-todo $2
    elif [ "$1" = "done" ]; then
        _done-todo $2
    elif [ "$1" = "edit" ]; then
        _edit-todo $2
    fi
}
