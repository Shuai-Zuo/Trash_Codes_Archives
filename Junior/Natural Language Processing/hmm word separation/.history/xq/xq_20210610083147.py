import os
import jieba
from math import log2
# 读取每个义项的语料
def read_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        lines = [_.strip() for _ in f.readlines()]
        return lines
# 对示例句子分词
#sent = '1980年12月12日，苹果公司公开招股上市，在不到一个小时内，460万股全被抢购一空，当日以每股29美元收市。'
sent = '今天我吃了一个苹果'
wsd_word = '苹果'
jieba.add_word(wsd_word)
sent_words = list(jieba.cut(sent, cut_all=False))
# 去掉停用词
stopwords = [wsd_word, '我', '你', '它', '他', '她', '了', '是', '的', '啊', '谁', '什么','都',\
             '很', '个', '之', '人', '在', '上', '下', '左', '右', '。', '，', '！', '？']
sent_cut = []
for word in sent_words:
    if word not in stopwords:
        sent_cut.append(word)
print(sent_cut)
wsd_dict = {}
for fil in os.listdir('F:\\hmm\\xq'):
    if wsd_word in fil:
        wsd_dict[fil.replace('.txt', '')] = read_file('F:\\hmm\\xq\\'+fil)
tf_dict = {}
for meaning, sents in wsd_dict.items():
    tf_dict[meaning] = []
    for word in sent_cut:
        word_count = 0
        for sent in sents:
            example = list(jieba.cut(sent, cut_all=False))
            word_count += example.count(word)
        if word_count:
            tf_dict[meaning].append((word, word_count))
idf_dict = {}
for word in sent_cut:
    document_count = 0
    for meaning, sents in wsd_dict.items():
        for sent in sents:
            if word in sent:
                document_count += 1
    idf_dict[word] = document_count
total_document = 0
for meaning, sents in wsd_dict.items():
    total_document += len(sents)
mean_tf_idf = []
for k, v in tf_dict.items():
    #print(k+':')
    tf_idf_sum = 0
    for item in v:
        word = item[0]
        tf = item[1]
        tf_idf = item[1]*log2(total_document/(1+idf_dict[word]))
        tf_idf_sum += tf_idf
        #print('%s, 频数为: %s, TF-IDF: %s'% (word, tf, tf_idf))
    mean_tf_idf.append((k, tf_idf_sum))
sort_array = sorted(mean_tf_idf, key=lambda x:x[1], reverse=True)
true_meaning = sort_array[0][0].split('_')[1]
print('\n%s在该句子中的意思为 %s .' % (wsd_word, true_meaning))