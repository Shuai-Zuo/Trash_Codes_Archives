#coding = utf-8
import requests
import re
import time
def get_flim_images(url,title,type):
    img_binary = requests.get(url)
    img = img_binary.content
    with open( './img/'+title+'.'+type,'wb' ) as f:
        f.write(img)
    #print(span)
    #pattern = re.compile(r'')
if __name__=='__main__':
    #get_flim_images('https://movie.douban.com/subject/2131459/')
    #title_file=open( './namelist.txt','r',encoding="utf-8")
    id_file=open( './idlist.txt','r',encoding="utf-8")
    image_file=open( './imglist.txt','r',encoding="utf-8")
    #titles=title_file.read().split()
    ids=id_file.read().split()
    images=image_file.read().split()
    i=0
    for img in images:
        #get_flims(url)
        if(img.find(".jpg", len(img)-6)!=-1):
            typ="jpg"
        elif(img.find(".png", len(img)-6)!=-1):
            typ="png"
        else:
            typ="webp"
        #get_flim_images(img,titles[i],typ)
        get_flim_images(img,ids[i],typ)
        print(str(i+1)+' picture(s) crawl completed')
        #if i==12:
            #break
        i=i+1
        time.sleep(2)
    #film.close()
        #get_flims(urls[0])
    #url='https://python123.io/ws/demo.html'
    #url='https://movie.douban.com/subject/34914949'
    #url='https://movie.douban.com/subject/33440244'
    #header='https://movie.douban.com/subject/'
    #i=0
    #succeeded=0
    '''while(succeeded<1000):
        i=i+1
        succeeded=succeeded+get_flims(header+str(i))
        print(str(i)+" succeeded:"+str(succeeded))
        print(url+str(i))
    '''
    