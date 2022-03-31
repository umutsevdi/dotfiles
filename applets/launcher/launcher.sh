#!/usr/bin/env bash

theme="appfolder"
dir="$HOME/.dotfiles/applets/launcher"
rofi -no-lazy-grab -show combi -combi-modi drun -theme $dir/"$theme" -show-combi
