import requests
import json
import csv
import time
import re
class Spider(object):
    def __init__(self):
        self.keylist=[]
    def parse(self):
        '''page_wr=open("1.txt", "r",encoding='utf-8')
        dict_data = json.loads(page_wr.read())'''
        f = open("res.txt","r",encoding='utf-8')
        text = f.read()
        dict_data = json.loads(text)
        f.close()
        list = []
        key_dict={}
        key_dict["%<xc"]="DateRange"
        key_dict["ghTS"]="Link"
        key_dict[">dkh"]="SortingValue"
        key_dict["HzAt"]="Followed"
        
        for words in dict_data['result']['reducerResults']:
            dict_data['result']['reducerResults']['table:uncategorized:XcYr:checked']
            if re.match(r'table:uncategorized.*',words) != None:
                tem = words.split(":")
                key_dict[tem[2]]=tem[3]

        for singlerawdata in dict_data['recordMap']['block']:
            for blockid in dict_data['result']['reducerResults']['collection_group_results']['blockIds']:
                if blockid == singlerawdata:
                    list.append(dict_data['recordMap']['block'][singlerawdata]['value']['value']['properties'])
        for singledata in list:
            for key in key_dict:
                if key in singledata.keys():
                    if key_dict[key] not in self.keylist:
                        self.keylist.append(key_dict[key])
                    singledata[key_dict[key]] = singledata.pop(key)
                    if key_dict[key] == 'DateRange' or key_dict[key] == 'latest_date':
                        singledata[key_dict[key]] = singledata[key_dict[key]][0][1][0][1]
                    else:
                        singledata[key_dict[key]] = singledata[key_dict[key]][0]
                    
        return list
    # 保存为.CSV
    def save(self,my_data):
        keylist = self.keylist
        with open("Original_Data" + ".csv", "w", newline="", encoding='utf-8') as f:
            writer = csv.DictWriter(f, keylist)
            writer.writeheader()
            for row in my_data:
                writer.writerow(row)
        with open("Original_Data_gbk" + ".csv", "w", newline="", encoding='gbk') as f:
            writer = csv.DictWriter(f, keylist)
            writer.writeheader()
            for row in my_data:
                writer.writerow(row)




if __name__ == '__main__':
    spider = Spider()
    #spider.run()
    spider.save(spider.parse())