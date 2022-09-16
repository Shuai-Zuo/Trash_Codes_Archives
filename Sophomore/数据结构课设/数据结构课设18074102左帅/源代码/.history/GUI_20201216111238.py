import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt5 import QtCore
from Ui_GUI import *
from Ui_review import *
from search import Search
import webbrowser

class MyQLabel(QtWidgets.QLabel):
    button_clicked_signal = QtCore.pyqtSignal()
    def __init__(self, parent=None):
        super(MyQLabel, self).__init__(parent)
        self.node=None
    def mouseReleaseEvent(self, QMouseEvent):
        self.button_clicked_signal.emit()
    def connect_customized_slot(self, func):
        self.button_clicked_signal.connect(func)



class Review(QtWidgets.QMainWindow, Ui_review):
    def __init__(self, parent=None):
        super(Review, self).__init__(parent)
        self.setupUi(self)

    def ConfirmClicked(self):
        pass

    def CancelClicked(self):
        self.closeEvent(QCloseEvent)



class MyWindow(QMainWindow, Ui_FSS):

    def __init__(self, parent=None):
        super(MyWindow, self).__init__(parent)
        self.s=Search()
        self.setFocusPolicy(QtCore.Qt.StrongFocus)
        self.rev=Review()
        self.setFocus()
