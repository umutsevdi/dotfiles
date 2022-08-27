#! /bin/bash
# launcher.sh - Rofi App Launcher, is a dmenu like graphical app launcher
# @author umutsevdi 
# @requires rofi

theme="config"
dir="$HOME/.dotfiles/applets/tab"
rofi -show window  -theme $dir/"$theme" 
