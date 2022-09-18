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
		self.state_count={}
		self.dic = {}
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
		self.train_data=open(filepath,'r',encoding='utf-8')

	def counta(self):
		for word in self.train_data.split():
			if word not in dic:
				self.dic[word] = 1
			else:
				self.dic[word] = self.dic[word] + 1

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
			self.init_P_array[key]=float(self.init_array[key])/float(self.state_count[key])

		for key1 in self.tran_array:
			for key2 in self.tran_array:
				self.tran_p_array[key1][key2]=float(self.tran_array[key1][key2])/float(self.state_count[key1])

		for s in self.tran_array:
			for o in self.emit_array[s]:
				self.emit_p_array[s][o]=float(self.emit_array[s][o])/float(self.state_count[s])

	def predict(self,seq):
		'''维特比算法'''
		tab=[{}] 
		path = {}

		for state in self.states:
			tab[0][state]=self.init_P_array[state]*self.emit_p_array[state].get(seq[0],0)    # pi(s1)*p(o1|s1)
			path[state]=[state]

		for t in range(1,len(seq)):
			tab.append({})
			newpath={}

			for state1 in self.states:
				items=[] 
				for state2 in self.states:
					p=tab[t-1][state2]*self.tran_p_array[state2].get(state1,0)*self.emit_p_array[state1].get(seq[t],0)
					items.append((p,state2))
				best=max(items)
				tab[t][state1]=best[0]
				newpath[state1] = path[best[1]] + [state1]
			path=newpath

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













