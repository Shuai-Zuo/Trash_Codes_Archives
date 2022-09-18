from Film import film
class linked_list():
    class node():
        def __init__(self,film):
            self.film = film
            self.next = None
    
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


if __name__ == "__main__":
    llist=linked_list()
    llist.append(1)
    llist.append(2)
    llist.append(3)
    llist.append(4)
    llist.append(5)
    pass
    