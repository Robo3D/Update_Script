#! /bin/sh
THIS_DIR=`dirname $0`
USER_PI="sudo -u pi"
UPLOADS="/home/pi/.octoprint/uploads"

#remove gcode files
echo "removing old gcode files"

rm $UPLOADS/robo_keychain.gcode
rm $UPLOADS/smartphone_and_tablet_stand.gcode
rm $UPLOADS/wavy_vase.gcode
rm $UPLOADS/Whistle_V29D.gcode
rm $UPLOADS/"TEST(skirt_no_raft).gcode"
rm $UPLOADS/"TEST(with_raft).gcode"

echo "adding new gcode files"

$USER_PI cp -a $THIS_DIR/../assets/gcode_files/. $UPLOADS/

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
