#!/usr/bin/env sh

[ $EUID -eq 0 ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1
. /home/$(whoami)/installscripts/colors
. /home/$(whoami)/installscripts/functions

USERNAME="$(whoami)"
sudo chown -R $USERNAME:$USERNAME ~

read -p "Do you want the virtualization suite of applications [y/n]? " VIRTUALIZATION

[ "$VIRTUALIZATION" = "y" ] && VIRTPACKAGES="virt-manager qemu libvirt dnsmasq edk2-ovmf ebtables iptables" || VIRTPACKAGES=""

info "Installing paru-bin"
git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg --noconfirm -si
cd ..
rm -rf paru-bin
sudo sed -i -e "s/#BottomUp/BottomUp/g ; s/#SudoLoop/SudoLoop/g ; s/#UpgradeMenu/UpgradeMenu/g" /etc/paru.conf

sudo mkdir -p /etc/pacman.d/hooks
info "Setting up /etc/pacman.conf and /etc/makepkg.conf and updating sudoers"
CPUTHREADS=$(grep -c processor /proc/cpuinfo)
sudo sed -i -e 's/#Color/Color/g ; s/#VerbosePkgLists/VerbosePkgLists/g' /etc/pacman.conf
sudo sed -i -e 's/#HookDir\ \ \ \ \ =\ \/etc\/pacman.d\/hooks\//HookDir\ \ \ \ \ =\ \/etc\/pacman.d\/hooks\//g' /etc/pacman.conf
sudo sed -i '37i ILoveCandy' /etc/pacman.conf
sudo sed -i -e "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$CPUTHREADS\"/g" /etc/makepkg.conf
sudo sed -i -e "s/#\ Defaults\ secure_path=\"\/usr\/local\/sbin\:\/usr\/local\/bin\:\/usr\/sbin\:\/usr\/bin\:\/sbin\:\/bin\"/Defaults\ secure_path=\"\/usr\/local\/sbin\:\/usr\/local\/bin\:\/usr\/sbin\:\/usr\/bin\:\/sbin\:\/bin\:\/home\/$USERNAME\/.local\/bin\"/g" /etc/sudoers

info "Installing all programs"
sudo pacman --needed --noconfirm -S xorg xorg-xinit xmonad xmonad-contrib xmobar feh alacritty texlive-most texlive-lang jdk-openjdk jre-openjdk nextcloud-client lsd nodejs npm lxappearance xclip zathura zathura-pdf-poppler mpv dunst pulseaudio pavucontrol pulsemixer playerctl pacman-contrib ranger discord lxsession unzip zip libreoffice jq acpi bc perl neofetch sysstat scrot cantarell-fonts emacs bat lm_sensors ripgrep fd xdo $VIRTPACKAGES
sudo npm i -g prettier
mkdir ~/scrot

if [[ "$VIRTUALIZATION" = "y" ]]; then
    info "Virtualization setup"
    sudo systemctl enable --now libvirtd.service
    sudo systemctl enable --now virtlogd.socket
    sudo gpasswd -a $USERNAME libvirt
    sudo gpasswd -a $USERNAME kvm
    sudo virsh net-autostart default
fi

sudo chsh -s /bin/zsh $USERNAME

echo "exec dbus-launch dwm" > ~/.xinitrc
echo "[ -f ~/.zshrc ] && . ~/.zshrc" > ~/.zprofile
echo '[ "$(tty)" = "/dev/tty1" ] && startx' >> ~/.zprofile

info "Switching capslock and control for a better emacs experience"
cat > ~/.Xmodmap <<EOF 
clear lock
clear control
keycode 66 = Control_L
add control = Control_L
add Lock = Control_R
EOF

info "Installing all needed AUR packages"
paru --noconfirm -S nerd-fonts-complete starship-bin dmenu-jadecell-git ttf-vista-fonts ttf-ms-fonts librewolf-bin devour mojave-gtk-theme
paru --gendb

info "Installing dotfiles"
git clone https://gitlab.com/jadecell/dotfiles ~/dotfiles
cp -r ~/dotfiles/.* ~
rm -rf ~/.git
sudo cp -r ~/.xmonad/pacman-hooks/* /etc/pacman.d/hooks
rm -rf ~/.emacs.d
~/.local/bin/lwdrm

info "Installing zsh-syntax-highlighting"
tac ~/.zshrc | sed '1d' | tac > tmp && mv tmp ~/.zshrc 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.local/share/zsh-syntax-highlighting/
echo "source /home/$(whomai)/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

info "Installing doom emacs"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom -y install

clear
echo -e "${GREEN}Completed!${NC} You can now ${RED}startx!${NC}"
