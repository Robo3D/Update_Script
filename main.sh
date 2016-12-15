#!/bin/bash
HOME_DIR="/home/pi"
VENV="oprint"
OCTO_DIR=$HOME_DIR/OctoPrint
USER_PI="sudo -u pi"



kill_octoprint () {
    service octoprint stop
}
#-------------------------------Kivy Update Screen-----------------------------------

python_run () {
    $USER_PI $HOME_DIR/$VENV/bin/python $1
}

#------------------------------ Main Update----------------------------------
#stop octo print
kill_octoprint

#pull up a warning screen
python_run $THIS_DIR/Kivy_Popup_Updater/main.py & 

#do the update
python_run $THIS_DIR/Update_Checker/Update_Checker.py




#exit
exit 0