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

echo $chosen
case $chosen in
    $shutdown)
                echo "shutting down"
		systemctl poweroff
    ;;
    $reboot)
                echo "rebooting"
		systemctl reboot
    ;;
    $lock)
        echo "locking"
         if ! command -v cinnamon-screensaver-command &> /dev/null ; then
            echo "cinnamon-screensaver doesn't exist, falling back to lockscreen" 1>&2
            lockscreen
        elif ! command -v lockscreen &> /dev/null ; then
            echo "lockscreen doesn't exist, falling back to i3lock" 1>&2
            i3lock
        else
            cinnamon-screensaver-command --activate
        fi
    ;;
    $sleep)
        echo "hibernate"
        killall dunst
		playerctl pause
        (( `amixer get Master  | grep "\[on\]" | wc -l` > 0 )) && amixer set Master mute
		systemctl suspend

        if ! command -v cinnamon-screensaver-command &> /dev/null ; then
            echo "cinnamon-screensaver doesn't exist, falling back to lockscreen" 1>&2
            lockscreen
        elif ! command -v lockscreen &> /dev/null ; then
            echo "lockscreen doesn't exist, falling back to i3lock" 1>&2
            i3lock
        else
            cinnamon-screensaver-command --activate
        fi

        (( `ps -aux | grep 'dunst' | wc -l` == 0 )) && dunst -conf $HOME/.dotfiles/dunst/dunstrc
        (( `amixer get Master  | grep "\[off\]" | wc -l` > 0 )) && amixer set Master unmute
    ;;
esac
