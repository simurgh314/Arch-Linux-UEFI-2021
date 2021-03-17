#!/bin/bash


cd && git clone https://aur.archlinux.org/nvidia-390xx-utils.git && cd nvidia-390xx-utils && makepkg -sri &&

#(wget https://raw.githubusercontent.com/simurgh314/Arch-GPT-/main/6_video.sh && sudo chmod +x 6_video.sh && sh 6_video.sh)

cd && git clone https://aur.archlinux.org/nvidia-390xx.git && cd nvidia-390xx && makepkg -sri

exit
