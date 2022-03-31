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
   echo "-m/--mate            Enable install of Mate desktop environment."
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
    dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo >> /tmp/install/rpm.logs &&  \
        echo Added GitHub CLI Repository
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo >> /tmp/install/rpm.logs &&  \
        echo Added Docker Repository
    dnf copr enable agriffis/neovim-nightly -y && \
        echo Added COPR Repository for neovim-nightly
    tee -a /etc/yum.repos.d/vscodium.repo << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
EOF
    echo Added VS Codium Repository
    echo Updating programs and drivers
    dnf update --refresh -y

#******************************************************************************
#                         Install Utilities
#******************************************************************************
    # Install tlp to improve battery
    dnf install tlp -y
    systemctl enable tlp
    systemctl start tlp
    # Systemd timeout fix
    echo "DefaultTimeoutStopSec=10s" >> /etc/systemd/system.conf
    echo Installing and configuring Graphical Utility Tools
    dnf install lightdm -y >> /tmp/install/graphic.logs
    systemctl enable lightdm >> /tmp/install/graphic.logs
    systemctl set-default graphical.target >> /tmp/install/graphic.logs

    echo Installing C/C++ development tools
    dnf install -y dbus-devel gcc g++ git libconfig-devel libdrm-devel libev-devel \
        libX11-devel libX11-xcb libXext-devel libxcb-devel mesa-libGL-devel    \
        meson pcre-devel pixman-devel uthash-devel xcb-util-image-devel \
        xcb-util-renderutil-devel xorg-x11-proto-devel cmake make
    dnf install -y playerctl scrot  xrandr xinput xclip mpv ImageMagick ffmpeg
    echo Installing i3 window manager & compositor
    dnf install -y --allowerasing i3 rofi conky
    dnf install -y --allowerasing alacritty polybar
    dnf install -y --allowerasing pasystray blueman xfce4-power-manager nitrogen xfce4-clipman-plugin
    [ "$get_nvidia" = true ] && dnf install akmod-nvidia -y
    echo Compiling dccsillag/implement-window-animations
    cd /tmp
    git clone https://github.com/dccsillag/picom/
    git checkout implement-window-animations
    cd picom
    git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build

    echo "Installing basic programs"
    dnf install -y firefox xed caja engrampa xreader htop

    echo Installing Development Tools
    dnf install neovim python3-neovim gh fzf pip -y
    dnf module install nodejs:16/common -y
    dnf install lua luarocks -y
    echo Installing Java Development Kit 1.8/11/latest
    dnf install -y java-1.8.0-openjdk-devel.x86_64 maven
    echo Installing Lombok
    sudo mkdir /usr/local/share/lombok
    sudo wget https://projectlombok.org/downloads/lombok.jar -O /usr/local/share/lombok/lombok.jar
    cd /tmp
    echo Installing Go
    wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
    tar -xvf go1.18.2.linux-amd64.tar.gz -C /lib/
    for i in $(ls /home/); do
        path="/home/$i"
        tar -xvf go1.18.2.linux-amd64.tar.gz -C $path
    done
    echo Installing Docker
    dnf install docker -y
    groupadd docker
    usermod -aG docker $USER
    systemctl start docker
    systemctl enable docker

    echo Configuring Neovim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    npm install -g neovim

    mkdir $HOME/.config/nvim
    if [ "$get_common" = true ]; then
        echo Installing Common Programs
        echo obs-studio telegram spotify discord teams libreoffice slack \ 
            krita kdenlive zoom jetbrains-toolbox git-kraken virt-manager
        dnf install -y mate-calculator gnome-disk-utility \
            thunderbird gnome-system-monitor eom dconf-edior telegram obs-studio cheese
        dnf install -y flatpak >> /tmp/install/flatpak.logs
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  
        flatpak remote-delete fedora
        flatpak update
        flatpak install com.getpostman.Postman \
            com.spotify.Client \
            com.discordapp.Discord \
            com.github.tchx84.Flatseal \
            org.libreoffice.LibreOffice \
            com.slack.Slack \
            org.kde.krita \
            org.kde.kdenlive \
            us.zoom.Zoom
        echo Installing JetBrains Toolbox
        curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash
        echo Installing Git Kraken
        cd /tmp/
        wget https://release.gitkraken.com/linux/gitkraken-amd64.rpm
        dnf install gitkraken-amd64.rpm -y
        cd -
    fi
    echo Installing KDEConnect
    dnf install kdeconnectd
    firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp
    firewall-cmd --zone=public --permanent --add-port=1714-1764/udp
    systemctl restart firewalld.service
    if [ "$mate" = true ]; then 
        echo "Installing mate-desktop-environment"
        dnf groupinstall -y mate-desktop
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

    # Theme config
    echo "Setting GTK theme"
    cd /tmp/
    git clone https://github.com/vinceliuice/Qogir-theme.git
    cd Qogir-theme

    sh ./install.sh -d ~/.themes/ -t default  -l fedora --tweaks round 
    sh ./install.sh -d /usr/share/themes/ -t default  -l fedora --tweaks round 
    flatpak override --filesystem=$HOME/.themes

    echo "Setting Icons"
    cd /tmp/
    wget https://github.com/bikass/kora/archive/refs/tags/v1.5.2.tar.gz
    tar -xvf kora-1.5.2.tar.gz
    cd kora-1.5.2
    cp kora* /usr/share/icons/ -r

    git clone https://github.com/vinceliuice/Qogir-icon-theme/archive/refs/tags/2022-01-12.zip
    unzip Qogir-icon-theme-2022-01-12.zip 
    cd Qogir-icon-theme-2022-01-12
    sh install.sh
    flatpak override --env=GTK_THEME=Qogir

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
    cp $HOME/dotfiles $HOME/.dotfiles
    echo "Extracting .dotfile configurations"
    chmod +x $HOME/.dotfiles/bin/*
    rm -rf $HOME/.config/autostart
    ln -s $HOME/.dotfiles/autostart $HOME/.config/autostart
    $HOME/.dotfiles/bin/dotfetch --root
    echo "Updating Neovim packages"
    nvim -c ":PackerInstall "
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
        -m | --mate)
            echo "Mate desktop environment will be installed alongside i3wm."
            mate=true
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
