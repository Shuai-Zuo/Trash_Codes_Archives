import math
from ctypes import cdll
cur = cdll.LoadLibrary('./test.so')
def runVerifaction(str):
    return cur.isVerTrue(str.encode("utf-8"))
def addZero(num, dig):
    nDig = int(math.log10(1 if num == 0 else num) + 1)
    pr = dig - nDig
    pr0 = pr * '0'
    return '{}{}'.format(pr0, num)

if __name__ == "__main__":
    #44XXXX20XX(03-12)05114514
    IDnum1 = "44"
    IDnum2 = "20"
    IDnum3 = "05114514"
    count = 0
    fr = open("iddistw.txt", mode='r', encoding="utf-8")
    f = open("result.txt", mode='w', encoding="utf-8")
    fo = open("resultOnlynum.txt", mode='w', encoding="utf-8")
    line = fr.readline()
    districtNum = {}
    while line != "":
        list = line.split(" ")
        districtNum[list[0]] = list[1]
        line = fr.readline()
    for i in range(0,10000):
        IDnum4 = addZero(i, 4)
        distnum = IDnum1 + IDnum4
        dist = districtNum.get(distnum)
        count = 0
        reslist = []
        if dist == None:
            continue
        else:
            pass
        for j in range(3,13):
            IDnum = IDnum1 + IDnum4 + IDnum2 + addZero(j, 2) + IDnum3
            if runVerifaction(IDnum):
                count += 1
                reslist.append(IDnum)
        if count != 0:
            f.write(f"{distnum} {dist} 共{count}个\n")
        for res in reslist:
            fo.write(res + "\n")
            f.write(res + "\n")
    fo.close()
    f.close()
    fr.close()
