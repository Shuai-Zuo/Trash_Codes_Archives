from film import film
class film_Node(film):
    def __init__(self,name,introduction,language,rating): 
        self.Kind_of_film=[]
        self.film_name=name
        self.introduction=introduction
        self.language=language
        self.rating=rating
        self.leftchild=None
        self.rightchild=None
        
if __name__=="__main__":
    f1=film("name1","introduction1","language1",9.1)
    f2=film("name2","introduction2","language2",9.3)
    f3=film("name3","introduction3","language3",9.5)
    f1.leftchild=f2
    f1.rightchild=f3
    f1.leftchild.get_film_name()
    f1.leftchild=f3
    f1.leftchild.get_film_name()