#! /bin/bash
# powermenu.sh - Rofi Powermenu
# @author umutsevdi 

dir="$HOME/.dotfiles/applets/powermenu"
rofi_cmd="rofi -theme $dir/config.rasi"
uptime="Uptime: $(uptime -p | sed -e "s/up //g" | sed -e "s/hours/h/g" | sed -e  "s/hour/h/g" | sed -e "s/minutes/min/g")" 

shutdown=""
reboot="勒"
lock=""
logout=""

options="$shutdown\n$reboot\n$lock\n$logout"

chosen="$(echo -e "$options" | $rofi_cmd -p "$uptime" -dmenu -selected-row 1)"

case $chosen in
    $shutdown)
		systemctl poweroff
    ;;
    $reboot)
		systemctl reboot
    ;;
    $lock)
        lockscreen
    ;;
    $logout)
		playerctl pause
		amixer set Master mute
		systemctl suspend
    ;;
esac
