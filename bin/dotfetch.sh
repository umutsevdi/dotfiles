#! /bin/bash
# Restarts all graphical services while updating their values

cd $HOME/.config
rm -rf i3 kitty polybar gtk conky
cp -r $HOME/.dotfiles/conky/ $HOME/.config/conky/
cp -r $HOME/.dotfiles/gtk/ $HOME/.config/gtk/
cp -r $HOME/.dotfiles/i3/ $HOME/.config/i3/
cp -r $HOME/.dotfiles/kitty $HOME/.config/kitty
cp -r $HOME/.dotfiles/polybar $HOME/.config/
cp -r $HOME/.dotfiles/.bashrc $HOME/.bashrc
sudo cp $HOME/.dotfiles/.bashrc /root/.bashrc

i3 restart
