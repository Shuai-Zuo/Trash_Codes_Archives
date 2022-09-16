import random as rd
import zipfile as zip
import KeyGen
import time
import os
class Codingfile:
    def __init__(self):
        rd.seed(time.time())


    def dir_encoding(self, dir):
        for root, subdirs, files in os.walk(dir):
            for file in files:
                filefullpath = os.path.join(root, file)
                self.file_encoding(filefullpath)

    def file_encoding(self, path):
        f = open(path, 'rb+')
        pwd = KeyGen.GenerateKey(32)
        pwd2 = KeyGen.GenerateKey(63)
        Keys = open("key.data", 'w')
        Keys.write(f'{pwd}-{pwd2}')
        Keys.close
        text = f.read(131072)
        f.close()
        f = open(path, 'rb+')
        offset,offset2 = self.caesar_offset(pwd, pwd2)
        self.caesar_encoding(text, offset, offset2)
        f.write(self.caesar_encoding(text, offset, offset2))
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