import random
import time
class dices():
    def __init__(self, number:int = 1):
        self.__num = number
    
    def oneroll(self):
        random.seed(time.time())
        tot = 0
        for i in range(0,self.__num):
            tot += random.randint(1,6)
        return tot

    def rolls(self, times = 1):
        ResultSet =  [0 for x in range(self.__num*6 + 1)]
        for i in range(0,times):
            ResultSet[self.oneroll()] += 1
        ResultSet[0] = times
        return ResultSet

    def changeNumber(self,number:int = 1):
        self.__num = number

            

if __name__ == "__main__":
    threeDices = dices(3)
    rS = threeDices.rolls(10000000)
    i = 0
    for item in rS:
        print(str(i) + ":" + str(item))
        i += 1