#! /bin/sh
THIS_DIR=`dirname $0`
USER_PI="sudo -u pi"
UPLOADS="/home/pi/.octoprint/uploads"

echo "adding new gcode files"

#download .zip folder of assets
cd $THIS_DIR/../assets/gcode_files/
wget https://s3.amazonaws.com/roboupdate/assets/gcode_files.zip

#unzip all files to the uploads folder
if [ -f "gcode_files.zip" ]; then
    $USER_PI unzip -o gcode_files.zip -d $UPLOADS/ 
    fi

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0