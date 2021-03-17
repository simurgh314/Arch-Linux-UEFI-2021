#!/bin/bash

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
grub-mkconfig -o /boot/grub/grub.cfg
