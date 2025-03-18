#!/usr/bin/env sh
string_match='CLIPBOARD_STATE=nil'
old_lines=1
temp_file=$(mktemp)

wl-paste --watch sh -c "env | grep CLIPBOARD_STATE" > $temp_file &

while true; do
    inotifywait -e modify $temp_file

    # Check if current number of lines are equal to old_lines - 1
    # Also check if last line is =nil
    if [ $old_lines -eq $(( $(wc -l $temp_file | sed 's/\s.*$//') - 1)) \
        -a "$(tail -n 1 $temp_file)" == "$string_match" ]; then
        cliphist list | head -n1 | cliphist delete
        notify-send "Cleared clipboard!"
    fi

    old_lines=$(wc -l $temp_file | sed 's/\s.*$//')
done
