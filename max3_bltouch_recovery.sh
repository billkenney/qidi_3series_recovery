#!/bin/bash
read -p 'do you want to update your printer.cfg file? (y/n): ' pcfg
if [[ "$pcfg" =~ [yY] ]] ; then
  sudo sed -i 's/deb.debian.org\/debian buster-backports/archive.debian.org\/debian buster-backports/g' /etc/apt/sources.list
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/printer-max3_bltouch.cfg
  mv ~/klipper_config/printer.cfg ~/klipper_config/printer.cfg.bak ; mv printer-max3_bltouch.cfg ~/klipper_config/printer.cfg
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/800_480.tft
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/mksclient-max3.deb
  sudo dpkg -i mksclient-max3.deb ; sudo mv 800_480.tft /root/
  sudo mv ~/klipper_config/MKS_THR.cfg ~/klipper_config/MKS_THR.cfg.bak ; path=$(ls /dev/serial/by-id/*) ; printf "[mcu MKS_THR]\nserial:$path\n" > ~/klipper_config/MKS_THR.cfg
elif [[ "$pcfg" =~ [nN] ]] ; then
  sudo sed -i 's/deb.debian.org\/debian buster-backports/archive.debian.org\/debian buster-backports/g' /etc/apt/sources.list
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/800_480.tft
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/mksclient-max3.deb
  sudo dpkg -i mksclient-max3.deb ; sudo mv 800_480.tft /root/
  sudo mv ~/klipper_config/MKS_THR.cfg ~/klipper_config/MKS_THR.cfg.bak ; path=$(ls /dev/serial/by-id/*) ; printf "[mcu MKS_THR]\nserial:$path\n" > ~/klipper_config/MKS_THR.cfg
else
  echo "ERROR: invalid response"
  exit 0
fi

echo "the printer firmware updates have been installed. turn your printer off, wait for 15 seconds, and turn it back on. there should be a white screen with a progress indicator. once that's complete, reboot your printer again and you should be good to go"
