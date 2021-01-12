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

flaggie libreoffice -branding
flaggie clang-runtime -sanitize
flaggie app-editors/emacs +gtk +gui
emerge --autounmask-continue feh fish alacritty nextcloud-client lsd dev-python/pip yarn lxappearance x11-misc/xclip zathura zathura-pdf-poppler mpv dunst pulseaudio pavucontrol pulsemixer playerctl ranger discord-bin spotify lxsession unzip libreoffice jq sys-power/acpi sys-devel/bc newsboat xdo wmctrl neofetch wget wmname qt5ct qalculate-gtk htop kvantum

info "Installing dracula gtk theme"
mkdir -p /usr/share/themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
cp -r gtk-master/ /usr/share/themes/Dracula
rm master.zip

git clone https://gitlab.com/jadecell/dwm.git
cd dwm
make install
cd ..
rm -rf dwm

git clone https://gitlab.com/jadecell/aslstatus.git
cd aslstatus
make install
cd ..
rm -rf aslstatus

git clone https://gitlab.com/jadecell/dmenu.git
cd dmenu
make install
cd ..
rm -rf dmenu

echo "exec dbus-launch dwm" > /home/$USERNAME/.xinitrc
chown $USERNAME:$USERNAME /home/$USERNAME/.xinitrc
