#!/bin/bash

# предварительно требуется wget и parted
# не забыть изменить vda на sda


(
	
unit mib
mklabel gpt
mkpart primary 2 258		#1 /dev/vda1 256MB EFI (FAT32)
set 1 boot on
mkpart primary 258 514		#2 /dev/vda2 256MB boot (ext2)
name 2 boot
mkpart primary 514 4610		#3 /dev/vda3 4GB (SWAP)
name 3 swap
mkpart primary 4610 -1		#4 /dev/vda4 (ext4)
name 4 root

) | parted -a optimal /dev/vda  # выравнивание разделов
