import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt5 import QtCore
class MyQLabel(QtWidgets.QLabel):
    button_clicked_signal = QtCore.pyqtSignal()
    def __init__(self, parent=None):
        super(MyQLabel, self).__init__(parent)
        self.node=None
    def mouseReleaseEvent(self, QMouseEvent):
        self.button_clicked_signal.emit()
    def connect_customized_slot(self, func):
        self.button_clicked_signal.connect(func)


