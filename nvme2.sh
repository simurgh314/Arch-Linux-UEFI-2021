#!/bin/bash

# Разделы дисков NVME именуются системой иначе, чем диски SDA
# к названию добавляется не просто цифра, а еще и буква!

export DISK="nvme0n1" &&
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
export LANG="ru_RU.UTF-8" &&
timedatectl set-ntp true &&

echo  'СОЗДАЕМ РАЗДЕЛЫ НА ДИСКЕ'

(
echo g;
echo n;
echo ;
echo ;
echo +256M; #EFI 1
echo Y;
echo t;
echo 1;

echo n;
echo ;
echo ;
echo +4G; #swap 2
echo Y;

echo n;
echo ;
echo ;
echo ; #root 3
echo Y;
echo w;

) | fdisk -t gpt /dev/$DISK


echo 'ФОРМАТИРУЕМ ИХ'

mkswap /dev/${DISK}p2 &&
swapon /dev/${DISK}p2 &&
mkfs.fat -F32 /dev/${DISK}p1 &&
(echo y;) | mkfs.ext4 /dev/${DISK}p3 &&

echo 'МОНТИРУЕМ ФАЙЛОВУЮ СИСТЕМУ'

mount /dev/${DISK}p3 /mnt &&
mkdir -p /mnt/{home,boot} &&

lsblk
