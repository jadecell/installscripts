#!/bin/bash

. ../wizard.sh
# Installs the powerline fonts

git clone https://github.com/powerline/fonts.git powerfonts
cd powerfonts/
bash install.sh

# Installs the actual terminal

git clone https://gitlab.com/jadecell/st.git st
cd st/
echo $SUDOPASSWORD | sudo -S make clean install
