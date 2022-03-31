#!/usr/bin/env bash
#echo "$(xdotool getactivewindow getwindowname)" 
declare array

TITLE=$(xdotool getwindowfocus getwindowname) 
if [[ "$TITLE" = "i3" ]]; then 
    TITLE=
elif [[ -z "$TITLE" ]]; then
    array=($(echo "$TITLE" | tr " " "^" | tr "-" "\n" | tr "|" "\n" ))
    if [ ${#array[@]} -gt 1 ]; then
        appname=${array[-1]}
        param=${array[-2]}
        param=${param:0:25}
       # parameters=$(parameters:0:40)
        TITLE="$(echo "$param - $appname" | tr "^" " ")"
    fi
fi
echo "$TITLE"
