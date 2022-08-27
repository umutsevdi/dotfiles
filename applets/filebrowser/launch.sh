#! /bin/bash
# launcher.sh - Rofi App Launcher, is a dmenu like graphical app launcher
# @author umutsevdi 
# @requires rofi

theme="config"
dir="$HOME/.dotfiles/applets/filebrowser"
rofi -show filebrowser -theme $dir/"$theme"
