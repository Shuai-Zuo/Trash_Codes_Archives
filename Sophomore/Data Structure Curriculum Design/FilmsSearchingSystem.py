#from AVLTree import AVLTree
#from time import time
from search import Search
if __name__ == '__main__':
    #start_time = time()
    s=Search()
    #print('TreeCreate time: {} seconds'.format(time() - start_time))
    #s.list_all()
    #s.show_types()
    search_str = input('Please Enter:')
    while search_str !='exit':
        #start_time = time()
        s.search(search_str)
        #print('Search time: {} seconds'.format(time() - start_time))
        search_str = input('Please Enter:')