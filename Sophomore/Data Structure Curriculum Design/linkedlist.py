from Film import film
class linked_list():
    class node():
        def __init__(self,film):
            self.film = film
            self.next = None
            self.strs=''
    
    def __init__(self):
        self.head = None

    def _append(self,film,node):
        if self.head == None:
            self.head = self.node(film)
        elif node.next is not None:
            self._append(film,node.next)
        else:
            node.next = self.node(film)
    
    def append(self,film):
        self._append(film,self.head)
    
    def is_empty(self):
        if self.head is None:
            return True
        else:
            return False

    def delete(self,film_name):
        p=self.head
        q=self.head
        if p is not None:
            if p.film.name == film_name:
                self.head=p.next
                return
            q=q.next
            while q is not None:
                if q.film.name == film_name:
                    p.next=q.next
                    break
                q=q.next
                p=p.next
    
    def _show(self,node):
        if node is not None:
            print(node.film.name,end=' ')
            self.strs=self.strs+'   '+node.film.name
            self._show(node.next)

    def show(self):
        self.strs=''
        self._show(self.head)
        return self.strs

    def lenth(self):
        i=0
        p=self.head
        while p!=None:
            p=p.next
            i=i+1
        return i

if __name__ == "__main__":
    llist=linked_list()
    llist.append(1)
    llist.append(2)
    llist.append(3)
    llist.append(4)
    llist.append(5)
    pass
    