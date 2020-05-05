# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse, JsonResponse
import mysql.connector
from pymongo import MongoClient
import json
from django.template import loader
import csv
from bson import json_util
from datetime import datetime


client = MongoClient('localhost', 27017)
db = client['mytest']
cnx = mysql.connector.connect(user='root', database='mytest')
cursor = cnx.cursor()

def index(request):
    geolocation=request.GET.get("location",'')
    dbtype=request.GET.get('dbtype','')
    location_object = []
    resultObject={}
    if geolocation == '':
        with open('/home/karthi-4004/Case_Study/geolocation.csv', 'r') as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            for each_row in csv_reader:
                if each_row[0] != "Canada" and each_row[0] != "Northwest Territories":
                    location_object.append(each_row[0])
        newObject = { "locations" : location_object }
        return JsonResponse(newObject)
        #return HttpResponse(location_object)
        #send the geolocations available in json format and load it in the html
    elif dbtype != '':
        beforeExecution = datetime.now()
        if dbtype == 'mongo':
            if geolocation in ['Newfoundland and Labrador', 'Prince Edward Island', 'Nova Scotia', 'New Brunswick','Quebec', 'Ontario']:
                #beforeExecution = datetime.now()
                contacts = db.dbWithoutRDBMSStyle
                contacts_post = contacts.find({ "location_id": geolocation })
                #afterExecution = datetime.now()
                resultObject = json.loads(json_util.dumps(contacts_post))
            else:
                # beforeExecution = datetime.now()
                contacts = db.dbWithRDBMSStyle
                contacts_post = contacts.find({"LOCATION_ID": geolocation})
                # afterExecution = datetime.now()
                resultObject = json.loads(json_util.dumps(contacts_post))
                '''
                query = ("select * from Jobvacancy inner join Geolocation on Geolocation.LOCATION_ID = Jobvacancy.LOCATION_ID and GEO_LOCATION = '" + geolocation + "'")
                # beforeExecution = datetime.now()
                cursor.execute(query)
                # afterExecution = datetime.now()
                resultObject = json.loads(json_util.dumps(cursor))
                
        else:
            if dbtype == 'mongo':
                #beforeExecution = datetime.now()
                contacts = db.dbWithRDBMSStyle
                contacts_post = contacts.find({"LOCATION_ID": geolocation})
                #afterExecution = datetime.now()
                resultObject = json.loads(json_util.dumps(contacts_post))
                '''
        else:
            query = ("select * from LocationJobVacancy where LOCATION_ID = '" + geolocation + "'")
            # beforeExecution = datetime.now()
            cursor.execute(query)
            # afterExecution = datetime.now()
            resultObject = json.loads(json_util.dumps(cursor))
        afterExecution = datetime.now()
    response_time=afterExecution - beforeExecution
    response_data = {"response_data": resultObject, "millis": response_time.microseconds / 1000.0 , "time_taken" : str(beforeExecution)+str(afterExecution)}
    return JsonResponse(response_data)

def home(request):
    template = loader.get_template('index.html')
    context = {
    }
    return HttpResponse(template.render(context, request))