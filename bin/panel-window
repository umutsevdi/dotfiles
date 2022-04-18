#!/usr/bin/env bash
#echo "$(xdotool getactivewindow getwindowname)" 
declare array

TITLE=$(xdotool getwindowfocus getwindowname) 
if [[ "$TITLE" = "i3" ]]; then 
    TITLE=
elif [[ -z "$TITLE" ]]; then
    array=($(echo "$TITLE" | tr " " "^" | tr "-" "\n" | tr "|" "\n" ))
    if [ ${#array[@]} -gt 1 ]; then
        appname=${array[-1]:0:25}
        param=${array[-2]:0:25}
        param=${param:0:25}
       # parameters=$(parameters:0:40)
        TITLE="$(echo "$param - $appname" | tr "^" " ")"
    fi
fi
#echo "$TITLE"

active_window=$(xprop -root _NET_ACTIVE_WINDOW|cut -d ' ' -f 5|sed -e 's/../0&/2')

current_display=$(wmctrl -d|grep "*"|awk '{print $1}')
color1="a2d1ec" # Blue

active_window_decoration_style_left_side="%{F#$color1}%{+u}%{u#$color1}"
active_window_decoration_style_right_side="%{-u}%{F-}"

current_windows=$(wmctrl -lx|awk -v current_display="$current_display" -v active_window="$active_window" -v active_window_decoration_style_left_side="$active_window_decoration_style_left_side" -v active_window_decoration_style_right_side="$active_window_decoration_style_right_side" '
	{if ($2==current_display) {
		split($3,window_title,".")
		if ($1==active_window) {
			window_title[1]=active_window_decoration_style_left_side window_title[1] active_window_decoration_style_right_side
			}
		print "%{A1: wmctrl -ia "$1" & disown:}"window_title[1]"%{A}"
		}
	}')
echo $current_windows
