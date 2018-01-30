#!/bin/bash
THIS_DIR=`dirname $0`

HOME_DIR="/home/pi"
VENV="oprint"
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"

######octoprint plugins #######
install_plugin () {
    $USER_PI $HOME_DIR/$VENV/bin/pip install $1
}


#AVRDUDE
SERIAL_PATH="/dev/ttyACM0"
flash_arduino () {
     avrdude -p m2560 -c wiring -P $SERIAL_PATH -b 115200 -F -v -U flash:w:$1 -D
}

# #get pyserial
sudo service octoprint stop
sudo pip install pyserial

# #AVRDude
apt-get install -y avrdude
#flash the board
cd $THIS_DIR/../assets/Hex_Assets

#Erase EEPROM for 1.1.6 firmware. If this doesn't happen the user will get a nasty error that they will not be able to fix on their own.
flash_arduino EEPROM_ERASE.hex
#Let the Erase happen
sleep 10
#Flash the actual firmware
flash_arduino Marlin.R2.1.2.3.hex

#Ensure baudrate == 115200 in config.yaml
$USER_PI $HOME_DIR/$VENV/bin/python replace_baudrate.py


#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0