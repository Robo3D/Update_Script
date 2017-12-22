from kivy.properties import NumericProperty, ObjectProperty, StringProperty,  BooleanProperty
from kivy.clock import Clock
from kivy.uix.modalview import ModalView
from kivy.logger import Logger
import subprocess

class UpdateStats(object):
    def __init__(self, path):
        self.path = path
        self.executed = 0
        self.total = 0
        self.failed = 0
        Clock.schedule_interval(self.update, 0.1)

    def update(self,dt):
        with open(self.path, 'rb') as f:
            stats = f.read()
            e,t,f =  stats.split(',')
            self.executed = float(e)
            self.total = float(t)
            self.failed += int(f)

class Failed_Updating_Popup(ModalView):
    def __init__(self,**kwargs):
        super(Failed_Updating_Popup,self).__init__(**kwargs)

    def reboot(self):
        Logger.info("RESTART")
        r = Restarting_Popup()
        r.open()
        self.dismiss()

class Restarting_Popup(ModalView):
    def __init__(self,**kwargs):
        super(Restarting_Popup,self).__init__(**kwargs)
        Clock.schedule_once(self.restart, 1)

    def restart(self, dt):
        Logger.info("Supposed to Restart.... defer to RRUS")
        exit(0)
        # subprocess.call(['sudo', 'reboot'])


class USB_Progress_Popup(ModalView):
    current_percent = NumericProperty(0.0)
    value_progress = NumericProperty(0.0)
    body = StringProperty('Your printer will restart after the\n2 part update is finished.\n[size=25][color=#FF0000]Please do not turn the printer off.[/color][/size]')

    def __init__(self,**kwargs):
        super(USB_Progress_Popup,self).__init__(**kwargs)
        self.update_stats = UpdateStats('/home/pi/.progress')
        self.sched_update = Clock.schedule_interval(self.update, 0.25)

    def update(self,dt):
        """Update progress bar based on update_checker's reported stats."""
        self.current_percent = float(self.update_stats.executed)/float(self.update_stats.total)
        next_percent = float(self.update_stats.executed + 1)/float(self.update_stats.total)

        within_range = self.current_percent <= self.value_progress < next_percent
        if within_range and int(self.current_percent) is not 1:
            self.value_progress += 0.001
        elif self.current_percent > self.value_progress:
            self.value_progress = self.current_percent
        else:
            pass
        Logger.info('displayed: {}'.format(self.value_progress))
