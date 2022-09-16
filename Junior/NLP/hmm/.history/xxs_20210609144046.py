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
    before = time.time()

    #preprocess.preprocess()
    with open('./pku_training.utf8', 'r',encoding = 'utf-8') as f:

        corpus = f.read()  # 读取文件得到语料库文本
        split_words = corpus.split() # 利用jieba分词
        words_len = len(split_words)

        print("语料库字数:", len(corpus))
        print("分词个数:", words_len)
        print("平均词长:", round(len(corpus)/words_len, 3))

        words_tf = get_tf(split_words)  # 得到词频表
        # print("词频表:", tf_words)

        entropy = [-(uni_word[1]/words_len)*math.log(uni_word[1]/words_len, 2) for uni_word in words_tf]
        print("基于词的信息熵为:", round(sum(entropy), 3), "比特/词")

    after = time.time()