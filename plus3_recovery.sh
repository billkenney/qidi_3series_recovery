#!/bin/bash
cd /home/mks
sudo sed -i 's/deb.debian.org\/debian buster-backports/archive.debian.org\/debian buster-backports/g' /etc/apt/sources.list
wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/mksclient-plus3.deb
sudo mv ~/klipper_config/MKS_THR.cfg ~/klipper_config/MKS_THR.cfg.bak ; path=$(ls /dev/serial/by-id/*) ; printf "[mcu MKS_THR]\nserial:$path\n" > ~/klipper_config/MKS_THR.cfg
sudo dpkg -i mksclient-plus3.deb ; rm mksclient-plus3.deb
read -p 'do you want to update your screen firmware (unnecessary if its already on the latest firmware, this update takes like 30 min)? (y/n): ' sfmw
if [[ "$sfmw" =~ [yY] ]] ; then
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/800_480.tft
  sudo mv 800_480.tft /root/800_480.tft
fi
read -p 'do you want to update your printer.cfg file? (y/n): ' pcfg
if [[ "$pcfg" =~ [yY] ]] ; then
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/printer-plus3.cfg
  mv ~/klipper_config/printer.cfg ~/klipper_config/printer.cfg.bak ; mv printer-plus3.cfg ~/klipper_config/printer.cfg
  echo "your old printer.cfg has been saved to ~/klipper_config/printer.cfg.bak"
fi

echo "the printer firmware updates have been installed. turn your printer off, wait for 15 seconds, and turn it back on. if you've chosen to install the screen firmware, there should be a white screen with a progress indicator. it could take a few minutes for the update to begin, so don't be impatient. once that's complete, reboot your printer again and you should be good to go"
