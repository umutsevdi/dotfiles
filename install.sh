#!/bin/bash

Help()
{
   # Display Help
   echo "Umut Sevdi\'s install script for Fedora Linux"
   echo
   echo "Syntax: scriptTemplate [-h/c|n] -i"
   echo "options:"
   echo "-h/--help            Prints this menu."
   echo "-i/--install         Starts installation."
   echo "-c/--common          Installs common programs."
   echo "-n/--nvidia          Installs Nvidia softwares."
   echo
}

Install()
{
    cd $HOME
    cp $HOME/dotfiles $HOME/.dotfiles
    echo "Begin: ./install.sh - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "
    mkdir /tmp/install
    ## UPATE ##
    echo "Enabling RPM Repositories"

    dnf -y install dnf-plugins-core
    dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm >> /tmp/install/rpm.logs
    dnf install -y  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm >> /tmp/install/rpm.logs
    dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo >> /tmp/install/rpm.logs
    dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo >> /tmp/instal/rpm.logs
    echo "Upgrading programs and drivers"
    dnf update --refresh -y
    ## GRAPHIC UTILS ##
    echo "Installing and configuring Graphical Utility Tools"
    dnf install sddm -y >> /tmp/install/graphic.logs
    systemctl enable sddm >> /tmp/install/graphic.logs
    systemctl set-default graphical.target >> /tmp/install/graphic.logs
    ## Directories ##
    mkdir .config .cache .themes
    mkdir Documents Downloads Music Pictures Public src Templates Videos

    echo "Installing i3 window manager & compositor"
    dnf install -y --allowerasing i3-gaps picom rofi
    dnf install -y --allowerasing kitty polybar
    echo "edit /etc/sddm.conf\nSet session to i3"
    if [[ "$NVIDIA" = "t" ]];then
        dnf install akmod-nvidia -y
    fi
    ## REQUIRED PROGRAMS ##
    echo "Installing basic programs" 
    dnf install -y firefox nautilus nitrogen gedit
    ## CLI PROGRAMS ##
    echo "Installing CLI tools"
    dnf install neovim gh -y
    dnf module install nodejs:16/common -y
    dnf install g++ -y
    ## DOCKER
    dnf install docker
    systemctl start docker
    systemctl enable docker
    ## neovim CONFIG ##
    echo "Configuring Neovim"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    npm install -g neovim
    npm install -g coc-clangd
    npm install bash-language-server
    mkdir $HOME/.config/nvim
    echo "source $HOME/.dotfiles/nvim/init.vim" >> $HOME/.config/nvim/init.vim
    if [[ "$COMMON" = "t" ]];then
        echo "Installing Common Programs"
        dnf install -y discord steam 
        dnf install -y conky
        dnf install -y flatpak >> /tmp/install/flatpak.logs
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  
        flatpak update
        flatpak install com.getpostman.Postman  com.spotify.Client io.github.shiftey.Desktop com.github.tchx84.Flatseal com.microsoft.Teams fr.natron.Natron org.libreoffice.LibreOffice org.telegram.desktop org.videolan.VLC 
    fi
        echo "Installing JetBrains Toolbox"
    curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash

    ## Symbolic Links ##
    echo "Extracting .dotfile configurations"
    chmod +x $HOME/.dotfiles/bin/*
    rm -rf $HOME/.config/autostart
    ln -s $HOME/.dotfiles/autostart $HOME/.config/autostart
    $HOME/.dotfiles/bin/dotfetch --root
    mkdir $HOME/.local $HOME/.local/fonts $HOME/.themes
    echo "Installing Fonts"
    mkdir /usr/share/fonts/jetbrains-mono
    cd  /usr/share/fonts/jetbrains-mono
    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
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
    dnf install flat-remix-gtk* -y
    gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Dark"
    $HOME/.dotfiles/dotfetch
    mv /tmp/install $HOME/install
    ## Optional
    # vim
    # go install golang.org/x/tools/gopls@latest
    # npm i -g coc-clangd
    echo "write: \nfastestmirror=True\ndeltarpm=True\nto  /etc/dnf/dnf.conf"
    ## END OF INSTALL ##
    dnf clean all
    echo "End: ./install.sh - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "
    echo "INSTALL SUCCESSFUL"
    echo "Type Y to reboot"
    read RESTART

    if [[ "$RESTART" = "Y" ]];then 
        reboot
    fi
}
for arg in $@;do
    case $arg in
        -h | --help)
            HELP="t"
        ;;
        -n | --nvidia)
            echo "Nvidia software updates are enabled"
            NVIDIA="t"
        ;;
        -c | --common)
            echo "Common software install is enabled"
            COMMON="t"
        ;;
        -i | --install)
            INSTALL="t"
        ;;
        \?)
            echo -e "Error: Invalid arguments"
            exit
        ;;
    esac
done
if [[ "$INSTALL" = "t" ]];then
    Install
elif [[ "$HELP" = "t" ]]; then
    Help 
fi

