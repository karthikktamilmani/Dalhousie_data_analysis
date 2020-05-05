import tweepy
from bson import json_util
import json
import emoji
import re
from numpy import unicode
from pymongo import MongoClient
from newsapi import NewsApiClient
import spacy
import urllib.request
from bs4 import BeautifulSoup
import sys

#coding=utf-8

def give_emoji_free_text(text):
    #print(emoji.emoji_count(text))
    new_text = re.sub(emoji.get_emoji_regexp(), r"", text)
    return new_text


def removeHashTagsAndUrls(text,entitiesObj):
    #check if hashtag, user and urls are present
    #print(text)
    text = text.lower()
    try:
        tags_to_be_removed = ["urls","user_mentions","hashtags"]#"symbols",
        if entitiesObj is not None:
            #text = give_emoji_free_text(text)
            for tags in tags_to_be_removed:
                arrayObject=entitiesObj[tags]
                for entityObj in arrayObject:
                    replacedText=""
                    if tags == "hashtags":
                        removedText = "#" + entityObj["text"]
                    elif tags == "urls":
                        removedText = entityObj["url"]
                    elif tags == "user_mentions":
                        removedText = "@" + entityObj["screen_name"]
                    removedText = removedText.lower()
                    text=re.sub(removedText, '', text)
        #text = cleanTextData(text)
        #print(text)
        text = re.sub(" -PRON-", "", text)
        text = re.sub(" 's", "", text)
        text = re.sub(" 't", "t", text)
        text = re.sub("\W+", " ", text)
        #print(text)
    except:
        print(sys.exc_info()[0])
    return text

def cleanTextData(text):
    spacyText = sp(text)
    return " ".join([token.lemma_ for token in spacyText])

def getOriginalText(text):
    returnObj = {}
    try:
        searchObj = re.search("\[\+", text)
        if searchObj is not None:
            start_index = searchObj.start()
            end_index = searchObj.end()
            returnObj["text"] =text[:start_index-2]
            number = 0
            iter=end_index
            while iter < len(text):
                if text[iter].isdigit():
                    number = (number * 10) + int(text[iter])
                else:
                    break
                iter=iter+1
            returnObj["extraChars"]=number
    except:
        print(sys.exc_info()[0])
    returnObj["text"] =text
    return returnObj

def getTextFromURL(page_url,text,extraChars):
    try:
        request_page = urllib.request.Request(page_url)
        page = urllib.request.urlopen(request_page)
        soup = BeautifulSoup(page, 'html.parser')
        bodyOfPage = soup.find('body')
        bodyText = bodyOfPage.text
        bodyText = bodyText.replace("  "," ")
        originalLen = len(text)
        newtext = text[:30]
        searchObj = re.search(newtext,bodyText,re.IGNORECASE)
        if searchObj is not None and extraChars is not None:
            start_index = searchObj.start()
            end_index = originalLen+extraChars-2
            textValue = bodyText[start_index:end_index]
            stop_index = bodyText.find(".",end_index)
            textValue = textValue + bodyText[end_index:stop_index]
            return textValue
        #print(text)
    except:
        print(sys.exc_info()[0])
    return text

def writeData(tweet_list):
    tweetDataDocument.insert_many(tweet_list)


auth = tweepy.OAuthHandler("wKplKGfRQmwXha5Ep5LTWwvFq","7q4fSufnv2NRCRvELJnmzLhEELDXnS3IWc8h7enigKVKx7xyYw")
auth.set_access_token("825235838-vcNlF5BILsPDwZT4oxgbCDCcA15kRLRKoFAthZXI","VBh7P9kJFYOpDuhIdigwQKV0kFbHoc4nZXx87hQMfGVVU")

api = tweepy.API(auth, wait_on_rate_limit=True)
#
sp = spacy.load('en_core_web_sm')
tweet_list=[]
#
# client = MongoClient('mongodb://ian:secretPassword@3.19.213.209/cool_db')
# db = client['cool_db']
# tweetDataDocument = db.tweetData
#
client = MongoClient(port=27017)
db = client['tweetDB']
tweetDataDocument = db.tweetData
searchable_list=["Canada","University","Dalhousie University","Halifax","Canada Education"]
for search_item in searchable_list:
    newsapi = NewsApiClient(api_key='0e1a8832c2b240e8a16234661e9f4847')
    pageSize=1
    while pageSize < 20:
        try:
            all_articles = newsapi.get_everything(q=search_item,page=pageSize)
            for each_article in all_articles["articles"]:
                try:
                    textVal = each_article["content"]
                    if textVal is not None:
                        #print(textVal)
                        resultObj = getOriginalText(textVal)
                        textVal = resultObj["text"]
                        extraChars=None
                        if 'extraChars' in resultObj.keys():
                            extraChars = resultObj['extraChars']
                        textVal=getTextFromURL(each_article["url"],textVal,extraChars)
                        processedtextVal = removeHashTagsAndUrls(textVal, None)
                        tweet_value = {}
                        tweet_value["text"] = processedtextVal
                        tweet_value["author"] = each_article["author"]
                        tweet_value["time"] = each_article["publishedAt"]
                        tweet_value["source"] = each_article["source"]["name"]
                        tweet_list.append(tweet_value)
                except:
                    print(sys.exc_info()[0])
        except:
            print(sys.exc_info()[0])
            pageSize = 20
        pageSize = pageSize + 1
    #
    #writeData(tweet_list)
    #tweet_list=[]

    # for tweet in tweepy.Cursor(api.search,q=search_item).items(500):
    #     result_json=tweet._json
    #     #print(result_json['text'])
    #     textVal = result_json["text"]
    #     entitiesObj = result_json["entities"]
    #     processedtextVal = removeHashTagsAndUrls(textVal,entitiesObj)
    #     tweet_value = {}
    #     tweet_value["text"] = processedtextVal
    #     tweet_value["time"] = result_json["created_at"]
    #     tweet_value["author"] = result_json["user"]["screen_name"]
    #     tweet_list.append(tweet_value)


writeData(tweet_list)
print("done")