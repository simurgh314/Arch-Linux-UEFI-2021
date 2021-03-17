#!/bin/bash

sudo pacman -Syu --noconfirm xorg-server xorg-xinit xorg-apps xterm mesa-libgl &&
sudo pacman -S --noconfirm ttf-font-awesome ttf-liberation ttf-dejavu opendesktop-fonts ttf-bitstream-vera ttf-arphic-uming ttf-hanazono ttf-arphic-ukai &&

su $USER
