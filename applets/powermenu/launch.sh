#! /bin/bash
# powermenu.sh - Rofi Powermenu
# @author umutsevdi 

dir="$HOME/.dotfiles/applets/powermenu"
rofi_cmd="rofi -theme $dir/config.rasi"
uptime="`uptime -p | sed -e "s/up //g" | sed -e "s/hours/h/g" | sed -e  "s/hour/h/g" | sed -e "s/minutes/min/g"`"

shutdown=""
reboot="勒"
lock=""
sleep=⏾

options="$shutdown\n$reboot\n$lock\n$sleep"

chosen="`echo -e "$options" | $rofi_cmd -p "$uptime" -dmenu -selected-row 1`"

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
    $sleep)
        killall dunst
		playerctl pause
        (( `amixer get Master  | grep "\[on\]" | wc -l` > 0 )) && amixer set Master mute
		systemctl suspend

        if ! command -v lockscreen &> /dev/null ; then
            echo "lockscreen doesn't exist, falling back to i3lock" 1>&2
            i3lock
        else
            lockscreen
        fi

        (( `ps -aux | grep 'dunst' | wc -l` == 0 )) && dunst -conf $HOME/.dotfiles/dunst/dunstrc
        (( `amixer get Master  | grep "\[off\]" | wc -l` > 0 )) && amixer set Master unmute
    ;;
esac
