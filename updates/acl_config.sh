#!/bin/bash

HOME_DIR="/home/pi"
VENV="oprint"
THIS_DIR=`dirname $0`
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"
LOG=/home/pi/.octoprint/logs/update_info.log
script_path=/home/pi/.octoprint/data/roboACL

verify_success () {
  if [ $1 -eq 0 ]; then
    echo "$2 ...success" &>> $LOG
  else
    echo "$2 ...failure" &>> $LOG
    exit 1
  fi
}

task="[Task]:: Ensure roboACL Folder..."
echo $task &>> $LOG
$USER_PI mkdir -p $script_path
verify_success $? $task

task="[Task]:: Copying roboACL enable/disable script..."
echo $task &>> $LOG
$USER_PI cp $THIS_DIR/../assets/roboacl.py $script_path/roboacl.py
verify_success $? $task

task="[Task]:: Setting permissions..."
echo $task &>> $LOG
$USER_PI chmod 755 $script_path/roboacl.py
verify_success $? $task

task="[Task]:: Writing to ACL to config.yaml..."
echo $task &>> $LOG
$USER_PI $HOME_DIR/$VENV/bin/python $THIS_DIR/../assets/acl_config.py
verify_success $? $task


#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
