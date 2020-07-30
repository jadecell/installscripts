#!/bin/bash

# Installs the yay aur helper
echo "[INFO] Installing yay AUR helper"
echo "[INFO] This might take a while"
git clone https://aur.archlinux.org/yay.git > /dev/null 2>&1
cd yay/
makepkg --noconfirm -si > /dev/null 2>&1

