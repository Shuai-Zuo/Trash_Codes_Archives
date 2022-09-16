class film():
    def __init__(self,name,rating,region,plot,types,director,actors,language,time):
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
        self.click_times = 0
    def clicked(self):
        self.click_times = self.click_times + 1