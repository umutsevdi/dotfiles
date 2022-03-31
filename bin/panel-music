#!/usr/bin/env bash
status=$(playerctl status -s)
s_artist="$(playerctl $ARGUMENTS metadata artist -s)";
s_title=$(playerctl $ARGUMENTS metadata title -s);
current="$s_artist - $s_title";

if [ "$status" = "" ]; then
    echo " ";
else
    if [[ "$status" = "Playing" ]]; then
        play_pause="";
    else
        play_pause="";
    fi

    #Display output
    echo "  ${current:0:40} $play_pause"
fi 
# Displays the actively playing music with it's author
# Exit the script if no music players running
