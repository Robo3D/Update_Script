#! /bin/sh
THIS_DIR=`dirname $0`
USER_PI="sudo -u pi"
HOME_DIR="/home/pi"
VENV="oprint"
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"

install_plugin () {
    $USER_PI $HOME_DIR/$VENV/bin/pip install $1
}

install_plugin "https://github.com/mikerybka/OctoPrint-Lani/archive/master.zip"

#disable lani in config
cd $THIS_DIR/../assets
$USER_PI $HOME_DIR/$VENV/bin/python disable_lani.py

#store that the update has occured
echo ${0##*/} >> /home/pi/.updates.txt
echo "Update Complete!"
exit 0
