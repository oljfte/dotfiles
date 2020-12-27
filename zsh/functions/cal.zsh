#!/bin/zsh

call_calendar_functions=$(cat << EOS
    to convertDate(textDate)
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
    end convertDate

    to addEventToCalendar(startDate, duration, eventName)
        set formattedStartDate to convertDate(startDate)
        set formattedEndDate to convertDate(startDate) + hours * duration
        tell application "Calendar"
            tell calendar "iCloud"
                make new event with properties {summary:eventName as string, start date:formattedStartDate, end date:formattedEndDate}
            end tell
        end tell
    end addEventToCalendar

    to deleteEventFromCalendar(targetDate, eventName)
        set formattedTargetDate to convertDate(targetDate)
        tell application "Calendar"
            tell calendar "iCloud"
                set theEventList to every event where its start date ≥ formattedTargetDate and end date ≤ formattedTargetDate + 1 * days and summary is equal to eventName as string
                if theEventList is not {} then
                    set theEvent to first item of theEventList
                    delete theEvent
                else
                    return
                end if
            end tell
            save
        end tell
    end deleteEventFromCalendar

    to modifyEventOnCalendar(targetDate, targetEventName, modifiedStartDate, modifiedDuration, modifiedEventName)
        deleteEventFromCalendar(targetDate, targetEventName)
        addEventToCalendar(modifiedStartDate, modifiedDuration, modifiedEventName)
    end modifyEventOnCalendar 
EOS
)

function show-cal() {
    temp_file=$(mktemp $TEMP_DIR/cal.XXXXXX)
    (for event_file in `find ~/Library/Calendars -name "*.ics"`; do
        regex_command=" | sed -E 's/^[A-Z].*:(.*$)/\1/g' | sed -E 's/^([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2})([0-9]{2})([0-9]{2}).*$/\1-\2-\3 \4:\5/g'"
        start_date=`eval "grep -h -e 'DTSTART' $event_file $regex_command"`
        if [[ $start_date =~ ^[0-9]{8} ]]; then start_date=$(date -j -f "%Y%m%d " $start_date +%Y-%m-%d); fi
        end_date=`eval "grep -h -e 'DTEND' $event_file $regex_command"`
        summary=`eval "grep -h -e 'SUMMARY' $event_file $regex_command"`
        if [[ ($start_date > $(date '+%Y-%m-%d %H:%M')) && ($start_date < $(date -v +${1:-1}d '+%Y-%m-%d')) ]]; then
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

function cal() {
    unset calendar_action
    cal_args="\"${${@:2}//${IFS:0:1}/\",\"}\""
    if [ "$1" = "show" ]; then
        echo
        /usr/bin/cal -3
        echo
        repeat 64 printf "\e[37;1m-\e[m"
        echo "\n"
        show-cal ${2:-1}
    elif [ "$1" = "add" ]; then
        echo "Add event $2 $3 $4"
        calendar_action="addEventToCalendar($cal_args)"
    elif [ "$1" = "modify" ]; then
        calendar_action="modifyEventOnCalendar($cal_args)"
    elif [ "$1" = "delete" ]; then
        calendar_action="deleteEventFromCalendar($cal_args)"
    else
        /usr/bin/cal $* 2>/dev/null || echo "Invalid action."
    fi
    [[ -v calendar_action ]] && osascript -e "$call_calendar_functions" -e "$calendar_action" 1>/dev/null
}
