# qidi_3series_recovery
This is a manual install script for qidi max3/plus3/smart3 firmware 4.3.13/4.2.13/4.1.13 for people with the error message that "the system starts abnormally!", a blank screen, or you're unable to update the firmware for some reason. 

The 800_480.tft file is the QD_Max3_UI5.0 and the QD_Plus3_UI5.0, and is the same for the max3 and the plus3. The 800_480-smart3.tft is the QD_Smart3_UI4.3. The mksclient-max3.deb is the QD_Max_SOC file, the mksclient-plus3.deb is the QD_Plus_SOC file, and the mksclient-smart3.deb is the QD_Smart_SOC. The only change I made was to comment out the line "systemctl disable gpio-monitor.service" in the DEBIAN/postinst script, because that service did not exist on my printer and it caused the firmware update to fail. 

if you have the max3 with the bltouch, ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/max3_bltouch_recovery.sh ; chmod +x max3_bltouch_recovery.sh ; ./max3_bltouch_recovery.sh`

if you have the max3 with the inductive probe, ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/max3_probe_recovery.sh ; chmod +x max3_probe_recovery.sh ; ./max3_probe_recovery.sh`

if you have the plus3, ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/plus3_recovery.sh ; chmod +x plus3_recovery.sh ; ./plus3_recovery.sh`

if you have the smart3, ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/smart3_recovery.sh ; chmod +x smart3_recovery.sh ; ./smart3_recovery.sh`

if you get an ssl error when trying to download the file, find your time zone here: https://en.m.wikipedia.org/wiki/List_of_tz_database_time_zones (it should be in the format America/Chicago), then run `sudo timedatectl set-timezone [your_timezone] ; sudo timedatectl set-ntp 1` replacing [your_timezone] with your actual timezone
