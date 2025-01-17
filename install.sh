#!/bin/bash
#******************************************************************************
#
# * File: install.sh
#
# * Author:  Umut Sevdi
# * Created: 20/08/22
# * Description: A script that installs and configures desktop environment to
# your needs. Designed for Fedora 3X Server Editions
# * @require dnf, https://www.github.com/umutsevdi/dotfiles
#*****************************************************************************

Help()
{
   # Display Help
   echo "install.sh - Umut Sevdi's install script for Fedora Server"
   echo
   echo "  Disclaimer: run --install with root privileges, --config"
   echo "with normal user. Run install first with your arguments"
   echo
   echo "Example: sudo sh install.sh --common --nvidia --install"
   echo "Example: sh install.sh --configure"
   echo "Syntax: [-h/C/i [c|n|m]]"
   echo
   echo "Options:"
   echo "-h/--help            Prints this menu."
   echo "-i/--install         Starts installation. Requires sudo."
   echo "-C/--config          Configures system files."
   echo "-c/--common          Enable install of common programs."
   echo "-n/--nvidia          Enable install of Nvidia modules."
   echo
}

Install()
{
    echo "Beginning Installation - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "
    mkdir /tmp/install
#******************************************************************************
#                              Configure RPM
#******************************************************************************
    echo Configuring RPM repositories
    dnf -y install dnf-plugins-core
    dnf install -y \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
        echo Added Non-Free Fedora Repositories
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo >> /tmp/install/rpm.logs &&  \
        echo Added Docker Repository
    dnf copr enable agriffis/neovim-nightly -y && \
        echo Added COPR Repository for neovim-nightly
    echo Updating programs and drivers
    dnf upgrade --refresh -y

#******************************************************************************
#                         Install Utilities
#******************************************************************************
    echo "DefaultTimeoutStopSec=10s" >> /etc/systemd/system.conf
    echo Installing C/C++ development tools
    [ "$get_nvidia" = true ] && dnf install akmod-nvidia -y
    echo Installing Development Tools
    dnf install neovim python3-neovim fzf pip -y
    dnf module install nodejs:16/common -y
    dnf install lua luarocks npm -y
    echo Installing Go
    wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz
    tar -xvf go1.23.4.linux-amd64.tar.gz -C /lib/
    for i in $(ls /home/); do
        path="/home/$i"
        tar -xvf go1.23.4.linux-amd64.tar.gz -C $path
    done
    echo Installing Docker
    dnf install docker -y
    groupadd docker
    usermod -aG docker $USER
    systemctl start docker
    systemctl enable docker

    mkdir $HOME/.config/nvim
    if [ "$get_common" = true ]; then
        echo Installing Common Programs
        echo obs-studio telegram spotify discord teams libreoffice slack \
            krita kdenlive zoom jetbrains-toolbox git-kraken virt-manager
        dnf install -y telegram obs-studio cheese
        dnf install -y flatpak >> /tmp/install/flatpak.logs
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  
        flatpak update
        flatpak install com.spotify.Client \
            com.discordapp.Discord \
            com.github.tchx84.Flatseal \
            org.kde.krita \
            org.kde.kdenlive \
    fi
#******************************************************************************
#                          Setup Fonts and Misc
#******************************************************************************

    # Theme, update this section later
    echo Setting Fonts and Themes
    mkdir /usr/share/fonts/jetbrains-mono
    cd  /usr/share/fonts/jetbrains-mono
    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
    unzip JetBrainsMono-2.242.zip; unzip JetBrainsMono.zip
    cd /usr/share/fonts/
    mkdir droidsans-nerd-fonts

    ## END OF get_install ##
    dnf clean all
    echo "Installation Complete  - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "
    echo "Type Y to reboot"
    read get_reboot

    if [[ "$get_reboot" = "Y" ]];then 
        reboot
    fi
}

Configure()
{
    echo "╭────────────────────────────────╮"
    echo "│     Starting Configuration     │"
    echo "╰────────────────────────────────╯"
    cd $HOME
    mv $HOME/dotfiles $HOME/.dotfiles
    chmod +x $HOME/.dotfiles/bin/*
    $HOME/.dotfiles/bin/dotfetch --root
    echo "Updating Neovim packages"
    mkdir -p $HOME/.config/rust/.cargo/
}

for arg in $@;do
    case $arg in
        -h | --help)
            get_help=true
        ;;
        -n | --nvidia)
            echo "Nvidia software updates are enabled"
            get_nvidia=true
        ;;
        -c | --common)
            echo "Common software install is enabled"
            get_common=true
        ;;
        -i | --install)
            get_install=true
        ;;
        -C | --configure)
            get_config=true
        ;;
        *)
            echo -e "Error: Invalid arguments" 1>&2
            Help
            exit
        ;;
    esac
done

if   [ "$get_install" = true ]; then
    Install
elif [ "$get_help" = true ]; then
    Help
elif [ "$get_config" = true ]; then
    Configure
    echo "Configuration is successful"
elif [ $# -eq 0 ]; then
    Help
fi
