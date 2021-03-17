#!/bin/bash

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

#clear &&
