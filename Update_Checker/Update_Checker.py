import os
from os import walk
import os.path
import string
import subprocess
import yaml
import logging


class Update_Checker():
    """docstring for Update_Checker"""
    def __init__(self, versioning_path='/home/pi/roboOS.txt', pipe=None):
        logging.basicConfig(filename='/home/pi/update_script.log', level=logging.DEBUG)
        logging.info('Update_Checker imported')

        self.version = '1.8.1-r2.1'
        self.current_path = os.path.dirname(os.path.realpath(__file__))
        print("Current Directory is: " + self.current_path)

        self.versioning_path, pipe = self.sort_args(versioning_path, pipe)

        self.check_updates()
        self.check_completed_updates()
        # report back to caller

        if pipe:
            output_p, input_p = pipe
            output_p.close()
            if len(self.needed_updates) > 0:
                input_p.send(True)
            else:
                input_p.send(False)
            input_p.close()
        self.execute_updates()

    def sort_args(self, v, p):
        """
        manually screen args and correct misnomers.
        return (versioning_path, pipe)

        fix for bug introduced in RoboLCD 1.3.0.
        __History__
            RoboLCD 1.3.0 passes the pipe arg before versioning_path, while 1.2.3 only passes the verisioning_path. This causes Update_Checker to be incompatible with both 1.2.3 and 1.3.0.

        """
        v_type = type(v)
        p_type = type(p)

        if v_type is str:
            versioning_path = v
        elif p_type is str:
            versioning_path = p

        if v_type is tuple or v is None:
            pipe = v
        elif p_type is tuple or p is None:
            pipe = p

        return versioning_path, pipe

    def update_version(self):
        if self.versioning_path:
            with open(self.versioning_path, 'w') as f:
                f.write(self.version)
        else:
            pass

    def check_updates(self):
        self.updates_path = self.current_path + "/../updates/"
        self.update_filenames = []
        for (dirpath, dirnames, filenames) in walk(self.updates_path):
            if filenames != "updates.txt":
                self.update_filenames.extend(filenames)

        print("Files inside of /updates/ : ")
        for file in self.update_filenames:
            print("\t" + file)
        logging.info("Available Updates: {}".format(self.update_filenames))

    def check_completed_updates(self):
        #get the filename of the logged updates
        self.current_updates_filename = "/home/pi/.updates.txt"
        if not os.path.isfile(self.current_updates_filename):
            create_file = open(self.current_updates_filename, 'w+')

        print("Completed Updated Path: " + self.current_updates_filename)

        #put all logged filenames into a list
        cu = []
        with open(self.current_updates_filename, "r") as completed:
            for line in completed:
                cu.append(line)
        completed.close()

        cu_fixed = []
        for file in cu:
            cu_fixed.append(file.replace("\n", ""))
        print(cu_fixed)

        #check the logged filenames against the updates that need to occur
        print("Checking Updates")
        self.needed_updates = []
        for update in self.update_filenames :
            if update in cu_fixed:
                print("\t" + update + ": Already updated")
            else:
                self.needed_updates.append(update)
                print("\t" + update + ": Needs Updating")

        logging.info("Desires an update: {}".format(self.needed_updates))

    def render_gui(self):
        # make Kivy_Popup_Updater discoverable
        import sys
        sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
        from Kivy_Popup_Updater.main import Updater_App
        Updater_App().run()

    def execute_updates(self):
        if len(self.needed_updates) != 0:
            from multiprocessing import Process, Array
            gui = Process(target=self.render_gui, args=())
            print "#### STARTING GUI!!!"
            gui.start()

            #update all pending updates
            print("These need updating:")
            for update in self.needed_updates:
                print("\t" + update)

            exit_codes = []
            for update in self.needed_updates:
                print("Executing " + update)
                logging.info("Start... package: {}".format(update))
                ec = subprocess.call(["sudo bash "+ self.updates_path + update], shell=True)
                exit_codes.append(ec)
                if ec is 0:
                    logging.info("Complete... package: {}".format(update))
                else:
                    logging.info("Failed... package: {}".format(update))

            success_count = exit_codes.count(0)
            failed_count = exit_codes.count(1)
            count_msg = 'Success: {} Failed: {}'.format(success_count, failed_count)
            logging.info(count_msg)
            if 1 in exit_codes:
                logging.info('Failed detected... Not updating version.')
            else:
                logging.info("Updating Version...")
                self.update_version()
                logging.info("...Complete.")
                #restart the machine
                logging.info("Deferring reboot to new update system...")
                # subprocess.call("sudo reboot", shell=True)
                logging.info("Exiting....")
                exit(0)
        else:
            self.update_version()
            exit(0)



if __name__ == '__main__':
    Update_Checker()
