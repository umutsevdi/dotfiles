#! /bin/bash
# Restarts all graphical services while updating their values

cd $HOME/.config
rm -rf i3 kitty polybar gtk-3.0 conky
cp -r $HOME/.dotfiles/conky/ $HOME/.config/conky/
cp -r $HOME/.dotfiles/gtk/ $HOME/.config/gtk-3.0/
cp -r $HOME/.dotfiles/i3/ $HOME/.config/i3/
cp -r $HOME/.dotfiles/kitty $HOME/.config/kitty
cp -r $HOME/.dotfiles/polybar $HOME/.config/
cp -r $HOME/.dotfiles/.bashrc $HOME/.bashrc
if [[ "$1" = "--root" ]]; then
    sudo cp $HOME/.dotfiles/.bashrc /root/.bashrc
fi
i3-msg restart
notify-send 'i3 Window Manager' 'WM has been restarted with updated configurations' --app-name="Resize Window" --icon=window_list --category='presence'
