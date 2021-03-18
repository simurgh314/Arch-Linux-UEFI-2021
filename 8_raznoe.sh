#!/bin/bash

echo '
Если после перезагрузки у вас наебнется сеть, вы можете попробовать вручную поднять интерфейс.
"sudo ip link set wlp2s0 up" ( вместо wlp2s0 впишите название вашего интерфейса), если сеть проводная,
то активируйте проводной интерфейс (если он не активен) и запустите сервис DHCP командой "sudo systemctl start dhcpcd". 
Эти манипуляции будут радовать вас до первого перезапуска. Если желаете добавить их в постоянную автозагрузку,
то наберите еще и "sudo systemctl enable dhcpcd" для проводного и "sudo systemctl enable wpa_supplicant".
Создайте профиль службы netctl для WIFI: "sudo wifi-menu -o" запомните название получившегося профиля, 
например он может быть таким: wlp2s0-matrix777. 
Затем добавьте его в автозагрузку: sudo netctl enable wlp2s0-matrix777
Итого, в случае беспроводной сети, у вас должно быть запущено 2 сервиса:
1) sudo systemctl enable wpa_supplicant
2) sudo netctl enable wlp2s0-matrix777
В случае проводного, у вас должен быть активен интрефейс (sudo ip link set nazvanie_interfeysa up)
и запущен dhcp сервис (sudo systemctl start dhcpcd) (ну или настроены адреса вручную)

##########################################################################################

cp /etc/X11/xinit/xinitrc ~/.xinitrc &&
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> .bash_profile &&



sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/ 
sudo touch /etc/systemd/system/getty@tty1.service.d/override.conf
sudo echo '
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $USER --noclear %I $TERM' > nano /etc/systemd/system/getty@tty1.service.d/override.conf
#проверить
