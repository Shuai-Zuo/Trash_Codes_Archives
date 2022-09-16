from Film import film
from AVLTree import AVLTree
from sortedlinkedlist import sorted_linked_list
import re
class Search():
    def __init__(self):
        self.all_types = []
        self.directors = []
        self.actors = []
        self.words = ''
        self.strs=''
        with open('filmlist.txt', 'r',encoding='utf-8') as f:
            self.words = f.read()
        self.words = self.words.split()
        self.avl=AVLTree()
        self.rating_sort=sorted_linked_list()
        self.clicks_sort=sorted_linked_list()
        for word in self.words:
            wd = word.split('#')
            if self.avl.contains(wd[0]):
                print("duplicated")
            else:
                import_film=film(wd[0],wd[1],wd[2],wd[3],wd[4],wd[5],wd[6],wd[7],wd[8])
                self.avl.add_from_root(import_film)#filmname,director,actors,types,ratings,regions,languages,date,intro
                self.rating_sort.insert_by_rating(import_film)
                self.clicks_sort.insert_by_clicks(import_film)
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

    def refresh_list(self,linkedlist, films):
        for film in films:
            linkedlist.delete(film.name)
            linkedlist.insert_by_clicks(film)

    def show_types(self):
        print('There are',len(self.all_types),'types.')
        print(self.all_types)
        self.strs=''
        i=0
        for types in self.all_types:
            self.strs=self.strs+types+'\t'
            i+=1
            if i==4:
                self.strs=self.strs+'\n'
                i=0
        return self.strs

    def show_actors(self):
        print('There are',len(self.actors),'actors.')
        print(self.actors)
        self.strs=''
        i=0
        for actor in self.actors:
            self.strs=self.strs+actor+'   '
            i+=1
            if i==2:
                self.strs=self.strs+'\n'
                i=0
        return self.strs

    def show_directors(self):
        print('There are',len(self.directors),'directors.')
        print(self.directors)
        i=0
        for director in self.directors:
            self.strs=self.strs+director+'   '
            i+=1
            if i==2:
                self.strs=self.strs+'\n'
                i=0
        return self.strs

    def list_all(self):
        print('There are',self.avl.size,'films.')
        return self.avl.root_preorder_traversal()

    def search(self,search_str):
        self.search_word = search_str.split()
        i = 0
        for word in self.search_word:
            if self.all_types.count(word) < 1 and self.directors.count(word) < 1 and self.actors.count(word) < 1:
                i = 1
        if i == 0:
            str1=self.avl.root_preorder_traversal_search(search_str)
            if len(self.avl.need_refresh_list)!=0:
                self.refresh_list(self.clicks_sort, self.avl.need_refresh_list)
            return str1
        elif search_str == 'list':
            return self.list_all()
        elif search_str == 'types':
            return self.show_types()
        elif search_str == 'directors':
            return self.show_directors()
        elif search_str == 'actors':
            return self.show_actors()
        elif search_str == 'ratingsort':
            return self.rating_sort.show()
        elif search_str == 'heatsort':
            return self.clicks_sort.show()
        elif re.match(r'delete .*',search_str):
            self.delete(search_str.split()[1])
        else:
            #searched_film = self.avl.get_film_from_node(search_str)
            str1=self.avl.get_film_from_node_llist(search_str)
            if len(self.avl.need_refresh_list)!=0:
                self.refresh_list(self.clicks_sort, self.avl.need_refresh_list)
            return str1
        return ''

    def append(self):
        pass
    
    def delete(self,strs):
        self.avl.remove(strs)
        self.rating_sort.delete(strs)
        self.clicks_sort.delete(strs)