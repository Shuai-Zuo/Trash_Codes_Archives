from Film import film
class AVLTree:
    class film_node:
        def __init__(self, film_name=None,director=None,types=None,rating=None,region=None,plot=None,actors=None,language=None,time=None):
            self.film_name = film_name
            self.left = None
            self.right = None
            self.height = 1
            self.film = film(film_name,rating,region,plot,types,director,actors,language,time)

    def __init__(self):
        self.root = None
        self.size = 0

    def get_size(self):
        return self.size

    def add_from_root(self,film_name,rating,region,plot,types,director,actors,language,time):
        self.root=self.add(self.root,film_name,rating,region,plot,types,director,actors,language,time)

    def add(self, node,film_name,rating,region,plot,types,director,actors,language,time):
        if not node:
            self.size += 1#若节点为空，则创建一个节点
            return self.film_node(film_name,director,types,rating,region,plot,actors,language,time)
        elif node.film_name > film_name:
            node.left = self.add(node.left,film_name,rating,region,plot,types,director,actors,language,time)
        else:
            node.right = self.add(node.right,film_name,rating,region,plot,types,director,actors,language,time)
        # 更新height,获取平衡因子
        node.height = 1 + max(self.get_height(node.left), self.get_height(node.right))
        banlance_factor = self.get_balance_factor(node)
        # 维护平衡性，共四种情况LL,RR,LR,RL
        #LL
        if banlance_factor > 1 and self.get_balance_factor(node.left) >= 0:
            return self.right_rotate(node)
        #RR
        if banlance_factor < -1 and self.get_balance_factor(node.right) <= 0:
            return self.left_rotate(node)
        #LR
        if banlance_factor > 1 and self.get_balance_factor(node.left) < 0:
            node.left = self.left_rotate(node.left)
            return self.right_rotate(node)
        #RL
        if banlance_factor < -1 and self.get_balance_factor(node.right) > 0:
            node.right = self.right_rotate(node.right)
            return self.left_rotate(node)
        return node

    def get_height(self, node):
        if not node:
            return 0
        return node.height

    def get_balance_factor(self, node):
        if not node:
            return 0
        return self.get_height(node.left) - self.get_height(node.right)

    def right_rotate(self, y):
        x = y.left
        T3 = x.right
        # 右旋转
        x.right = y
        y.left = T3
        # 更新height
        y.height = max(self.get_height(y.left), self.get_height(y.right)) + 1
        x.height = max(self.get_height(x.left), self.get_height(x.right)) + 1
        return x

    def left_rotate(self, y):
        x = y.right
        T2 = x.left
        x.left = y
        y.right = T2
        # 更新height
        y.height = max(self.get_height(y.left), self.get_height(y.right)) + 1
        x.height = max(self.get_height(x.left), self.get_height(x.right)) + 1
        return x

    def get_node(self, node, film_name):
        if not node:
            return
        if node.film_name == film_name:
            return node
        elif node.film_name > film_name:
            return self.get_node(node.left, film_name)
        else:
            return self.get_node(node.right, film_name)

    def get_film_from_node(self,film_name):
        s = self.get_node(self.root, film_name)
        if s is not None:
            return s.film
        else:
            return film('noname','norating','noregion','nointro','notypes','nosuchdirector','noactor','nolanguage','notime')

    def get_film_from_node_print(self,film_name):
        self.searched_film = self.get_film_from_node(film_name)
        if self.searched_film.name != 'noname':
            print(self.searched_film.name,self.searched_film.director,self.searched_film.types)
        else:
            print('No Such Film!')

    def contains(self, film_name):
        return self.get_node(self.root, film_name) is not None

    def preorder_traversal(self,node):
        if node is not None:
            print(node.film_name,node.film.director,node.film.types)
            self.preorder_traversal(node.left)
            self.preorder_traversal(node.right)

    def root_preorder_traversal(self):
        self.preorder_traversal(self.root)

    def root_preorder_traversal_search(self,types):
        self.flag = 0
        self.preorder_traversal_search(self.root,types)
        if self.flag == 0:
            print("No Such Film!")

    def preorder_traversal_search(self,node,search_str):
        if node is not None:
            i = 1            
            strs=search_str.split()
            for string in strs:
                if node.film.types.count(string) < 1 and node.film.director!=string and node.film.actors.count(string) < 1:
                    i = 0
            if i == 1:
                self.flag = 1
                print(node.film_name,node.film.director,node.film.actors,node.film.types)
            self.preorder_traversal_search(node.left,search_str)
            self.preorder_traversal_search(node.right,search_str)

    def delete(self):
        pass