#coding = utf-8
import requests
import re
import time
import random
from urllib.parse import urlencode
from bs4 import BeautifulSoup
def getURL(url):
    try:
        kv={'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36'}
        r=requests.get(url,headers=kv,timeout=30)
        r.raise_for_status()
        r.encoding='utf-8'#r.apparent_encoding
        return r.text
    except:
        return 'Exception Occured'

def prettify(text):
    soup = BeautifulSoup(text, 'html.parser')
    return soup.prettify()

def get_flims(url):
    if getURL(url)!='Exception Occured':
        soup=BeautifulSoup(getURL(url), 'html.parser')
        #print(soup.find_all('div',id="info"))
        directories=soup.find('div',id="info").find('a',rel="v:directedBy")
        actors=soup.find('div',id="info").find_all('a',rel="v:starring")
        types=soup.find('div',id="info").find_all('span',property="v:genre")
        rating=soup.find('div',attrs={"class" :"rating_self clearfix","typeof":"v:Rating"}).find('strong')
        intros=soup.find('div',attrs={"class" :"related-info"}).find('span',property="v:summary")
        countries_or_regions=soup.find('span',text=re.compile(r'制片.*')).next_sibling
        languages=soup.find('span',text=re.compile(r'语言.*')).next_sibling
        release_date=soup.find('span',property="v:initialReleaseDate")
        #print(directories)
        #print(actors)
        #print(types)
        #print(rating)
        #print(intros)
        #语句处理
        #directories_group=re.match(r'>.*<',str(directories)).group()
        title=soup.title.contents[0]
        title=title.replace("(豆瓣)",'')
        title=title.replace(" ",'')
        title=title.replace('\n','')
        title=title.replace('\u3000','')
        directors_str=directories.contents[0]
        actors_str=[]
        types_str=[]
        rating_str=rating.contents[0]
        intro_str=intros.contents[0]
        intro_str=intro_str.replace(' ','')
        intro_str=intro_str.replace('\n','')
        intro_str=intro_str.replace('\u3000','')
        languages_str=languages.replace(' ','')
        countries_or_regions_str=countries_or_regions.replace(' ','')
        release_date_raw=release_date.contents[0]
        release_date_str=re.sub(re.compile(r'\(.*?\)'),"",release_date_raw)
        #print(directors_str)
        for actor in actors:
            if re.search(r'[^a-z A-Z]+',actor.contents[0])!=None:
                actors_str.append(re.search(r'[^a-z A-Z]+',actor.contents[0]).group())
        #print(actors_str)
        for typ in types:
            types_str.append(typ.contents[0])
        film.write(title)
        film.write('#')
        film.write(directors_str)
        film.write('#')
        i=0
        for actor in actors_str:
            i=i+1
            film.write(actor)
            if(i<len(actors_str)):
                film.write('/')
        i=0
        film.write('#')
        for typ in types_str:
            i=i+1
            film.write(typ)
            if(i<len(types_str)):
                film.write('/')
        film.write('#')
        film.write(rating_str)
        film.write('#')
        film.write(countries_or_regions_str)
        film.write('#')
        film.write(languages_str)
        film.write('#')
        film.write(release_date_str)
        film.write('#')
        film.write(intro_str)
        film.write('#')
        film.write(url)
        film.write('\n')
        #print(types_str)
        #print(rating_str)
        #print(intro_str)
        return 1
    else:
        #print(getURL(url))
        return 0
    #print(span)
    #pattern = re.compile(r'')


#<img src="https://img3.doubanio.com/view/photo/s_ratio_poster/public/p1461851991.webp" title="点击看更多海报" alt="WALL·E" rel="v:image" />

def get_flim_images(url):
    if getURL(url)!='Exception Occured':
        soup=BeautifulSoup(getURL(url), 'html.parser')
        #print(soup.find_all('div',id="info"))
        title=soup.title.contents[0]
        title=title.replace("(豆瓣)",'')
        title=title.replace(" ",'')
        title=title.replace('\n','')
        title=title.replace('\u3000','')
        image=soup.find('div',id="mainpic").find('img')
        img_binary = requests.get(image.attrs['src'])
        img = img_binary.content
        with open( './img/'+title+'.webp','wb' ) as f:
            f.write(img)

        pass
        return 1
    else:
        #print(getURL(url))
        return 0
    #print(span)
    #pattern = re.compile(r'')


def datatest():
    url = "https://lyc-page.notion.site/cd1d26e074f74639979d26551cb0ffa1?v=d6516eb303dd4b12b7be6135c8246ceb"
    soup = BeautifulSoup(getURL(url), 'html.parser')
    data=soup.find_all(attrs={"class":"notion-selectable notion-page-block notion-collection-item"})
    
    return data
if __name__=='__main__':
    a = datatest()
    pass
    