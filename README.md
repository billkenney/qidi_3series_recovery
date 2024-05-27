# qidi_3series_recovery
this is a manual install script for qidi max3/plus3/smart3 firmware 4.3.13/4.2.13/4.1.13 for people with the error message that "the system starts abnormally!", a blank screen, or you're unable to update the firmware for some reason. all of these files are from qidi's github repository. the only change i made was to comment out the line "systemctl disable gpio-monitor.service" in the DEBIAN/postinst script of the mksclient, because that service did not exist on my printer and it caused the firmware update to fail

using a terminal client such as putty for windows, Terminal on macos or linux, or an app like shelly or terminus on your phone, ssh into your printer: `ssh mks@printer.ip.address` replacing 'printer.ip.address' with your printers ip address. enter 'makerbase' any time you are prompted for a password (unless you changed it)

if you get an ssl error when trying to download the script, find your time zone here: https://en.m.wikipedia.org/wiki/List_of_tz_database_time_zones (it should be in the format America/Chicago), then run `sudo timedatectl set-timezone [your_timezone] ; sudo timedatectl set-ntp 1` replacing [your_timezone] with your actual timezone

# for the max3 with the bltouch
ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/max3_bltouch_recovery.sh ; chmod +x max3_bltouch_recovery.sh ; ./max3_bltouch_recovery.sh`

# for the max3 with the inductive probe
ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/max3_probe_recovery.sh ; chmod +x max3_probe_recovery.sh ; ./max3_probe_recovery.sh`

# for the plus3
ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/plus3_recovery.sh ; chmod +x plus3_recovery.sh ; ./plus3_recovery.sh`

# for the smart3
ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/qidi_3series_recovery/main/smart3_recovery.sh ; chmod +x smart3_recovery.sh ; ./smart3_recovery.sh`
