#!/bin/bash

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

# Installs the base xorg display system

if [[ "$DISTRO" = "arch" ]]; then
    sudo pacman --noconfirm --needed -S xorg xorg-xinit dmenu termite
else
    sudo echo " " >> /etc/portage/make.conf
    sudo echo "VIDEO_CARDS=\"nouveau qxl intel i915 i965\"" >> /etc/portage/make.conf
    sudo echo "INPUT_DEVICES=\"libinput synaptics\"" >> /etc/portage/make.conf
    sudo emerge --autounmask-continue x11-base/xorg-x11 x11-terms/rxvt-unicode
fi

# Finished

echo " "
echo "---------------------INSTALLED MISC PROGRAMS----------------------"
echo " "
