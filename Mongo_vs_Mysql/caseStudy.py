import re
import sys
import spacy
import csv
from sets import Set



geolocation_list = []
uom_map = {}
scalar_map = {}
location_map = {}
#value contains empty, so make that null

def writeRowObject(writerObject,rowObject):
    writerObject.writerow(rowObject)

def writeListObject(writerObject, listObject):
    for listIter in listObject:
        rowObject=[listIter]
        writeRowObject(writerObject,rowObject)

def writeDictObject(writerObject, dictObj):
    for key in dictObj:
        rowObject=[key, dictObj[key]]
        writeRowObject(writerObject,rowObject)

def writeObject(writerObject, objectValue):
    if isinstance(objectValue,list):
        writeListObject(writerObject, objectValue)
    elif isinstance(objectValue,dict):
        writeDictObject(writerObject,objectValue)

with open('cleanedCaseStudy.csv', 'rb') as csv_file, open('geolocation.csv', 'w') as geolocation_file , open('uom_mapping.csv', 'w') as uom_mapping_file, open('baseTable.csv','w') as base_file, open('scalar_mapping.csv','w') as scalar_map_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    geoLocationFile_writer = csv.writer(geolocation_file , delimiter=',')
    uom_mapping_writer = csv.writer(uom_mapping_file, delimiter=',')
    baseFile_writer = csv.writer(base_file, delimiter=',')
    scalar_map_writer = csv.writer(scalar_map_file, delimiter=',')
    line_count = 0
    #cleanedFile_writer.writerow(next(csv_reader))
    #prevRow = next(csv_reader)
    #cleanRow(prevRow)
    row=next(csv_reader)
    '''
    del row[7]
    del row[5]
    '''
    #
    #del row[1]
    writeRowObject(baseFile_writer,row)
    #location="GEO_LOCATION"
    #rowObject=[location]
    #geolocationdummy = row[1].strip()
    #
    #write object into csv file
    for row in csv_reader:
        try:
            #parse the row
            geolocation=row[1].strip()
            location_id=row[2].strip()
            if not (geolocation in geolocation_list):
                geolocation_list.append(geolocation)
            locationIndex=geolocation_list.index(geolocation) + 1

            if not (location_id in location_map):
                location_map[location_id]=geolocation
            row[1]=locationIndex
            #del row[1]
            #
            if row[11] == "" or row[11].strip() == "":
                row[11] = None
            #
            #
            '''
            if not (row[8] in scalar_map):
                scalar_map[row[8]] = row[7]
            del row[7]
            #
            if not (row[6] in uom_map):
                uom_map[row[6]] = row[5]
            del row[5]
            '''
            writeRowObject(baseFile_writer,row)
        except:
            print("Unexpected error:", sys.exc_info()[0])
        '''
        line_count = line_count+1
        if line_count == 5000:
            break
        '''
    #geolocation_list.insert(0,'GEOLOCATION')
    print(geolocation_list)
    print(scalar_map)
    print(uom_map)
    writeObject(geoLocationFile_writer, geolocation_list)
    writeObject(uom_mapping_writer, uom_map)
    writeObject(scalar_map_writer,scalar_map)

