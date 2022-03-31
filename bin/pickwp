#! /bin/bash
# Randomly picks a wallpaper from $HOME/.dotfiles/wallpapers
# Selects a different wallpaper each time
# Applies the wallpaper to all monitors

IMG_PATH="$HOME/.dotfiles/wallpapers/$(ls $HOME/.dotfiles/wallpapers | shuf -n 1)"
OLD_PATH=$(cat /tmp/pickwp_img)
while [ "$IMG_PATH" = "$OLD_PATH" ]; do
    IMG_PATH="$HOME/.dotfiles/wallpapers/$(ls $HOME/.dotfiles/wallpapers | shuf -n 1)"
done
echo $IMG_PATH > /tmp/pickwp_img

for (( i=0; i < 2; i++ )); do 
    nitrogen --set-scaled --head=$i $IMG_PATH --save
done


