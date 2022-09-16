import random
import time

def onetrial():
    count = 1
    while 1:
        if random.randint(0,1) == 0:
            break
        else:
            count += 1
    return count

if __name__ == "__main__":
    random.seed(time.time())
    times = input("please input trial times:")
    tot = 0
    for i in range(0,int(times)):
        tot += onetrial()
    print(str(tot/float(times)))