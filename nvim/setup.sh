#!/bin/bash
#******************************************************************************
#
# * File: nvim/setup.sh
#
# * Author:  Umut Sevdi
# * Created: 08/18/24
# * Description: Neovim setup script.
#*****************************************************************************

PROGRAM_LIST="lua luarocks npm node python3 pip"
INSTALL_LIST=

pkg_install() {
if [ "$#" -eq 0 ]; then
    echo "Error: No package names provided."
    return 1
fi
echo "Installing $INSTALL_LIST"
if [ -f /etc/debian_version ]; then
    sudo apt install -y $INSTALL_LIST
elif [ -f /etc/fedora-release ]; then
    sudo dnf install -y $INSTALL_LIST
elif [ -f /etc/arch-release ]; then
    sudo pacman -Syu --noconfirm $INSTALL_LIST
else
    exit 1
fi
}

get_nvim() {
    cd /tmp
    wget "https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz"
    tar -xvf nvim-linux64.tar.gz -C ~/.local/bin/
}

usage(){
   echo "Usage: $0 --{neovim|check-health|install}"
}

help() {
   echo "Neovim setup script"
   echo "Runs selected steps to install neovim with plugins."
   echo
   usage
   echo "Options:"
   echo "-a/--all         Performs all of the given actions in a sequence."
   echo "--neovim         Installs neovim."
   echo "--check-health   Checks for required packages."
   echo "--install        Installs LSP dependencies."
   echo "-h/--help        Prints this menu."
   echo
}


check_health() {
    echo "Dependencies"

    if command -v "nvim" &> /dev/null; then
        nvim --version
    else
        echo "Neovim not found"
    fi
    for i in $PROGRAM_LIST; do
        if command -v "$i" &> /dev/null; then
            echo "[X] $i"
            continue
        else
            echo "[ ] $i"
            if $i == "nodejs"; then  INSTALL_LIST+=" nodejs"
            fi
            INSTALL_LIST+=" $i "
        fi
    done
    [ "$INSTALL_LIST" = "" ] && echo "All dependencies are found."
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

while [ -n "$1" ]; do
    case $1 in
        --check-health)
            check_health
            ;;
        --neovim)
            get_nvim
            ;;
        --install)
            check_health
            [ "$INSTALL_LIST" = "" ] || pkg_install $INSTALL_LIST
            exit
            ;;
        --all|-a)
            get_nvim && \
            source "$HOME/.bashrc" \
             check_health \
            [ "$INSTALL_LIST" = "" ] || pkg_install $INSTALL_LIST
            ;;
        *)
            help && exit 1
            ;;
    esac
    shift
done
