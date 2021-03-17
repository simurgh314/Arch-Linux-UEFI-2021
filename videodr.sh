#!/bin/bash


(
echo Y;
echo y;
echo ;
) | git clone https://aur.archlinux.org/nvidia-390xx-utils.git && cd nvidia-390xx-utils && makepkg -sri

(echo Y;
echo y;
echo ;
) | git clone https://aur.archlinux.org/nvidia-390xx.git && cd nvidia-390xx && makepkg -sri
