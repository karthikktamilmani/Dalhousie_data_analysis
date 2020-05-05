import re
from newsapi import NewsApiClient
import urllib.request
from bs4 import BeautifulSoup
import sys
from bson import json_util
import json
import pandas as pd
from pymongo import MongoClient
import math

client = MongoClient(port=27017)
db = client['tweetDB']

tweetDataCursor = db.tweetData.find({ 'source' : { '$exists' : True } } , {"text":1})
resultObject = json.loads(json_util.dumps(tweetDataCursor))
#
newArticleList=[]
for each_item in resultObject:
    newArticleList.append(each_item["text"])

def insertIntoMap(search_var, article, count):
    eachVarMap = frequencyList.get(search_var,[])
    eachVarMap.append({ "article" : article,
                        "total_words" : str(len(article)),
                        "frequency" : str(count),
                        "f/m" : str(count/len(article))
                        })
    frequencyList[search_var]=eachVarMap

totalArticles=len(newArticleList)
documentCountMap={}
highestFrequencyMap={}
highestFrequencyArticles={}
frequencyList={}
for each_article in newArticleList:
    for each_search_var in ["canada","university","dalhousie university","halifax","canada education"]:
        var_count = each_article.count(each_search_var)
        if var_count > 0:
            dummyiter = documentCountMap.get(each_search_var,0)+1
            documentCountMap[each_search_var] = dummyiter
            relativeFreq = var_count / len(each_article)
            #
            if highestFrequencyMap.get(each_search_var,0) < relativeFreq:
                highestFrequencyMap[each_search_var] = relativeFreq
                highestFrequencyArticles[each_search_var] = each_article
            insertIntoMap(each_search_var , each_article, var_count)
            # (pd.DataFrame.from_dict(data=newMap, orient='index')
            #  .to_csv('.csv', header=False))
    #
    #write f/m to file
#
print(documentCountMap)
print(totalArticles)
for key, value in documentCountMap.items():
    documentCountMap[key] = math.log10( totalArticles / value)
# print(highestFrequencyArticles)
print(highestFrequencyMap)
# print(documentCountMap)
#print(frequencyList)
df = pd.DataFrame([x for x in frequencyList["canada"]])
# print(df)
(pd.DataFrame.from_dict(data=documentCountMap, orient='index')
   .to_csv('inverse_df.csv', header=False))
(pd.DataFrame.from_dict(data=highestFrequencyArticles, orient='index')
   .to_csv('highest_freq_article.csv', header=False))
# (pd.DataFrame.from_dict(data=frequencyList, orient='index')
#    .to_csv('article_freq.csv', header=False))
df.to_csv('article_freq.csv', header=False)