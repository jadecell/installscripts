#!/bin/bash

# Installs thr yay aur helper

git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg --noconfirm -si
