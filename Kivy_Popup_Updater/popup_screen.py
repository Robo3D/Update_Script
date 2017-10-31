from kivy.properties import NumericProperty, ObjectProperty, StringProperty,  BooleanProperty
from kivy.clock import Clock
from kivy.uix.modalview import ModalView
from kivy.logger import Logger

class UpdateProgress(object):
    def __init__(self, path):
        self.path = path
        self.executed = 0
        self.total = 0
        Clock.schedule_interval(self.update, 0.1)

    def update(self,dt):
        with open(self.path, 'rb') as f:
            fraction = f.read()
            if '/' in fraction:
                e,t =  fraction.split('/')
                self.executed = float(e)
                self.total = float(t)

class Updating_Popup(ModalView):
    # total_updates = NumericProperty(0)
    # exec_updates = NumericProperty(0)
    def __init__(self,**kwargs):
        super(Updating_Popup,self).__init__(**kwargs)
        # self.app_instance = App.get_running_app()
        self.open()
        Logger.info("Updating_Popup.open()!!!")
        # Clock.schedule_interval(self.update, 0.5)

    # def update(self,dt):
    #     self.exec_updates = self.app_instance.update_progress[0]
    #     self.update_progress.total = self.app_instance.update_progress[1]

class USB_Progress_Popup(ModalView):
    # total_updates = NumericProperty(0)
    # exec_updates = NumericProperty(0)
    value_progress = NumericProperty(0.0)
    body = StringProperty('Your printer will restart after the\nupdate is finished.\n[size=25][color=#FF0000]Please do not turn the printer off.[/color][/size]')

    def __init__(self,**kwargs):
        super(USB_Progress_Popup,self).__init__(**kwargs)
        self.update_progress = UpdateProgress('/home/pi/.progress')
        self.open()
        Clock.schedule_interval(self.update, 0.25)


    def update(self,dt):
        current_percent = float(self.update_progress.executed)/float(self.update_progress.total)
        next_percent = float(self.update_progress.executed + 1)/float(self.update_progress.total)

        within_range = current_percent <= self.value_progress < next_percent
        if within_range and int(current_percent) is not 1:
            self.value_progress += 0.005
        elif current_percent > self.value_progress:
            self.value_progress = current_percent
        else:
            pass
        Logger.info('displayed: {}'.format(self.value_progress))
