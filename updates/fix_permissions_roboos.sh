#! /bin/sh
LOG=/home/pi/.octoprint/logs/update_info.log

verify_success () {
  if [ $1 -eq 0 ]; then
    echo "$2 ...success" &>> $LOG
  else
    echo "$2 ...failure" &>> $LOG
    exit 1
  fi
}
task="[Task]:: fixing permissions roboos.txt ..."
echo $task &>> $LOG
chown pi:pi /home/pi/.octoprint/data/RoboLCD/roboOS.txt
verify_success $? $task
#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
