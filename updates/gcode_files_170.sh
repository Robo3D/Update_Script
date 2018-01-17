#! /bin/sh
THIS_DIR=`dirname $0`
USER_PI="sudo -u pi"
UPLOADS="/home/pi/.octoprint/uploads"

echo "adding new gcode files"

#download .zip folder of assets
GCODE_FOLDER=$THIS_DIR/../assets/gcode_files/c2_gcode_files.zip
wget -O $GCODE_FOLDER https://s3.amazonaws.com/roboupdate/assets/c2_gcode_files.zip

cd $THIS_DIR/../assets/gcode_files/
#unzip all files to the uploads folder
if [ -f "c2_gcode_files.zip" ]; then
    $USER_PI unzip -o c2_gcode_files.zip -d $UPLOADS/ 
    fi

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
