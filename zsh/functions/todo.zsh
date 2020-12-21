call_todo_functions=$(cat << EOS
    to addTodo(todoStr)
        tell application "Reminders"
            tell list "todo"
                set newReminder to make new reminder
                set name of newReminder to todoStr as string
                log "Added " & todoStr
            end tell
        end tell
    end addTodo

    to showTodo()
        tell application "Reminders"
            set todoList to reminders in list "todo"
            repeat with n from 1 to count of todoList 
                log "[" & n & "] " & name of item n of todoList
            end repeat
        end tell
    end showTodo

    to doneTodo(index)
        tell application "Reminders"
            log "Complete: [" & index & "] " & name of reminder index in list "todo"
            delete (reminder index in list "todo")
        end tell
    end doneTodo

    to editTodo(index, todoStr)
        tell application "Reminders"
            log "Before: [" & index & "] " & name of reminder index in list "todo"
            set name of  reminder index in list "todo" to todoStr
            log " After: [" & index & "] " & name of reminder index in list "todo"
        end tell
    end doneTodo
EOS
)

function todo() {
    unset calendar_action
    if [ "$1" = "show" ]; then
        todo_action="showTodo()"
    elif [ "$1" = "add" ]; then
        todo_action="addTodo(\"$2\")"
    elif [ "$1" = "done" ]; then
        todo_action="doneTodo($2)"
    elif [ "$1" = "edit" ]; then
        todo_action="editTodo($2, \"$3\")"
    fi
    [[ -v todo_action ]] && osascript -e "$call_todo_functions" -e "$todo_action"
}
