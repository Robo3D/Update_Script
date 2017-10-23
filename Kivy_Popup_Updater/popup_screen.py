from kivy.properties import NumericProperty, ObjectProperty, StringProperty,  BooleanProperty
from kivy.clock import Clock
from kivy.uix.modalview import ModalView
from kivy.app import App


class Updating_Popup(ModalView):
    total_updates = NumericProperty(0)
    exec_updates = NumericProperty(0)
    def __init__(self,**kwargs):
        super(Updating_Popup,self).__init__(**kwargs)
        self.app_instance = App.get_running_app()
        self.open()
        Clock.schedule_interval(self.update, 0.5)

    def update(self,dt):
        self.exec_updates = self.app_instance.update_progress[0]
        self.total_updates = self.app_instance.update_progress[1]
