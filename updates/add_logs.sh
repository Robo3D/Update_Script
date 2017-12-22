#!/bin/bash
LOGPATH=/home/pi/.octoprint/logs
LOG=/home/pi/.octoprint/logs/update_info.log

verify_success () {
  if [ $1 -eq 0 ]; then
    echo "$2 ...success" &>> $LOG
  else
    echo "$2 ...failure" &>> $LOG
    exit 1
  fi
}

make_link () {
    task="[Task]:: Making symbolic link "$1
    echo $task &>> $LOG
    sudo ln -sf $1 $2
    verify_success $? $task
}

make_link /var/log/netconnectd.log $LOGPATH/netconnectd.log
make_link /var/log/boot.log $LOGPATH/boot.log
make_link /var/log/daemon.log $LOGPATH/daemon.log
make_link /var/log/kern.log $LOGPATH/kern.log
make_link /var/log/syslog $LOGPATH/syslog
make_link /var/log/daemon.log $LOGPATH/daemon.log




#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
