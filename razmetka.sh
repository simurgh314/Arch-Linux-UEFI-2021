#!/bin/bash

echo '
###################################################################
###################################################################
################                                   ################
################             ARCHLINUX             ################
################                                   ################
################         Сын ошибок трудных        ################
################                                   ################
################              UEFI GPT             ################
################                                   ################
###################################################################
###################################################################
'

export disk = vda &&
export LANG = "ru_RU.UTF-8" &&
loadkeys ru &&
setfont cyr-sun16 &&
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen &&
echo 'en_US ISO-8859-1' >> /etc/locale.gen &&
echo 'ru_RU.KOI8-R KOI8-R' >> /etc/locale.gen &&
echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen &&
echo 'ru_RU ISO-8859-5' >> /etc/locale.gen &&
locale-gen &&
timedatectl set-ntp true &&




echo  'РАЗМЕТКА'
# не забыть изменить vda на sda

(

echo g;
echo n;
echo ;
echo ;
echo +256M; #EFI
echo Y;
echo t;
echo 1;


echo n;
echo ;
echo ;
echo +256M; #boot
echo Y;
 
 
echo n;
echo ;
echo ;
echo +4G; #swap
echo Y;
  
  
echo n;
echo ;
echo ;
echo ; #root
echo Y;
echo w;

) | fdisk -t gpt /dev/$disk



echo 'ФОРМАТИРОВАНИЕ'

mkswap /dev/${disk}3 &&
swapon /dev/${disk}3 &&
mkfs.fat -F32 /dev/${disk}1 &&
(echo y;) | mkfs.ext2 /dev/${disk}2	&&
(echo y;) | mkfs.ext4 /dev/${disk}4	&&


echo 'МОНТИРОВАНИЕ'

mount /dev/${disk}4 /mnt &&
mkdir -p /mnt/{home,boot} &&
mount /dev/${disk}2 /mnt/boot &&
lsblk

