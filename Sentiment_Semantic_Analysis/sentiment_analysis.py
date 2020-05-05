import tweepy
import re
import spacy
import sys
import enchant
from langdetect import detect
import pandas as pd
import json
from bson import json_util
from pymongo import MongoClient

dictionary = enchant.Dict("en_US")

client = MongoClient(port=27017)
db = client['tweetDB']
tweetDataCursor = db.tweetData.find({ 'source' : { '$exists' : False } } , {"text":1})
resultObject = json.loads(json_util.dumps(tweetDataCursor))
#
tweet_list=[]
for each_item in resultObject:
    tweet_list.append(each_item["text"])

def readFromFile(fileName):
    fileObj = open(fileName,"r")
    contentList = []
    if fileObj.mode == "r":
        contents = fileObj.readlines()
        for content in contents:
            content = re.sub("\n", '', content)
            contentList.append(content)
    return contentList

def writeToObjMap(objMap,value):
    iterValue = objMap.get(value,0) + 1
    objMap[value] = iterValue

#
positiveDataContents = readFromFile("positive-words.txt")
negativeDataContents = readFromFile("negative-words.txt")
negationDataContents = readFromFile("negation-words.txt")
positiveDataMap={}
negativeDataMap={}
tweetVsSentimentMap={}
wordsAvailableList=[]
#
#print(positiveDataContents)
#print(negativeDataContents)
#
for tweet in tweet_list:
    processedtextVal = tweet
    try:
        if not(detect(processedtextVal) == 'en'):
            print(processedtextVal)
            continue
    except:
        continue
    is_negation=False
    each_negation_count=0
    numberOfPositive=0
    numberOfNegative = 0
    for each_item in processedtextVal.split(" "):
        if each_item in negationDataContents:
            is_negation=True
            each_negation_count=0
        elif each_item in positiveDataContents:
            if is_negation == True:
                numberOfNegative = numberOfNegative + 1
            else:
                numberOfPositive = numberOfPositive + 1
            writeToObjMap(positiveDataMap, each_item)
            is_negation=False
            wordsAvailableList.append(each_item)
        elif each_item in negativeDataContents:
            if is_negation == True:
                numberOfPositive = numberOfPositive + 1
            else:
                numberOfNegative = numberOfNegative + 1
            writeToObjMap(negativeDataMap, each_item)
            is_negation=False
            wordsAvailableList.append(each_item)
        if is_negation == True and each_negation_count > 2:
            is_negation=False
        each_negation_count = each_negation_count + 1
    sentiment='Neutral'
    if numberOfPositive > numberOfNegative:
        sentiment='Positive'
    elif numberOfPositive < numberOfNegative:
        sentiment = 'Negative'
    tweetVsSentimentMap[processedtextVal]=sentiment

print("done")
print(positiveDataMap)
print(negativeDataMap)
print(tweetVsSentimentMap)
(pd.DataFrame.from_dict(data=tweetVsSentimentMap, orient='index')
   .to_csv('sentiment_file.csv', header=False))
words_csv = { "words ": wordsAvailableList }
df = pd.DataFrame(data={"col1": wordsAvailableList})
df.to_csv("wordsAvailable.csv", sep=',',index=False)

# #coding=utf-8
# def removeHashTagsAndUrls(text,entitiesObj):
#     #check if hashtag, user and urls are present
#     #print(text)
#     text = text.lower()
#     try:
#         tags_to_be_removed = ["urls","user_mentions","hashtags"]#"symbols",
#         if entitiesObj is not None:
#             #text = give_emoji_free_text(text)
#             for tags in tags_to_be_removed:
#                 arrayObject=entitiesObj[tags]
#                 for entityObj in arrayObject:
#                     replacedText=""
#                     if tags == "hashtags":
#                         removedText = "#" + entityObj["text"]
#                     elif tags == "urls":
#                         removedText = entityObj["url"]
#                     elif tags == "user_mentions":
#                         removedText = "@" + entityObj["screen_name"]
#                     removedText = removedText.lower()
#                     #print(removedText + "removed from text:"+text)
#                     text=re.sub(removedText, '', text)
#         #text = cleanTextData(text)
#         #print(text)
#         text = re.sub(" -PRON-", "", text)
#         text = re.sub(" 's", "", text)
#         text = re.sub(" 't", "t", text)
#         text = re.sub("\W+", " ", text)
#         #print(text)
#     except:
#         print(sys.exc_info()[0])
#     return text
#

