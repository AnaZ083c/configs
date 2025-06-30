#!/bin/bash

set -eu

OPTIMUS=false
if [ "$1" = "--optimus" ] || [ "$1" = "-o" ]; then
    OPTIMUS=true
elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo -e "This is a script for automatic setting up of EndeavourOS with all the necesary Nvidia drivers and essentials for gaming"
    echo -e "\nUsage:"
    echo -e "\t./endeavour-os-nvidia.sh [--optimus | -o | --help | -h]"
    echo -e "\n\t--optimus, -o\tUsing this, the system will be setup with prime and envycontrol for switching between the GPUs"
    echo -e "\t--help, -h\tThis help"
    exit 0
fi

ENVY_CONTROL_PYQT_PATH="$HOME/GitHub/repos/EnvyControl-PyQt"

installed_nvidia_drivers=false

echo "--- Setting up EndeavourOS for Nvidia and gaming ---"
echo "---"

# update the system
echo "- Update with pacman"
pacman -Syu

echo "- Update with yay"
yay -Syu; yay

# install nvidia proprietary drivers
echo "- Installing Nvidia proprietary drivers using 'nvidia-inst'"

if [ $OPTIMUS = true ]; then
    echo "- Your device is using 'optimus', the system will be set up with this in mind"
    nvidia-inst --32 --prime

    echo "- Installing 'envycontrol' for GPU switching"
    yay -S envycontrol

    echo "- Installing GPU switching GUI 'envycontrol-pyqt'"
    pacman -S python-pyqt

    if [[ ! $(-d $HOME/GitHub/repos) ]]; then
        echo "- Preparing directory for 'envycontrol-pyqt'"
        mkdir -p $HOME/GitHub/repos/
    else
        echo "- Directory for GitHub repos exists, continuing"
    fi
    
    # clone the repo (this is needed)
    git clone https://github.com/MatveyM11/EnvyControl-PyQt.git $ENVY_CONTROL_PYQT_PATH
    chmod +x $ENVY_CONTROL_PYQT_PATH/install.sh && $ENVY_CONTROL_PYQT_PATH/install.sh

    installed_nvidia_drivers=true
else
    echo "- Your device uses only a dedicated GPU (not optimus), installing as per usual"
    nvidia-inst --32  # good to include 32bit drivers for older games
    installed_nvidia_drivers=true
fi

# install all for gaming
echo "- Installing 'steam' and 'lutris'"
pacman -S steam steam-native-runtime lutris

echo "- Installing 'heroic'"
yay -S heroic-games-launcher-bin

echo "- Installing 'protonup-qt'"
yay -S protonup-qt

echo "- Installing 'wine'"
yay -S wine-staging

echo "- Installing 'gamemode feral' (good for optimizing games)"
pacman -S gamemode lib32-gamemode

echo "- Adding user '$(whoami)' to group 'gamemode'"
usermod -aG gamemode $(whoami)

echo "- Installing 'mangohud' for monitoring game performance"
pacman -S mangohud

echo "- Installing 'cdemu' for mounting ISOs (!!! choose one without dkms and not linux-zen !!!)"
pacman -S cdemu-client

echo "- Installing cdemu GUI for easier mounting"
yay -S kde-cdemu-manager

echo "- Installing 'gamescope'"
yay -S gamescope-git lib32-gamescope-git

if [ $installed_nvidia_drivers = true ]; then
    echo "---"
    echo "To use CDEMU, you must do the following after reboot (!!! without sudo !!!):"
    echo "  1. systemctl --user start --now cdemu-daemon.service"
    echo "  2. (optional) make cdemu-daemon start automatically at startup"
    echo "---"
    echo "System needs to be rebooted to complete the setup!"
    echo "TIP: use command 'reboot'"
fi

exit 0
