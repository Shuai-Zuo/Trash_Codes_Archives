import random
import time

def onetrial():
    count = 0
    for i in range(0,7):
        if random.randint(0,1) == 0:
            if random.randint(0,4) == 0:
                return 1
            else: 
                count += 1
    if count > 2:
        return 1
    else:
        return 0

if __name__ == "__main__":
    random.seed(time.time())
    times = input("please input trial times:")
    tot = 0
    for i in range(0,int(times)):
        tot += onetrial()
    print(str(tot*100/float(times)) + '%')