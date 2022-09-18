from linkedlist import linked_list
from Film import film
class sorted_linked_list():
    class node():
        def __init__(self,weights):
            self.weights=weights
            self.filmlist=linked_list()
            self.next=None

    def __init__(self):
        self.head=None
    
    def insert(self,film):
        if self.head is None:
            self.head=self.node(float(film.rating))
            self.head.filmlist.append(film)
        else:
            p=self.head
            q=self.head
            while(p.weights>float(film.rating)):
                q=p
                p=p.next
                if p is None:
                    break
            if q==p:
                self.head=self.node(float(film.rating))
                self.head.filmlist.append(film)
                self.head.next=p
                return
            if p is not None:
                if p.weights<float(film.rating):
                    q.next=self.node(float(film.rating))
                    q.next.filmlist.append(film)
                    q.next.next=p
                else:
                    p.filmlist.append(film)
            else:
                q.next=self.node(float(film.rating))
                q.next.filmlist.append(film)
                q.next.next=p

    def _show(self,node):
        if node is not None:
            print(str('\n'+node.weights)+':',end="")
            node.filmlist.show()
            self._show(node.next)
    
    def show(self):
        self._show(self.head)

if __name__=='__main__':
    class test():
        def __init__(self,rating):
            self.rating = rating
    
    sll=sorted_linked_list()
    sll.insert(test('8.7'))
    sll.insert(test('7.1'))
    sll.insert(test('9.7'))
    sll.insert(test('8.2'))
    sll.insert(test('8.4'))
    sll.insert(test('8.1'))
    sll.insert(test('8.1'))
    sll.insert(test('8.1'))
    pass