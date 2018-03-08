#! /bin/sh
THIS_DIR=`dirname $0`
USER_PI="sudo -u pi"
SLICING_DIR='/home/pi/.octoprint/slicingProfiles/cura'

rm $SLICING_DIR/fast_pla.profile
rm $SLICING_DIR/high_quality.profile
rm $SLICING_DIR/lowpla.profile
rm $SLICING_DIR/"low_quality_(raft).profile"
rm $SLICING_DIR/normal_quality.profile
rm $SLICING_DIR/highpla.profile
rm $SLICING_DIR/"high_quality_(raft).profile"
rm $SLICING_DIR/low_quality.profile
rm $SLICING_DIR/midpla.profile
rm $SLICING_DIR/"normal_quality_(raft).profile"
rm $SLICING_DIR/robo.profile
rm $SLICING_DIR/medium_quality.profile
rm $SLICING_DIR/ultra_high_quality.profile

$USER_PI cp -a $THIS_DIR/../assets/slicing_profiles_c2/. $SLICING_DIR


#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
