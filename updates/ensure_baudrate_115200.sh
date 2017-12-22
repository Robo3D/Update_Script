#!/bin/bash
THIS_DIR=`dirname $0`

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

#Ensure baudrate == 115200 in config.yaml
task="[Task]:: Ensure correct baudrate 115200 ..."
echo $task &>> $LOG
$USER_PI $HOME_DIR/$VENV/bin/python replace_baudrate.py
verify_success $? $task

#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
