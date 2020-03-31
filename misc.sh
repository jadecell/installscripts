#!/bin/bash

# Installs the base xorg display system

sudo pacman --noconfirm --needed -S xorg xorg-xinit

# Installs a basic terminal

sudo pacman --noconfirm --needed -S termite

# Finished

echo " "
echo "---------------------INSTALLED MISC PROGRAMS----------------------"
echo " "

