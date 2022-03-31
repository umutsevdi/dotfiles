#!/usr/bin/env bash

dir="$HOME/.dotfiles/applets/powermenu"
rofi_command="rofi -theme $dir/powermenu.rasi"

uptime=$(uptime -p | sed -e "s/up //g" | sed -e "s/hours/h/g" | sed -e  "s/hour/h/g" | sed -e "s/minutes/min/g")

shutdown=""
reboot=""
lock=""
suspend=""
logout=""

options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 1)"
case $chosen in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
        PICTURE=/tmp/i3lock.png
        SCREENSHOT="scrot $PICTURE"
        BLUR="16x9"
        $SCREENSHOT
        convert $PICTURE -blur $BLUR -flatten $PICTURE
        i3lock -i $PICTURE
        rm $PICTURE
        ;;
    $suspend)
		playerctl pause
		amixer set Master mute
		systemctl suspend
        ;;
    $logout)
        xfce4-session-logout --logout
        ;;
esac
