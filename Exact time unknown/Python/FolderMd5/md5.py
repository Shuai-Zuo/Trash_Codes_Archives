from hashlib import md5
import time
import os
 
def calMD5(str):
    m = md5()
    m.update(str)
     
    return m.hexdigest()
 
def calMD5ForFile(file):
    statinfo = os.stat(file)
     
    if int(statinfo.st_size)/(1024*1024) >= 1000 :
        return calMD5ForBigFile(file)
    m = md5()
    f = open(file, 'rb')
    m.update(f.read())
    f.close()
     
    return m.hexdigest()
 
def calMD5ForFolder(dir,MD5File):
    outfile = open(MD5File,'w',encoding="utf-8")
    for root, subdirs, files in os.walk(dir):
        for file in files:
            filefullpath = os.path.join(root, file)
            """print filefullpath"""
             
            filerelpath = os.path.relpath(filefullpath, dir)
            md5 = calMD5ForFile(filefullpath)
            outfile.write(dir+"\\"+filerelpath+':'+md5+"\n")
            print(dir+"\\"+filerelpath+" Completed!")
    outfile.close()
 
def calMD5ForBigFile(file):
    m = md5()
    f = open(file, 'rb')
    buffer = 8192    # why is 8192 | 8192 is fast than 2048
     
    while 1:
        chunk = f.read(buffer)
        if not chunk : break
        m.update(chunk)
         
    f.close()
    return m.hexdigest()
     
     
 
 
if __name__ == "__main__":
    #print calMD5("Hello World!")
     
    t = time.time()
    #print(calMD5ForFile("H:\\[WMSUB][Detective_Conan][Movie_24_The Scarlet Bulle][BDRip][GB][1920X1080].mp4"))
    calMD5ForFolder("E:\\World of Warcraft","World_of_Warcraft.mdl")