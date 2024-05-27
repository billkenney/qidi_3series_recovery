#!/bin/bash
read -p 'do you want to update your printer.cfg file? (y/n): ' pcfg
if [[ "$pcfg" =~ [yY] ]] ; then
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/printer-max3_bltouch.cfg
  mv ~/klipper_config/printer.cfg ~/klipper_config/printer.cfg.bak
  mv printer-max3_bltouch.cfg ~/klipper_config/printer.cfg
  sudo sed -i 's/deb.debian.org\/debian buster-backports/archive.debian.org\/debian buster-backports/g' /etc/apt/sources.list
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/800_480.tft
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/mksclient-max3.deb
  sudo dpkg -i mksclient-max3.deb
  sudo mv 800_480.tft /root/
elif [[ "$pcfg" =~ [nN] ]] ; then
  sudo sed -i 's/deb.debian.org\/debian buster-backports/archive.debian.org\/debian buster-backports/g' /etc/apt/sources.list
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/800_480.tft
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/mksclient-max3.deb
  sudo dpkg -i mksclient-max3.deb
  sudo mv 800_480.tft /root/
else
  echo "ERROR: invalid response"
  exit 0
fi
