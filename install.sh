#!/bin/bash
cd $HOME
mv $HOME/dotfiles $HOME/.dotfiles
echo "Begin: ./install.sh - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "

mkdir /tmp/install
echo "write: \nfastestmirror=True\ndeltarpm=True\nto  /etc/dnf/dnf.conf"

## UPATE ##
echo "Installing RPM Repositories"
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm >> /tmp/install/rpm.logs
dnf install -y  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm >> /tmp/install/rpm.logs
dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo >> /tmp/install/rpm.logs
echo "Updating programs and drivers"
dnf update --refresh -y
dnf group update -y core >> /tmp/install/update.logs
dnf group update -y --with-optional Multimedia >> /tmp/install/update.logs

## GRAPHIC UTILS ##
echo "Installing and configuring Graphical Utility Tools"
dnf install sddm -y >> /tmp/install/graphic.logs
systemctl enable sddm >> /tmp/install/graphic.logs
systemctl set-default graphical.target >> /tmp/install/graphic.logs
## Directories ##
mkdir .config .cache .themes
mkdir Documents Downloads Music Pictures Public src Templates Videos

echo "Installing i3 window manager & compositor"
dnf install -y --allowerasing i3-gaps picom >> /tmp/install/i3.logs
dnf install -y --allowerasing kitty polybar
echo "edit /etc/sddm.conf\nSet session to i3"
if [[ "$1" = "--enable-nvidia" ]];then
    dnf install akmod-nvidia -y
fi
## REQUIRED PROGRAMS ##
echo "Installing basic programs" 
dnf install -y thunar nitrogen gedit
## COMMONLY USED PROGRAMS ##
echo "Installing neovim"
dnf install neovim gh -y
echo "Installing nodeJS"
dnf module install nodejs:16/default -y
dnf install g++ -y

## neovim CONFIG ##
echo "Configuring Neovim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
npm install -g neovim
npm install -g coc-clangd
npm install bash-language-server

echo "Installing common programs:\ndiscord, telegram, steam"
dnf install -y discord telegram steam 
dnf install -y rofi conky cheese
dnf install -y flatpak >> /tmp/install/flatpak.logs
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  
flatpak update
echo "Installing Postman, Spotify, Github GUI from Flatpak"
flatpak install com.getpostman.Postman  com.spotify.Client io.github.shiftey.Desktop 

echo "Installing JetBrains Toolbox"
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash


## Symbolic Links ##
echo "Extracting .dotfile configurations"
chmod +x $HOME/.dotfiles/bin/*
rm -rf $HOME/.config/autostart
ln -s $HOME/.dotfiles/autostart $HOME/.config/autostart
$HOME/.dotfiles/bin/dotfetch --root

## UNINSTALLING UNNECESSARY PROGRAMS ##
echo "Uninstalling unnecessary programs"
dnf -y remove galculator asunder gnumeric gparted parole rxvt xfburn xfdashboard claws-mail pidgin clamtk pragha
dnf clean all
echo "End: ./install.sh - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "

mkdir $HOME/.local $HOME/.local/fonts $HOME/.themes
echo "Installing Fonts"
mkdir /usr/share/fonts/jetbrains-mono
cd  /usr/share/fonts/jetbrains-mono
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
unzip JetBrainsMono*
..
mkdir droidsans-nerd-fonts
cd droidsans-nerd-fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
unzip DroidSansMono* 
..
echo "Installing icons"
cd /usr/share/icons/
wget https://github.com/bikass/kora/archive/refs/tags/v1.5.1.zip
unzip *.zip
dnf install flat-remix-theme
$HOME/.dotfiles/dotfetch
## Optional
# vim
# go install golang.org/x/tools/gopls@latest
# npm i -g coc-clangd
