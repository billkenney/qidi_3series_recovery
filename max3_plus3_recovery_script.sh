#!/bin/bash
echo 'this script will update the firmware for a qidi max 3 or plus 3 to version 4.3.13'
echo 'if you choose to update your printer.cfg, it will save the current config to printer.cfg.bak'

read -p "what is your printer's ip address? " ip_address
read -p 'is your printer the (1) max 3 or (2) the plus 3? ' printer

if [[ "$printer" -eq 1 ]] ; then
  rm *-plus3*
  read -p 'does your printer have the (1) bltouch (which has orange on the side) or the (2) probe? ' probe
  if [[ "$probe" -eq 1 ]] ; then
    rm printer-max3_probe.cfg
  elif [[ "$probe" -eq 2 ]] ; then
    rm printer-max3_bltouch.cfg
  fi
  read -p 'do you want to update your printer.cfg file? (y/n) ' cfg
  echo "###############################################################################
please enter the password 'makerbase' if prompted (there should be two prompts)
###############################################################################"
  if [[ "$cfg" =~ [yY] ]] ; then
    echo "#!/bin/bash
if [ -f /home/mks/klipper_config/printer.cfg ] ; then
  mv /home/mks/klipper_config/printer.cfg /home/mks/klipper_config/printer.cfg.bak
fi
mv *.cfg /home/mks/klipper_config/printer.cfg
sudo dpkg -i mksclient-max3.deb
sudo mv 800_480.tft /root/" > recovery_script.sh
    scp recovery_script.sh *.cfg *.deb *.tft mks@"$ip_address":/home/mks
  elif [[ "$cfg" =~ [nN] ]] ; then
    rm *.cfg
    echo "#!/bin/bash
sudo dpkg -i mksclient-max3.deb
sudo mv 800_480.tft /root/" > recovery_script.sh
    scp recovery_script.sh *.deb *.tft mks@"$ip_address":/home/mks
  fi
  ssh mks@"$ip_address" "cd /home/mks ; chmod +x recovery_script.sh ; /bin/bash recovery_script.sh"
fi

if [[ "$printer" -eq 2 ]] ; then
  rm *-max3*
  read -p 'do you want to update your printer.cfg file? (y/n) ' cfg
  echo "###############################################################################
please enter the password 'makerbase' if prompted (there should be two prompts)
###############################################################################"
  if [[ "$cfg" =~ [yY] ]] ; then
    echo "#!/bin/bash
if [ -f /home/mks/klipper_config/printer.cfg ] ; then
  mv /home/mks/klipper_config/printer.cfg /home/mks/klipper_config/printer.cfg.bak
fi
mv *.cfg /home/mks/klipper_config/printer.cfg
sudo dpkg -i mksclient-plus3.deb
sudo mv 800_480.tft /root/" > recovery_script.sh
    scp recovery_script.sh *.cfg *.deb *.tft mks@"$ip_address":/home/mks
 elif [[ "$cfg" =~ [nN] ]] ; then
    rm *.cfg
    echo "#!/bin/bash
sudo dpkg -i mksclient-plus3.deb
sudo mv 800_480.tft /root/" > recovery_script.sh
    scp recovery_script.sh *.deb *.tft mks@"$ip_address"
  fi
  ssh mks@"$ip_address" "cd /home/mks ; chmod +x recovery_script.sh ; /bin/bash recovery_script.sh"
fi

echo 'the mksclient has been installed, and the mksrecovery file has been moved to your root directory'
echo 'please turn off your printer, wait for 20 seconds, and turn it back on'
echo 'the firmware update will take about 30 minutes, you can see the progress on your screen'
