#!/bin/bash
# install.sh 
# @author xtechnology 
# A script that installs and configures desktop enviroment to your needs.
# Installs various tools.
# Designed for Fedora 3X Server Editions
# @requires dnf, https://www.github.com/xtechnology/dotfiles

Help()
{
   #Yardımı Görüntüle
    echo "install.sh - XTechnology'nin Fedora Sunucusu için kurulum komut dosyası"
    echo
    echo " Sorumluluk Reddi: --install root ayrıcalıklarıyla çalıştırın, --config"
    echo "normal kullanıcı ile. Önce bağımsız değişkenlerinizle kurulumu çalıştırın"
    echo
    echo "Örnek: sudo sh install.sh --common --nvidia --install"
    echo "Örnek: sh install.sh --configure"
    echo "Sözdizimi: [-h/C/i [c|n]]"
    echo
    echo "Seçenekler:"
    echo "-h/--help Bu menüyü yazdırır."
    echo "-i/--install Kurulumu başlatır. Sudo gerektirir."
    echo "-C/--config Sistem dosyalarını yapılandırır."
    echo "-c/--common Ortak programları yükler."
    echo "-n/--nvidia Nvidia yazılımlarını yükler."
    echo
}

Install()
{
    echo "Kurulum Başlıyor - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "
    mkdir /tmp/install
    ## UPDATE ##
    echo "╭────────────────────────────────╮"
    echo "│    RPM Depoları Ekleme         │"
    echo "╰────────────────────────────────╯"
    dnf -y install dnf-plugins-core
    sudo dnf install -y \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
        echo "Ücretsiz Olmayan Fedora Depoları Eklendi"
    dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo >> /tmp/install/rpm.logs &&  \
        echo "GitHub CLI Deposu Eklendi"
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo >> /tmp/install/rpm.logs &&  \
        echo "Docker Deposu Eklendi"
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' >> /tmp/install/rpm.logs && \
        echo "VS Kod Deposu Eklendi"
    echo "╭───────────────────────────────────────╮"
    echo "│ Programları ve sürücüleri güncelleme  │"
    echo "╰───────────────────────────────────────╯"
    dnf update --refresh -y
    ## GRAFİK ARAÇLAR ##
    echo "Grafik Yardımcı Araçlarını yükleme ve yapılandırma"
    echo "SDDM'yi Yapılandırma"
    dnf install sddm sddm-themes -y >> /tmp/install/graphic.logs
    cp sddm/themes/sddm-chili-0.1.5 /usr/share/sddm/themes -r
    cp sddm/sddm.conf /etc/sddm.conf
    systemctl enable sddm >> /tmp/install/graphic.logs
    systemctl set-default graphical.target >> /tmp/install/graphic.logs
    ## Dizinler ##
    echo "Gerekli programları yükleme"
    dnf install -y dbus-devel gcc git libconfig-devel libdrm-devel libev-devel libX11-devel libX11-xcb libXext-devel libxcb-devel mesa-libGL-devel meson pcre-devel pixman-devel uthash-devel xcb-util-image-devel xcb-util-renderutil-devel xorg-x11-proto-devel
    dnf install -y playerctl scrot xdotool  xrandr xinput xclip mpv gnome-online-accounts fish  fishbowl  fishbowl-javadoc
    echo "i3 Pencere Yöneticisini ve Bestecisini Yükleme"
    dnf install -y --allowerasing i3-gaps rofi conky
    dnf install -y --allowerasing alacritty polybar
    dnf install -y --allowerasing pasystray blueberry xfce4-power-manager nitrogen rofi xfce4-clipman-plugin glava 
    if [[ "$get_nvidia" = true ]];then
        dnf install akmod-nvidia -y
    fi
    # COMPILING PICOM
    echo "dccsillag/uygulama-pencere-animasyonlarını derleme"
    cd /tmp
    git clone https://github.com/dccsillag/picom/
    git checkout implement-window-animations
    cd picom
    git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build

    ## GEREKLİ PROGRAMLAR ##
    echo "Temel programları yükleme"
    dnf install -y firefox nemo gedit xarchiver
    ## CLI PROGRAMS ##
    echo "╭────────────────────────────────╮"
    echo "│  Geliştirme Araçlarını Yükleme  │"
    echo "╰────────────────────────────────╯"
    echo "agriffis/neovim-nightly'den"
    dnf copr enable agriffis/neovim-nightly -y
    echo "NodeJS Pip Lua Kurulumu"
    dnf install neovim python3-neovim gh -y
    dnf module install nodejs:16/common -y
    dnf install g++ fzf -y
    dnf install pip -y
    pip install neovim
    dnf install lua luarocks -y
    echo "Java Development Kit 1.8/11/en son sürümünü yükleme"
    dnf install -y java-1.8.0-openjdk-devel.x86_64 java-11-openjdk-devel.x86_64 java-latest-openjdk-devel.x86_64 maven
    echo "Lombok'u yükleme"
    sudo mkdir /usr/local/share/lombok
    sudo wget https://projectlombok.org/downloads/lombok.jar -O /usr/local/share/lombok/lombok.jar
    cd /tmp
    echo "Go'yu Yükleme"
    wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
    tar -xvf go1.18.2.linux-amd64.tar.gz -C /lib/
    for i in $(ls /home/); do
        path="/home/$i";
        tar -xvf go1.18.2.linux-amd64.tar.gz -C $path
    done
    echo "Docker'ı Yükleme"
    ## DOCKER
    dnf install docker -y
    groupadd docker
    usermod -aG docker $USER
    systemctl start docker
    systemctl enable docker
    ## neovim get_config ##
    echo "Neovim'i Yapılandırma"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    npm install -g neovim
    npm install -g coc-clangd
    npm install -g bash-language-server
    npm install -g instant-markdown-d
    mkdir $HOME/.config/nvim
    echo "package.path = package.path .. ';/home/xtechnology/.dotfiles/nvim/?.lua;/home/xtechnology/.dotfiles/nvim/pkg/?.lua'" \ 
        "\nvim.cmd('source /home/xtechnology/.dotfiles/nvim/init.lua')" >> $HOME/.config/nvim/init.lua
    if [ "$get_common" = true ]; then
        echo "Ortak Programları Yükleme"
        dnf install -y gnome-calculator gnome-font-viewer gnome-disk-utility \
            geary gnome-calendar gnome-system-monitor eom dconf-edior
        dnf install -y discord telegram gnome-software
        dnf install -y flatpak >> /tmp/install/flatpak.logs
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  
        flatpak update
        flatpak install com.getpostman.Postman  io.github.shiftey.Desktop \
            com.github.tchx84.Flatseal com.icons8.Lunacy \
            com.spotify.Client
        fi
    echo "JetBrains Toolbox'ı Yükleme"
    curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash

    echo "╭────────────────────────────────╮"
    echo "│      Installing KDEConnect     │"
    echo "╰────────────────────────────────╯"
    dnf install kdeconnectd
    firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp
    firewall-cmd --zone=public --permanent --add-port=1714-1764/udp
    systemctl restart firewalld.service
    ## Symbolic Links ##
    echo "╭───────────────────────────────────────────╮"
    echo "│    Yazı Tiplerini ve Temaları Ayarlama    │"
    echo "╰───────────────────────────────────────────╯"
   echo "Yazı Tiplerini Yükleme"
    mkdir /usr/share/fonts/jetbrains-mono
    cd  /usr/share/fonts/jetbrains-mono
    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
    unzip JetBrainsMono-2.242.zip; unzip JetBrainsMono.zip
    cd /usr/share/fonts/
    mkdir droidsans-nerd-fonts
    cd droidsans-nerd-fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
    unzip DroidSansMono.zip
    mv /tmp/install $HOME/install

    echo "write: \nfastestmirror=True\ndeltarpm=True\nmax_parallel_downloads=10\nto  /etc/dnf/dnf.conf"
    # Tema yapılandırması
    echo "GTK temasını ayarlama"
    cd /tmp/
    git clone https://github.com/vinceliuice/Qogir-theme.git
    cd Qogir-theme

    sh ./install.sh -d ~/.themes/ -t default  -l fedora --tweaks round 
    sh ./install.sh -d /usr/share/themes/ -t default  -l fedora --tweaks round 
    flatpak override --filesystem=$HOME/.themes

    echo "Simgeleri Ayarlama"
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
    echo "Kurulum Tamamlandı  - $(date +%H:%M) - $(date +' '%a' '%d' '%b' '%Y) "
    echo "Yeniden başlatmak için Y basın"
    read get_reboot

    if [[ "$get_reboot" = "Y" ]];then 
        reboot
    fi
}
Configure()
{
    echo "╭────────────────────────────────────╮"
    echo "│    Yapılandırma Başlatılıyor       │"
    echo "╰────────────────────────────────────╯"
    cd $HOME
    cp $HOME/dotfiles $HOME/.dotfiles
    echo ".dotfile yapılandırmalarını ayıklama"
    chmod +x $HOME/.dotfiles/bin/*
    rm -rf $HOME/.config/autostart
    ln -s $HOME/.dotfiles/autostart $HOME/.config/autostart
    $HOME/.dotfiles/bin/dotfetch --root
    echo -e " Neovim için kurulumda aşağıdaki komutları çalıştırın:\n\
    - :PlugInstall\n\
    - :TSInstall all\n"\
    nvim -c ":PlugInstall | CocUpdate " "Neovim Kurulumu tamamlandı"
}

for arg in $@;do
    case $arg in
        -h | --help)
            get_help=true
        ;;
        -n | --nvidia)
            echo "Nvidia yazılım güncellemeleri etkin"
            get_nvidia=true
        ;;
        -c | --common)
            echo "Ortak yazılım yüklemesi etkinleştirildi"
            get_common=true
        ;;
        -i | --install)
            get_install=true
        ;;
        -C | --configure)
            get_config=true
        ;;
        *)
            echo -e "Hata: Geçersiz bağımsız değişkenler" 1>&2
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
    echo "Yapılandırma başarılı"
elif [ $# -eq 0 ]; then
    Help
fi
