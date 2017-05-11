#!/bin/bash

HOME_DIR="/home/pi"
VENV="oprint"
THIS_DIR=`dirname $0`
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"


python_run () {
    $USER_PI $HOME_DIR/$VENV/bin/python $1
}


python_run $THIS_DIR/../assets/ensure_webcamstops.py

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
