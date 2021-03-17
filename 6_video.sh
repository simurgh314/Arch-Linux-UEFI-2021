#!/bin/bash


(
echo 'harahara108';
echo Y;
echo ;
) | cd && git clone https://aur.archlinux.org/nvidia-390xx-utils.git && cd nvidia-390xx-utils && makepkg -sri

#(echo Y;
#echo y;
#echo ;
#) | cd && git clone https://aur.archlinux.org/nvidia-390xx.git && cd nvidia-390xx && makepkg -sri
