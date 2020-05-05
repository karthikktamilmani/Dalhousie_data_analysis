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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (1,'Department of Mathematics and Statistics',3),(2,'Department of Business and Social Sciences',4),(3,'Department of Animal Science and Aquaculture',4),(4,'Department of Biochemistry and Molecular Biology',3),(5,'Department of Biology',3),(6,'Department of Chemistry',3),(7,'Department of Classics',2),(8,'Department of English',2),(9,'Department of Earth Sciences',3),(10,'Department of Economics',3),(11,'Department of Plant',4),(12,'Department of European Studies',2),(13,'Department of French',8),(14,'Department of Gender and Women',2),(15,'Department of German',8),(16,'Department of History',2),(17,'Department of Engineering',4),(18,'Department of International Development Studies',2),(19,'Department of Microbiology and Immunology',3),(20,'Department of Psychology and Neuroscience',3),(21,'Department of Oceanography',3),(22,'Department of Philosophy',2),(23,'Department of Physics and Atmospheric Science',3),(24,'Department of Political Science',2),(25,'Department of Health and Human Performance',1),(26,'Department of Russian Studies',2),(27,'Department of Sociology and Social Anthropology',2),(28,'Department of Spanish and Latin American Studies',2),(29,'Department of Community Health and Epidemiology',11),(30,'Department of Medical Neuroscience',11),(31,'Department of Microbiology',13),(32,'Department of Physics',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faculty`
--

LOCK TABLES `Faculty` WRITE;
/*!40000 ALTER TABLE `Faculty` DISABLE KEYS */;
INSERT INTO `Faculty` VALUES (1,'Faculty of Management'),(2,'Faculty of Arts and Social Sciences'),(3,'Faculty of Science'),(4,'Faculty of Agriculture'),(5,'Faculty of Computer Science'),(6,'Faculty of Architecture and Planning'),(7,'Faculty of Engineering'),(8,'Faculty of Arts and Social Science'),(9,'Faculty of Dentistry'),(10,'Faculty of Health'),(11,'Faculty of Medicine'),(12,'Faculty of Medicine and the Faculty'),(13,'Faculty of Graduate Studies'),(14,'Faculty of Dentistry clinics and dental laboratories');
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
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Program`
--

LOCK TABLES `Program` WRITE;
/*!40000 ALTER TABLE `Program` DISABLE KEYS */;
INSERT INTO `Program` VALUES (1,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(2,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(3,'Bachelor of Science',1,3,'undergraduate',NULL,NULL),(4,'Bachelor of Science',2,4,'undergraduate',NULL,NULL),(5,'Bachelor of Science',2,4,'undergraduate',NULL,NULL),(6,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(7,'Bachelor of Applied Computer Science',NULL,5,'undergraduate',NULL,NULL),(8,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(9,'Bachelor of Environmental Design Studies',NULL,6,'professional',NULL,NULL),(10,'Bachelor of Science',4,3,'undergraduate',NULL,NULL),(11,'Bachelor of Science',5,3,'undergraduate',NULL,NULL),(12,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(13,'Bachelor of Science',2,4,'undergraduate',NULL,NULL),(14,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(15,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(16,'Bachelor of Science',6,3,'undergraduate',NULL,NULL),(17,'Bachelor of Arts',NULL,8,'undergraduate',NULL,NULL),(18,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(19,'Bachelor of Arts',7,2,'undergraduate',NULL,NULL),(20,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(21,'Bachelor of Computer Science',NULL,5,'undergraduate',NULL,NULL),(22,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(23,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(24,'Bachelor of Arts',8,2,'undergraduate',NULL,NULL),(25,'Bachelor of Dental Hygiene',NULL,9,'professional',NULL,NULL),(26,'Master of Periodontics',NULL,9,'professional',NULL,NULL),(27,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(28,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(29,'Bachelor of Science',9,3,'undergraduate',NULL,NULL),(30,'Bachelor of Science',10,3,'undergraduate',NULL,NULL),(31,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(32,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(33,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(34,'Bachelor of Arts',8,8,'undergraduate',NULL,NULL),(35,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(36,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(37,'Bachelor of Environmental Design Studies',NULL,6,'undergraduate',NULL,NULL),(38,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(39,'Bachelor of Technology',11,4,'undergraduate',NULL,NULL),(40,'Bachelor of Science',NULL,3,'undergraduate',NULL,NULL),(41,'Bachelor of Science',11,4,'undergraduate',NULL,NULL),(42,'Bachelor of Arts',12,2,'undergraduate',NULL,NULL),(43,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(44,'Bachelor of Arts',13,8,'undergraduate',NULL,NULL),(45,'Bachelor of Arts',14,2,'undergraduate',NULL,NULL),(46,'Bachelor of Arts',15,8,'undergraduate',NULL,NULL),(47,'Bachelor of Science',NULL,10,'undergraduate',NULL,NULL),(48,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(49,'Bachelor of Arts',16,2,'undergraduate',NULL,NULL),(50,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(51,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(52,'Bachelor of Science',17,4,'undergraduate',NULL,NULL),(53,'Bachelor of Science',NULL,3,'undergraduate',NULL,NULL),(54,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(55,'Bachelor of Arts',18,2,'undergraduate',NULL,NULL),(56,'Bachelor of Business Administration',2,4,'undergraduate',NULL,NULL),(57,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(58,'Bachelor of Science',NULL,10,'undergraduate',NULL,NULL),(59,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(60,'Bachelor of Technology',11,4,'undergraduate',NULL,NULL),(61,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(62,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(63,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(64,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(65,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(66,'Bachelor of Science',5,3,'undergraduate',NULL,NULL),(67,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(68,'Bachelor of Science',1,3,'undergraduate',NULL,NULL),(69,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(70,'Bachelor of Science',NULL,3,'undergraduate',NULL,NULL),(71,'Mastery',NULL,11,'professional',NULL,NULL),(72,'Bachelor of Science',19,3,'undergraduate',NULL,NULL),(73,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(74,'Bachelor of Music',NULL,2,'undergraduate',NULL,NULL),(75,'Bachelor of Science',20,3,'undergraduate',NULL,NULL),(76,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(77,'Bachelor of Science',NULL,10,'undergraduate',NULL,NULL),(78,'Bachelor of Science',21,3,'undergraduate',NULL,NULL),(79,'Bachelor of Science',NULL,10,'professional',NULL,NULL),(80,'Bachelor of Arts',22,2,'undergraduate',NULL,NULL),(81,'Bachelor of Science',23,3,'undergraduate',NULL,NULL),(82,'Bachelor of Science',11,4,'undergraduate',NULL,NULL),(83,'Bachelor of Science',11,4,'undergraduate',NULL,NULL),(84,'Bachelor of Arts',24,2,'undergraduate',NULL,NULL),(85,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(86,'Bachelor of Science',20,3,'undergraduate',NULL,NULL),(87,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(88,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(89,'Bachelor of Science Recreation',NULL,10,'undergraduate',NULL,NULL),(90,'Bachelor of Science',25,1,'undergraduate',NULL,NULL),(91,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(92,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(93,'Bachelor of Arts',26,2,'undergraduate',NULL,NULL),(94,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(95,'Bachelor of Technology',2,4,'undergraduate',NULL,NULL),(96,'Bachelor of Social Work',NULL,10,'professional',NULL,NULL),(97,'Bachelor of Arts',27,2,'undergraduate',NULL,NULL),(98,'Bachelor of Arts',28,2,'undergraduate',NULL,NULL),(99,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(100,'Bachelor of Science',1,3,'undergraduate',NULL,NULL),(101,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(102,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(103,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(104,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(105,'Master of Science',NULL,4,'graduate',NULL,NULL),(106,'Master of Architecture',NULL,6,'graduate',NULL,NULL),(107,'Master',4,11,'graduate',NULL,NULL),(108,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(109,'Master of Science',NULL,3,'graduate',NULL,NULL),(110,'Master of Applied Science',NULL,12,'graduate',NULL,NULL),(111,'Master of Science',NULL,1,'graduate',NULL,NULL),(112,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(113,'Master',6,13,'graduate',NULL,NULL),(114,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(115,'Master',NULL,10,'graduate',NULL,NULL),(116,'Master of Science',NULL,10,'graduate',NULL,NULL),(117,'Master',29,11,'graduate',NULL,NULL),(118,'Master of Science',NULL,13,'graduate',NULL,NULL),(119,'Master of Applied Computer Science',NULL,5,'graduate',NULL,NULL),(120,'Master of Science',9,3,'graduate',NULL,NULL),(121,'Master of Arts',NULL,3,'graduate',NULL,NULL),(122,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(123,'Master of Electronic Commerce',NULL,5,'graduate',NULL,NULL),(124,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(125,'Master of Science',NULL,7,'graduate',NULL,NULL),(126,'Master',8,13,'graduate',NULL,NULL),(127,'Master of Engingeering',NULL,7,'graduate',NULL,NULL),(128,'Master of Environmental Studies',NULL,1,'graduate',NULL,NULL),(129,'Master of Science',NULL,7,'graduate',NULL,NULL),(130,'Master of Arts',NULL,2,'graduate',NULL,NULL),(131,'Master of Arts',NULL,2,'graduate',NULL,NULL),(132,'Master',NULL,13,'graduate',NULL,NULL),(133,'Master of Health Informatics',NULL,5,'graduate',NULL,NULL),(134,'Master of Arts',NULL,2,'graduate',NULL,NULL),(135,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(136,'Master of Information Management',NULL,1,'graduate',NULL,NULL),(137,'Master of Arts',18,2,'graduate',NULL,NULL),(138,'Master of Engineering Internetworking program',NULL,7,'graduate',NULL,NULL),(139,'Master of Fine Arts',NULL,13,'graduate',NULL,NULL),(140,'Master of Science Kinesiology',NULL,13,'graduate',NULL,NULL),(141,'Master of Law',NULL,13,'graduate',NULL,NULL),(142,'Master of Information',NULL,1,'graduate',NULL,NULL),(143,'Master of Marine Management',NULL,3,'graduate',NULL,NULL),(144,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(145,'Master of Science',NULL,3,'graduate',NULL,NULL),(146,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(147,'Master',30,11,'graduate',NULL,NULL),(148,'Master of Science',NULL,11,'graduate',NULL,NULL),(149,'Master',31,13,'graduate',NULL,NULL),(150,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(151,'Master',NULL,13,'graduate',NULL,NULL),(152,'Master of Science',NULL,13,'graduate',NULL,NULL),(153,'Master of Nursing',NULL,13,'graduate',NULL,NULL),(154,'Master',NULL,13,'graduate',NULL,NULL),(155,'Master',NULL,13,'graduate',NULL,NULL),(156,'Master of Science',21,3,'graduate',NULL,NULL),(157,'Master of Science',NULL,9,'graduate',NULL,NULL),(158,'Master of Science',NULL,11,'graduate',NULL,NULL),(159,'Master of Periodontics',NULL,9,'graduate',NULL,NULL),(160,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(161,'Master',NULL,13,'graduate',NULL,NULL),(162,'Master of Science',NULL,11,'graduate',NULL,NULL),(163,'Master of Arts',NULL,2,'graduate',NULL,NULL),(164,'Master',32,3,'graduate',NULL,NULL),(165,'Masters level health',NULL,10,'graduate',NULL,NULL),(166,'Master of Planning',NULL,6,'graduate',NULL,NULL),(167,'Master of Arts',NULL,2,'graduate',NULL,NULL),(168,'Master of Science',NULL,14,'graduate',NULL,NULL),(169,'Master of Science',NULL,11,'graduate',NULL,NULL),(170,'Master',20,13,'graduate',NULL,NULL),(171,'Master of Public Administration',NULL,1,'graduate',NULL,NULL),(172,'Master of Public Administration',NULL,1,'graduate',NULL,NULL),(173,'Master of Resource',NULL,1,'graduate',NULL,NULL),(174,'Master',27,13,'graduate',NULL,NULL),(175,'Bachelor of Social Work',NULL,10,'graduate',NULL,NULL),(176,'Master',27,13,'graduate',NULL,NULL),(177,'Master of Science',NULL,3,'graduate',NULL,NULL),(178,'Bachelor of Environmental Design Studies',NULL,6,'professional',NULL,NULL),(179,'Bachelor of Dental Hygiene',NULL,9,'professional',NULL,NULL),(180,'Master of Periodontics',NULL,9,'professional',NULL,NULL),(181,'Mastery',NULL,11,'professional',NULL,NULL),(182,'Bachelor of Science',NULL,10,'professional',NULL,NULL),(183,'Bachelor of Social Work',NULL,10,'professional',NULL,NULL),(184,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(185,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(186,'Bachelor of Science',1,3,'undergraduate',NULL,NULL),(187,'Bachelor of Science',2,4,'undergraduate',NULL,NULL),(188,'Bachelor of Science',2,4,'undergraduate',NULL,NULL),(189,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(190,'Bachelor of Applied Computer Science',NULL,5,'undergraduate',NULL,NULL),(191,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(192,'Bachelor of Environmental Design Studies',NULL,6,'professional',NULL,NULL),(193,'Bachelor of Science',4,3,'undergraduate',NULL,NULL),(194,'Bachelor of Science',5,3,'undergraduate',NULL,NULL),(195,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(196,'Bachelor of Science',2,4,'undergraduate',NULL,NULL),(197,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(198,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(199,'Bachelor of Science',6,3,'undergraduate',NULL,NULL),(200,'Bachelor of Arts',NULL,8,'undergraduate',NULL,NULL),(201,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(202,'Bachelor of Arts',7,2,'undergraduate',NULL,NULL),(203,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(204,'Bachelor of Computer Science',NULL,5,'undergraduate',NULL,NULL),(205,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(206,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(207,'Bachelor of Arts',8,2,'undergraduate',NULL,NULL),(208,'Bachelor of Dental Hygiene',NULL,9,'professional',NULL,NULL),(209,'Master of Periodontics',NULL,9,'professional',NULL,NULL),(210,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(211,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(212,'Bachelor of Science',9,3,'undergraduate',NULL,NULL),(213,'Bachelor of Science',10,3,'undergraduate',NULL,NULL),(214,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(215,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(216,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(217,'Bachelor of Arts',8,8,'undergraduate',NULL,NULL),(218,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(219,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(220,'Bachelor of Environmental Design Studies',NULL,6,'undergraduate',NULL,NULL),(221,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(222,'Bachelor of Technology',11,4,'undergraduate',NULL,NULL),(223,'Bachelor of Science',NULL,3,'undergraduate',NULL,NULL),(224,'Bachelor of Science',11,4,'undergraduate',NULL,NULL),(225,'Bachelor of Arts',12,2,'undergraduate',NULL,NULL),(226,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(227,'Bachelor of Arts',13,8,'undergraduate',NULL,NULL),(228,'Bachelor of Arts',14,2,'undergraduate',NULL,NULL),(229,'Bachelor of Arts',15,8,'undergraduate',NULL,NULL),(230,'Bachelor of Science',NULL,10,'undergraduate',NULL,NULL),(231,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(232,'Bachelor of Arts',16,2,'undergraduate',NULL,NULL),(233,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(234,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(235,'Bachelor of Science',17,4,'undergraduate',NULL,NULL),(236,'Bachelor of Science',NULL,3,'undergraduate',NULL,NULL),(237,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(238,'Bachelor of Arts',18,2,'undergraduate',NULL,NULL),(239,'Bachelor of Business Administration',2,4,'undergraduate',NULL,NULL),(240,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(241,'Bachelor of Science',NULL,10,'undergraduate',NULL,NULL),(242,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(243,'Bachelor of Technology',11,4,'undergraduate',NULL,NULL),(244,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(245,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(246,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(247,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(248,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(249,'Bachelor of Science',5,3,'undergraduate',NULL,NULL),(250,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(251,'Bachelor of Science',1,3,'undergraduate',NULL,NULL),(252,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(253,'Bachelor of Science',NULL,3,'undergraduate',NULL,NULL),(254,'Mastery',NULL,11,'professional',NULL,NULL),(255,'Bachelor of Science',19,3,'undergraduate',NULL,NULL),(256,'Bachelor of Engineering',NULL,7,'undergraduate',NULL,NULL),(257,'Bachelor of Music',NULL,2,'undergraduate',NULL,NULL),(258,'Bachelor of Science',20,3,'undergraduate',NULL,NULL),(259,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(260,'Bachelor of Science',NULL,10,'undergraduate',NULL,NULL),(261,'Bachelor of Science',21,3,'undergraduate',NULL,NULL),(262,'Bachelor of Science',NULL,10,'professional',NULL,NULL),(263,'Bachelor of Arts',22,2,'undergraduate',NULL,NULL),(264,'Bachelor of Science',23,3,'undergraduate',NULL,NULL),(265,'Bachelor of Science',11,4,'undergraduate',NULL,NULL),(266,'Bachelor of Science',11,4,'undergraduate',NULL,NULL),(267,'Bachelor of Arts',24,2,'undergraduate',NULL,NULL),(268,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(269,'Bachelor of Science',20,3,'undergraduate',NULL,NULL),(270,'Bachelor of Management',NULL,1,'undergraduate',NULL,NULL),(271,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(272,'Bachelor of Science Recreation',NULL,10,'undergraduate',NULL,NULL),(273,'Bachelor of Science',25,1,'undergraduate',NULL,NULL),(274,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(275,'Bachelor of Health Science',NULL,10,'undergraduate',NULL,NULL),(276,'Bachelor of Arts',26,2,'undergraduate',NULL,NULL),(277,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(278,'Bachelor of Technology',2,4,'undergraduate',NULL,NULL),(279,'Bachelor of Social Work',NULL,10,'professional',NULL,NULL),(280,'Bachelor of Arts',27,2,'undergraduate',NULL,NULL),(281,'Bachelor of Arts',28,2,'undergraduate',NULL,NULL),(282,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(283,'Bachelor of Science',1,3,'undergraduate',NULL,NULL),(284,'Bachelor of Commerce',NULL,1,'undergraduate',NULL,NULL),(285,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(286,'Bachelor of Arts',NULL,2,'undergraduate',NULL,NULL),(287,'Bachelor of Science',3,4,'undergraduate',NULL,NULL),(288,'Master of Science',NULL,4,'graduate',NULL,NULL),(289,'Master of Architecture',NULL,6,'graduate',NULL,NULL),(290,'Master',4,11,'graduate',NULL,NULL),(291,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(292,'Master of Science',NULL,3,'graduate',NULL,NULL),(293,'Master of Applied Science',NULL,12,'graduate',NULL,NULL),(294,'Master of Science',NULL,1,'graduate',NULL,NULL),(295,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(296,'Master',6,13,'graduate',NULL,NULL),(297,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(298,'Master',NULL,10,'graduate',NULL,NULL),(299,'Master of Science',NULL,10,'graduate',NULL,NULL),(300,'Master',29,11,'graduate',NULL,NULL),(301,'Master of Science',NULL,13,'graduate',NULL,NULL),(302,'Master of Applied Computer Science',NULL,5,'graduate',NULL,NULL),(303,'Master of Science',9,3,'graduate',NULL,NULL),(304,'Master of Arts',NULL,3,'graduate',NULL,NULL),(305,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(306,'Master of Electronic Commerce',NULL,5,'graduate',NULL,NULL),(307,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(308,'Master of Science',NULL,7,'graduate',NULL,NULL),(309,'Master',8,13,'graduate',NULL,NULL),(310,'Master of Engingeering',NULL,7,'graduate',NULL,NULL),(311,'Master of Environmental Studies',NULL,1,'graduate',NULL,NULL),(312,'Master of Science',NULL,7,'graduate',NULL,NULL),(313,'Master of Arts',NULL,2,'graduate',NULL,NULL),(314,'Master of Arts',NULL,2,'graduate',NULL,NULL),(315,'Master',NULL,13,'graduate',NULL,NULL),(316,'Master of Health Informatics',NULL,5,'graduate',NULL,NULL),(317,'Master of Arts',NULL,2,'graduate',NULL,NULL),(318,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(319,'Master of Information Management',NULL,1,'graduate',NULL,NULL),(320,'Master of Arts',18,2,'graduate',NULL,NULL),(321,'Master of Engineering Internetworking program',NULL,7,'graduate',NULL,NULL),(322,'Master of Fine Arts',NULL,13,'graduate',NULL,NULL),(323,'Master of Science Kinesiology',NULL,13,'graduate',NULL,NULL),(324,'Master of Law',NULL,13,'graduate',NULL,NULL),(325,'Master of Information',NULL,1,'graduate',NULL,NULL),(326,'Master of Marine Management',NULL,3,'graduate',NULL,NULL),(327,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(328,'Master of Science',NULL,3,'graduate',NULL,NULL),(329,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(330,'Master',30,11,'graduate',NULL,NULL),(331,'Master of Science',NULL,11,'graduate',NULL,NULL),(332,'Master',31,13,'graduate',NULL,NULL),(333,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(334,'Master',NULL,13,'graduate',NULL,NULL),(335,'Master of Science',NULL,13,'graduate',NULL,NULL),(336,'Master of Nursing',NULL,13,'graduate',NULL,NULL),(337,'Master',NULL,13,'graduate',NULL,NULL),(338,'Master',NULL,13,'graduate',NULL,NULL),(339,'Master of Science',21,3,'graduate',NULL,NULL),(340,'Master of Science',NULL,9,'graduate',NULL,NULL),(341,'Master of Science',NULL,11,'graduate',NULL,NULL),(342,'Master of Periodontics',NULL,9,'graduate',NULL,NULL),(343,'Master of Engineering',NULL,7,'graduate',NULL,NULL),(344,'Master',NULL,13,'graduate',NULL,NULL),(345,'Master of Science',NULL,11,'graduate',NULL,NULL),(346,'Master of Arts',NULL,2,'graduate',NULL,NULL),(347,'Master',32,3,'graduate',NULL,NULL),(348,'Masters level health',NULL,10,'graduate',NULL,NULL),(349,'Master of Planning',NULL,6,'graduate',NULL,NULL),(350,'Master of Arts',NULL,2,'graduate',NULL,NULL),(351,'Master of Science',NULL,14,'graduate',NULL,NULL),(352,'Master of Science',NULL,11,'graduate',NULL,NULL),(353,'Master',20,13,'graduate',NULL,NULL),(354,'Master of Public Administration',NULL,1,'graduate',NULL,NULL),(355,'Master of Public Administration',NULL,1,'graduate',NULL,NULL),(356,'Master of Resource',NULL,1,'graduate',NULL,NULL),(357,'Master',27,13,'graduate',NULL,NULL),(358,'Bachelor of Social Work',NULL,10,'graduate',NULL,NULL),(359,'Master',27,13,'graduate',NULL,NULL),(360,'Master of Science',NULL,3,'graduate',NULL,NULL),(361,'Bachelor of Environmental Design Studies',NULL,6,'professional',NULL,NULL),(362,'Bachelor of Dental Hygiene',NULL,9,'professional',NULL,NULL),(363,'Master of Periodontics',NULL,9,'professional',NULL,NULL),(364,'Mastery',NULL,11,'professional',NULL,NULL),(365,'Bachelor of Science',NULL,10,'professional',NULL,NULL),(366,'Bachelor of Social Work',NULL,10,'professional',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (1,'Dr.Deborah','Adewole',NULL,'Assistant Professor and Industry Research Chair, Poultry',NULL,3,NULL),(2,'Derek','Anderson',NULL,'Adjunct Professor (Retired)',NULL,3,NULL),(3,'David','Barrett',NULL,'Assistant Professor, Animal Physiology',NULL,3,NULL),(4,'Amy','Birchall',NULL,'Instructor - Veterinary Technology Program',NULL,3,NULL),(5,'Dr.Fraser','Clark',NULL,NULL,NULL,3,NULL),(6,'Dr.Stephanie','Collins',NULL,'Assistant Professor, Monogastric Nutrition',NULL,3,NULL),(7,'Dr.Stefanie','Colombo',NULL,'Assistant Professor and Canada Research Chair, Aquaculture Nutrition',NULL,3,NULL),(8,'Jim','Duston',NULL,'Professor, Finfish Aquaculture',NULL,3,NULL),(9,'Hossain','Farid',NULL,'Adjunct Professor (Retired)',NULL,3,NULL),(10,'Gillian','Fraser',NULL,'Senior Instructor and Coordinator, DEM Program',NULL,3,NULL),(11,'AhmadPhD','Al-Mallahi',NULL,'Research Chair and Assistant Professor',NULL,17,NULL),(12,'Tessema','Astatkie',NULL,'Professor, P.Stat.(SSC), P.Stat.(ASA)',NULL,17,NULL),(13,'Young','Chang',NULL,'Assistant Professor',NULL,17,NULL),(14,'TravisPhD','Esau',NULL,'Assistant Professor',NULL,17,NULL),(15,'PeterP.','Havard',NULL,'Department Chair and Associate Professor',NULL,17,NULL),(16,'Quan','He',NULL,'Associate Professor',NULL,17,NULL),(17,'Alex','Martynenko',NULL,'Associate Professor',NULL,17,NULL),(18,'Chris','Nelson',NULL,'Senior Instructor',NULL,17,NULL),(19,'Pat','Nelson',NULL,'Senior Instructor',NULL,17,NULL),(20,'Dr.TriPhD','Nguyen-Quang',NULL,'Associate Professor',NULL,17,NULL),(21,'HaiboPhD','Niu',NULL,'Associate Professor and Graduate Studies Coordinator',NULL,17,NULL),(22,'Gordon','Price',NULL,'Associate Professor (Innovative Waste Management Research Program) and Faculty Graduate Coordinator',NULL,17,NULL),(23,'Scott','Read',NULL,'Senior Instructor',NULL,17,NULL),(24,'JinPhD','Yue',NULL,'Senior Instructor',NULL,17,NULL),(25,'Qamar','Zaman',NULL,'Professor',NULL,17,NULL);
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

-- Dump completed on 2019-09-30  0:02:59
