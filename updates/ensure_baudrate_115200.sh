#!/bin/bash
THIS_DIR=`dirname $0`

HOME_DIR="/home/pi"
VENV="oprint"
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"

#Ensure baudrate == 115200 in config.yaml
$USER_PI $HOME_DIR/$VENV/bin/python replace_baudrate.py


#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
