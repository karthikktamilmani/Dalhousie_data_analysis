#pip install validator-collection

import urllib2
from bs4 import BeautifulSoup
from validator_collection import validators, checkers
import re
import sys
import spacy
import csv
from sets import Set

from selenium import webdriver


programXMLWriter = open("Program.xml","w+")
facultyXMLWriter = open("Faculty.xml","w+")
departmentXMLWriter = open("Department.xml","w+")
staffXMLWriter = open("Staff.xml","w+")
faculty_name_map = []
department_name_map = []
faculty_department_map = {}


quote_page = 'https://www.dal.ca/academics/programs.html'
sp = spacy.load('en_core_web_sm')

page = urllib2.urlopen(quote_page)

soup= BeautifulSoup(page,'html.parser')

atags=soup.find_all('a')


#tags = soup.find('a', string = 'Academics')
#atags=tags.attrs['href']

def cleanName(name_value):
    #for iter in name_value:
    try:

        start_index=re.search("([^a-zA-Z ])",name_value).start()
        cleanedName=name_value[:start_index]
        sen = sp(unicode(cleanedName, "utf-8"))
        spaceIter=3;
        newCleanedName=cleanedName
        if len(cleanedName.split(' ')) > 3:
            for word in sen[3:]:
                #print(word.text + ", " + word.pos_)
                if re.match("VERB|ADP",word.pos_):
                    break
                spaceIter=spaceIter+1
            splitName=cleanedName.split(' ')
            newCleanedName=''
            for dummyNameIter in range(0,spaceIter):
                newCleanedName=newCleanedName+splitName[dummyNameIter]+" "
    except:
        newCleanedName=name_value
    return newCleanedName.strip()


def findPrograms(link_url):
    resp_page=urllib2.urlopen(link_url)
    response=resp_page.read()
    #
    try:
        starting_index=re.search("(Bachelor|Master|Doctorate).*", response).start()
        degree_name=response[starting_index:].splitlines()[0]
        faculty_name=response[re.search("(Faculty of).*", response).start():].splitlines()[0]
        faculty_name = cleanName(faculty_name)
        degree_name = cleanName(degree_name)
        if len(faculty_name.split(' ')) >= 3 and not ( faculty_name in faculty_name_map):
            faculty_name_map.append(faculty_name)
        programType="professional"
        if re.search("undergraduate",link_url):
            programType="undergraduate"
        elif re.search("graduate",link_url):
            programType="graduate"
        department_name=''
        #print cleanName(degree_name) + ","  + faculty_name
        try:
            department_name=response[re.search("(Department of ).*", response).start():].splitlines()[0]
            department_name=cleanName(department_name)
            #print department_name
            if not ( department_name in department_name_map):
                department_name_map.append(department_name)
                faculty_department_map[department_name] = faculty_name_map.index(faculty_name) + 1

        except:
            print "eee"
        getProgramXMLRow(degree_name, programType, department_name, faculty_name )
    except:
        print "error" + link_url

def getFacultyXMLRow(facultyName):
    facultyXMLWriter.write("<Faculty FACULTY_NAME='"+facultyName+"'/>")

def getDepartmentXMLRow(departmentName):
    departmentXMLWriter.write("<Department DEPARTMENT_NAME='"+departmentName+"' FACULTY_ID='"+str(faculty_department_map[departmentName])+"'/>")

def getProgramXMLRow(programName,programType,departmentName,facultyName):
    xmlString = "<Program PROGRAM_NAME='"+programName+"' PROGRAM_TYPE='"+programType+"' "
    if not departmentName == '':
        xmlString = xmlString + "DEPARTMENT_ID='"+ str(department_name_map.index(departmentName) + 1) + "' "
    if not facultyName == '':
        xmlString = xmlString + "FACULTY_ID='"+ str(faculty_name_map.index(facultyName) + 1) + "' "
    xmlString = xmlString + "/>"
    programXMLWriter.write(xmlString);
    #print  "" if departmentName == '' else  "DEPARTMENT_NAME='"+ str(department_name_map.index(departmentName) + 1) + "' " + "" if facultyName == "" else "FACULTY_NAME='" + str(faculty_name_map.index(facultyName) + 1) + "' />"



programs_urlList=[]
dummyIter=0
for each_tag in atags:
    try:
        link_name=each_tag.attrs['href']
        if re.search("undergraduate|graduate|professional",link_name):
            if not checkers.is_url(link_name):
                link_name = "https://www.dal.ca" + link_name
                if not checkers.is_url(link_name):
                    print link_name
            programs_urlList.append(link_name)
            findPrograms(link_name)
    except:
        print "for error" + link_name
    dummyIter=dummyIter+1
    #if dummyIter==100:
    #    break


for i in faculty_name_map:
    getFacultyXMLRow(i)
for j in department_name_map:
    getDepartmentXMLRow(j)



