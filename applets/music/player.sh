#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.dotfiles/applets/music/player.rasi"

# Playerctl data initialization
status=$(playerctl status -s)
s_artist="$(playerctl $ARGUMENTS metadata artist -s)";
s_title=$(playerctl $ARGUMENTS metadata title -s);
current="$s_artist - $s_title";

stop="栗"
next="怜"
previous="玲"

if [ -n $status]; then
    exit;
fi

if [[ "$status" = "Playing" ]]; then
    play_pause="";
else
    play_pause="契";
fi
options="$previous\n$play_pause\n$next\n$stop"
current=${current:0:60}
chosen="$(echo -e "$options" | $rofi_command -p "$current" -dmenu $active $urgent -selected-row 1)"
case $chosen in
    $previous)
        playerctl previous
        ;;
    $play_pause)
        playerctl play-pause
        ;;
    $stop)
        playerctl stop
        ;;
    $next)
        playerctl next
        ;;
esac
