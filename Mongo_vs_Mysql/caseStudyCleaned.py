import re
import sys
import spacy
import csv
from sets import Set



geolocation_list = []
uom_map = {}
scalar_map = {}
#value contains empty, so make that null

def writeRowObject(writerObject,rowObject):
    writerObject.writerow(rowObject)

with open('14100224.csv', 'r') as csv_file, open('cleanedCaseStudy.csv', 'wb') as cleanedFile:
    csv_reader = csv.reader(csv_file, delimiter=',')
    cleanedFile_writer = csv.writer(cleanedFile , delimiter=',')
    line_count = 0
    #cleanedFile_writer.writerow(next(csv_reader))
    #prevRow = next(csv_reader)
    #cleanRow(prevRow)
    row=next(csv_reader)
    del row[13]
    del row[13]
    row[0] = "REF_DATE"
    row[1] = "LOCATION_ID"
    row[3] = "JOB_VACANCY_STAT"
    row[4] = "NAICS"
    writeRowObject(cleanedFile_writer,row)
    #
    #write object into csv file
    for row in csv_reader:
        try:
            #parse the row
            #
            if row[11] == "" or row[11].strip() == "":
                row[11] = None
            #
            del row[13]
            del row[13]
            writeRowObject(cleanedFile_writer,row)
        except:
            print("Unexpected error:", sys.exc_info()[0])
