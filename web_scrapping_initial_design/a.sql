-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: dalAfterNormalization
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Assets`
--

DROP TABLE IF EXISTS `Assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Assets` (
  `ASSET_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSET_NAME` varchar(250) DEFAULT NULL,
  `COUNT_AVAILABLE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ASSET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assets`
--

LOCK TABLES `Assets` WRITE;
/*!40000 ALTER TABLE `Assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `Assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Book` (
  `ASSET_ID` bigint(20) NOT NULL,
  `AUTHOR_NAME` varchar(250) DEFAULT NULL,
  `PUBLISHER` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ASSET_ID`),
  CONSTRAINT `Book_ibfk_1` FOREIGN KEY (`ASSET_ID`) REFERENCES `Assets` (`ASSET_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Building`
--

DROP TABLE IF EXISTS `Building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Building` (
  `BUILDING_NAME` varchar(250) NOT NULL,
  `WIRELESS` tinyint(1) DEFAULT NULL,
  `STUDY_SPACE` varchar(250) DEFAULT NULL,
  `LOUNGE_AREA` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`BUILDING_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Building`
--

LOCK TABLES `Building` WRITE;
/*!40000 ALTER TABLE `Building` DISABLE KEYS */;
/*!40000 ALTER TABLE `Building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course`
--

DROP TABLE IF EXISTS `Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course` (
  `COURSE_ID` varchar(250) NOT NULL,
  `COURSE_NAME` varchar(250) NOT NULL,
  `TERMS_AVAILABLE` varchar(250) NOT NULL,
  `PROGRAM_NAME` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`COURSE_ID`,`TERMS_AVAILABLE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course`
--

LOCK TABLES `Course` WRITE;
/*!40000 ALTER TABLE `Course` DISABLE KEYS */;
/*!40000 ALTER TABLE `Course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Department` (
  `DEPARTMENT_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DEPARTMENT_NAME` varchar(250) NOT NULL,
  `FACULTY_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`),
  KEY `FACULTY_ID` (`FACULTY_ID`),
  CONSTRAINT `Department_ibfk_1` FOREIGN KEY (`FACULTY_ID`) REFERENCES `Faculty` (`FACULTY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Exams`
--

DROP TABLE IF EXISTS `Exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Exams` (
  `COURSE_ID` varchar(250) NOT NULL,
  `SECTION` int(11) NOT NULL,
  `EXAM_DATE` date NOT NULL,
  `EXAM_TIME` time NOT NULL,
  `LOCATION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COURSE_ID`,`SECTION`,`EXAM_DATE`),
  CONSTRAINT `Exams_ibfk_1` FOREIGN KEY (`COURSE_ID`) REFERENCES `Course` (`COURSE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Exams`
--

LOCK TABLES `Exams` WRITE;
/*!40000 ALTER TABLE `Exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `Exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faculty`
--

DROP TABLE IF EXISTS `Faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Faculty` (
  `FACULTY_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `FACULTY_NAME` varchar(250) NOT NULL,
  PRIMARY KEY (`FACULTY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faculty`
--

LOCK TABLES `Faculty` WRITE;
/*!40000 ALTER TABLE `Faculty` DISABLE KEYS */;
/*!40000 ALTER TABLE `Faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JournalPaper`
--

DROP TABLE IF EXISTS `JournalPaper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `JournalPaper` (
  `ASSET_ID` bigint(20) NOT NULL,
  `CATEGORY` varchar(250) DEFAULT NULL,
  `YEAR_PUBLISHED` int(11) DEFAULT NULL,
  `JOURNAL_TYPE` varchar(250) DEFAULT NULL,
  `AUTHOR_NAME` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ASSET_ID`),
  CONSTRAINT `JournalPaper_ibfk_1` FOREIGN KEY (`ASSET_ID`) REFERENCES `Assets` (`ASSET_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JournalPaper`
--

LOCK TABLES `JournalPaper` WRITE;
/*!40000 ALTER TABLE `JournalPaper` DISABLE KEYS */;
/*!40000 ALTER TABLE `JournalPaper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Program`
--

DROP TABLE IF EXISTS `Program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Program` (
  `PROGRAM_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROGRAM_NAME` varchar(250) NOT NULL,
  `DEPARTMENT_ID` bigint(20) DEFAULT NULL,
  `FACULTY_ID` bigint(20) DEFAULT NULL,
  `PROGRAM_TYPE` varchar(50) NOT NULL,
  `PROGRAM_LENGTH` int(11) DEFAULT NULL,
  `CAMPUS` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`PROGRAM_ID`),
  KEY `DEPARTMENT_ID` (`DEPARTMENT_ID`),
  KEY `FACULTY_ID` (`FACULTY_ID`),
  CONSTRAINT `Program_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `Department` (`DEPARTMENT_ID`) ON DELETE CASCADE,
  CONSTRAINT `Program_ibfk_2` FOREIGN KEY (`FACULTY_ID`) REFERENCES `Faculty` (`FACULTY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Program`
--

LOCK TABLES `Program` WRITE;
/*!40000 ALTER TABLE `Program` DISABLE KEYS */;
/*!40000 ALTER TABLE `Program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Staff` (
  `STAFF_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `FIRST_NAME` varchar(100) DEFAULT NULL,
  `LAST_NAME` varchar(100) DEFAULT NULL,
  `PREFIX` varchar(10) DEFAULT NULL,
  `ROLE` varchar(250) DEFAULT NULL,
  `IS_ACTIVE` tinyint(1) DEFAULT '1',
  `DEPARTMENT_ID` bigint(20) DEFAULT NULL,
  `FACULTY_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`STAFF_ID`),
  KEY `DEPARTMENT_ID` (`DEPARTMENT_ID`),
  KEY `FACULTY_ID` (`FACULTY_ID`),
  CONSTRAINT `Staff_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `Department` (`DEPARTMENT_ID`),
  CONSTRAINT `Staff_ibfk_2` FOREIGN KEY (`FACULTY_ID`) REFERENCES `Faculty` (`FACULTY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StaffVsCourse`
--

DROP TABLE IF EXISTS `StaffVsCourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StaffVsCourse` (
  `STAFF_ID` bigint(20) NOT NULL,
  `COURSE_TAKEN` varchar(250) NOT NULL,
  `TERMS` varchar(250) NOT NULL,
  PRIMARY KEY (`STAFF_ID`,`COURSE_TAKEN`,`TERMS`),
  KEY `fk_StaffVsCourse_2_idx` (`COURSE_TAKEN`,`TERMS`),
  CONSTRAINT `fk_StaffVsCourse_1` FOREIGN KEY (`STAFF_ID`) REFERENCES `Staff` (`STAFF_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_StaffVsCourse_2` FOREIGN KEY (`COURSE_TAKEN`, `TERMS`) REFERENCES `Course` (`COURSE_ID`, `TERMS_AVAILABLE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StaffVsCourse`
--

LOCK TABLES `StaffVsCourse` WRITE;
/*!40000 ALTER TABLE `StaffVsCourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `StaffVsCourse` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-29 23:59:44
