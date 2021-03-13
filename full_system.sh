#!/usr/bin/env sh

[ $EUID -eq 0 ] && echo "Do not run this script as root. Please run as a non-priviledged user." && exit 1
. $HOME/installscripts/colors
. $HOME/installscripts/functions

USERNAME="$(whoami)"
sudo chown -R $USERNAME:$USERNAME ~

read -p "Do you want the virtualization suite of applications [y/n]? " VIRTUALIZATION

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

info "Installing dotfiles"
git clone https://gitlab.com/jadecell/dotfiles ~/dotfiles
~/dotfiles/setup

[ "$VIRTUALIZATION" = "y" ] && sudo pacman --needed --noconfirm -S virt-manager qemu libvirt dnsmasq edk2-ovmf ebtables iptables

info "Installing all programs"
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

info "Switching capslock and control for a better emacs experience"
cat > ~/.Xmodmap <<EOF 
clear lock
clear control
keycode 66 = Control_L
add control = Control_L
add Lock = Control_R
EOF

info "Creating the autostart file for dwm"
mkdir -p ~/.local/share/dwm/
cat > ~/.local/share/dwm/autostart.sh <<EOF
#!/usr/bin/env sh
xset r rate 300 50 &
xset s off -dpms &
xrdb ~/.Xresources &
xmodmap ~/.Xmodmap &
wmname "LG3D" &
/usr/bin/emacs --daemon &
aslstatus &
xcompmgr &
feh --bg-scale ~/.config/wallpaper &
EOF
chmod 755 ~/.local/share/dwm/autostart.sh

info "Cloning wallpapers if not already present"
[ ! -d ~/wallpapers ] && git clone https://gitlab.com/jadecell/wallpapers.git ~/wallpapers

### XMonad stuff
# mkdir -p ~/.cache/xmonad/
# mkdir -p ~/.local/share/xmonad/
# sudo cp -r ~/.config/xmonad/pacman-hooks/* /etc/pacman.d/hooks
~/.local/bin/lwdrm
ln -s ~/dotfiles/home/.config/shell/profile ~/.zprofile
ln -s ~/dotfiles/home/.config/shell/profile ~/.bash_profile

info "Installing zsh plugins"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.local/share/zsh-syntax-highlighting/
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.local/share/zsh-vi-mode/ 

info "Installing doom emacs"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom -y install

clear
echo -e "${BLUE}Completed!${NC} You can now ${MAGENTA}startx!${NC}"
