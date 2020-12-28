#!/usr/bin/env sh

[ $EUID -eq 0 ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1
. /home/$(whoami)/installscripts/colors
. /home/$(whoami)/installscripts/functions

USERNAME="$(whoami)"

# Determine the distro
[ -f /usr/bin/emerge ] && DISTRO="gentoo" || DISTRO="arch"

read -p "Do you want the virtualization suite of applications [y/n]? " VIRTUALIZATION

[ "$VIRTUALIZATION" = "y" ] && VIRTPACKAGES="virt-manager qemu libvirt dnsmasq edk2-ovmf ebtables iptables" || VIRTPACKAGES=""

info "Installing yay-bin"
https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

info "Setting up /etc/pacman.conf and /etc/makepkg.conf"
CPUTHREADS=$(grep -c processor /proc/cpuinfo)
sudo sed -i -e 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i '37i ILoveCandy' /etc/pacman.conf
sudo sed -i -e "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$CPUTHREADS\"/g" /etc/makepkg.conf


info "Installing all programs"
sudo pacman --needed --noconfirm -S xorg xorg-xinit xcompmgr feh xmonad xmonad-contrib xmobar firefox fish alacritty texlive-most texlive-lang jdk-openjdk jre-openjdk nextcloud-client lsd python-pynvim yarn nodejs neovim pandoc lxappearance xclip zathura zathura-pdf-poppler mpv dunst pulseaudio pavucontrol pulsemixer playerctl trayer pacman-contrib ranger discord lxsession unzip $VIRTPACKAGES

info "Installing dracula gtk theme"
sudo mkdir -p /usr/share/themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
sudo cp -r gtk-master/ /usr/share/themes/Dracula

[ "$VIRTUALIZATION" = "y" ] && info "Installing virtualization settings" && sudo systemctl enable --now libvirtd.service && sudo systemctl enable --now virtlogd.socket && sudo gpasswd -a $USERNAME libvirt && sudo gpasswd -a $USERNAME kvm && sudo virsh net-autostart default

echo "exec dbus-launch xmonad" > ~/.xinitrc
chown $USERNAME:$USERNAME ~/.xinitrc

info "Installing spotify and mojave-gtk-theme"
yay --noconfirm -S spotify mojave-gtk-theme

info "Installing dotfiles"
git clone https://gitlab.com/jadecell/dotfies ~/dotfiles && cp -r ~/dotfiles/.* ~ && rm -rf ~/.git
xmonad --recompile

info "Installing nerd fonts"
git clone https://github.com/ryanoasis/nerd-fonts && cd nerd-fonts && ./install.sh && rm -rf nerd-fonts
