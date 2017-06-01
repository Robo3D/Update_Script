#!/bin/bash

THIS_DIR=`dirname $0`
USER_PI="sudo -u pi"

echo "Installing gcode_cmds"

$USER_PI cp -a $THIS_DIR/../assets/gcode_scripts/. /home/pi/.octoprint/scripts/gcode/

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
