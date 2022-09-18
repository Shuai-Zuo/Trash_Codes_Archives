import numpy as np
import copy
import json

class HMM(object):

	def __init__(self,states):
		self.states=states
		self.states_num = len(states)
		self.tran_array={}
		self.emit_array={}
		self.init_array={}
		self.state_count={}   # 统计每个state出现的总次数
		for i in states:
			self.tran_array[i]={}
			for j in states:
				self.tran_array[i][j]=0
			self.emit_array[i]={}
			self.init_array[i]=0
			self.state_count[i]=0
		self.tran_p_array = copy.deepcopy(self.tran_array)
		self.emit_p_array = copy.deepcopy(self.emit_array)
		self.init_P_array = copy.deepcopy(self.init_array)
		self.train_data=None

	def get_train_data(self,filepath):
		# with open(filepath,'r',encoding='utf-8') as f:  # 用with读完就会close，self.train_data变成None了
		self.train_data=open(filepath,'r',encoding='utf-8')

	def train(self,observe_seq,state_seq):
		last_s = -1
		for i,(s,o) in enumerate(zip(state_seq,observe_seq)):
			if i==0:
				self.init_array[s]+=1
				self.state_count[s]+=1
			else:
				self.tran_array[last_s][s]+=1
				self.emit_array[s][o]=self.emit_array[s].get(o,0)+1
				self.state_count[s] += 1
			last_s=s

	def count2prob(self):
		for key in self.init_array:
			# 每个state作为句首出现的次数 / 每个state出现的总数，得到每个state作为句首出现的概率
			self.init_P_array[key]=float(self.init_array[key])/float(self.state_count[key])

		for key1 in self.tran_array:
			for key2 in self.tran_array:
				# 每个key2在key1后出现的次数 / key1出现的总数，得到key1向其他状态转移的概率
				self.tran_p_array[key1][key2]=float(self.tran_array[key1][key2])/float(self.state_count[key1])

		for s in self.tran_array:
			for o in self.emit_array[s]:
				# 每个观测在状态s后出现的次数 / 状态s出现的总数，得到状态s映射到每个观测的概率
				self.emit_p_array[s][o]=float(self.emit_array[s][o])/float(self.state_count[s])

	def predict(self,seq):
		'''
		HMM的解码问题，维特比算法
		'''
		tab=[{}] # 动态规划表, tab[t][state]表示 时刻t到达state状态的所有路径中，概率最大路径的概率
		path = {}

		for state in self.states:   # 初始化句子开头的状态，是不是需要考虑句子首字在训练时没有做过开头的情况
			tab[0][state]=self.init_P_array[state]*self.emit_p_array[state].get(seq[0],0)    # pi(s1)*p(o1|s1)
			path[state]=[state]

		for t in range(1,len(seq)):  # 因为第一步在上面已经走了
			tab.append({})
			newpath={}

			for state1 in self.states:
				items=[]  # 保存从每个state2转移到state1的所有排列组合及其概率
				for state2 in self.states:
					# pi(s1)*p(o1|s1)*p(s1->s2)*p(o2|s2)
					p=tab[t-1][state2]*self.tran_p_array[state2].get(state1,0)*self.emit_p_array[state1].get(seq[t],0)
					items.append((p,state2))
				best=max(items)
				tab[t][state1]=best[0]
				newpath[state1] = path[best[1]] + [state1]
			path=newpath  # 保存t时刻所有state1的最佳路径，循环结束后需要从中选出最后时刻最好的那个state1作为唯一的路径

		p,s=max([(tab[len(seq)-1][state],state) for state in self.states])
		return path[s]


	def save(self,filename="hmm.json"):
		data={
			"tran_p_array":self.tran_p_array,
			"emit_p_array":self.emit_p_array,
			"init_P_array":self.init_P_array,
			"state_count":self.state_count
		}
		data=json.dumps(data)
		with open(filename,'w',encoding='utf-8') as f:
			f.write(data)

	def load(self,filename="hmm.json"):
		with open(filename,'r',encoding='utf-8') as f:
			s=f.readlines()
			data=json.loads(s)
		self.tran_p_array=data['tran_p_array']
		self.emit_p_array=data['emit_p_array']
		self.init_P_array=data['init_P_array']
		self.state_count=data['state_count']













