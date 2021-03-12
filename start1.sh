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

#не забыть поменять на sda

export DISK="vda" &&
export LANG="ru_RU.UTF-8" &&
export MODULE="" &&

loadkeys ru &&
setfont cyr-sun16 &&
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen &&
echo 'en_US ISO-8859-1' >> /etc/locale.gen &&
echo 'ru_RU.KOI8-R KOI8-R' >> /etc/locale.gen &&
echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen &&
echo 'ru_RU ISO-8859-5' >> /etc/locale.gen &&
locale-gen &&
timedatectl set-ntp true &&


echo  'СОЗДАЕМ РАЗДЕЛЫ НА ДИСКЕ'

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

) | fdisk -t gpt /dev/$DISK


echo 'ФОРМАТИРУЕМ ИХ'

mkswap /dev/${DISK}3 &&
swapon /dev/${DISK}3 &&
mkfs.fat -F32 /dev/${DISK}1 &&
(echo y;) | mkfs.ext2 /dev/${DISK}2	&&
(echo y;) | mkfs.ext4 /dev/${DISK}4	&&


echo 'МОНТИРУЕМ ФАЙЛОВУЮ СИСТЕМУ'

mount /dev/${DISK}4 /mnt &&
mkdir -p /mnt/{home,boot} &&
mount /dev/${DISK}2 /mnt/boot &&
lsblk
clear &&


echo 'СТАВИМ БАЗОВЫЕ ПАКЕТЫ'

pacstrap /mnt linux-firmware linux-zen-headers linux-zen base base-devel nano dhcpcd dialog wpa_supplicant netctl networkmanager network-manager-applet ppp mc net-tools git wget &&   
genfstab -U /mnt >> /mnt/etc/fstab
systemctl enable NetworkManager


echo 'ПЕРЕХОДИМ В НОВОЕ ОКРУЖЕНИЕ'

arch-chroot /mnt /bin/bash &&
echo "MODULES=($MODULE)" > /etc/mkinitcpio.conf &&
echo "BINARIES=()" >> /etc/mkinitcpio.conf &&
echo "FILES=()" >> /etc/mkinitcpio.conf &&
echo "HOOKS=(base udev autodetect modconf block keymap filesystems keyboard fsck)" >> /etc/mkinitcpio.conf &&


echo 'СОЗДАЕМ ЯДРО (Zen) И ЗАГРУЗЧИК'

cd /boot && mkinitcpio -p linux-zen &&
pacman -Syu --noconfirm grub efibootmgr dosfstools os-prober mtools &&
mkdir /boot/EFI &&
mount /dev/${DISK}1 /boot/EFI &&
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck &&
grub-mkconfig -o /boot/grub/grub.cfg &&

clear &&
echo '                       '
echo '                       '
echo '                       '
echo '                       '
echo 'ЗАДАЙТЕ ПАРОЛЬ АДМИНА :'
passwd


echo 'СЕЙЧАС ПРОИЗОЙДЕТ ПЕРЕЗАПУСК. '

exit
umount /mnt/boot/EFI &&
umount /mnt/boot &&
umount /mnt &&

systemctl reboot




