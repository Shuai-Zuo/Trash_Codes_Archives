from linkedlist import linked_list
from Film import film
class sorted_linked_list():
    class node():
        def __init__(self,weights):
            self.weights=weights
            self.filmlist=linked_list()
            self.next=None
            self.strs=''
            self.symbol=0

    def __init__(self):
        self.head=None

    def gnext(self,node):
        if node.next is not None:
            return node.next
        elif self.symbol == 1:
            if float(node.film.rating) == float(self.head.weights):
                if self.head.next is not None:
                    return self.head.next.filmlist.head
            else:
                p=self.head.next
                while p is not None:
                    if float(node.film.rating) == float(p.weights):
                        if p.next is not None:
                            return p.next.filmlist.head
                    p=p.next
        elif self.symbol == 2:
            if float(node.film.click_times) == float(self.head.weights):
                if self.head.next is not None:
                    return self.head.next.filmlist.head
            else:
                p=self.head.next
                while p is not None:
                    if float(node.film.click_times) == float(p.weights):
                        if p.next is not None:
                            return p.next.filmlist.head
                    p=p.next
        return None
    
    def insert_by_rating(self,film):
        self.symbol=1
        if self.head is None:
            self.head=self.node(float(film.rating))
            self.head.filmlist.append(film)
        else:
            p=self.head
            q=self.head
            while(float(p.weights)>float(film.rating)):
                q=p
                p=p.next
                if p is None:
                    break
            if q==p:
                if(p.weights!=film.rating):
                    self.head=self.node(film.rating)
                    self.head.filmlist.append(film)
                    self.head.next=p
                    return
            if p is not None:
                if float(p.weights)<float(film.rating):
                    q.next=self.node(float(film.rating))
                    q.next.filmlist.append(film)
                    q.next.next=p
                else:
                    p.filmlist.append(film)
            else:
                q.next=self.node(float(film.rating))
                q.next.filmlist.append(film)
                q.next.next=p

    def insert_by_clicks(self,film):
        self.symbol=2
        if self.head is None:
            self.head=self.node(film.click_times)
            self.head.filmlist.append(film)
        else:
            p=self.head
            q=self.head
            while(p.weights>film.click_times):
                q=p
                p=p.next
                if p is None:
                    break
            if q==p:
                if(p.weights!=film.click_times):
                    self.head=self.node(film.click_times)
                    self.head.filmlist.append(film)
                    self.head.next=p
                    return
            if p is not None:
                if p.weights<film.click_times:
                    q.next=self.node(film.click_times)
                    q.next.filmlist.append(film)
                    q.next.next=p
                else:
                    p.filmlist.append(film)
            else:
                q.next=self.node(film.click_times)
                q.next.filmlist.append(film)
                q.next.next=p

    def _show(self,node):
        if node is not None:
            if node.weights != 0:
                print('\n'+str(node.weights)+':',end="")
                self.strs=self.strs+str(node.weights)+':\n'+node.filmlist.show()+'\n'
                self._show(node.next)

    def show(self):
        self.strs=''
        self._show(self.head)
        print('')
        return self.strs

    def _delete(self,film_name,node):
        if node is not None:
            node.filmlist.delete(film_name)
            self._delete(film_name,node.next)

    def delete_null_node(self):
        p=self.head
        q=self.head
        if p is not None:
            if p.filmlist.is_empty():
                self.head=p.next
                return
            q=q.next
            while q is not None:
                if q.filmlist.is_empty():
                    p.next=q.next
                    break
                q=q.next
                p=p.next


    def delete(self,film_name):
        self._delete(film_name,self.head)
        self.delete_null_node()

if __name__=='__main__':
    class test():
        def __init__(self,rating):
            self.rating = rating