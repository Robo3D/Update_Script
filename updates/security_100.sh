#!/bin/bash
THIS_DIR=`dirname $0`
ACL_DIRECTORY="/home/pi/.octoprint/data/roboACL"
SSH_STATE_PATH="/home/pi/.octoprint/ssh_marker.txt"

#make robo ACL folder
if [ ! -d $ACL_DIRECTORY ]; then
    mkdir $ACL_DIRECTORY
    fi

#Copy Access Control setup script
cp $THIS_DIR/../assets/security_assets/roboacl.py $ACL_DIRECTORY/roboacl.py
#change the owner to pi and set filemode 0755
sudo chown pi:pi $ACL_DIRECTORY/roboacl.py 
sudo chmod 0755 $ACL_DIRECTORY/roboacl.py

#change ssh state to disabled
systemctl disable ssh && touch $SSH_STATE_PATH

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0