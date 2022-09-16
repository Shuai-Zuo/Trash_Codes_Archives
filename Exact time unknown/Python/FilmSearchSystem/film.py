class film:
    def __init__(self,name,introduction,language,rating): 
        self.Kind_of_film=[]
        self.film_name=name
        self.introduction=introduction
        self.language=language
        self.rating=rating
    def get_film_name(self):
        print(self.film_name)
    def get_introduction(self):
        print(self.introduction)
    def get_language(self):
        print(self.language)
    def get_rating(self):
        print(self.rating)
if __name__=="__main__":
    f1=film("name","introduction","language",9.1)
    f1.get_film_name()
    f1.get_introduction()
    f1.get_language()
    f1.get_rating()