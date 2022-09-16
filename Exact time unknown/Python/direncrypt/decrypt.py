#coding=utf-8
import random as rd
import os
import time
import sys
import datetime
class Codingfile:
    def __init__(self):
        Keyr = open("key.data", 'r')
        #log = open("logs.txt","a")#log
        pwds = Keyr.read().split("-")
        self.pwd = pwds[0]
        self.pwd2 = pwds[1]
        #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] PWD Readed\n")#log
        self.offset,self.offset2 = self.caesar_offset(self.pwd, self.pwd2)
        #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] Offset Created\n")#log
        Keyr.close()
        #log.close()#log


    def dir_decoding(self, dir):
        #log = open("logs.txt","a")#log
        for root, subdirs, files in os.walk(dir):
            for file in files:
                if file == "key.data" or file == "FilenameList" or file == "logs.txt" or file == os.path.basename(sys.argv[0]):
                    continue
                filefullpath = os.path.join(root, file)
                self.file_decoding(filefullpath)
                #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] {file} decoded\n")#log
        #log.close()#log

    def file_decoding(self, path):
        offset, offset2 = self.caesar_offset(self.pwd, self.pwd2)
        f = open(path, 'rb+')
        text = f.read(262144)
        f.close()
        f = open(path, 'rb+')
        f.write(self.caesar_decoding(text, offset, offset2))
        f.close()

    def file_full_decoding(self, path):
        offset,offset2 = self.caesar_offset(self.pwd, self.pwd2)
        #log = open("logs.txt","a")#log
        f = open(path, 'rb+')
        text = f.read()
        f.close()
        f = open(path, 'rb+')
        f.write(self.caesar_decoding(text, offset, offset2))
        f.close()
        #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] {path} Full decoded\n")#log
        #log.close()#log
    def file_full_decoding_new_file(self, path):
        offset,offset2 = self.caesar_offset(self.pwd, self.pwd2)
        #log = open("logs.txt","a")#log
        f = open(path, 'rb+')
        text = f.read()
        f.close()       
        f = open(os.path.join(os.path.dirname(path),"FilenameListDecoded"), 'wb')
        f.write(self.caesar_decoding(text, offset, offset2))
        f.close()


    @staticmethod
    def caesar_offset(pwd, pwd2):
        pwd = bytes(pwd, encoding="utf-8")
        pwd2 = bytes(pwd2, encoding="utf-8")
        offset = []
        offset2 = []

        for i in range(len(pwd)):
            offset.append(pwd[i])
        offset = traversal(offset)

        for i in range(len(pwd2)):
            offset2.append(pwd2[i])
        offset2 = traversal(offset2)
        return [offset, offset2]

    @staticmethod
    def caesar_decoding(text, offset, offset2):     
        text = bytearray(text)   
        for i in range(len(text)):
            byte = text[i] - next(offset) - next(offset2)
            if byte < 0:
                text[i] = byte + 256
                if text[i] < 0:
                    text[i] = text[i] + 256
            else:
                text[i] = byte
        return text



def traversal(list):
    i = 0
    while True:
        length = len(list)
        i = i % length
        yield list[i]
        i += 1


if __name__ == "__main__":
    file = Codingfile()
    #file.dir_decoding("D:\\Python\\renamer")
    file.file_full_decoding("encryptbkp1.py")