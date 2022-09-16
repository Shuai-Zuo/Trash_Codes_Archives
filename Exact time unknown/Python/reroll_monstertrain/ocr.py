from PIL import Image,ImageGrab
import pytesseract
import pyautogui
import time

def mousemove():
    pyautogui.moveTo(1649,31, duration=0.1)
    pyautogui.click()
    pyautogui.moveTo(1045,427, duration=0.1)
    pyautogui.click()
    time.sleep(1.35)

threshold = 210
table = []
for i in range(256):
    if i < threshold:
        table.append(1)
    else:
        table.append(0)

#1170,210
while(1): 
    imgb = ImageGrab.grab()
    img_array = imgb.load()
    rgb = img_array[1170,210]
    #print(rgb)
    if rgb == (191, 94, 185):
        print("Wrong Boss\n")
        mousemove()
        continue
    #imgb.show()
    #textb = pytesseract.image_to_string(imgb, lang='chi_sim')
    #print(textb)
    #if text1[0:4] == '人唱果吸':

    img1 = ImageGrab.grab(bbox=(773,714,905,746))
    img1 = img1.convert('L')
    img1 = img1.point(table,'1')
    #img1.show()
    text1 = pytesseract.image_to_string(img1, lang='chi_sim')
    if text1[0:4] == '人唱果吸':
        print("True")
    else:
        print("Wrong Card1\n")
        mousemove()
        continue
    #'人唱果吸\n'
    img2 = ImageGrab.grab(bbox=(1083,714,1218,746))
    img2 = img2.convert('L')
    img2 = img2.point(table,'1')
    #img2.show()
    text2 = pytesseract.image_to_string(img2, lang='chi_sim')
    if text2[0:3] == "地锌火":
        print("True")
    else:
        print("Wrong Card2\n")
        mousemove()
        continue
    break
    #地锌火
    '''
    if text1[0:4] != '人唱果吸' or text2[0:3] != "地锌火":
        pyautogui.moveTo(1649,31, duration=0.1)
        pyautogui.click()
        pyautogui.moveTo(1045,427, duration=0.1)
        pyautogui.click()
        time.sleep(1.5)
    else:
        break
    '''

#773,714,905,751 1083,714,1218,751
#626,263,686,304
