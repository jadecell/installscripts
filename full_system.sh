#!/usr/bin/env sh

[ $EUID -eq 0 ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1
. /home/$(whoami)/installscripts/colors
. /home/$(whoami)/installscripts/functions

USERNAME="$(whoami)"
sudo chown -R $USERNAME:$USERNAME ~

read -p "Do you want the virtualization suite of applications [y/n]? " VIRTUALIZATION

[ "$VIRTUALIZATION" = "y" ] && VIRTPACKAGES="virt-manager qemu libvirt dnsmasq edk2-ovmf ebtables iptables" || VIRTPACKAGES=""

info "Installing yay-bin"
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg --noconfirm -si
cd ..
rm -rf yay-bin

info "Setting up /etc/pacman.conf and /etc/makepkg.conf and updating sudoers"
CPUTHREADS=$(grep -c processor /proc/cpuinfo)
sudo sed -i -e 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i '37i ILoveCandy' /etc/pacman.conf
sudo sed -i -e "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$CPUTHREADS\"/g" /etc/makepkg.conf
sudo sed -i -e "s/#\ Defaults\ secure_path=\"\/usr\/local\/sbin\:\/usr\/local\/bin\:\/usr\/sbin\:\/usr\/bin\:\/sbin\:\/bin\"/Defaults\ secure_path=\"\/usr\/local\/sbin\:\/usr\/local\/bin\:\/usr\/sbin\:\/usr\/bin\:\/sbin\:\/bin\:\/home\/$USERNAME\/.local\/bin\"/g" /etc/sudoers

info "Installing all programs"
sudo pacman --needed --noconfirm -S xorg xorg-xinit xcompmgr feh bspwm sxhkd firefox fish alacritty texlive-most texlive-lang jdk-openjdk jre-openjdk nextcloud-client lsd python-pynvim yarn nodejs neovim pandoc lxappearance xclip zathura zathura-pdf-poppler mpv dunst pulseaudio pavucontrol pulsemixer playerctl pacman-contrib ranger discord lxsession unzip zip libreoffice jq acpi bc perl xdo wmctrl neofetch sysstat scrot cantarell-fonts emacs $VIRTPACKAGES
mkdir ~/scrot

git clone https://gitlab.com/jadecell/dmenu
cd dmenu
make && sudo make install
cd ..
rm -rf dmenu

info "Installing dracula gtk theme"
sudo mkdir -p /usr/share/themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
sudo cp -r gtk-master/ /usr/share/themes/Dracula
rm master.zip

info "Installing gruvbox-gtk"
git clone https://github.com/3ximus/gruvbox-gtk
sudo cp -rf gruvbox-gtk/ /usr/share/themes/gruvbox-gtk
rm -rf gruvbox-gtk

if [[ "$VIRTUALIZATION" = "y" ]]; then
    info "Virtualization setup"
    sudo systemctl enable --now libvirtd.service
    sudo systemctl enable --now virtlogd.socket
    sudo gpasswd -a $USERNAME libvirt
    sudo gpasswd -a $USERNAME kvm
    sudo virsh net-autostart default
fi

echo "exec dbus-launch bspwm" > ~/.xinitrc
echo "[ -f ~/.bashrc ] && . ~/.bashrc" > ~/.bash_profile
echo '[ "$(tty)" = "/dev/tty1" ] && startx' >> ~/.bash_profile

info "Switching capslock and control for a better emacs experience"
cat > ~/.Xmodmap <<EOF 
clear lock
clear control
keycode 66 = Control_L
add control = Control_L
add Lock = Control_R
EOF

info "Installing all needed AUR packages"
yay --noconfirm -S mojave-gtk-theme polybar nerd-fonts-complete starship-bin

info "Installing dotfiles"
git clone https://gitlab.com/jadecell/dotfiles ~/dotfiles
cp -r ~/dotfiles/.* ~
rm -rf ~/.git
