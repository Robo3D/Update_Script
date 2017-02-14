#! /bin/sh
THIS_DIR=`dirname $0`

#splash screen
echo "Installing Longer Splash Screen!"

cd $THIS_DIR/../assets
rm /etc/init.d/splash.mp4
cp splash.mp4 /etc/init.d/




#complete the update
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
