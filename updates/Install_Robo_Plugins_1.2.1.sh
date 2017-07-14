#!/bin/bash
HOME_DIR="/home/pi"
VENV="oprint"
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"

######octoprint plugins #######
install_plugin () {
    $USER_PI $HOME_DIR/$VENV/bin/pip install $1
}

#Custom Controls Plugin
install_plugin "https://github.com/Robo3D/octoprint-customControl/archive/0.2.7.zip"

#Marlin EEPROM Editor
install_plugin "https://github.com/Robo3D/OctoPrint-EEPROM-Marlin/archive/0.1.5.zip"

#persistent Mainboard connection
# install_plugin "https://github.com/Robo3D/OctoPrint-MainboardConnection/archive/master.zip"

#Netconnectd
install_plugin "https://github.com/Robo3D/OctoPrint-Netconnectd/archive/0.2.zip"

#Print History
install_plugin "https://github.com/Robo3D/OctoPrint-PrintHistory/archive/0.92.zip"

#Printer stats
install_plugin "https://github.com/Robo3D/OctoPrint-Stats/archive/1.0.1.zip"

#Request Spinner
install_plugin "https://github.com/Robo3D/OctoPrint-RequestSpinner/archive/0.1.2.zip"

#kaa print event
install_plugin "https://github.com/Robo3D/Kaa_Printevent/archive/0.1.0.zip"

#lani
# install_plugin "https://github.com/mikerybka/OctoPrint-Lani/archive/master.zip"

#Alexa
install_plugin "https://github.com/Robo3D/Octoprint_Alexa/archive/0.1.3.zip"



#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
