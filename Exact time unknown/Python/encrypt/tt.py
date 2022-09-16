import random as rd
from hashlib import md5
import zipfile as zip
import getpass
import sys
import os
a,b =[3,4]


f = open("a.txt", 'rb')
text = f.read(2)
print(text)
while text!= b"":
    text = f.read(2)
print(text)