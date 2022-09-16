import hmm
import re
import operator

STATES = ['B', 'M', 'E', 'S']
dic = {}

def add_tags(word):
	if len(word) == 1:
		tags = ['S']
	elif len(word) == 2:
		tags = ['B', 'E']
	else:
		tags = ['M'] * len(word)
		tags[0] = 'B'
		tags[-1] = 'S'
	char_lst = []
	for i in word:
		char_lst.append(i)
	return tags, char_lst


hmm_obj = hmm.HMM(STATES)

hmm_obj.get_train_data('C:\\Users\\admin\\Downloads\\wordcut_hmm-master\\pku_training.utf8')

for line in hmm_obj.train_data:
	if len(line) == 0:
		continue
	word_lst = re.split('\s+', line.strip())  # 切掉全部空格
	observes = []
	states = []
	for w in word_lst:
		if w == "":
			continue
		if w not in dic:
			dic[w] = 1
		else:
			dic[w] = dic[w] + 1
		tags, char_lst = add_tags(w)
		observes.extend(char_lst)
		states.extend(tags)
	hmm_obj.train(observes, states)

hmm_obj.count2prob()

def cut(sen,tags):
	s=list(sen)
	tags=''.join(tags)
	lst=re.finditer('BE{1}|BME{1}',tags)
	count=0  # 已插入空格的数量
	for i in lst:
		start=i.span()[0]+count
		count+=1
		end=i.span()[1]+count
		s.insert(start,' ')
		s.insert(end,' ')
		count+=1
	s=''.join(s)
	result=re.split('\s+',s.strip())
	return result
fo = open("fre.txt", "w",encoding = "utf-8")
swd = sorted(dic.items(),key=operator.itemgetter(1),reverse=True)
for tup in swd:
	if(len(tup[0])<=1):
		continue
	fo.write(tup[0])
	fo.write(" ")
	fo.write(str(tup[1]))
	fo.write("\n")
fo.close()

test = '就像是一场梦，醒来很久还是很感动！'
test_tags=hmm_obj.predict(test)
print(cut(test,test_tags))

test = '淡黄的长裙，蓬松的头发，你牵着我的手看最新展出的油画。'
test_tags=hmm_obj.predict(test)
print(cut(test,test_tags))

test = '自然语言处理结课了。'
test_tags=hmm_obj.predict(test)
print(cut(test,test_tags))
