import sys
from UIcode.UIWindow.mainWindow import Ui_MainWindow
from PyQt5.QtWidgets import QApplication, QMainWindow, QDesktopWidget, QFileDialog
from PyQt5 import QtCore, QtGui, QtWidgets
import numpy as np
# from utils import MayaviQWidget, load_nii
from utils import MayaviQWidget, load_bmp


class MainWindow(QMainWindow, Ui_MainWindow):

    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setupUi(self)

        # mayavi 窗口
        spacing = [1, 1, 1]
        self.mayavi_widget = MayaviQWidget(None, spacing)
        self.verticalLayout.addWidget(self.mayavi_widget)

        # 连接槽函数和信号
        self.pushButton.clicked.connect(self.import_data)
        self.comboBox.currentIndexChanged.connect(self.selectionchange)
        self.verticalScrollBar.sliderMoved.connect(self.sliderval)
        self.mayavi_widget.singal_index.connect(self.set_text)

    def selectionchange(self):
        which = self.comboBox.currentText()
        if which == 'X':
            self.mayavi_widget.visualer.update_axis('x_axes')
        if which == 'Y':
            self.mayavi_widget.visualer.update_axis('y_axes')
        if which == 'Z':
            self.mayavi_widget.visualer.update_axis('z_axes')

    def sliderval(self):
        value = self.verticalScrollBar.value()
        self.mayavi_widget.visualer.set_opacity(value)

    def set_text(self, val):
        # print(val)
        self.textBrowser.setText(str(val))
        # print('setting text value.')

    def import_data(self):
        get_filename_dir = QFileDialog.getExistingDirectory(self,
                                                            "打开目录",
                                                            "../data"
                                                            )
        data, spacing = load_bmp(get_filename_dir)
        self.mayavi_widget.update_data(data, spacing)


if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    my_MainWindow = MainWindow()
    my_MainWindow.show()

    my_MainWindow.move(int((QApplication.desktop().width()-my_MainWindow.width())/2),
                        int((QApplication.desktop().height()-my_MainWindow.height())/2-20))

    sys.exit(app.exec_())