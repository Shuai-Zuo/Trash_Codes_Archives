import requests
import json
from bs4 import BeautifulSoup
import csv
import time
import re




#None: 0 TigerXbox: 1 TigerPsn: 2 TigerSteam: 3 TigerBlizzard: 4 TigerStadia: 5 TigerDemon: 10 BungieNext: 254 All: -1
class bungieAPI(object):
    def __init__(self):
        self.bungieapi = "https://www.bungie.net/Platform/"
        self.apilist = {
            "searchPlayer":"Destiny2/SearchDestinyPlayer/-1/{displayName}",\
            "GetProfile":"Destiny2/{membershipType}/Profile/{destinyMembershipId}/",\
            "GetCharacter":"Destiny2/{membershipType}/Profile/{destinyMembershipId}/Character/{characterId}/",\
            "GetActivityHistory":"Destiny2/{membershipType}/Account/{destinyMembershipId}/Character/{characterId}/Stats/Activities/"
        }

        self.DTRN = "https://api.tracker.gg/api/v2/destiny-2/"
        self.DTRNapi = {
            "eloProfile":"standard/profile/{platform}/{destinyMembershipId}/segments/playlist"
        }
        self.DTRNparams = {
            "season":"15"
        }
        self.membershipIntToStr={
            "0":"none",
            "1":"xbl",
            "2":"psn",
            "3":"steam",
            "4":"blizzard",
            "5":"stadia",
            "10":"demon",
            "254":"bungienext",
            "-1":"all"
        }



        self.headers = {
            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36",
            "X-API-Key":"a7737970da564ba29263c5351704afbf",
            "TRN-Api-Key":"bfd119ee-95ac-424b-95be-166134b9ceb5"
        }
        self.data_key = None

    def searchPlayer(self, id = ""):
        response = requests.get(url=self.bungieapi+self.apilist["searchPlayer"].replace("{displayName}",id.replace("#","%23")), headers=self.headers)
        rawjson = response.content.decode('utf8')
        data = json.loads(rawjson)
        return data

    def GetProfile(self, id = ""):
        res = self.searchPlayer(id)
        response = requests.get(url=self.bungieapi+\
            self.apilist["GetProfile"].replace("{membershipType}",str(res['Response'][0]['membershipType'])).\
            replace("{destinyMembershipId}",res['Response'][0]['membershipId']),\
             headers=self.headers,params={"components":100})
        rawjson = response.content.decode('utf8')
        data = json.loads(rawjson)
        return data

    def GetCharacter(self, id = "", cclass = 0):#Titan: 0 Hunter: 1 Warlock: 2 Unknown: 3
        res = self.GetProfile(id)
        membershipType=res['Response']['profile']['data']['userInfo']['membershipType']
        membershipId=res['Response']['profile']['data']['userInfo']['membershipId']
        characterIds=res['Response']['profile']['data']['characterIds']
        for characterId in characterIds:
            response = requests.get(url=self.bungieapi+self.apilist["GetCharacter"].\
                replace("{membershipType}",str(membershipType)).\
                replace("{destinyMembershipId}",membershipId).\
                replace("{characterId}",characterId),\
                headers=self.headers,params={"components":200})
            rawjson = response.content.decode('utf8')
            data=json.loads(rawjson)
            if data['Response']['character']['data']['classType'] == cclass:
                return data
        return data

    def GetRawEloFormTRN(self,id = ""):
        res = self.searchPlayer(id)
        membershipType = res['Response'][0]['membershipType']#int32
        membershipId = res['Response'][0]['membershipId']#string
        #None: 0 TigerXbox: 1 TigerPsn: 2 TigerSteam: 3 TigerBlizzard: 4 TigerStadia: 5 TigerDemon: 10 BungieNext: 254 All: -1
        response = requests.get(url = self.DTRN+self.DTRNapi["eloProfile"].\
            replace("{platform}",self.membershipIntToStr[str(membershipType)]).\
            replace("{destinyMembershipId}",membershipId), params = self.DTRNparams,headers = self.headers)
        rawjson = response.content.decode('utf8')
        data = json.loads(rawjson)
        return data
    
    def getElo(self,id = ""):
        res = self.GetRawEloFormTRN(id)
        playerStats = {}
        for data in res['data']:
            playerStats[data['attributes']['playlist']] = {}
            playerStats[data['attributes']['playlist']]['rank'] = data['stats']['elo']['rank']
            playerStats[data['attributes']['playlist']]['percentile'] = data['stats']['elo']['percentile']
            playerStats[data['attributes']['playlist']]['winrate'] = data['stats']['wl']['displayValue']
            playerStats[data['attributes']['playlist']]['kdratio'] = data['stats']['kd']['displayValue']
            playerStats[data['attributes']['playlist']]['kadratio'] = data['stats']['kad']['displayValue']
            playerStats[data['attributes']['playlist']]['wons'] = data['stats']['activitiesWon']['value']
            playerStats[data['attributes']['playlist']]['losts'] = data['stats']['activitiesLost']['value']
        return playerStats

    
    def GetRaidStats(self, id = ""):#Titan: 0 Hunter: 1 Warlock: 2 Unknown: 3
        res = self.GetProfile(id)
        membershipType=res['Response']['profile']['data']['userInfo']['membershipType']
        membershipId=res['Response']['profile']['data']['userInfo']['membershipId']
        characterIds=res['Response']['profile']['data']['characterIds']
        params={"page":0,"mode":"raid","count":250}
        raidUrl=self.bungieapi+self.apilist["GetActivityHistory"].replace("{membershipType}",str(membershipType)).replace("{destinyMembershipId}",membershipId)
        data=[]
        for characterId in characterIds:
            response = requests.get(url=raidUrl.replace("{characterId}",characterId),\
                headers=self.headers,params=params)
            rawjson = response.content.decode('utf8')
            rawdata = json.loads(rawjson)
            for singledata in rawdata['Response']['activities']:
                data.append(singledata)
        return data

if __name__ == '__main__':
    api = bungieAPI()
    a=input()
    res = api.getElo(a)
    for key in res:
        print(key+":"+str(res[key]))
    '''
    res = api.GetRaidStats(a)
    list = []
    for key in res[0]:
        if key == "period":
            list.append(key)
        else:
            for ikey in res[0][key]:
                list.append(ikey)

    with open("raidData" + ".csv", "w", newline="", encoding='utf-8') as f:
        writer = csv.DictWriter(f, list)
        writer.writeheader()
        for row in res:
            newrow = {}
            for key in row:
                if key == "period":
                    newrow[key]=row[key]
                else:
                    for ikey in row[key]:
                        newrow[ikey]=row[key][ikey]
            writer.writerow(newrow)
    print(res)
    '''
    '''
    res = api.getElo(a)
    for key in res:
        print(key+":"+str(res[key]))
    '''
    #res = api.GetCharacter(a, 1)
    #print(res)

