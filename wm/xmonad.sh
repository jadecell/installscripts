#!/usr/bin/env sh

[ -z "$1" ] && echo "Please supply a screen resolution for xmobar!" && exit 1

cd $HOME/installscripts/
./applications/misc.sh && ./applications/yay.sh && ./applications/nerd-fonts.sh
sudo pacman --needed --noconfirm -S xcompmgr feh ranger xmonad xmonad-contrib xmobar firefox zsh

mkdir -p $HOME/.config/xmobar/

# Install dotfiles if not already installed
! [ -d "$HOME/dotfiles/" ] && git clone https://gitlab.com/jadecell/dotfiles.git $HOME/dotfiles/

cp $HOME/dotfiles/.Xresources $HOME
cp -r $HOME/dotfiles/.config/xmobar/xmobarrc? $HOME/.config/xmobar/

# Changes the bar width depending on display resolution
sed -i -e "s/,\ position\ =\ Static\ \{\ xpos\ =\ 0\ ,\ ypos=\ 0,\ width\ =\ 1920,\ height\ =\ 24\ \}/,\ position\ =\ Static\ \{\ xpos\ =\ 0\ ,\ ypos=\ 0,\ width\ =\ $1,\ height\ =\ 24\ \}" $HOME/.config/xmobar/xmobarrc0

cp -r $HOME/dotfiles/.xmonad/ $HOME

xmonad --recompile

echo "exec xmonad" > $HOME/.xinitrc

echo
echo "--------XMONAD INSTALLED SUCCESSFULLY--------"
echo

exit 0
