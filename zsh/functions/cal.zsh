#!/bin/zsh

function _convert-date {
    local text_date=$1
    date_string=$(osascript << EOS
        set textDate to "$text_date" as string
        set resultDate to the current date
        set the month of resultDate to (1 as integer)
        set the day of resultDate to (1 as integer)
        
        set the year of resultDate to (text 1 thru 4 of textDate)
        set the month of resultDate to (text 5 thru 6 of textDate)
        set the day of resultDate to (text 7 thru 8 of textDate)
        set the time of resultDate to 0
        
        if (length of textDate) > 10 then
            set the hours of resultDate to (text 9 thru 10 of textDate)
            set the minutes of resultDate to (text 11 thru 12 of textDate)
            
            if (length of textDate) > 16 then
                set the seconds of resultDate to (text 13 thru 14 of textDate)
            end if
        end if
        return resultDate
EOS
    )
    echo $(echo $date_string | sed 's/date /"/')\"
}

function _add-event-to-cal {
    while true; do
        echo -e 'Name: \c'
        read event_name
        [ ! -z "$event_name" ] && \
            tput el && break || \
            (echo "Name cannot be empty. Enter again." && tput cuu 2 && tput el)
    done
    tput cuu1 && tput ich 2 && echo -e "\033[0;32m\xE2\x9C\x94\033[0m"
    while true; do
        echo -e 'Datetime: \c'
        local start_date_date=$(for i in {0..365}; do echo $(date -v +${i}d "+%Y-%m-%d"); done | fzf -w 17 -h 4)
        [ -z $start_date_date ] && return 0
        local start_date_time=$(for i in `seq -w 0 23`; do for j in `seq -w 0 5 55`; do echo $i:$j; done ; done | fzf -w 12 -h 4)
        [ -z $start_date_date ] && return 0
        local start_date=$(echo $start_date_date$start_date_time | sed 's/[^0-9]*//g')
        [[ $start_date -ge $(date "+%Y%m%d%H%M") ]] && \
            tput el && break || \
            (echo "Datetime must be in the future. Enter again." && tput cuu 2 && tput el)
    done
    tput cub 10 && tput el && echo -e "\033[0;32m\xE2\x9C\x94\033[0m Datetime: $start_date_date $start_date_time"
    while true; do
        echo -e 'Duration: \c'
        read duration
        [[ $duration -gt 0 ]] && break || echo "Duration must be a positive value.\n"
    done
    tput cuu 1 && tput el && echo -e "\033[0;32m\xE2\x9C\x94\033[0m Duration: ${duration}h"
    osascript << EOS &>/dev/null
        set formattedStartDate to date $(_convert-date $start_date)
        set formattedEndDate to date $(_convert-date $start_date) + hours * $duration
        log formattedEndDate as string
        tell application "Calendar"
            tell calendar "iCloud"
                make new event with properties ¬
                {summary:"$event_name", start date:formattedStartDate, end date:formattedEndDate}
            end tell
        end tell
EOS
    (($?)) || echo "\nEvent added as shown above."
}

function _delete-event-from-cal {
    IFS=$'\n'
    for target_event in `_show-cal 0 -p | fzf -w 70 -h 15`; do
        IFS=$' \t\n'
        read target_date target_event_name <<< $(echo $target_event | awk -F ' {3,}' '{ gsub(/[^0-9]*/,"", $1); gsub(/[^[:print:]]/,"", $3); print $1, $3 }')

        osascript << EOS
            set formattedTargetDate to date $(_convert-date $target_date)
            tell application "Calendar"
                tell calendar "iCloud"
                    set theEventList to every event where its summary = "$target_event_name" ¬
                        and its start date = formattedTargetDate
                    if theEventList is not {} then
                        set theEvent to first item of theEventList
                        delete theEvent
                    else
                        return
                    end if
                end tell
                save
            end tell
EOS
        (($?)) || echo "Deleted: $target_event"
        IFS=$'\n'
    done
    IFS=$' \t\n' 
}

function _show-cal {
    local temp_file=$(mktemp $TEMP_DIR/cal.XXXXXX)
    [ "$2" = "-p" ] && local rg_query="--files-without-match 'CLASS:PUBLIC'" || rg_query="--files"
    (for event_file in `eval brg -g '*ics' $rg_query ~/Library/Calendars/`; do
        local regex_command=" | sed -E 's/^[A-Z].*:(.*$)/\1/g' | sed -E 's/^([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2})([0-9]{2})([0-9]{2}).*$/\1-\2-\3 \4:\5/g'"
        local start_date=`eval "grep -h -e 'DTSTART' $event_file $regex_command"`
        if [[ $start_date =~ ^[0-9]{8} ]]; then start_date=$(date -j -f "%Y%m%d " $start_date +%Y-%m-%d); fi
        local end_date=`eval "grep -h -e 'DTEND' $event_file $regex_command"`
        local summary=`eval "grep -h -e 'SUMMARY' $event_file $regex_command"`
        local search_range=$([[ $1 -eq 0 ]] && echo 36500 || echo ${1:-1})
        if [[ ($start_date > $(date '+%Y-%m-%d %H:%M')) && ($start_date < $(date -v +${search_range}d '+%Y-%m-%d')) ]]; then
            if [[ $start_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then
                if [[ ${#start_date} -eq 16 ]]; then
                    duration_hours=$(( ($(date -j -f "%Y-%m-%d %H:%M" "$end_date" +%s) - $(date -j -f "%Y-%m-%d %H:%M" "$start_date" +%s))/3600 ))
                    duration_minutes=$(( ($(date -j -f "%Y-%m-%d %H:%M" "$end_date" +%s) - $(date -j -f "%Y-%m-%d %H:%M" "$start_date" +%s))/60 % 60 ))
                    echo "$start_date    $(printf '%2d' ${duration_hours})h $(printf '%2d' ${duration_minutes})m     $summary"
                else 
                    echo "$start_date --:--     -h  -m     $summary"
                fi
            fi
        fi
    done) > $temp_file
    sort $temp_file -o $temp_file
    cat $temp_file
    rm $temp_file
}

function cal {
    if [ "$1" = "show" ]; then
        echo
        /usr/bin/cal -3
        echo
        repeat 64 printf "\e[37;1m-\e[m"
        echo "\n"
        _show-cal ${2:-1}
    elif [ "$1" = "add" ]; then
        _add-event-to-cal
    elif [ "$1" = "delete" ]; then
        _delete-event-from-cal
    else
        /usr/bin/cal $* 2>/dev/null || echo "Invalid action."
    fi
}
