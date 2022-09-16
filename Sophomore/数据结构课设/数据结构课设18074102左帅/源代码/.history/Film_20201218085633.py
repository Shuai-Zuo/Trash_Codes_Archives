class film():
    def __init__(self,name,director,actors,types,rating,region,language,time,plot,url,click_times=0,review='noreview'):
        #filmname,director,actors,types,ratings,regions,languages,date,intro
        #def __init__(self,name,director,types):
        self.name = name
        self.rating = rating
        #self.adapt_from = adapt_from
        self.region = region.split('/')
        self.types = types.split('/')
        self.plot = plot
        self.director = director
        self.actors = actors.split('/')
        self.language = language.split('/')
        self.time = time
        #self.types = types
        self.click_times = int(click_times)
        self.image='./img/'+self.name+'.webp'
        self.url=url
        self.review=review.split('/')
    #构造方法用于创建电影节点
    def clicked(self):
        self.click_times = self.click_times + 1
    #用于实现热度自增