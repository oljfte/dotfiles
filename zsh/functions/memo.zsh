function memo() {
    memodir=$DOCUMENTS/memo
    date=$(date "+%Y%m%d")
    # Remove empty memo
    for file in $memodir/*.md; do
        if [ ! -s $file ]; then
            rm $file
        fi
    done
    # Show list of memo
    if [ "$1" = "list" ]; then
        find $memodir -name \*.md -mtime -30 | xargs -n 1 basename
        return
    # Delete memo
    elif [ "$1" = "delete" ]; then
        filename="$date.md"
        filepath="$memodir/${filename}"
        if [ "$2" = "today" ]; then
            rm $filepath
            echo "Deleted $filepath"
            return
        else
            rm "$memodir/$2.md"
            echo "Deleted $memodir/$2.md"
            return
        fi
    # Cat previous memo
    elif [ "$1" = "prev" ]; then
        filename=$(echo $memodir/*.md([-${2:-"1"}]))
        echo -e "# ${filename: -11:8}\n\n"
        cat "$filename"
        echo -e "\n\n"
    # Edit memo
    else
        filename="${1:-$date}.md"
        filepath="$memodir/${filename}"
        if [ ! -f $filepath ]; then
            if [ "$filename" = $(date "+%Y%m%d.md") ]; then
                vim $filepath
            else
                echo "No memo found on that day."
            fi
        else
            if [ "$filename" = $(date "+%Y%m%d.md") ]; then
                vim $filepath
            else
                vim -R $filepath
            fi
        fi
    fi
}
