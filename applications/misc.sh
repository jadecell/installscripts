#!/bin/bash

# Installs the base xorg display system

echo "[INFO] Installing base Xorg packages."
sudo pacman --noconfirm --needed -S xorg xorg-xinit dmenu >> /dev/null 2>&1

# Installs a basic terminal
echo "[INFO] Installing termite."
sudo pacman --noconfirm --needed -S termite >> /dev/null 2>&1

# Finished

echo " "
echo "---------------------INSTALLED MISC PROGRAMS----------------------"
echo " "

