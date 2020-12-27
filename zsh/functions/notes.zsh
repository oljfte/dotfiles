#!/bin/zsh

call_notes_functions=$(cat << EOS
    to getNote(noteTitle)
        tell application "Notes"
            tell account "iCloud"
                tell folder "Notes"
                    return body of note noteTitle as string
                end tell
            end tell
        end tell
    end getNote

    to editNote(noteTitle, noteBody)
        tell application "Notes"
            tell account "iCloud"
                tell folder "Notes"
                    if (exists note noteTitle) then
                        set body of note noteTitle to noteBody
                    else
                        make new note with properties {name:noteTitle as string, body:noteBody as string}
                    end if
                end tell
            end tell
        end tell
    end editNote

    to deleteNote(noteTitle)
        tell application "Notes"
            tell account "iCloud"
                tell folder "Notes"
                    delete note noteTitle
                end tell
            end tell
        end tell
    end deleteNote

    to getNoteList()
        tell application "Notes"
            tell account "iCloud"
                repeat with theNote in notes in folder "Notes"
                   return name of theNote as string 
                end repeat
            end tell
        end tell
    end getNoteList

    to checkIfNoteExists(noteTitle)
        tell application "Notes"
            tell account "iCloud"
                tell folder "Notes"
                    if (exists note noteTitle) then
                        return 1
                    else
                        return 0
                    end if
                end tell
            end tell
        end tell
    end checkIfNoteExists
EOS
)

function open-note() {
    date=${1:-$(date '+%Y%m%d')}
    temp_file="$TEMP_DIR/note-$date.txt"
    note_exists=$(osascript -e "$call_notes_functions" -e "checkIfNoteExists(\"$date\")")
    if [[ $note_exists -eq 1 ]]; then
        echo $(osascript -e "$call_notes_functions" -e "getNote(\"$date\")") > $temp_file
        plain_txt_buffer=$(html2text $temp_file | tail -n +2)
        echo $plain_txt_buffer > $temp_file
    fi
    nvim $temp_file
    note_body="<div>$(awk -v ORS='</div><div>' '1' $temp_file)</div>"
    [[ $note_exists -eq 1 ]] && note_body="<div>${date}</div>$note_body"
    osascript -e "$call_notes_functions" -e "editNote(\"$date\", \"$note_body\")" 1>/dev/null
    rm $temp_file
}

function notes() {
    unset notes_action
    notes_args="\"${${@:2}//${IFS:0:1}/\",\"}\""
    if [ "$1" = "open" ]; then
        open-note $2
    elif [ "$1" = "delete" ]; then
        if [ ! -z "$2" ]; then
            osascript -e "$call_notes_functions" -e "deleteNote(\"$2\")"
        else
            echo "Specify date."
        fi
    elif [ "$1" = "list" ]; then
        osascript -e "$call_notes_functions" -e "getNoteList()"
    else
        echo "Invalid action."
    fi
}
