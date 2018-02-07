Shell script for updating Robo R2 and C2 Printers
Installation
Installation on R2 and C2 printers requires the correct repository to be checked out in Git on your printer.

The generic steps that should basically be done regardless of the printer are below.

Clone Update_Script: `git clone https://github.com/Robo3D/Update_Script.git`
Checkout the correct branch. `git checkout R2_2.0`
Source Octoprint's virtual environment: `source oprint/bin/activate`
Change into the Update Script folder: `cd Update_Script`
Start the updater: `bash main.sh`

The Updater will begin checking for version numbers, and installing updated assets into their proper place.
