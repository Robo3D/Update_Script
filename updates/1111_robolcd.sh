
#!/bin/bash
HOME_DIR="/home/pi"
VENV="oprint"
OCTO_DIR=$HOME_DIR/OctoPrint
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

######octoprint plugins #######
install_plugin () {
    $USER_PI $HOME_DIR/$VENV/bin/pip install $1
}

#Install the new RoboLCD Version
task="[Task]:: Installing RoboLCD..."
echo $task &>> $LOG
install_plugin "https://robo3dtest:r0b0r0b0@github.com/Robo3D/RoboLCD/archive/master.zip"
verify_success $? $task

# Ensure dependencies got installed
task="[Task]:: Installing FirmwareUpdater..."
echo $task &>> $LOG
install_plugin "https://github.com/Robo3D/OctoPrint-FirmwareUpdater/archive/0.2.1.zip"
verify_success $? $task

task="[Task]:: Installing Octoprint..."
echo $task &>> $LOG
install_plugin "https://github.com/Robo3D/roboOctoprint/archive/Master_2.0.zip"
verify_success $? $task

task="[Task]:: Installing Meta-Reader..."
echo $task &>> $LOG
install_plugin "https://github.com/Robo3D/Meta-Reader/archive/1.1.0.zip"
verify_success $? $task

#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
