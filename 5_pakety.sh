#!/bin/bash


echo 'УСТАНОВКА ПРОГРАММ'
cd && 


pack={
xorg-server 
xorg-xinit 
xorg-apps 
xterm 
mesa-libgl 
ttf-font-awesome 
ttf-liberation 
ttf-dejavu 
opendesktop-fonts 
ttf-bitstream-vera 
ttf-arphic-uming 
ttf-hanazono 
ttf-arphic-ukai 
i3-gaps 
i3status 
nitrogen
xfce4-clipman-plugin 
lxappearance 
tumbler 
numlockx 
firefox 
ristretto 
unzip
usbutils
speedcrunch
neofetch
xfce4-terminal 
gvfs
}

sudo pacman -Syu --noconfirm $pack

#rofi pasystray pavucontrol pulseaudio-jack pulseaudio-equalizer flameshot thunar
#alsa-plugins alsa-utils pulseaudio alsa gpart gparted kolourpaint ufw htop catfish
