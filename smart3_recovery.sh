#!/bin/bash
cd /home/mks
sudo sed -i 's/deb.debian.org\/debian buster-backports/archive.debian.org\/debian buster-backports/g' /etc/apt/sources.list
sudo mv ~/klipper_config/MKS_THR.cfg ~/klipper_config/MKS_THR.cfg.bak ; path=$(ls /dev/serial/by-id/*) ; printf "[mcu MKS_THR]\nserial:$path\n" > ~/klipper_config/MKS_THR.cfg
read -p 'do you want to restore the stock klipper_config folder? (y/n): ' kfg
if [[ "$kfg" =~ [yY] ]] ; then
  tar -czf klipper_config.bak.tgz klipper_config ; rm -rf klipper_config
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/klipper_config.tgz
  tar -xzf klipper_config.tgz ; rm klipper_config.tgz
   wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/printer-smart3.cfg
   mv printer-smart3.cfg ~/klipper_config/printer.cfg
  echo "your old klipper_config folder has been backed up to klipper_config.bak.tgz and the stock klipper_config folder and printer.cfg have been installed"
elif [[ "$kfg" =~ [nN] ]] ; then
  read -p 'do you want to update your printer.cfg file? (y/n): ' pcfg
  if [[ "$pcfg" =~ [yY] ]] ; then
    wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/printer-smart3.cfg
    mv ~/klipper_config/printer.cfg ~/klipper_config/printer.cfg.bak ; mv printer-smart3.cfg ~/klipper_config/printer.cfg
    echo "your old printer.cfg has been saved to ~/klipper_config/printer.cfg.bak"
  fi
fi
wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/mksclient-smart3.deb
sudo dpkg -i mksclient-smart3.deb ; rm mksclient-smart3.deb
read -p 'do you want to update your screen firmware (unnecessary if its already on the latest firmware, this update takes like 30 min)? (y/n): ' sfmw
if [[ "$sfmw" =~ [yY] ]] ; then
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/800_480-smart3.tft
  sudo mv 800_480-smart3.tft /root/800_480.tft
fi
sudo chown -R mks:mks /home/mks/klipp* /home/mks/moonraker* /home/mks/fluidd

echo "the printer firmware updates have been installed. turn your printer off, wait for 15 seconds, and turn it back on. if you've chosen to install the screen firmware, there should be a white screen with a progress indicator. it could take a few minutes for the update to begin, so don't be impatient. once that's complete, reboot your printer again and you should be good to go"
