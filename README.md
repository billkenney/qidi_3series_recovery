# max3_plus3_recovery
This is a manual install script for qidi max3/plus3 firmware 4.3.13 for people with the error message that "the system starts abnormally!", a blank screen, or you're unable to update the firmware for some reason. 

The 800_480.tft file is the QD_Max3_UI5.0 and the QD_Plus3_UI5.0, and is the same for both printers. The mksclient-max3.deb is the QD_Max_SOC file, and the mksclient-plus3.deb is the QD_Plus_SOC file. The only change I made was to comment out the line "systemctl disable gpio-monitor.service" in the DEBIAN/postinst script, because that service did not exist on my printer and it caused the firmware update to fail. 

if you have the max3 with the bltouch, ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/max3_bltouch_recovery.sh ; chmod +x max3_bltouch_recovery.sh ; ./max3_bltouch_recovery.sh`

if you have the max3 with the inductive probe, ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/max3_probe_recovery.sh ; chmod +x max3_probe_recovery.sh ; ./max3_probe_recovery.sh`

if you have the plus3, ssh into your printer and run: `cd ~ ; wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/plus3_recovery.sh ; chmod +x plus3_recovery.sh ; ./plus3_recovery.sh`
