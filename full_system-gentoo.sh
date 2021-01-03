#!/usr/bin/env sh

USERNAME="jackson"
. /home/$USERNAME/installscripts/colors
. /home/$USERNAME/installscripts/functions

VIDEODRIVER=$(lspci -k | grep 'nouveau\|qxl\|i915\|i965' | awk '{print $5}')
[ "$VIDEODRIVER" = "i915" ] && VIDEODRIVER="intel i965 i915"

echo " " >> /etc/portage/make.conf
echo "VIDEO_CARDS=\"$VIDEODRIVER\"" >> /etc/portage/make.conf
echo "INPUT_DEVICES=\"libinput synaptics\"" >> /etc/portage/make.conf
emerge --autounmask-continue x11-base/xorg-x11

info "Installing all programs"

flaggie firefox +hwaccel
flaggie neovim +**
flaggie libreoffice -branding
flaggie clang-runtime -sanitize
emerge --autounmask-continue feh bspwm sxhkd firefox fish alacritty nextcloud-client lsd dev-python/pip yarn lxappearance x11-misc/xclip zathura zathura-pdf-poppler mpv dunst pulseaudio pavucontrol pulsemixer playerctl ranger discord-bin spotify lxsession unzip libreoffice jq sys-power/acpi sys-devel/bc newsboat xdo wmctrl neofetch wget polybar dmenu wmname qt5ct qalculate-gtk htop kvantum
emerge --autounmask-continue =app-editors/neovim-9999

info "Installing dracula gtk theme"
mkdir -p /usr/share/themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
cp -r gtk-master/ /usr/share/themes/Dracula
rm master.zip

git clone https://github.com/3ximus/gruvbox-gtk.git
cp -rf gruvbox-gtk/ /usr/share/themes/gruvbox-gtk
rm -rf gruvbox-gtk/

echo "exec dbus-launch bspwm" > /home/$USERNAME/.xinitrc
chown $USERNAME:$USERNAME /home/$USERNAME/.xinitrc
