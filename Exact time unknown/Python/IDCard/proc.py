f = open("iddist.txt", mode='r', encoding="utf-8")
fw = open("iddistw.txt", mode='w', encoding="utf-8")
line = f.readline()
while line != "":
    if line != "\n":
        fw.write(line)
    line = f.readline()
