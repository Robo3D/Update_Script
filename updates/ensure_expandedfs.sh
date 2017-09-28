#!/bin/bash

sudo /usr/bin/raspi-config --expand-rootfs

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
