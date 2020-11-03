#!/usr/bin/env sh

[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

[ -z "$1" ] && echo "Please supply a screen resolution for xmobar!" && exit 1

cd $HOME/installscripts/

if [[ "$DISTRO" = "arch" ]]; then
    ./applications/misc.sh && ./applications/st.sh && ./applications/yay.sh && ./applications/nerd-fonts.sh
    sudo pacman --needed --noconfirm -S xcompmgr feh ranger xmonad xmonad-contrib xmobar firefox zsh
else
    ./applications/misc.sh && ./applications/st.sh && ./applications/nerd-fonts.sh
    sudo flaggie firefox +hwaccel
    sudo flaggie xmobar +wifi +iwlib
    sudo emerge --autounmask-continue x11-misc/xcompmgr media-gfx/feh app-misc/ranger x11-wm/xmonad x11-wm/xmonad-contrib x11-misc/xmobar www-client/firefox app-shells/zsh
fi

mkdir -p $HOME/.config/xmobar/

# Install dotfiles if not already installed
! [ -d "$HOME/dotfiles/" ] && git clone https://gitlab.com/jadecell/dotfiles.git $HOME/dotfiles/

cp $HOME/dotfiles/.Xresources $HOME
cp -r $HOME/dotfiles/.config/xmobar/xmobarrc? $HOME/.config/xmobar/

# Changes the bar width depending on display resolution
sed -i -e "s/,\ position\ =\ Static\ {\ xpos\ =\ 0\ ,\ ypos\ =\ 0,\ width\ =\ 1920,\ height\ =\ 24\ }/,\ position\ =\ Static\ {\ xpos\ =\ 0,\ ypos\ =\ 0,\ width\ =\ $1,\ height\ =\ 24\ }/g" $HOME/.config/xmobar/xmobarrc0

cp -r $HOME/dotfiles/.xmonad/ $HOME

xmonad --recompile

echo "exec xmonad" > $HOME/.xinitrc

echo
echo "--------XMONAD INSTALLED SUCCESSFULLY--------"
echo

exit 0
