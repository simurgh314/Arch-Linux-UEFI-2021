#!/bin/bash

echo 'УСТАНОВКА Xorg'
pacman -Syu --noconfirm xorg-server xorg-xinit xorg-apps xterm mesa-libgl &&
pacman -S --noconfirm ttf-font-awesome ttf-liberation ttf-dejavu opendesktop-fonts ttf-bitstream-vera ttf-arphic-uming ttf-hanazono ttf-arphic-ukai &&
pacman -S --noconfirm i3-gaps rofi i3status nitrogen flameshot xfce4-clipman-plugin lxappearance tumbler numlockx firefox ristretto unzip kolourpaint usbutils ufw speedcrunch gpart gparted catfish neofetch htop xfce4-terminal gvfs &&  
pacman -S alsa alsa-plugins alsa-utils pulseaudio pulseaudio-equalizer pulseaudio-jack pavucontrol pasystray


