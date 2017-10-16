#!/bin/sh

THIS_DIR=$(echo $(pwd))
RRUS_DIR=$THIS_DIR/../roboRemoteUpdateSystem


echo "Cloning Repository..."
git clone https://robo3dtest:r0b0r0b0@github.com/Robo3D/roboRemoteUpdateSystem.git $RRUS_DIR

echo "Running installation..."
cd $RRUS_DIR
chmod +x install.sh
./install.sh

echo "Running playbook..."
cd $THIS_DIR/../assets
sudo service roboRemoteUpdateSystem restart
# give RRUS time to start up
sleep 5
/home/pi/oprint/bin/python run_playbook.py
if [ $? -eq 0 ]; then
  echo "successfully run_playbook.py" >> /home/pi/SHINFO.txt
else
  echo "unsuccessfully run_playbook.py" >> /home/pi/SHINFO.txt
  echo $VAL >> /home/pi/SHINFO.txt
  exit 1
fi

echo "Finishing up..."
#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
