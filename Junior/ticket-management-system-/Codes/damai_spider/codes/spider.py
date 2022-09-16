import requests
import json
import csv
import time
import re
class Spider(object):
    def __init__(self):
        #self.url = "https://search.damai.cn/searchajax.html"
        #构造请求头，请使用自己的Cookie
        self.url = 'https://search.damai.cn/searchajax.html?keyword=&cty=%E5%8C%97%E4%BA%AC&ctl=&sctl=&tsg=0&st=&et=&order=1&pageSize=30&currPage=1&tn='

        self.headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.70 Safari/537.36 Edg/92.0.902.30",
            "cookie": "cna=dijtFTtT3y8CAT0xagWliNM8; xlly_s=1; XSRF-TOKEN=3a4cf19b-fca7-49b1-b160-885469359a4c; destCity=%u5317%u4EAC; _samesite_flag_=true; cookie2=1e2f9c152fc82340fbedc4c62e2f45ce; t=c19d494ddbe077912bef683c6c690110; _tb_token_=e547be3053319; _hvn_login=18; munb=2212162704424; csg=04461deb; damai.cn_nickName=%E9%BA%A6%E5%AD%9021MHX; damai.cn_user=TuGPEtsgDFEUHrdqvCF+j0JqgBFWzA4YDFKz9FsrNWVLNqjeebMrMIipG40Sb6mYGxb2+Rjuqig=; damai.cn_user_new=TuGPEtsgDFEUHrdqvCF%2Bj0JqgBFWzA4YDFKz9FsrNWVLNqjeebMrMIipG40Sb6mYGxb2%2BRjuqig%3D; h5token=b5b403fe15004d2487eb3994a623b30c_1_1; damai_cn_user=TuGPEtsgDFEUHrdqvCF%2Bj0JqgBFWzA4YDFKz9FsrNWVLNqjeebMrMIipG40Sb6mYGxb2%2BRjuqig%3D; loginkey=b5b403fe15004d2487eb3994a623b30c_1_1; user_id=172701699; tfstk=cg9CBpjaEy4QIchzLHiaa0bJY0W5ZFPcVv_BAI04GCMKYstCiWeVlQpJrP5xqG1..; l=eBQxHG57j9X1k2TMBO5Zourza77tEQObzsPzaNbMiInca69l9FtBANCBLfVvWdtjgt5f4etPCN-OOReH5-aU--Mot9HJfRskeh9eRe1..; isg=BEdHq6bh6wCwnW-MpK6duY4J1vsRTBsukQNYyBk3JFbdiGVKIR6LfzLOKkjWYPOm",
            "referer": "https://search.damai.cn/search.htm?spm=a2oeg.home.category.ditem_0.1b3123e1fkk8L&order=1&cty=%E5%8C%97%E4%BA%AC",
            "accept": "application/json, text/plain, */*",
            "accept-encoding": "gzip, deflate, br",
            "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
            "sec-ch-ua": "\"Chromium\";v=\"92\", \" Not A;Brand\";v=\"99\", \"Microsoft Edge\";v=\"92\"",
            "sec-ch-ua-mobile": "?0",
            "sec-fetch-dest": "empty",
            "sec-fetch-mode": "cors",
            "sec-fetch-site": "same-origin",
            "x-xsrf-token": "3a4cf19b-fca7-49b1-b160-885469359a4c"
        }
        '''self.data = {
            "keyword":"",
            "cty": "%E5%8C%97%E4%BA%AC",
            "ctl": "",
            "sctl": "",
            "tsg": '0',
            "st": "",
            "et": "",
            "order": '1',
            "pageSize":'60',
            "currPage":'1',
            "tn":""
        }'''
        self.data_key = None

    def get(self,pages:int = 1):
        page_num = re.search(r'currPage=(\d+)', self.url).group(1)
        page_num = 'currPage=' + str(pages)
        self.url = re.sub(r'currPage=\d+', page_num, self.url)
        #self.data['currPage']=str(pages)
        #response = requests.get(url=self.url, headers=self.headers, data=self.data)
        response = requests.get(url=self.url, headers=self.headers)
        #print(response.text)
        #self.data['currPage']=str(1)
        return response

    def parse(self,pages:int=1):
        '''page_wr=open("1.txt", "r",encoding='utf-8')
        dict_data = json.loads(page_wr.read())'''
        dict_data = json.loads(self.get(pages).text)
        #print(dict_data["pageData"]["resultData"])
        need_spider_data = dict_data["pageData"]["resultData"]
        # print(need_spider_data)
        data_key = []
        for item in need_spider_data[0]:
            data_key.append(item)
        print("\nGot "+str(pages)+"\n")
        self.data_key = data_key
        return need_spider_data
        # print(data_key)
        '''
        time.sleep(60)
        for i in range(2,23):
            dict_data = json.loads(self.get(i).text)
            spider_data = dict_data["pageData"]["resultData"]
            need_spider_data.append(spider_data)
            print("\nGot "+str(i)+"\n")
            time.sleep(55)
        '''
    # 保存为.CSV
    def save(self,my_data):
        list = self.data_key
        list.append('favourable')
        #print(list)
        #print(my_data)
        with open("Original_Data" + ".csv", "w", newline="", encoding='utf-8') as f:
            # 传入表头
            writer = csv.DictWriter(f, list)
            writer.writeheader()
            for row in my_data:
                writer.writerow(row)




if __name__ == '__main__':
    spider = Spider()
    #spider.run()
    original_data=[]
    for i in range(1,23):
        original_data.extend(spider.parse(i))
        time.sleep(0)
    spider.save(original_data)
