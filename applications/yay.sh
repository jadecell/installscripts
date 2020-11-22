#!/bin/bash
git clone https://aur.archlinux.org/yay.git > /dev/null 2>&1
cd yay/
makepkg --noconfirm -si > /dev/null 2>&1
