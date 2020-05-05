from pymongo import MongoClient
import json
from bson import json_util


client = MongoClient('mongodb://ian:secretPassword@3.19.213.209/cool_db')
db = client['cool_db']
tweetDataCursor = db.tweetData.find({} , {"text":1})
resultObject = json.loads(json_util.dumps(tweetDataCursor))
#
newString=""
for each_item in resultObject:
    newString = newString + each_item["text"] + " "


doubleWordNewList=[]
prev=""
for each_item in newString.split(" "):
    doubleWordNewList.append(prev+" "+each_item)
    prev=each_item



singleWordNewList=[]
for each_item in newString.split(" "):
    singleWordNewList.append(each_item)


doubleWords = sc.parallelize(doubleWordNewList).flatMap(lambda line: line.split("\W+"))
singleWords = sc.parallelize(singleWordNewList).flatMap(lambda line: line.split("\W+"))
doubleWordCounts = doubleWords.map(lambda word: (word, 1)).reduceByKey(lambda a, b: a + b)
singleWordCounts = singleWords.map(lambda word: (word, 1)).reduceByKey(lambda a, b: a + b)
#
wordList=["education", "canada", "university", "dalhousie", "expensive", "faculty", "graduate"]
doubleWordList=["good school", "bad school", "poor school", "computer science"]
#
for each_singleWord in wordList:
    print(each_singleWord + "-->" + str(singleWordCounts.lookup(each_singleWord)))

for each_DoubleWord in doubleWordList:
    print(each_DoubleWord + "-->" + str(doubleWordCounts.lookup(each_DoubleWord)))



singleWordCounts.saveAsTextFile("singlecountOutput")
doubleWordCounts.saveAsTextFile("doublecountOutput")
