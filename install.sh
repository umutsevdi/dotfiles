#!/bin/bash

echo "Begin: ./install.sh - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "
cd $HOME

mkdir /tmp/install
echo "fastestmirror=true
deltarpm=true" >> /etc/dnf/dnf.conf

## UPATE ##
echo "Installing RPM Repositories"
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm >> /tmp/install/rpm.logs
dnf install -y  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm >> /tmp/install/rpm.logs
dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo >> /tmp/install/rpm.logs
echo "Updating programs and drivers"
dnf update --refresh -y
dnf group update -y core >> /tmp/install/update.logs
dnf group update -y --with-optional Multimedia >> /tmp/install/update.logs

echo "Installing i3 window manager & compositor"
dnf install -y --allowerasing i3-gaps compton >> /tmp/install/i3.logs
dnf install picom -y --allowerasing
dnf install akmod-nvidia -y
## REQUIRED PROGRAMS ##
echo "Installing rofi, conky, cheese, github-cli, lightdm-greeter settings and nitrogen\nUpdating Thunar plugins"
dnf install -y rofi conky thunar* cheese gh lightdm-gtk-greeter-settings nitrogen

echo "Installing common programs:\ndiscord, telegram, steam"
dnf install -y discord telegram steam
echo "Installing neovim, flatpak"
dnf install neovim

dnf install -y flatpak >> /tmp/install/flatpak.logs
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  
flatpak update
echo "Installing Postman, Spotify, Github GUI from Flatpak"
flatpak install com.getpostman.Postman  com.spotify.Client io.github.shiftey.Desktop 

echo "Installing JetBrains Toolbox"
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash


## Symbolic Links ##
echo "Extracting .dotfile configurations"
cp $HOME/.dotfiles/.bashrc .bashrc
cp $HOME/.dotfiles/.bashrc /root/.bashrc
rm $HOME/.config/i3/config
ln -s $HOME/.dotfiles/i3/config $HOME/.config/i3/config
rm -rf $HOME/.config/autostart
ln -s $HOME/.dotfiles/autostart $HOME/.config/autostart
rm  -rf $HOME/.config/conky
ln -s $HOME/.dotfiles/conky $HOME/.config/conky
cp $HOME/.dotfiles/gtk/bookmarks $HOME/.config/gtk-3.0/bookmarks

echo "Installing nodeJS"
dnf module install nodejs:16/default -y
dnf install g++
## neovim CONFIG ##
echo "Configuring Neovim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir $HOME/.config/neovim
echo "source $HOME/.dotfiles/nvim/init.vim" >> $HOME/.config/nvim/init.vim

## xfce4 CONFIG ##
echo "Copying xfce config"
cp -r $HOME/.dotfiles/xfce4 $HOME/.config/

## UNINSTALLING UNNECESSARY PROGRAMS ##
echo "Uninstalling unnecessary programs
dnf -y remove galculator asunder gnumeric gparted parole rxvt xfburn xfdashboard claws-mail pidgin clamtk pragha
dnf clean all
echo "End: ./install.sh - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "

## Optional
# vim
# go install golang.org/x/tools/gopls@latest
# npm i -g coc-clangd
