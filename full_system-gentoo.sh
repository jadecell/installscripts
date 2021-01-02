#!/usr/bin/env sh

USERNAME="jackson"
. /home/$USERNAME/installscripts/colors
. /home/$USERNAME/installscripts/functions


info "Installing all programs"

emerge --autounmask-continue feh bspwm sxhkd firefox fish alacritty nextcloud-client lsd dev-python/pip yarn neovim lxappearance x11-misc/xclip zathura zathura-pdf-poppler mpv dunst pulseaudio pavucontrol pulsemixer playerctl ranger discord-bin spotify lxsession unzip libreoffice jq sys-power/acpi sys-devel/bc dev-lang/perl newsboat xdo wmctrl neofetch wget polybar dmenu wmname qutebrowser qt5ct qalculate-gtk htop gtop kvantum

info "Installing dracula gtk theme"
mkdir -p /usr/share/themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
cp -r gtk-master/ /usr/share/themes/Dracula
rm master.zip

echo "exec dbus-launch bspwm" > /home/$USERNAME/.xinitrc
chown $USERNAME:$USERNAME /home/$USERNAME/.xinitrc
