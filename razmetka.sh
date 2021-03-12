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


loadkeys ru &&
setfont cyr-sun16 &&
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen &&
echo 'en_US ISO-8859-1' >> /etc/locale.gen &&
echo 'ru_RU.KOI8-R KOI8-R' >> /etc/locale.gen &&
echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen &&
echo 'ru_RU ISO-8859-5' >> /etc/locale.gen &&
locale-gen &&
export LANG='ru_RU.UTF-8' &&
timedatectl set-ntp true &&
#pacman -Sy --noconfirm wget &&



echo  'РАЗМЕТКА'
# не забыть изменить vda на sda

(

echo g;
echo n;
echo ;
echo ;
echo +256M; #EFI
echo t;
echo 1;


echo n;
echo ;
echo ;
echo +256M; #boot
 
 
echo n;
echo ;
echo ;
echo +4G; #swap
  
  
echo n;
echo ;
echo ;
echo ; #root

) | fdisk -t gpt /dev/vda



echo 'ФОРМАТИРОВАНИЕ'

mkfs.fat -F32 /dev/vda1 &&			 #EFI  (FAT32)
mkfs.ext2 /dev/vda2	&&			 #boot (ext2)
mkfs.ext4 /dev/vda4	&&			 #root (ext4)
mkswap /dev/vda3 &&				 #swap
swapon /dev/vda3 &&



echo 'МОНТИРОВАНИЕ'

mount /dev/vda4 /mnt &&
mkdir -p /mnt/{home,boot} &&
mount /dev/vda2 /mnt/boot &&
lsblk

