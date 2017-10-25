from kivy.properties import NumericProperty, ObjectProperty, StringProperty,  BooleanProperty
from kivy.clock import Clock
from kivy.uix.modalview import ModalView
from kivy.app import App
from kivy.logger import Logger


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
    #     self.total_updates = self.app_instance.update_progress[1]

class USB_Progress_Popup(ModalView):
    total_updates = NumericProperty(0)
    exec_updates = NumericProperty(0)
    value_progress = NumericProperty(0.0)
    body = StringProperty('Your printer will restart after the\nupdate is finished.\n[size=25][color=#FF0000]Please do not turn the printer off.[/color][/size]')

    def __init__(self,**kwargs):
        super(USB_Progress_Popup,self).__init__(**kwargs)
        self.app_instance = App.get_running_app()
        self.open()
        Clock.schedule_interval(self.update, 0.25)


    def update(self,dt):
        self.exec_updates = self.app_instance.update_progress[0]
        self.total_updates = self.app_instance.update_progress[1]
        current_percent = float(self.exec_updates)/float(self.total_updates)
        next_percent = float(self.exec_updates + 1)/float(self.total_updates)

        within_range = current_percent <= self.value_progress < next_percent
        if within_range and int(current_percent) is not 1:
            self.value_progress += 0.005
        elif current_percent > self.value_progress:
            self.value_progress = current_percent
        else:
            pass
        Logger.info('displayed: {}'.format(self.value_progress))
