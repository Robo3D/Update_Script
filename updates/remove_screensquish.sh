#! /bin/sh
THIS_DIR=`dirname $0`
USER_PI="sudo -u pi"
HOME_DIR="/home/pi"
VENV="oprint"
USER_PI="sudo -u pi"

$USER_PI $HOME_DIR/$VENV/bin/pip uninstall -y OctoPrint-ScreenSquish

echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
