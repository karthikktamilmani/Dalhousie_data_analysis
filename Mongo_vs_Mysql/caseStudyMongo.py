import re
import sys
import spacy
import csv
from sets import Set
import simplejson
from pymongo import MongoClient

#value contains empty, so make that null
def writeRowObject(writerObject,rowObject):
    writerObject.writerow(rowObject)

with open('cleanedCaseStudy.csv', 'rb') as csv_file, open('canada.csv', 'wb') as canada_file , open('newfoundland.csv', 'wb') as newfoundland_file, open('princeedward.csv', 'wb') as princeedward_file, open('novascotia.csv', 'wb') as novascotia_file, open('newbrunswick.csv', 'wb') as newbrunswick_file, open('quebec.csv', 'wb') as quebec_file, open('ontario.csv', 'wb') as ontario_file, open('manitoba.csv', 'wb') as manitoba_file, open('saskatchewan.csv', 'wb') as saskatchewan_file, open('alberta.csv', 'wb') as alberta_file, open('british.csv', 'wb') as british_file, open('yukon.csv', 'wb') as yukon_file, open('nunavut.csv', 'wb') as nunavut_file, open('northwest.csv', 'wb') as northwest_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    canada_writer = csv.writer(canada_file , delimiter=',')
    newfoundland_writer = csv.writer(newfoundland_file , delimiter=',')
    princeedward_writer = csv.writer(princeedward_file , delimiter=',')
    novascotia_writer = csv.writer(novascotia_file , delimiter=',')
    newbrunswick_writer = csv.writer(newbrunswick_file , delimiter=',')
    quebec_writer = csv.writer(quebec_file , delimiter=',')
    ontario_writer = csv.writer(ontario_file , delimiter=',')
    manitoba_writer = csv.writer(manitoba_file , delimiter=',')
    saskatchewan_writer = csv.writer(saskatchewan_file , delimiter=',')
    alberta_writer = csv.writer(alberta_file , delimiter=',')
    british_writer = csv.writer(british_file , delimiter=',')
    yukon_writer = csv.writer(yukon_file , delimiter=',')
    nunavut_writer = csv.writer(nunavut_file , delimiter=',')
    northwest_writer = csv.writer(northwest_file , delimiter=',')
    writer_geo_map = {
        "Canada" : canada_writer,
        "Newfoundland and Labrador" : newfoundland_writer,
        "Prince Edward Island" : princeedward_writer,
        "Nova Scotia" : novascotia_writer,
        "New Brunswick" : newbrunswick_writer,
        "Quebec" : quebec_writer,
        "Ontario" : ontario_writer,
        "Manitoba" : manitoba_writer,
        "Saskatchewan" : saskatchewan_writer,
        "Alberta" : alberta_writer,
        "British Columbia" : british_writer,
        "Yukon" : yukon_writer,
        "Nunavut" : nunavut_writer,
        "Northwest Territories" : northwest_writer,
    }

    line_count = 0
    #cleanedFile_writer.writerow(next(csv_reader))
    #prevRow = next(csv_reader)
    #cleanRow(prevRow)
    row=next(csv_reader)
    #write this in all the files
    #
    del row[1]
    for objIter in writer_geo_map:
        writeRowObject(writer_geo_map[objIter],row)
    #write object into csv file
    for row in csv_reader:
        try:
            #parse the row
            geolocation=row[1].strip()
            del row[1]
            #
            writeRowObject(writer_geo_map[geolocation],row)
        except:
            print("Unexpected error:", sys.exc_info()[0])
        '''
        line_count = line_count+1
        if line_count == 5000:
            break
        '''

with open('canada.csv', 'rb') as canada_file , open('newfoundland.csv', 'rb') as newfoundland_file, open('princeedward.csv', 'rb') as princeedward_file, open('novascotia.csv', 'rb') as novascotia_file, open('newbrunswick.csv', 'rb') as newbrunswick_file, open('quebec.csv', 'rb') as quebec_file, open('ontario.csv', 'rb') as ontario_file, open('manitoba.csv', 'rb') as manitoba_file, open('saskatchewan.csv', 'rb') as saskatchewan_file, open('alberta.csv', 'rb') as alberta_file, open('british.csv', 'rb') as british_file, open('yukon.csv', 'rb') as yukon_file, open('nunavut.csv', 'rb') as nunavut_file, open('northwest.csv', 'rb') as northwest_file, open('resultObj.txt','w+') as result_file, open('csv_result_obj.csv','w+') as csv_result_file:
    canada_reader = csv.reader(canada_file, delimiter=',')
    newfoundland_reader = csv.reader(newfoundland_file, delimiter=',')
    princeedward_reader = csv.reader(princeedward_file, delimiter=',')
    novascotia_reader = csv.reader(novascotia_file, delimiter=',')
    newbrunswick_reader = csv.reader(newbrunswick_file, delimiter=',')
    quebec_reader = csv.reader(quebec_file, delimiter=',')
    ontario_reader = csv.reader(ontario_file, delimiter=',')
    manitoba_reader = csv.reader(manitoba_file, delimiter=',')
    saskatchewan_reader = csv.reader(saskatchewan_file, delimiter=',')
    alberta_reader = csv.reader(alberta_file, delimiter=',')
    british_reader = csv.reader(british_file, delimiter=',')
    yukon_reader = csv.reader(yukon_file, delimiter=',')
    nunavut_reader = csv.reader(nunavut_file, delimiter=',')
    northwest_reader = csv.reader(northwest_file, delimiter=',')

    csv_result_writer = csv.writer(csv_result_file,delimiter=",")

    
    reader_geo_map = {
        "Canada": canada_reader,
        "Newfoundland and Labrador": newfoundland_reader,
        "Prince Edward Island": princeedward_reader,
        "Nova Scotia": novascotia_reader,
        "New Brunswick": newbrunswick_reader,
        "Quebec": quebec_reader,
        "Ontario": ontario_reader,
        "Manitoba": manitoba_reader,
        "Saskatchewan": saskatchewan_reader,
        "Alberta": alberta_reader,
        "British Columbia": british_reader,
        "Yukon": yukon_reader,
        "Nunavut": nunavut_reader,
        "Northwest Territories": northwest_reader,
    }

    #
    writeRowObject(csv_result_writer,['location_id','country_vacancy'])
    entire_list = []
    for objIter in reader_geo_map:
        objectReader = reader_geo_map[objIter]
        #
        nameRow=next(objectReader)
        #break
        #nameRow=['aa','b']
        #
        country_object={}
        country_object["location_id"]=objIter
        newRowObject=[]
        newRowObject.append(objIter)
        stat_list=[]
        numberOfRows=0
        for row in objectReader:
            #construct stat object
            stat={}
            rowIter=0
            while rowIter < len(row):
                stat[nameRow[rowIter]]=row[rowIter]
                rowIter=rowIter+1

            stat_list.append(stat)
            numberOfRows=numberOfRows+1
        country_object["country_vacancy"]=stat_list
        newRowObject.append(stat_list)
        writeRowObject(csv_result_writer, newRowObject)
        #result_file.write(country_object)
        entire_list.append(country_object)
    #print(entire_list)
    print("done")

    client = MongoClient()
    db = client['mytest']
    collection = db.dbWithoutRDBMSStyle
    collection.insert(entire_list)
    #simplejson.dump(entire_list,result_file)
    #result_file.write(entire_list)


