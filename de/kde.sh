#!/bin/bash
echo "[INFO] Installing Misc Xorg packages."
bash ../applications/misc.sh

echo "[INFO] Installing all the plasma applications."
sudo pacman --needed --noconfirm -S plasma kde-applications >> /dev/null 2>&1

cd $HOME

echo "[INFO] Enabling the display manager."
sudo systemctl enable sddm >> /dev/null 2>&1

echo "[INFO] You may restart now for all changed to take effect."
