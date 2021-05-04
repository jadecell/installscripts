#!/usr/bin/env sh

# For Xorg
# https://wiki.gentoo.org/wiki/Xorg/Guide

# overlays added: menelkir src_prepare-overlay thegreatmcpain bobwya
sudo emerge app-eselect/eselect-repository
sudo mkdir -p /etc/portage/repos.conf
sudo eselect repository enable menelkir src_prepare-overlay thegreatmcpain bobwya tlp guru go-overlay
sudo eix-sync

curl -fsSL https://starship.rs/install.sh | bash

sudo emerge --autounmask-continue x11-base/xorg-x11 media-fonts/joypixels www-client/firefox app-shells/fzf x11-misc/xwallpaper media-gfx/sxiv sys-apps/lsd net-libs/nodejs lxde-base/lxappearance x11-misc/xclip app-text/zathura app-text/zathura-pdf-poppler media-video/mpv x11-misc/dunst media-sound/pulseaudio media-sound/pamixer media-sound/pavucontrol media-sound/playerctl app-misc/ranger dev-libs/libvterm mail-client/thunderbird lxde-base/lxsession app-arch/unzip app-arch/zip app-office/libreoffice app-misc/jq sys-power/acpi media-fonts/nerd-fonts sys-devel/bc x11-misc/trayer x11-misc/xcompmgr app-admin/sysstat media-gfx/scrot media-fonts/cantarell app-editors/emacs sys-apps/bat sys-apps/lm-sensors sys-apps/ripgrep sys-apps/fd x11-misc/xdo media-fonts/ubuntu-font-family net-misc/nextcloud-client dev-vcs/lazygit dev-util/shfmt app-laptop/tlp
