#pip install validator-collection

import urllib2
from bs4 import BeautifulSoup
from validator_collection import validators, checkers
import re
import sys
import spacy
import csv
from sets import Set


def cleanRow(rowObject):

            # remove app name length with more than 50, remove multiple category and consider genres as tags
            # rating(float) and number of reviews (highest number of reviews and corresponding rating is considered)
            # type, price and installs are not cleaned . price has free too which is equivalent to 0

        if not (rowObject[6] == "Paid" or rowObject[6] == "Free"):
            rowObject[6] = ""
        if re.search("([^0-9//.//$])",rowObject[7]):
            rowObject[7] = ""
            if rowObject[7] == "Free":
                rowObject[7] = 0

def writeRowObject(writerObject,rowObject):

        #https://support.google.com/googleplay/android-developer/answer/113469?hl=en - app name length 50
        #https://blog.prioridata.com/the-complete-guide-to-app-store-categories - category single -> can have tags which can help search and listing

    if len(rowObject[0]) < 51 and re.search("([a-zA-Z_])",rowObject[1]) and re.search("([0-9//.])",rowObject[2]):
        writerObject.writerow(rowObject)

with open('googleplaystore', 'rb') as csv_file, open('employee_file.csv', 'wb') as cleanedFile:
    csv_reader = csv.reader(csv_file, delimiter=',')
    cleanedFile_writer = csv.writer(cleanedFile , delimiter=',')
    line_count = 0
    cleanedFile_writer.writerow(next(csv_reader))
    prevRow = next(csv_reader)
    cleanRow(prevRow)
    for row in csv_reader:
        try:
            #parse the row
            cleanRow(row)
            if row[0] == prevRow[0]:
                if row[2] > prevRow[2]:
                    prevRow = row
            else:
                writeRowObject(cleanedFile_writer,prevRow)
                prevRow = row
        except:
            print "Unexpected error:", sys.exc_info()[0]
        #line_count = line_count+1
        #if line_count == 5000:
        #    break
