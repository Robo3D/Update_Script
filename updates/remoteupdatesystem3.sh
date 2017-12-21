#!/bin/bash

THIS_DIR=`dirname $0`
RRUS_DIR=$THIS_DIR/../roboRemoteUpdateSystem
USER_PI="sudo -u pi"
LOG=/home/pi/SHINFO.txt

verify_success () {
  if [ $1 -eq 0 ]; then
    echo "$2 ...success" &>> $LOG
  else
    echo "$2 ...failure" &>> $LOG
    exit 1
  fi
}

task="[Task]:: Install compliant RoboLCD version..."
echo $task &>> $LOG
cd $THIS_DIR &>> $LOG
$USER_PI /home/pi/oprint/bin/pip install https://github.com/victorevector/RoboLCD/archive/RRUSpub.zip
verify_success $? $task

echo "Finishing up..." &>> $LOG
#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!" >> $LOG
exit 0