# def readFromFile(fileName):
#     fileObj = open(fileName,"r")
#     contentList = []
#     if fileObj.mode == "r":
#         contents = fileObj.readlines()
#         for content in contents:
#             content = re.sub("\n", '', content)
#             contentList.append(content)
#     return contentList
#
# def writeToObjMap(objMap,value):
#     iterValue = objMap.get(value,0) + 1
#     objMap[value] = iterValue
#
# auth = tweepy.OAuthHandler("wKplKGfRQmwXha5Ep5LTWwvFq","7q4fSufnv2NRCRvELJnmzLhEELDXnS3IWc8h7enigKVKx7xyYw")
# auth.set_access_token("825235838-vcNlF5BILsPDwZT4oxgbCDCcA15kRLRKoFAthZXI","VBh7P9kJFYOpDuhIdigwQKV0kFbHoc4nZXx87hQMfGVVU")
#
# api = tweepy.API(auth, wait_on_rate_limit=True)
# #
# sp = spacy.load('en_core_web_sm')
# tweet_list=[]
# #
# positiveDataContents = readFromFile("positive-words.txt")
# negativeDataContents = readFromFile("negative-words.txt")
# negationDataContents = readFromFile("negation-words.txt")
# positiveDataMap={}
# negativeDataMap={}
# tweetVsSentimentMap={}
# #
# #print(positiveDataContents)
# #print(negativeDataContents)
# #
# searchable_list=["Canada","University","Dalhousie University","Halifax","Canada Education"]
# for search_item in searchable_list:
#     #
#     for tweet in tweepy.Cursor(api.search,q=search_item).items(500):
#         result_json=tweet._json
#         #print(result_json['text'])
#         textVal = result_json["text"]
#         entitiesObj = result_json["entities"]
#         processedtextVal = removeHashTagsAndUrls(textVal,entitiesObj)
#         processedtextVal = processedtextVal.lstrip(" ")
#         if not(detect(processedtextVal) == 'en'):
#             print(processedtextVal)
#             continue
#         is_negation=False
#         each_negation_count=0
#         numberOfPositive=0
#         numberOfNegative = 0
#         for each_item in processedtextVal.split(" "):
#             if each_item in negationDataContents:
#                 is_negation=True
#                 each_negation_count=0
#             elif each_item in positiveDataContents:
#                 if is_negation == True:
#                     numberOfNegative = numberOfNegative + 1
#                 else:
#                     numberOfPositive = numberOfPositive + 1
#                 writeToObjMap(positiveDataMap, each_item)
#                 is_negation=False
#             elif each_item in negativeDataContents:
#                 if is_negation == True:
#                     numberOfPositive = numberOfPositive + 1
#                 else:
#                     numberOfNegative = numberOfNegative + 1
#                 writeToObjMap(negativeDataMap, each_item)
#                 is_negation=False
#             if is_negation == True and each_negation_count > 2:
#                 is_negation=False
#             each_negation_count = each_negation_count + 1
#         # tweet_value = {}
#         # #print(processedtextVal)
#         # tweet_value["text"] = processedtextVal
#         # tweet_value["time"] = result_json["created_at"]
#         # tweet_value["author"] = result_json["user"]["screen_name"]
#         # tweet_list.append(tweet_value)
#         sentiment='Neutral'
#         if numberOfPositive > numberOfNegative:
#             sentiment='Positive'
#         elif numberOfPositive < numberOfNegative:
#             sentiment = 'Negative'
#         tweetVsSentimentMap[result_json["text"]]=sentiment
#
# print("done")
# print(positiveDataMap)
# print(negativeDataMap)
# print(tweetVsSentimentMap)
# (pd.DataFrame.from_dict(data=tweetVsSentimentMap, orient='index')
#    .to_csv('sentiment_file.csv', header=False))
# f = open("sentiment_file.txt","w")
# f.write( str(tweetVsSentimentMap) )
# f.close()
#str(tweetVsSentimentMap).saveAsTextFile("sentiment_file")
