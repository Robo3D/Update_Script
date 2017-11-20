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

task="[Task]:: Cloning Repository..."
echo $task &>> $LOG
git clone https://robo3dtest:r0b0r0b0@github.com/Robo3D/roboRemoteUpdateSystem.git $RRUS_DIR &>> $LOG
verify_success $? $task

task="[Task]:: Running installation..."
echo $task &>> $LOG
cd $RRUS_DIR &>> $LOG
chmod +x install.sh &>> $LOG
./install.sh &>> $LOG
verify_success $? $task

task="[Task]:: Install compliant RoboLCD version..."
echo $task &>> $LOG
cd $THIS_DIR &>> $LOG
$USER_PI /home/pi/oprint/bin/pip install https://github.com/victorevector/RoboLCD/archive/RRUSpub.zip
verify_success $? $task

task="[Task]:: Starting roboRemoteUpdateSystem in 15 seconds..."
echo $task &>> $LOG
sudo service roboRemoteUpdateSystem restart &>> $LOG
# give RRUS time to start up
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do
  sleep 1
  echo $i &>> $LOG
done

cd $THIS_DIR &>> $LOG
task="[Task]:: Running playbook..."
echo $task &>> $LOG
chmod +x $THIS_DIR/../assets/run_playbook.py &>> $LOG
$USER_PI /home/pi/oprint/bin/python $THIS_DIR/../assets/run_playbook.py &>> $LOG
verify_success $? $task

echo "Finishing up..." &>> $LOG
#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!" >> $LOG
exit 0
