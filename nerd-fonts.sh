#!/usr/bin/env bash
echo "[INFO] Installing Nerd Fonts"
echo "[INFO] This will take awhile"
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
