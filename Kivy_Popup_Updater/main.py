import os
os.environ["KIVY_NO_ARGS"] = "1"
os.environ["KIVY_NO_CONSOLELOG"] = "1"

import sys
sys.dont_write_bytecode = True
import logging
import re
import sysv_ipc
import json
import threading
import kivy
import subprocess
import shlex

kivy.require('1.9.1')
from kivy.config import Config
Config.set('kivy', 'keyboard_mode', 'dock')
Config.set('graphics', 'height', '320')
Config.set('graphics', 'width', '480')
Config.set('graphics', 'borderless', '1')
Config.set('input', '%(name)s', 'probesysfs,provider=hidinput,param=rotation=270,param=invert_y=1')

from kivy.app import App
from kivy.lang import Builder
from kivy.resources import resource_add_path
from kivy.uix.screenmanager import ScreenManager, Screen, NoTransition
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.button import Button
from kivy.uix.togglebutton import ToggleButton
from kivy.uix.gridlayout import GridLayout
from kivy.uix.label import Label
from functools import partial
from kivy.logger import Logger
import thread
from kivy.core.window import Window
from kivy.clock import Clock
import subprocess

from popup_screen import Updating_Popup, USB_Progress_Popup

DIR_PATH = os.path.dirname(os.path.realpath(__file__))
resource_add_path(DIR_PATH)

class Updater_Screen_Manager(ScreenManager):
    def __init__(self,**kwargs):
        super(Updater_Screen_Manager, self).__init__(**kwargs)
        pass
        #open the popup

class MainScreen(Screen):
    def __init__(self,**kwargs):
        super(MainScreen, self).__init__(**kwargs)
        poppy = USB_Progress_Popup()


class Updater_App(App):

    def build(self):
        try:
            Logger.info('Build called...')
            Logger.info('Loading file: {}'.format(DIR_PATH+'/updater.kv'))
            sm = Builder.load_file(DIR_PATH+'/updater.kv')
            Logger.info("Opening Up Update Screen")
        except Exception as e:
            Logger.info(str(e))
        else:
            return sm

if __name__ == '__main__':
    Updater_App().run()
