#!/bin/sh

THIS_DIR=$(echo $(pwd))
RRUS_DIR=$THIS_DIR/../roboRemoteUpdateSystem
USER_PI="sudo -u pi"

echo "Cloning Repository..."
git clone https://robo3dtest:r0b0r0b0@github.com/Robo3D/roboRemoteUpdateSystem.git $RRUS_DIR

echo "Running installation..."
cd $RRUS_DIR
chmod +x install.sh
./install.sh

echo "Starting roboRemoteUpdateSystem in 15 seconds..."
sudo service roboRemoteUpdateSystem restart
# give RRUS time to start up
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do
  sleep 1
  echo $i
done

echo "Running playbook..."
$USER_PI /home/pi/oprint/bin/python $THIS_DIR/../assets/run_playbook.py
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
