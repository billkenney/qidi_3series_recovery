# qidi_3series_recovery
this is a manual install script for qidi max3/plus3/smart3 firmware 4.3.13/4.2.13/4.1.13 for people with the error message that "the system starts abnormally!", a blank screen, or you're unable to update the firmware for some reason. all of these files are from qidi's github repository. the only change i made was to comment out the line "systemctl disable gpio-monitor.service" in the DEBIAN/postinst script of the mksclient, because that service did not exist on my printer and it caused the firmware update to fail

using a terminal client such as putty for windows, Terminal on macos or linux, or an app like shelly or terminus on your phone, ssh into your printer: `ssh mks@printer.ip.address` replacing 'printer.ip.address' with your printers ip address. the username is 'mks' and the password is 'makerbase' (for ssh and sudo) any time you are prompted for a password (unless you changed it)

if you get an ssl error when trying to download the script, find your time zone here: https://en.m.wikipedia.org/wiki/List_of_tz_database_time_zones (it should be in the format America/Chicago), then run `sudo timedatectl set-timezone [your_timezone] ; sudo timedatectl set-ntp 1` replacing [your_timezone] with your actual timezone

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

someone posted that you can write the xindi image to a flash drive, plug it into the motherboard, and it will boot from the flash drive instead of the emmc. if you are able to do this, you can write the xindi image to your emmc without an adapter. first copy the xindi image file to a second flash drive and plug that into your printer, ssh into the printer, and check the path to the second flash drive with `sudo lsblk`, mount it, and write the image to your emmc module. first check that '/dev/mmcblk0' or '/dev/mmcblk1' is in the list of hard drives, this is your emmc. the second flash drive will probably be '/dev/sdb1', in which case you run `sudo umount /dev/sdb1 ; sudo mount /dev/sdb1 /mnt`. check to make sure the xindi image is there: `ls /mnt`, this should return 'xindi-20230309.img'. if the image is there, run `sudo dd if=/mnt/xindi-20230309.img of=/dev/mmcblk0 bs=32M status=progress`. replace '/dev/mmcblk0' with the path to your emmc

you need to update your firmware and install the correct printer.cfg after writing the xindi image to your emmc. run the recovery script again and you should be good
