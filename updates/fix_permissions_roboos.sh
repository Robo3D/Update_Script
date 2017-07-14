#! /bin/sh
chown pi:pi /home/pi/.octoprint/data/RoboLCD/roboOS.txt

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
