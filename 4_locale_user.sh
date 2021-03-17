#!/bin/bash

echo 'ЗАДАЙТЕ ПАРОЛЬ АДМИНА :'
passwd

read -p "ЗАДАЙТЕ ПАРОЛЬ НОВОГО ПОЛЬЗОВАТЕЛЯ :" PASS
read -p "Введите имя компьютера: " HOST
read -p "Введите имя нового пользователя" NEW_USER
read -p "Укажите часовой пояс в формате  Europe/Moscow  " POYAS


echo 'ЛОКАЛИЗАЦИЯ ЧАСЫ и ПРОЧЕЕ' 

hostnamectl set-hostname $HOST &&
ln -sf /usr/share/zoneinfo/$POYAS /etc/localtime &&
hwclock --systohc && 
timedatectl set-ntp true &&
localectl set-keymap ru &&
setfont cyr-sun16 &&
localectl set-locale LANG="ru_RU.UTF-8" &&
echo "FONT=cyr-sun16"  >>  /etc/vconsole.conf &&
export LANG="ru_RU.UTF-8" &&
mkinitcpio -P &&
grub-mkconfig -o /boot/grub/grub.cfg &&


echo ' СОЗДАНИЕ ПОЛЬЗОВАТЕЛЕЙ'

useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel -s /bin/bash $NEW_USER &&
#echo 'ВВЕДИТЕ ПАРОЛЬ ДЛЯ НОВОГО ПОЛЬЗОВАТЕЛЯ: '
(echo $PASS) | passwd $NEW_USER &&

sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers
#clear
su $NEW_USER


