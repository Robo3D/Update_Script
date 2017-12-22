#!/bin/bash

HOME_DIR="/home/pi"
VENV="oprint"
THIS_DIR=`dirname $0`
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"
LOG=/home/pi/.octoprint/logs/update_info.txt

verify_success () {
  if [ $1 -eq 0 ]; then
    echo "$2 ...success" &>> $LOG
  else
    echo "$2 ...failure" &>> $LOG
    exit 1
  fi
}

task="[Task]:: Writing to config.yaml..."
echo $task &>> $LOG
$USER_PI $HOME_DIR/$VENV/bin/python $THIS_DIR/../assets/ensure_webcamstops.py
verify_success $? $task

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
