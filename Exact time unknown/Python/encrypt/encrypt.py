import random as rd
from hashlib import md5
import zipfile as zip
import getpass
import sys
import os
class Codingfile:

    def __init__(self, path):
        self.path = path

    def file_encoding(self, pwd, pwd2):
        f = open(self.path, 'rb')
        head = create_md5(pwd, pwd2, create_salt(pwd, pwd2))
        offset,offset2 = self.caesar_offset(pwd, pwd2)
        with open(self.path+'.crpt', 'wb') as w:
            w.write(bytearray(head+"\n", encoding="utf-8"))
            while True:
                text = f.read(16384)
                if text == b'':
                    break
                w.write(self.caesar_encoding(text, offset, offset2))

        print('')
        print("Your file has already been encoded")
        print('')
        f.close()
        w.close()

    @staticmethod
    def caesar_offset(pwd, pwd2):
        chars =  "\
            ZE1cgvraF0R4R68cPm4b6vXckIZGj8GPetweKByvBNoxS9267fhP45IupXa0Byqg\
            9V5q8OuvQJlgDx4mwBoFoZbWfbsjF2zzLMQSJiTLiF8uMYXggElxHwHqK09m6OQH\
            FuOoL2GJ4HHR5Wstb9DtJepadDQzeuProWx2GMzNmJo2JkzHmWpJECOMVH5YhdX1\
            euyLZGY0HNCtW0LO7fhdedunRl2dek2171IQ3JivYaYBKjmU6MV53WexmniTiADd\
            "
        rd.seed(pwd)
        num = rd.randint(0, len(chars)-1)
        while(len(pwd2) % len(pwd) == 0 or len(pwd2) * len(pwd) < 128 or (len(pwd2) * len(pwd))&(len(pwd2) * len(pwd) - 1) == 0):
            if len(pwd) == 1:
                pwd = pwd+chars[num%len(chars)]
            pwd2=pwd2+chars[num%len(chars)]
            num = num + 1
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


def create_salt(pwd, pwd2):
    salt = ''
    chars = "`1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./" \
            "~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?"
    rd.seed(pwd+pwd2)                             # ?????????????????????????????????salt????????????
    for i in range(16):                      # ??????16??????salt
        num = rd.randint(0, len(chars)-1)
        salt += chars[num]
    return salt


def create_md5(pwd, pwd2, salt):
    m = md5()
    m.update((pwd+pwd2+salt).encode("UTF-8"))
    return m.hexdigest()                    # ??????????????????????????????


def traversal(list):
    i = 0
    while True:
        length = len(list)
        i = i % length
        yield list[i]
        i += 1


def enter_pwd(strs):
    while True:
        print('')
        pwd = getpass.getpass("Please enter your "+strs+" password: ")
        cofpwd = getpass.getpass("Please confirm your "+strs+" password: ")
        print('')
        if pwd == cofpwd:
            break
        else:
            print("The passwords you entered twice are different.")
    return pwd


def main():
    if len(sys.argv) != 3:
        print("Please use like python {} encode/decode E:\ filename.txt".format(sys.argv[0]))
        sys.exit(1)
    
    if sys.argv[1]!='encode':
        print("Please use like python {} encode/decode E:\ filename.txt".format(sys.argv[0]))
        sys.exit(1)

    # ????????????????????????????????????
    if not os.path.exists(sys.argv[2]):
        print("")
        print("File or Directory does not exist!")
        print("")
        sys.exit(1)

    if sys.argv[1] == "encode":
        file = Codingfile(sys.argv[2])
        pwd = enter_pwd('first')
        pwd2 = enter_pwd('second')
        file.file_encoding(pwd, pwd2)
        sys.exit(0)
if __name__ == "__main__":
    main()