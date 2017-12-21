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

task="[Task]:: Starting roboRemoteUpdateSystem in 15 seconds..."
echo $task &>> $LOG
sudo service roboRemoteUpdateSystem start &>> $LOG
# give RRUS time to start up
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do
  sleep 1
  echo $i &>> $LOG
done

echo "Finishing up..." &>> $LOG
#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!" >> $LOG
exit 0
