#!/bin/bash

THIS_DIR=`dirname $0`
RRUS_DIR=$THIS_DIR/../roboRemoteUpdateSystem
USER_PI="sudo -u pi"
LOG=/home/pi/.octoprint/logs/update_info.log
ERASEEEPROMHEX="EEPROM_ERASE.ino.hex"
HEXFILE="Marlin.R2.1.2.1.hex"
SERIAL_PATH="/dev/ttyACM0"

verify_success () {
  if [ $1 -eq 0 ]; then
    echo "$2 ...success" &>> $LOG
  else
    echo "$2 ...failure" &>> $LOG
    exit 1
  fi
}

# #get pyserial
sudo service octoprint stop
sudo pip install pyserial

# #AVRDude
apt-get install -y avrdude

# get access to assets
cd $THIS_DIR/../assets

#prep mainboard
task="[Task]:: Erase Eeprom..."
echo $task &>> $LOG
avrdude -p m2560 -c wiring -P $SERIAL_PATH -b 115200 -F -v -U flash:w:$ERASEEEPROMHEX -D
verify_success $? $task

sleep 10

#flash the board
task="[Task]:: Flashing Mainboard..."
echo $task &>> $LOG
avrdude -p m2560 -c wiring -P $SERIAL_PATH -b 115200 -F -v -U flash:w:$HEXFILE -D
verify_success $? $task

echo "Finishing up..." &>> $LOG
#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!" >> $LOG
exit 0