def getStaffXMLRow(firstName, lastName, role, department):
    if department in department_name_map:
    #print firstName + lastName + role + department
        staffXMLWriter.write("<Staff FIRST_NAME='"+ firstName +"' LAST_NAME='"+lastName+"' ROLE='"+ role +"' DEPARTMENT_ID='"+ str(department_name_map.index(department) + 1)+"' />")
    #+ str(department_name_map.index(department) + 1)+
    #

driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver')

#dummy = driver.find_element_by_link_text("100")

#print driver.find_element_by_id("skipContent")

#print driver.getPageSource();

def getFacultName(driver):
    driver.find_element_by_xpath('//li[@aria-label="Display 100 results per page"]').click()

    professor_name = driver.find_elements_by_xpath('//a[@class="CoveoResultLink"][@aria-level="2"]')

    #print driver.find_element_by_tag_name('html').get_attribute('innerHTML')
    driver.implicitly_wait(150)
    #print driver.find_element_by_tag_name('html').get_attribute('innerHTML')
    soup= BeautifulSoup(driver.find_element_by_tag_name('html').get_attribute('innerHTML'),'html.parser')

    professor_name = soup.find_all('a', attrs={ 'class' : "CoveoResultLink",  'aria-level':'2'})

    #print professor_name

    for a in professor_name:
        try:
            professorFull = a.text
            last_name = professorFull.split(',')[0]
            last_name = last_name.encode('ascii', 'ignore').strip()
            first_name = professorFull.split(',')[1]
            first_name = first_name.split(' ')[0]
            first_name = first_name.encode('ascii', 'ignore').strip()
            print "b"
            role = a.findNext('br').findNext('span').text
            role = role.encode('ascii', 'ignore').strip()
            print "v"
            staff_dept = a.findNext('div').findNext('a').text
            staff_dept = staff_dept.encode('ascii', 'ignore').strip()
            print "s"
            #print last_name + first_name + role + staff_dept
            #staff_dept = cleanName(staff_dept)
            getStaffXMLRow(first_name, last_name, role , staff_dept)
        except:
            print sys.exc_info()[0]
    driver.implicitly_wait(150)
#



for listiter in ["https://www.dal.ca/faculty/agriculture/animal-science-aquaculture/faculty-staff/our-faculty.html","https://www.dal.ca/faculty/agriculture/business-and-social-sciences/faculty-staff/our-faculty.html","https://www.dal.ca/faculty/agriculture/engineering/faculty-staff/our-faculty.html","https://www.dal.ca/faculty/agriculture/plant-food-env/faculty-staff/our-faculty.html","https://www.dal.ca/faculty/architecture-planning/faculty-staff.html","https://www.dal.ca/faculty/engineering/faculty_staff.html","https://www.dal.ca/faculty/law/faculty-staff/our-faculty.html"] :
    driver.implicitly_wait(150)
    driver.get(listiter)

    driver.implicitly_wait(150)

    getFacultName(driver)


programXMLWriter.close()
facultyXMLWriter.close()
departmentXMLWriter.close()
staffXMLWriter.close();
#print faculty_department_map
"""

    #except IOError as e:
    #    print "I/O error({0}): {1}".format(e.errno, e.strerror)
    #except ValueError:
    #    print "Could not convert data to an integer."
    #except:
        #print "Unexpected error:", sys.exc_info()[0]

#People -> Faculty/ Staff


#for word in sen:
#     print(word.text + ", " + word.pos_)
#for entity in sen.ents:
#    print(entity.text + ' - ' + entity.label_ + ' - ' + str(spacy.explain(entity.label_)))

https://www.dal.ca/faculty/agriculture/animal-science-aquaculture/faculty-staff/our-faculty.html
https://www.dal.ca/faculty/agriculture/business-and-social-sciences/faculty-staff/our-faculty.html
https://www.dal.ca/faculty/agriculture/engineering/faculty-staff/our-faculty.html
https://www.dal.ca/faculty/agriculture/plant-food-env/faculty-staff/our-faculty.html
https://www.dal.ca/faculty/architecture-planning/faculty-staff.html
https://www.dal.ca/faculty/engineering/faculty_staff.html
https://www.dal.ca/faculty/law/faculty-staff/our-faculty.html
diff click event but same format
https://www.dal.ca/faculty/health/health-humanperformance/faculty-staff.html
https://www.dal.ca/faculty/management/faculty-staff.html



Computer Science, Arts and Social Sciences(same faculty format but diff traversal) -> diff formats
Dentistry, Medicine -> not available
Science -> to be analyzed


with selenium library -> web drivers, it is possible to trigger onClick events

https://dev.mysql.com/doc/refman/5.5/en/load-xml.html

https://www.vertabelo.com/blog/chen-erd-notation/

I've considered SIN number as the primary key for Staff, but since the data is not available, it cannot be resolved, hence using the weak attribute NAME
add IS_ACTIVE and time dependent datas
take building data, course data, faculty, exams
separate genres from google play csv

"""
