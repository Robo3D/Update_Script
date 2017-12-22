#! /bin/sh
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

#splash screen

cd $THIS_DIR/../assets
sudo rm /etc/init.d/splash.mp4
task="[Task]:: Installing Longer Splash Screen..."
echo $task &>> $LOG
sudo cp splash.mp4 /etc/init.d/
verify_success $? $task



#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