#        self.SearchButton.clicked.connect(self.SearchButtonClicked)
        self.setupUi(self)
        self.lastimg=None
        self.allhead=None
        self.init_pages()
        self.sym=1
        self.current_url=''

    def eventFilter(self, obj, event):
        #if obj == self.SearchText:
        if event.type() == QtCore.QEvent.KeyPress and event.key() == QtCore.Qt.Key_Enter:
            self.SearchButtonClicked()
            return True
        return QtCore.QObject.eventFilter(self, obj, event)

    def SearchButtonClicked(self):
        strs=self.s.search(self.SearchText.text())
        if strs=='No Such Film!':
            self.imformation.setText(strs)
            QMessageBox.question(self, '错误',"未找到符合条件的电影",QMessageBox.Ok)
            return
        #self.imformation.setText(strs)
        self.allhead=strs.head
        self.lastimg=strs.head
        pointer=self.lastimg
        self.sym=4
        self.img1.node=pointer
        if pointer is not None:
            self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=pointer.next
        else:
            self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img2.node=pointer
        if pointer is not None:
            self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=pointer.next
        else:
            self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img3.node=pointer
        if pointer is not None:
            self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=pointer.next
        else:
            self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img4.node=pointer
        if pointer is not None:
            self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=pointer.next
        else:
            self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img5.node=pointer
        if pointer is not None:
            self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=pointer.next
        else:
            self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img6.node=pointer
        if pointer is not None:
            self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=pointer.next
        else:
            self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img7.node=pointer
        if pointer is not None:
            self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=pointer.next
        else:
            self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
        if pointer is not None:
            self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
        else:
            self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img8.node=pointer
        if pointer is not None:
            self.lastimg=pointer.next

    def DeleteButtonClicked(self):
        if self.s.avl.contains(self.SearchText.text()):
            reply=QMessageBox.question(self, '提示',"您确定要删除吗?", QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            if reply==QMessageBox.Yes:
                self.s.delete(self.SearchText.text())
                QMessageBox.question(self, '成功',"已删除",QMessageBox.Ok)
        else:
            self.imformation.setText('No Such Film!')
            QMessageBox.question(self, '错误',"未找到符合条件的电影",QMessageBox.Ok)
            return
    def init_pages(self):
        pointer=self.s.rating_sort.head.filmlist.head
        self.allhead=pointer
        self.img1.node=pointer
        if pointer is not None:
            self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img2.node=pointer
        if pointer is not None:
            self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img3.node=pointer
        if pointer is not None:
            self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img4.node=pointer
        if pointer is not None:
            self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img5.node=pointer
        if pointer is not None:
            self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img6.node=pointer
        if pointer is not None:
            self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img7.node=pointer
        if pointer is not None:
            self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
        if pointer is not None:
            self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
        else:
            self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img8.node=pointer
        if pointer is not None:
            self.lastimg=self.s.rating_sort.gnext(pointer)


    def NextPageClicked(self):
        pointer=self.lastimg
        self.img1.node=pointer
        if self.sym == 1:
            if pointer is not None:
                self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.rating_sort.gnext(pointer)
            else:
                self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img2.node=pointer
            if pointer is not None:
                self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.rating_sort.gnext(pointer)
            else:
                self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img3.node=pointer
            if pointer is not None:
                self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.rating_sort.gnext(pointer)
            else:
                self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img4.node=pointer
            if pointer is not None:
                self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.rating_sort.gnext(pointer)
            else:
                self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img5.node=pointer
            if pointer is not None:
                self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.rating_sort.gnext(pointer)
            else:
                self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img6.node=pointer
            if pointer is not None:
                self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.rating_sort.gnext(pointer)
            else:
                self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img7.node=pointer
            if pointer is not None:
                self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.rating_sort.gnext(pointer)
            else:
                self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
            if pointer is not None:
                self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
            else:
                self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img8.node=pointer
            if pointer is not None:
                self.lastimg=self.s.rating_sort.gnext(pointer)
        elif self.sym==2:
            if pointer is not None:
                self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.clicks_sort.gnext(pointer)
            else:
                self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img2.node=pointer
            if pointer is not None:
                self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.clicks_sort.gnext(pointer)
            else:
                self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img3.node=pointer
            if pointer is not None:
                self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.clicks_sort.gnext(pointer)
            else:
                self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img4.node=pointer
            if pointer is not None:
                self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.clicks_sort.gnext(pointer)
            else:
                self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img5.node=pointer
            if pointer is not None:
                self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.clicks_sort.gnext(pointer)
            else:
                self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img6.node=pointer
            if pointer is not None:
                self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.clicks_sort.gnext(pointer)
            else:
                self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img7.node=pointer
            if pointer is not None:
                self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=self.s.clicks_sort.gnext(pointer)
            else:
                self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
            if pointer is not None:
                self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
            else:
                self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img8.node=pointer
            if pointer is not None:
                self.lastimg=self.s.clicks_sort.gnext(pointer)
        elif self.sym == 4:
            if pointer is not None:
                self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=pointer.next
            else:
                self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img2.node=pointer
            if pointer is not None:
                self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=pointer.next
            else:
                self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img3.node=pointer
            if pointer is not None:
                self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=pointer.next
            else:
                self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img4.node=pointer
            if pointer is not None:
                self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=pointer.next
            else:
                self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img5.node=pointer
            if pointer is not None:
                self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=pointer.next
            else:
                self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img6.node=pointer
            if pointer is not None:
                self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=pointer.next
            else:
                self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img7.node=pointer
            if pointer is not None:
                self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
                pointer=pointer.next
            else:
                self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
            if pointer is not None:
                self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
            else:
                self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
            self.img8.node=pointer
            if pointer is not None:
                self.lastimg=pointer.next


    def Show_film(self):
        send = self.sender()
        if send.node is not None:
            _translate = QtCore.QCoreApplication.translate
            self.current_url=send.node.film.url
            self.imformation.setHtml('电影名称:'+send.node.film.name+'<br />'+\
                '导演:'+send.node.film.director+'<br />'+\
                '演员:'+' '.join(send.node.film.actors)+'<br />'+\
                '类型:'+' '.join(send.node.film.types)+'<br />'+\
                '上映日期: '+send.node.film.time+'<br />'+\
                '语言:'+' '.join(send.node.film.language)+'<br />'+\
                '区域:'+' '.join(send.node.film.region)+'<br />'+\
                '评分:'+send.node.film.rating+'<br />'+\
                '剧情梗概:'+send.node.film.plot+'<br />'+\
                '<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><a href=\"'+\
                send.node.film.url+\
                '\"><span style=\" text-decoration: underline; color:#0000ff;\">'+\
                send.node.film.url+'</span></a></p>')
        else:
            #self.imformation.setText('error')
            pass

    def FrontPageClicked(self):
        pointer=self.allhead
        if pointer!=self.lastimg:
            tmp1=pointer
            tmp=pointer
            while pointer is not None:
                tmp1=tmp
                tmp=pointer
                if self.sym == 1:
                    if pointer is not None:
                        pointer=self.s.rating_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.rating_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.rating_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.rating_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.rating_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.rating_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.rating_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.rating_sort.gnext(pointer)
                    if pointer == self.lastimg:
                        pointer=tmp1
                        if pointer == None:
                            pointer=tmp
                        if self.img1.node == self.lastimg:
                            pointer=tmp
                        self.img1.node=pointer
                        if pointer is not None:
                            self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.rating_sort.gnext(pointer)
                        else:
                            self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img2.node=pointer
                        if pointer is not None:
                            self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.rating_sort.gnext(pointer)
                        else:
                            self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img3.node=pointer
                        if pointer is not None:
                            self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.rating_sort.gnext(pointer)
                        else:
                            self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img4.node=pointer
                        if pointer is not None:
                            self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.rating_sort.gnext(pointer)
                        else:
                            self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img5.node=pointer
                        if pointer is not None:
                            self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.rating_sort.gnext(pointer)
                        else:
                            self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img6.node=pointer
                        if pointer is not None:
                            self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.rating_sort.gnext(pointer)
                        else:
                            self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img7.node=pointer
                        if pointer is not None:
                            self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.rating_sort.gnext(pointer)
                        else:
                            self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        if pointer is not None:
                            self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
                        else:
                            self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img8.node=pointer
                        if pointer is not None:
                            self.lastimg=self.s.rating_sort.gnext(pointer)
                        break
                elif self.sym == 2:
                    if pointer is not None:
                        pointer=self.s.clicks_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.clicks_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.clicks_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.clicks_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.clicks_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.clicks_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.clicks_sort.gnext(pointer)
                    if pointer is not None:
                        pointer=self.s.clicks_sort.gnext(pointer)
                    if pointer == self.lastimg:
                        pointer=tmp1
                        if pointer == None:
                            pointer=tmp
                        if self.img1.node == self.lastimg:
                            pointer=tmp
                        self.img1.node=pointer
                        if pointer is not None:
                            self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.clicks_sort.gnext(pointer)
                        else:
                            self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img2.node=pointer
                        if pointer is not None:
                            self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.clicks_sort.gnext(pointer)
                        else:
                            self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img3.node=pointer
                        if pointer is not None:
                            self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.clicks_sort.gnext(pointer)
                        else:
                            self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img4.node=pointer
                        if pointer is not None:
                            self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.clicks_sort.gnext(pointer)
                        else:
                            self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img5.node=pointer
                        if pointer is not None:
                            self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.clicks_sort.gnext(pointer)
                        else:
                            self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img6.node=pointer
                        if pointer is not None:
                            self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.clicks_sort.gnext(pointer)
                        else:
                            self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img7.node=pointer
                        if pointer is not None:
                            self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=self.s.clicks_sort.gnext(pointer)
                        else:
                            self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        if pointer is not None:
                            self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
                        else:
                            self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img8.node=pointer
                        if pointer is not None:
                            self.lastimg=self.s.clicks_sort.gnext(pointer)
                        break
                elif self.sym == 4:
                    if pointer is not None:
                        pointer=pointer.next
                    if pointer is not None:
                        pointer=pointer.next
                    if pointer is not None:
                        pointer=pointer.next
                    if pointer is not None:
                        pointer=pointer.next
                    if pointer is not None:
                        pointer=pointer.next
                    if pointer is not None:
                        pointer=pointer.next
                    if pointer is not None:
                        pointer=pointer.next
                    if pointer is not None:
                        pointer=pointer.next
                    if pointer == self.lastimg:
                        pointer=tmp1
                        if pointer == None:
                            pointer=tmp
                        if self.img1.node == self.lastimg:
                            pointer=tmp
                        self.img1.node=pointer
                        if pointer is not None:
                            self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=pointer.next
                        else:
                            self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img2.node=pointer
                        if pointer is not None:
                            self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=pointer.next
                        else:
                            self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img3.node=pointer
                        if pointer is not None:
                            self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=pointer.next
                        else:
                            self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img4.node=pointer
                        if pointer is not None:
                            self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=pointer.next
                        else:
                            self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img5.node=pointer
                        if pointer is not None:
                            self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=pointer.next
                        else:
                            self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img6.node=pointer
                        if pointer is not None:
                            self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=pointer.next
                        else:
                            self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img7.node=pointer
                        if pointer is not None:
                            self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
                            pointer=pointer.next
                        else:
                            self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        if pointer is not None:
                            self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
                        else:
                            self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
                        self.img8.node=pointer
                        if pointer is not None:
                            self.lastimg=pointer.next
                        break

    def DirectorButtonClicked(self):
        strs=self.s.search('directors')
        self.imformation.setText(strs)
    def ActorButtonClicked(self):
        strs=self.s.search('actors')
        self.imformation.setText(strs)
    def ListButtonClicked(self):
        strs=self.s.search('list')
        self.imformation.setText(strs)
    def TypesButtonClicked(self):
        strs=self.s.search('types')
        self.imformation.setText(strs)
    def RatingButtonClicked(self):
        pointer=self.s.rating_sort.head.filmlist.head
        self.allhead=pointer
        self.img1.node=pointer
        self.sym=1
        if pointer is not None:
            self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img2.node=pointer
        if pointer is not None:
            self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img3.node=pointer
        if pointer is not None:
            self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img4.node=pointer
        if pointer is not None:
            self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img5.node=pointer
        if pointer is not None:
            self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img6.node=pointer
        if pointer is not None:
            self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img7.node=pointer
        if pointer is not None:
            self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.rating_sort.gnext(pointer)
        else:
            self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
        if pointer is not None:
            self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
        else:
            self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img8.node=pointer
        if pointer is not None:
            self.lastimg=self.s.rating_sort.gnext(pointer)
    def HeatButtonClicked(self):
        pointer=self.s.clicks_sort.head.filmlist.head
        self.allhead=pointer
        self.img1.node=pointer
        self.sym=2
        if pointer is not None:
            self.img1.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.clicks_sort.gnext(pointer)
        else:
            self.img1.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img2.node=pointer
        if pointer is not None:
            self.img2.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.clicks_sort.gnext(pointer)
        else:
            self.img2.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img3.node=pointer
        if pointer is not None:
            self.img3.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.clicks_sort.gnext(pointer)
        else:
            self.img3.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img4.node=pointer
        if pointer is not None:
            self.img4.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.clicks_sort.gnext(pointer)
        else:
            self.img4.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img5.node=pointer
        if pointer is not None:
            self.img5.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.clicks_sort.gnext(pointer)
        else:
            self.img5.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img6.node=pointer
        if pointer is not None:
            self.img6.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.clicks_sort.gnext(pointer)
        else:
            self.img6.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img7.node=pointer
        if pointer is not None:
            self.img7.setPixmap(QtGui.QPixmap(pointer.film.image))
            pointer=self.s.clicks_sort.gnext(pointer)
        else:
            self.img7.setPixmap(QtGui.QPixmap('./img/timg.png'))
        if pointer is not None:
            self.img8.setPixmap(QtGui.QPixmap(pointer.film.image))
        else:
            self.img8.setPixmap(QtGui.QPixmap('./img/timg.png'))
        self.img8.node=pointer
        if pointer is not None:
            self.lastimg=self.s.clicks_sort.gnext(pointer)

    def openlinks(self):
        webbrowser.open(self.current_url)

    def save_file(self):
        self.s.avl.preorder_traversal_save()

    def Show_review(self):
        rev=Review()
        rev.show()

    def closeEvent(self, QCloseEvent):
        choice = QMessageBox.question(self, '提示', '您确定要关闭吗？', QMessageBox.Yes | QMessageBox.No)
        if choice == QMessageBox.Yes:
            self.save_file()
            QCloseEvent.accept()
        elif choice == QMessageBox.No:
            QCloseEvent.ignore()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    myWin = MyWindow()
    myWin.show()
    sys.exit(app.exec_())