# qidi_3series_recovery
this is a manual install script for qidi max3/plus3/smart3 firmware 4.3.15/4.2.15/4.1.13 for people with the error message that "the system starts abnormally!", a blank screen, you're unable to update the firmware for some reason, or you want an easier way to update the firmware and printer.cfg. all of these files are from qidi's github repository. the only change i made was to comment out the line "systemctl disable gpio-monitor.service" in the DEBIAN/postinst script of the mksclient, because that service did not exist on my printer and it caused the firmware update to fail

using a terminal client such as putty for windows, terminal on macos or linux, or an app like shelly or terminus on your phone, ssh into your printer. the printer should show up as mkspi in your router if you need to locate the ip address

the first 2.5 min of this video shows you how to use putty to connect if you're on windows (although the default username and password is different for us, see below): https://m.youtube.com/watch?v=KQVQOq0Tpgo

if you have mac you can use the terminal app. just type in ssh mks@192.168.1.xxx and press enter (replace '192.168.1.xxx' with your printers ip address)

the username is 'mks' and the password is 'makerbase' any time you are prompted for a password (unless you changed it)

if you get an ssl certificate error downloading the script, or if you have to reinstall klipper/moonraker, you need to make sure your date and time is correct. ssh into your printer and run `date`. if the date is incorrect, find your time zone here: https://en.m.wikipedia.org/wiki/List_of_tz_database_time_zones (it should be in the format America/Chicago), then run `sudo timedatectl set-timezone [your_timezone] ; sudo timedatectl set-ntp 1` replacing [your_timezone] with your actual timezone. run `date` again and make sure its correct. if its not, follow the steps here to fix it before proceeding: https://wiki.qidi3d.com/en/Memo/System-Time-Modification

the script has also been updated to give you the option to replace the klipper_config folder with the stock folder from Qidi's xindi image. if you choose this option, your current klipper_config folder will be backed up to klipper_config.bak.tgz. if you want to restore this backup, ssh into your printer and run `cd ~ ; rm -rf klipper_config ; tar -xzf klipper_config.bak.tgz`

# for the max3 with the bltouch
ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/max3_bltouch_recovery.sh ; chmod +x max3_bltouch_recovery.sh ; ./max3_bltouch_recovery.sh`

# for the max3 with the inductive probe
ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/max3_probe_recovery.sh ; chmod +x max3_probe_recovery.sh ; ./max3_probe_recovery.sh`

# for the plus3
ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/plus3_recovery.sh ; chmod +x plus3_recovery.sh ; ./plus3_recovery.sh`

# for the smart3
ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/smart3_recovery.sh ; chmod +x smart3_recovery.sh ; ./smart3_recovery.sh`

# if the printer or screen are not working properly after reinstalling the firmware, revert to qidi's klipper/moonraker, or write a recovery image to the emmc
follow the steps outlined here to reinstall klipper/moonraker from qidi's github repository: https://github.com/billkenney/revert_qidi_software/blob/main/readme.md

# write the xindi recovery image to your existing emmc without an adapter

you can also boot from a flash drived plugged into the printer if you don't have an adapter. i have a max3, and i was able to get it to boot by removing the wifi module and plugging the flash drive into that usb port--i don't know if it works with other ports. i also had to reboot a few times before i was able to ssh into this. if you are able to do this, you can write the xindi image to your emmc without an adapter--although you still need the 32gb emmc module. once you've written the xindi recovery image (from qidi's wiki) to the flash drive, plug it into that port. format a second flash drive in exfat, copy the xindi image file to that flash drive, plug it into another usb port on the printer, and turn it on. ssh into the printer (if you can't after a few minutes, turn it off and on again--repeat until it works). check the path to the second flash drive with `lsblk`, mount it, and write the image to your emmc module. first check that '/dev/mmcblk1' is in the list of hard drives, that is your emmc. the second flash drive will probably be '/dev/sdb1' (it's the one that doesn't have the boot volume next to it). if it is /dev/sdb1 you'd run `sudo umount /dev/sdb1 ; sudo mount /dev/sdb1 /mnt`. check to make sure the xindi image is in there: `ls /mnt`, this should return 'xindi-20230309.img'. if the image is there, run `sudo dd if=/mnt/xindi-20230309.img of=/dev/mmcblk0 bs=32M status=progress`. replace '/dev/mmcblk0' with the path to your emmc

you need to update your firmware and install the correct printer.cfg after writing the xindi image to your emmc. follow these steps to reinstall the firmware and update the printer.cfg: https://github.com/billkenney/qidi_3series_recovery
