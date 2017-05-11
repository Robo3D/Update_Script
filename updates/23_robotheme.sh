#!/bin/bash
HOME_DIR="/home/pi"
VENV="oprint"
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"

######octoprint plugins #######
install_plugin () {
    $USER_PI $HOME_DIR/$VENV/bin/pip install $1
}

install_plugin "https://github.com/Robo3D/OctoPrint-robotheme/archive/0.2.3.zip"

#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
