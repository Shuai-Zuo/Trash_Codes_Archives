import time
import os
import KeyGen
import random
import sys
import datetime
def list_dir(start_dir, dirlist):
    dir_res = os.listdir(start_dir)
    for path in dir_res:
        temp_path = os.path.join(start_dir, path)
        if os.path.isdir(temp_path):
            dirlist.append(temp_path)
            list_dir(temp_path, dirlist)
    return dirlist

def nameConfFolder(dir):
    #log = open("logs.txt","a")#log
    outfile = open("FilenameList",'w',encoding="utf-8")
    random.seed(time.time())
    dirlist = []
    list_dir(dir, dirlist)
    dirlist.reverse()
    for subdir in dirlist:
        dirsrc = os.path.dirname(subdir)
        dirfullpath = subdir
        dirnewpath = os.path.join(dirsrc, KeyGen.GenerateKey(64))
        dirrelpath = os.path.relpath(dirfullpath, dir)
        dirnewrelpath = os.path.relpath(dirnewpath, dir)
        outfile.write(f"{dirrelpath}>{dirnewrelpath}\n")
        os.rename(dirfullpath,dirnewpath)
    outfile.write(f">>>\n")
    for root, subdirs, files in os.walk(dir):
        for file in files:
            if file == "key.data" or file == "FilenameList" or file == "logs.txt" or file == os.path.basename(sys.argv[0]):
                    continue
            filefullpath = os.path.join(root, file)
            filenewpath = os.path.join(root, KeyGen.GenerateKey(64))
            filerelpath = os.path.relpath(filefullpath, dir)
            filenewrelpath = os.path.relpath(filenewpath, dir)
            outfile.write(f"{filerelpath}>{filenewrelpath}\n")
            os.rename(filefullpath,filenewpath)
            #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] rename Conf {filerelpath} To {filenewrelpath}\n")#log
    outfile.close()
    #log.close()#log

def nameUnconfFolder(dir):
    #log = open("logs.txt","a")#log
    file = open("FilenameList",'r',encoding="utf-8")
    dirlist = []
    while True:
        dirlog = file.readline()
        if dirlog == ">>>\n":
            break
        dirlist.append(dirlog.split(">"))
    dirlist.reverse()
    filedic = {}
    while True:
        dirlog = file.readline()
        if dirlog == "":
            break
        logparse = dirlog.split(">")
        filedic[os.path.basename(logparse[1][0:-1])]=os.path.basename(logparse[0])
    for root, subdirs, files in os.walk(dir):
        for fil in files:
            if file == "key.data" or file == "FilenameList" or file == "logs.txt" or file == os.path.basename(sys.argv[0]):
                    continue
            filefullpath = os.path.join(root, fil)
            src = filedic.get(fil)
            if src == None:
                continue                
            filenewpath = os.path.join(root, src)
            os.rename(filefullpath,filenewpath)
            #log.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')}] rename unConf {filefullpath} To {filenewpath}\n")#log


    for subdir in dirlist:   
        dirfullpath = os.path.join(dir, subdir[1][0:-1])
        dirsrcpath = os.path.join(dir, subdir[0])
        if os.path.exists(dirfullpath):
            os.rename(dirfullpath,dirsrcpath)
    #log.close()#log
    file.close()
 
     

 
if __name__ == "__main__":
    pass
    #print calMD5("Hello World!")
    #print(calMD5ForFile("H:\\[WMSUB][Detective_Conan][Movie_24_The Scarlet Bulle][BDRip][GB][1920X1080].mp4"))
    #nameConfFolder("D:\\Python\\renamer")
    #nameUnconfFolder("D:\\Python\\renamer")