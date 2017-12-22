#!/bin/bash
HOME_DIR="/home/pi"
VENV="oprint"
USER_PI="sudo -u pi"
THIS_DIR=`dirname $0`
LOG=/home/pi/.octoprint/logs/update_info.log

verify_success () {
  if [ $1 -eq 0 ]; then
    echo "$2 ...success" &>> $LOG
  else
    echo "$2 ...failure" &>> $LOG
    exit 1
  fi
}
# Detect filament installation status
task="[Task]:: Installing filament sensor..."
echo $task &>> $LOG
$USER_PI $HOME_DIR/$VENV/bin/python $THIS_DIR/../assets/upgrade_pkg.py "Filament-Sensor" "https://github.com/Robo3D/Octoprint-Filament/archive/2.4.zip"
verify_success $? $task


#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
