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


loadkeys ru 
setfont cyr-sun16
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen 
echo 'en_US ISO-8859-1' >> /etc/locale.gen
echo 'ru_RU.KOI8-R KOI8-R' >> /etc/locale.gen
echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen
echo 'ru_RU ISO-8859-5' >> /etc/locale.gen
locale-gen &&
export LANG="ru_RU.UTF-8" &&
timedatectl set-ntp true &&
pacman -Sy wget parted &&



echo  'РАЗМЕТКА'

# требуется wget 
# не забыть изменить vda на sda

(
	
echo 'unit mib';
echo 'mklabel gpt';
echo 'mkpart primary 2 258';		#1 /dev/vda1 256MB EFI (FAT32)
echo 'set 1 boot on';
echo 'mkpart primary 258 514';		#2 /dev/vda2 256MB boot (ext2)
echo 'name 2 boot';
echo 'mkpart primary 514 4610';		#3 /dev/vda3 4GB (SWAP)
echo 'name 3 swap';
echo 'mkpart primary 4610 -1';		#4 /dev/vda4 (ext4)
echo 'name 4 root';
print

) | parted -a optimal /dev/vda  # выравнивание разделов



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
