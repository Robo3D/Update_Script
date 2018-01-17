# -*- coding: utf-8 -*-
# @Author: Matt Pedler
# @Date:   2018-01-16 18:12:48
# @Last Modified by:   Matt Pedler
# @Last Modified time: 2018-01-16 19:14:52
import yaml
import os
import shutil

class yaml_editor_quick(object):
    def __init__(self):
        super(yaml_editor_quick, self).__init__()
        self.octo_config_path = '/home/pi/.octoprint/config.yaml'
        self.load_yaml_to_self()
        self.load_edits()

    def load_yaml_to_self(self):
        #make a copy just in case this all goes horribly wrong
        shutil.copy(self.octo_config_path, '/home/pi/.octoprint/config.yaml.backup')
        #load
        with open(self.octo_config_path, 'r') as file:
            self.config = yaml.load(file)

    def load_edits(self):
        if not 'system' in self.config:
            self.config['system'] = {'actions': []}

        commands = self.config['system']['actions']
        extra_commands = []
        for x in range(len(commands)):
            if 'action' in commands[x] and (commands[x]['action'] != 'aclon' and commands[x]['action'] != 'acloff' and commands[x]['action'] != 'divider' and commands[x]['action'] != 'streamon' and commands[x]['action'] != 'streamoff'):
                extra_commands.append(commands[x])
                print (str(commands[x]))
        #add the extra commands
        self.config['system']['actions'] = [] + extra_commands
        #ensure the robo commands are written
        self.config['system']['actions'] += [{'action': 'aclon',
                                             'command': '/home/pi/oprint/bin/python /home/pi/.octoprint/data/roboACL/roboacl.py enable',
                                             'name': 'Enable remote access security feature',
                                             'confirm': 'You are about to launch the setup wizard to enable remote access security features. You will have to complete the wizard in order to continue using the web dashboard. The dashboard and your printer will automatically restart once the wizard is finished. This will disrupt any active prints.'},

                                            {'action': 'acloff',
                                             'command': '/home/pi/oprint/bin/python /home/pi/.octoprint/data/roboACL/roboacl.py disable',
                                             'name': 'Disable remote access security feature',
                                             'confirm': 'You are about to disable the remote access security features and DELETE all user accounts. This will make your printer remotely accessible to everyone within your local network. The dashboard and your printer will automatically restart. This will disrupt any active prints.'},

                                            {'action': 'divider'},

                                            {'action': 'streamon',
                                             'command': '/home/pi/scripts/webcam start',
                                             'name': 'Start video stream',
                                             'confirm': False},

                                            {'action': 'streamoff',
                                             'command': '/home/pi/scripts/webcam stop',
                                             'name': 'Stop video stream',
                                             'confirm': False}]



        with open(self.octo_config_path, 'w') as file:
            yaml.dump(self.config, file, default_flow_style=False)



yaml_editor_quick()