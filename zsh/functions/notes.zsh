#!/bin/zsh

FOLDER_NAME="CLI"

function _get-note() {
    local note_title=$1
    echo "$(osascript -e "tell application \"Notes\" to return body of note \"$note_title\" \
        in folder \"$FOLDER_NAME\" in account \"iCloud\"" | \
        sed 's/<\/div> <div>/\n/g' | sed 's/<[^>]*>//g' | tail -n +2)"
}

function _get-notes-list() {
    echo "$(osascript -e "tell application \"Notes\" to \
        repeat with theNote in notes in folder \"$FOLDER_NAME\" in account \"iCloud\"" \
        -e "log name of theNote as string" \
        -e "end repeat" 2>&1)"
}

function _edit-note() {
    local note_title=$1
    local note_body=$2
    osascript -e "tell application \"Notes\" to \
        if (exists note \"$note_title\" in folder \"$FOLDER_NAME\" in account \"iCloud\") then" \
        -e "set body of note \"$note_title\" to \"$note_body\"" \
        -e "else" \
        -e "make new note with properties {name:\"$note_title\", body:\"$note_body\"}" \
        -e "end if" 1>/dev/null
}

function _delete-note() {
    local selected_notes=$(_get-notes-list | sort -r | fzf -w 80 -h 25 --preview-window right:80%:wrap \
        --preview "osascript -e 'tell application \"Notes\" to return body of note \"{}\" \
        in folder \"$FOLDER_NAME\" in account \"iCloud\"' \
        | sed 's/<\/div> <div>/\n/g' | sed 's/<[^>]*>//g' | tail -n +2")

    for note_title in $selected_notes; do
        osascript -e "tell application \"Notes\" to delete note \"$note_title\" \
            in folder \"$FOLDER_NAME\" in account \"iCloud\""
    done
}

function _format-file-as-note() {
    local file_path=$1
    echo "<div>$(awk -v ORS='</div><div>' '1' $file_path)</div>"
}

function _note-exists() {
    local note_title=$1
    echo $(osascript -e "tell application \"Notes\" to \
        if (exists note \"$note_title\" in folder \"$FOLDER_NAME\" in account \"iCloud\") then" \
        -e "return 1" \
        -e "else" \
        -e "return 0" \
        -e "end if")
}

function _open-note() {
    if [ "$1" = "new" ]; then
        local selected_notes=$(date '+%Y%m%d')
    else
        local selected_notes=$(_get-notes-list | sort -r | fzf -w 80 -h 25 --preview-window right:80%:wrap \
            --preview "osascript -e 'tell application \"Notes\" to return body of note \"{}\" \
            in folder \"$FOLDER_NAME\" in account \"iCloud\"' \
            | sed 's/<\/div> <div>/\n/g' | sed 's/<[^>]*>//g' | tail -n +2")
    fi
    
    for note_title in $selected_notes; do
        temp_file="$TEMP_DIR/note-$note_title.txt"
        (($(_note-exists $note_title))) && _get-note $note_title > $temp_file
        nvim $temp_file
        if [ -f $temp_file ]; then
            note_body=$(_format-file-as-note $temp_file)
            (($(_note-exists $note_title))) && note_body="<div>${note_title}</div>$note_body"
            _edit-note $note_title $note_body
            rm $temp_file
        else
            return 0
        fi
    done
}

function notes() {
    if ! (($#)) || [ "$1" = "new" ]; then
        _open-note $1
    elif [ "$1" = "delete" ]; then
        _delete-note
    elif [ "$1" = "list" ]; then
        _get-notes-list
    else
        echo "Invalid action."
    fi
}
