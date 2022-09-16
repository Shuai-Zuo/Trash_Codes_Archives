from Film import film
from AVLTree import AVLTree
class Search():
    def __init__(self):
        self.all_types = []
        self.directors = []
        self.actors = []
        self.words = ''
        with open('filmlist.txt', 'r',encoding='utf-8') as f:
            self.words = f.read()
        self.words = self.words.split()
        self.avl=AVLTree()
        for word in self.words:
            wd = word.split('#')
            if self.avl.contains(wd[0]):
                print("duplicated")
            else:
                self.avl.add_from_root(wd[0],wd[4],wd[5],wd[8],wd[3],wd[1],wd[2],wd[6],wd[7])
                tp=wd[3].split('/')
                actorslist=wd[2].split('/')
                directorslist=wd[1].split('/')
                for typ in tp:
                    if self.all_types.count(typ) < 1:
                        self.all_types.append(typ)
                for actor in actorslist:
                    if self.actors.count(actor) < 1:
                        self.actors.append(actor)
                for director in directorslist:
                    if self.directors.count(director) < 1:
                        self.directors.append(director)
    def show_types(self):
        print('There are',len(self.all_types),'types.')
        print(self.all_types)

    def show_actors(self):
        print('There are',len(self.actors),'actors.')
        print(self.actors)

    def show_directors(self):
        print('There are',len(self.directors),'directors.')
        print(self.actors[1801])
        print(self.directors)

    def list_all(self):
        print('There are',self.avl.size,'films.')
        self.avl.root_preorder_traversal()

    def search(self,search_str):
        self.search_word = search_str.split()
        i = 0
        for word in self.search_word:
            if self.all_types.count(word) < 1 and self.directors.count(word) < 1 and self.actors.count(word) < 1:
                i = 1
        if i == 0:
            self.avl.root_preorder_traversal_search(search_str)
        elif search_str == 'list':
            self.list_all()
        elif search_str == 'types':
            self.show_types()
        elif search_str == 'directors':
            self.show_directors()
        elif search_str == 'actors':
            self.show_actors()
        else:
            #searched_film = self.avl.get_film_from_node(search_str)
            self.avl.get_film_from_node_print(search_str)

    def append(self):
        pass
    
    def delete(self):
        pass