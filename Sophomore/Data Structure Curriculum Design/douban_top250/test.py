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
            actors_str.append(actor.contents[0])
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


def get_film_list():
    params = {
        'start': 0,
        'filter': '',
    }
    urltext = open("url_list.txt", "w")
    for params['start'] in range(0,250,25):
        #time.sleep(5)
        url = 'https://movie.douban.com/top250?' + urlencode(params)
        print(url)
        soup = BeautifulSoup(getURL(url), 'html.parser')  
    # url = 'https://movie.douban.com/top250?' + urlencode(params)
    # print(url)
    # soup = BeautifulSoup(getURL(url), 'html.parser')
        url_list=soup.find_all('a',attrs={'href':re.compile(r'https://movie.douban.com/subject/.*')})
    #print(url_list)
        i=0
        for film_url in url_list:
            if i==0:
                urltext.write(film_url.attrs['href'])
                urltext.write('\n')
                i=1
            else:
                i=0
    urltext.close()

if __name__=='__main__':
    with open('./url_list.txt', 'r') as f:
        url_str = f.read()
    urls = url_str.split()
    film=open("filmlist.txt", "w",encoding='utf-8')
    i=1
    for url in urls:
        get_flims(url)
        time.sleep(random.randint(3,9))
        print(str(i)+'completed')
        #if i==5:
            #break
        i=i+1
    film.close()
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
    