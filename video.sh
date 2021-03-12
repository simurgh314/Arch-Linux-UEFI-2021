#!/bin/bash

echo '=================================================='
echo 'УСТАНОВКА ДРАЙВЕРА ВИДЕО' 
echo 'НЕ ОТХОДИТЕ ОТ КОМПЬЮТЕРА (если устанавливаете Арч на компьютер) 
системе потребуется ввод пароля' 
#echo $USER 
echo 'и возможно какие то ваши осмысленные манипуляции...'

#read -p "Введите имя пользователя: " POLZ

echo 'Видеокарта Nvidia(1) или Radeon(0) ?' 
read -p "1 - Nvidia, 0 - Radeon: " GPU
if [[ $GPU == 0 ]]; then
  video_install="git clone https://aur.archlinux.org/catalyst.git && cd catalyst && makepkg -sri"
elif [[ $GPU == 1 ]]; then
  video_install="sudo pacman -Syu nvidia"
fi
echo 'Установка X-Server'
sudo pacman -Syu --noconfirm xorg-server xorg-xinit xorg-apps xterm mesa-libgl
echo 'ШРИФТЫ'
sudo pacman -S ttf-font-awesome ttf-liberation ttf-dejavu opendesktop-fonts ttf-bitstream-vera ttf-arphic-uming ttf-hanazono ttf-arphic-ukai
echo 'СЕЙЧАС ПРОИЗОЙДЕТ ПЕРЕЗАПУСК. '
