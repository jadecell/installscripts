#!/usr/bin/env sh
set -eu

[ ! -d ~/.ssh ] && echo "Can not find the .ssh directory, please add keys" && exit 1
[ ! -d ~/.local/repos/dotfiles ] && git clone git@github.com:jadecell/dotfiles.git ~/.local/repos/dotfiles
[ ! -d ~/.local/repos/archmatic ] && git clone git@github.com:jadecell/archmatic.git ~/.local/repos/archmatic
[ ! -d ~/.local/repos/aslstatus ] && git clone git@github.com:jadecell/aslstatus.git ~/.local/repos/aslstatus
[ ! -d ~/.local/repos/dmenu ] && git clone git@github.com:jadecell/dmenu ~/.local/repos/dmenu
[ ! -d ~/.local/repos/dwm ] && git clone git@github.com:jadecell/dwm ~/.local/repos/dwm
[ ! -d ~/.local/repos/dwmblocks ] && git clone git@github.com:jadecell/dwmblocks ~/.local/repos/dwmblocks
[ ! -d ~/.local/repos/gentoomatic ] && git clone git@github.com:jadecell/gentoomatic ~/.local/repos/gentoomatic
[ ! -d ~/.local/repos/grub-theme-install ] && git clone git@github.com:jadecell/grub-theme-install ~/.local/repos/grub-theme-install
[ ! -d ~/.local/repos/installscripts ] && git clone git@github.com:jadecell/installscripts ~/.local/repos/installscripts
[ ! -d ~/.local/repos/jadecell ] && git clone git@github.com:jadecell/jadecell ~/.local/repos/jadecell
[ ! -d ~/.local/repos/nvcode-gtk-theme ] && git clone git@github.com:jadecell/nvcode-gtk-theme ~/.local/repos/nvcode-gtk-theme
[ ! -d ~/.local/repos/slock ] && git clone git@github.com:jadecell/slock ~/.local/repos/slock
[ ! -d ~/.local/repos/slstatus ] && git clone git@github.com:jadecell/slstatus ~/.local/repos/slstatus
[ ! -d ~/.local/repos/st ] && git clone git@github.com:jadecell/st ~/.local/repos/st
[ ! -d ~/.local/repos/wallpapers ] && git clone git@github.com:jadecell/wallpapers ~/.local/repos/wallpapers
