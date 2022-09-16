from Film import film
from linkedlist import linked_list
class AVLTree:
    class film_node:
        def __init__(self, film):
            self.film_name = film.name
            self.left = None
            self.right = None
            self.height = 1
            self.film = film
            self.strs=''

    def __init__(self):
        self.root = None
        self.size = 0
        self.need_refresh_list=[]

    def get_size(self):
        return self.size

    def add_from_root(self,film):
        self.root=self.add(self.root,film)

    def add(self, node,film):
        if not node:
            self.size += 1#若节点为空，则创建一个节点
            return self.film_node(film)
        elif node.film_name > film.name:
            node.left = self.add(node.left,film)
        else:
            node.right = self.add(node.right,film)
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
            return film('noname','norating','noregion','nointro','notypes','nosuchdirector','noactor','nolanguage','notime','nourl')

    def preorder_traversal_save(self):
        film=open("filmlist.txt", "w",encoding='utf-8')
        self._preorder_traversal_save(self.root,film)
        film.close()

    def _preorder_traversal_save(self,node,film):
        if node is not None:
            #filmname,director,actors,types,ratings,regions,languages,date,intro
            film.write(node.film.name)
            film.write('#')
            film.write(node.film.director)
            film.write('#')
            film.write('/'.join(node.film.actors))
            film.write('#')
            film.write('/'.join(node.film.types))
            film.write('#')
            film.write(node.film.rating)
            film.write('#')
            film.write('/'.join(node.film.region))
            film.write('#')
            film.write('/'.join(node.film.language))
            film.write('#')
            film.write(node.film.time)
            film.write('#')
            film.write(node.film.plot)
            film.write('#')
            film.write(node.film.url)
            film.write('\n')
            self._preorder_traversal_save(node.left,film)
            self._preorder_traversal_save(node.right,film)

    def get_film_from_node_llist(self,film_name):
        s = self.get_node(self.root, film_name)
        llist = linked_list()
        self.need_refresh_list=[] 
        if s is not None:
            llist.append(s.film)
            s.film.clicked()
            self.need_refresh_list=[s]
            return llist
        else:
            return film('noname','norating','noregion','nointro','notypes','nosuchdirector','noactor','nolanguage','notime', 'nourl')

    def get_film_from_node_print(self,film_name):
        self.searched_film = self.get_film_from_node(film_name)
        if self.searched_film.name != 'noname':
            print(self.searched_film.name,self.searched_film.director,self.searched_film.types)
            self.searched_film.clicked()
            self.need_refresh_list=[self.searched_film]
            return '电影名称:'+self.searched_film.name+ \
            '\n导演:'+self.searched_film.director+ \
            '\n演员:'+' '.join(self.searched_film.actors)+ \
            '\n类型:'+' '.join(self.searched_film.types)+ \
            '\n上映日期: '+self.searched_film.time+ \
            '\n语言:'+' '.join(self.searched_film.language)+ \
            '\n区域:'+' '.join(self.searched_film.region)+ \
            '\n评分:'+self.searched_film.rating+ \
            '\n剧情梗概:'+self.searched_film.plot+'\n'
        else:
            print('No Such Film!')
            return 'No Such Film!'

    def contains(self, film_name):
        return self.get_node(self.root, film_name) is not None

    def preorder_traversal(self,node):
        if node is not None:
            print(node.film_name,node.film.director,node.film.types)
            self.strs=self.strs+node.film_name+'  ['+' '.join(node.film.types)+']\n'
            self.preorder_traversal(node.left)
            self.preorder_traversal(node.right)

    def root_preorder_traversal(self):
        self.strs=''
        self.preorder_traversal(self.root)
        return self.strs

    def root_preorder_traversal_search(self,types):
        self.flag = 0
        self.strs = ''
        self.llist = linked_list()
        self.need_refresh_list=[] 
        self.preorder_traversal_search(self.root,types)
        if self.flag == 0:
            print("No Such Film!")
            return 'No Such Film!'
        #return self.strs
        return self.llist

    def preorder_traversal_search(self,node,search_str):
        if node is not None:
            i = 1    
            strs=search_str.split()
            for string in strs:
                if node.film.types.count(string) < 1 and node.film.director!=string and node.film.actors.count(string) < 1:
                    i = 0
            if i == 1:
                self.flag = 1
                #print(node.film_name,node.film.director,node.film.actors,node.film.types)
                node.film.clicked()
                self.need_refresh_list.append(node.film)
                self.llist.append(node.film)
                self.strs =self.strs + '电影名称：'+node.film.name+ \
                '\n导演:'+node.film.director+ \
                '\n演员:'+' '.join(node.film.actors)+ \
                '\n类型:'+' '.join(node.film.types)+ \
                '\n上映日期: '+node.film.time+ \
                '\n语言:'+' '.join(node.film.language)+ \
                '\n区域:'+' '.join(node.film.region)+ \
                '\n评分:'+node.film.rating+ \
                '\n剧情梗概:'+node.film.plot+'\n\n'
            self.preorder_traversal_search(node.left,search_str)
            self.preorder_traversal_search(node.right,search_str)

    def remove(self, film_name):
        node = self.get_node(self.root, film_name)
        if node:
            self.root = self._remove(self.root, film_name)

        # 删除以node为根的BST中键值为key的节点，递归算法
        # 返回删除节点后的新的BSTMap的根

    def minimum(self, node):
        if not node.left:
            return node
        return self.minimum(node.left)   

    def _remove(self, node, film_name):
        if not node:
            return
        # 递归条件
        if node.film_name > film_name:
            node.left = self._remove(node.left, film_name)
            ret_node = node
        elif node.film_name < film_name:
            node.right = self._remove(node.right, film_name)
            ret_node = node
        else:  # node.film_name == film_name
            if not node.left:
                right_node = node.right
                node.right = None
                self.size -= 1
                ret_node = right_node
            elif not node.right:
                left_node = node.left
                node.left = None
                self.size -= 1
                ret_node = left_node
            # 如果左右子树均不为空
            # 找到比待删除节点大的最小节点，即待删除节点右子树的最小节点
            # 用这个节点顶替待删除节点的位置
            else:
                successor = self.minimum(node.right)
                successor.right = self._remove(node.right, successor.film_name)
                successor.left = node.left
                node.left = node.right = None
                ret_node = successor

        if not ret_node:
            return
            # 需要更新height
        ret_node.height = 1 + max(
            self.get_height(ret_node.left),
            self.get_height(ret_node.right),
        )
        banlance_factor = self.get_balance_factor(ret_node)
        #LL
        if banlance_factor > 1 and self.get_balance_factor(ret_node.left) >= 0:
            return self.right_rotate(ret_node)
        #RR
        if banlance_factor < -1 and self.get_balance_factor(ret_node.right) <= 0:
            return self.left_rotate(ret_node)
        # LR
        if banlance_factor > 1 and self.get_balance_factor(ret_node.left) < 0:
            ret_node.left = self.left_rotate(ret_node.left)
            return self.right_rotate(ret_node)
        # RL
        if banlance_factor < -1 and self.get_balance_factor(ret_node.right) > 0:
            ret_node.right = self.right_rotate(ret_node.right)
            return self.left_rotate(ret_node)
        return ret_node