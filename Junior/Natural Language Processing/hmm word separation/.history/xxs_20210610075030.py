import jieba
import math
#import preprocess
import time


# 词频统计，方便计算信息熵
def get_tf(words):
    tf_dic = {}
    for w in words:
        tf_dic[w] = tf_dic.get(w, 0) + 1
    return tf_dic.items()


if __name__ == '__main__':

    #preprocess.preprocess()
    with open('./pku_training.utf8', 'r',encoding = 'utf-8') as f:

        corpus = f.read() 
        split_words = corpus.split() 
        words_len = len(split_words)

        print("字数:", len(corpus))
        print("词数:", words_len)
        print("平均词长:", round(len(corpus)/words_len, 3))

        words_tf = get_tf(split_words) 

        entropy = [-(uni_word[1]/words_len)*math.log(uni_word[1]/words_len, 2) for uni_word in words_tf]
        print("信息熵为:", round(sum(entropy), 3))