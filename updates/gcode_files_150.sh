#! /bin/sh
THIS_DIR=`dirname $0`
USER_PI="sudo -u pi"
UPLOADS="/home/pi/.octoprint/uploads"

echo "adding new gcode files"

$USER_PI cp -a $THIS_DIR/../assets/gcode_files/. $UPLOADS/

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
