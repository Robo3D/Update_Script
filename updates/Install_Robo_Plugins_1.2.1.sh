#!/bin/bash
HOME_DIR="/home/pi"
VENV="oprint"
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"

LOG=/home/pi/.octoprint/logs/update_info.log

verify_success () {
  if [ $1 -eq 0 ]; then
    echo "$2 ...success" &>> $LOG
  else
    echo "$2 ...failure" &>> $LOG
    exit 1
  fi
}

######octoprint plugins #######
install_plugin () {
    task="[Task]:: Installing "$1
    echo $task &>> $LOG
    $USER_PI $HOME_DIR/$VENV/bin/pip install $1
    verify_success $? $task
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




#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
