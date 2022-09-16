# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'g:\fss\GUI.ui'
#
# Created by: PyQt5 UI code generator 5.15.1
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_FSS(object):
    def setupUi(self, FSS):
        FSS.setObjectName("FSS")
        FSS.resize(871, 751)
        self.centralwidget = QtWidgets.QWidget(FSS)
        self.centralwidget.setObjectName("centralwidget")
        self.SearchButton = QtWidgets.QPushButton(self.centralwidget)
        self.SearchButton.setGeometry(QtCore.QRect(560, 10, 75, 23))
        self.SearchButton.setObjectName("SearchButton")
        self.SearchText = QtWidgets.QLineEdit(self.centralwidget)
        self.SearchText.setGeometry(QtCore.QRect(320, 10, 231, 21))
        self.SearchText.setObjectName("SearchText")
        self.imformation = QtWidgets.QTextEdit(self.centralwidget)
        self.imformation.setGeometry(QtCore.QRect(520, 50, 251, 381))
        self.imformation.setReadOnly(True)
        self.imformation.setObjectName("imformation")
        self.DeleteButton = QtWidgets.QPushButton(self.centralwidget)
        self.DeleteButton.setGeometry(QtCore.QRect(640, 10, 75, 23))
        self.DeleteButton.setObjectName("DeleteButton")
        self.List = QtWidgets.QPushButton(self.centralwidget)
        self.List.setGeometry(QtCore.QRect(790, 80, 75, 23))
        self.List.setObjectName("List")
        self.Heat = QtWidgets.QPushButton(self.centralwidget)
        self.Heat.setGeometry(QtCore.QRect(790, 310, 75, 23))
        self.Heat.setObjectName("Heat")
        self.rating = QtWidgets.QPushButton(self.centralwidget)
        self.rating.setGeometry(QtCore.QRect(790, 340, 75, 23))
        self.rating.setObjectName("rating")
        self.img1 = MyQLabel(self.centralwidget)
        self.img1.setGeometry(QtCore.QRect(30, 60, 101, 141))
        self.img1.setText("")
        self.img1.setPixmap(QtGui.QPixmap("g:\\fss\\img/7号房的礼物.webp"))
        self.img1.setScaledContents(True)
        self.img1.setObjectName("img1")
        self.img2 = MyQLabel(self.centralwidget)
        self.img2.setGeometry(QtCore.QRect(140, 60, 101, 141))
        self.img2.setText("")
        self.img2.setPixmap(QtGui.QPixmap("g:\\fss\\img/7号房的礼物.webp"))
        self.img2.setScaledContents(True)
        self.img2.setObjectName("img2")
        self.img3 = MyQLabel(self.centralwidget)
        self.img3.setGeometry(QtCore.QRect(250, 60, 101, 141))
        self.img3.setText("")
        self.img3.setPixmap(QtGui.QPixmap("g:\\fss\\img/7号房的礼物.webp"))
        self.img3.setScaledContents(True)
        self.img3.setObjectName("img3")
        self.img4 = MyQLabel(self.centralwidget)
        self.img4.setGeometry(QtCore.QRect(360, 60, 101, 141))
        self.img4.setText("")
        self.img4.setPixmap(QtGui.QPixmap("g:\\fss\\img/7号房的礼物.webp"))
        self.img4.setScaledContents(True)
        self.img4.setObjectName("img4")
        self.img5 = MyQLabel(self.centralwidget)
        self.img5.setGeometry(QtCore.QRect(30, 240, 101, 141))
        self.img5.setText("")
        self.img5.setPixmap(QtGui.QPixmap("g:\\fss\\img/7号房的礼物.webp"))
        self.img5.setScaledContents(True)
        self.img5.setObjectName("img5")
        self.img6 = MyQLabel(self.centralwidget)
        self.img6.setGeometry(QtCore.QRect(140, 240, 101, 141))
        self.img6.setText("")
        self.img6.setPixmap(QtGui.QPixmap("g:\\fss\\img/7号房的礼物.webp"))
        self.img6.setScaledContents(True)
        self.img6.setObjectName("img6")
        self.img7 = MyQLabel(self.centralwidget)
        self.img7.setGeometry(QtCore.QRect(250, 240, 101, 141))
        self.img7.setText("")
        self.img7.setPixmap(QtGui.QPixmap("g:\\fss\\img/7号房的礼物.webp"))
        self.img7.setScaledContents(True)
        self.img7.setObjectName("img7")
        self.img8 = MyQLabel(self.centralwidget)
        self.img8.setGeometry(QtCore.QRect(360, 240, 101, 141))
        self.img8.setText("")
        self.img8.setPixmap(QtGui.QPixmap("g:\\fss\\img/7号房的礼物.webp"))
        self.img8.setScaledContents(True)
        self.img8.setObjectName("img8")
        self.FrontPage = QtWidgets.QPushButton(self.centralwidget)
        self.FrontPage.setGeometry(QtCore.QRect(130, 410, 75, 23))
        self.FrontPage.setObjectName("FrontPage")
        self.NextPage = QtWidgets.QPushButton(self.centralwidget)
        self.NextPage.setGeometry(QtCore.QRect(260, 410, 75, 23))
        self.NextPage.setObjectName("NextPage")
        self.textBrowser = QtWidgets.QTextBrowser(self.centralwidget)
        self.textBrowser.setGeometry(QtCore.QRect(290, 490, 251, 201))
        self.textBrowser.setObjectName("textBrowser")
        FSS.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(FSS)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 871, 23))
        self.menubar.setObjectName("menubar")
        FSS.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(FSS)
        self.statusbar.setObjectName("statusbar")
        FSS.setStatusBar(self.statusbar)

        self.retranslateUi(FSS)
        self.DeleteButton.clicked.connect(FSS.DeleteButtonClicked)
        self.SearchButton.clicked.connect(FSS.SearchButtonClicked)
        self.List.clicked.connect(FSS.ListButtonClicked)
        self.Heat.clicked.connect(FSS.HeatButtonClicked)
        self.rating.clicked.connect(FSS.RatingButtonClicked)
        self.img1.button_clicked_signal.connect(FSS.Show_film)
        self.FrontPage.clicked.connect(FSS.FrontPageClicked)
        self.NextPage.clicked.connect(FSS.NextPageClicked)
        self.img2.button_clicked_signal.connect(FSS.Show_film)
        self.img3.button_clicked_signal.connect(FSS.Show_film)
        self.img4.button_clicked_signal.connect(FSS.Show_film)
        self.img8.button_clicked_signal.connect(FSS.Show_film)
        self.img7.button_clicked_signal.connect(FSS.Show_film)
        self.img6.button_clicked_signal.connect(FSS.Show_film)
        self.img5.button_clicked_signal.connect(FSS.Show_film)
        QtCore.QMetaObject.connectSlotsByName(FSS)

    def retranslateUi(self, FSS):
        _translate = QtCore.QCoreApplication.translate
        FSS.setWindowTitle(_translate("FSS", "电影查询系统"))
        self.SearchButton.setText(_translate("FSS", "搜索"))
        self.DeleteButton.setText(_translate("FSS", "删除"))
        self.List.setText(_translate("FSS", "列表"))
        self.Heat.setText(_translate("FSS", "热度"))
        self.rating.setText(_translate("FSS", "评分"))
        self.FrontPage.setText(_translate("FSS", "上一页"))
        self.NextPage.setText(_translate("FSS", "下一页"))
        self.textBrowser.setHtml(_translate("FSS", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'SimSun\'; font-size:9pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">aa<a href=\"https://movie.douban.com/subject/1295124/\"><span style=\" text-decoration: underline; color:#0000ff;\">aa</span></a></p></body></html>"))
from MyQLabel import MyQLabel
