#!/bin/bash

THIS_DIR=`dirname $0`
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

task="[Task]:: Installing gcode_cmds"
echo $task &>> $LOG
$USER_PI cp -a $THIS_DIR/../assets/gcode_scripts/. /home/pi/.octoprint/scripts/gcode/
verify_success $? $task

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
