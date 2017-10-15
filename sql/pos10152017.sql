-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: gist_pos
-- ------------------------------------------------------
-- Server version	5.5.57-0ubuntu0.14.04.1

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
-- Table structure for table `cfg_entry`
--

DROP TABLE IF EXISTS `cfg_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfg_entry` (
  `id` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfg_entry`
--

LOCK TABLES `cfg_entry` WRITE;
/*!40000 ALTER TABLE `cfg_entry` DISABLE KEYS */;
INSERT INTO `cfg_entry` VALUES ('gist_sys_area_id','22'),('gist_sys_erp_url','http://erp.purltech.com'),('gist_sys_pos_url','http://pos.purltech.com');
/*!40000 ALTER TABLE `cfg_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cnt_address`
--

DROP TABLE IF EXISTS `cnt_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cnt_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `country` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `street` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DCF4B65A2D5B0234` (`city`),
  KEY `IDX_DCF4B65AA393D2FB` (`state`),
  KEY `IDX_DCF4B65A5373C966` (`country`),
  KEY `IDX_DCF4B65AEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_DCF4B65A2D5B0234` FOREIGN KEY (`city`) REFERENCES `world_location` (`id`),
  CONSTRAINT `FK_DCF4B65A5373C966` FOREIGN KEY (`country`) REFERENCES `world_location` (`id`),
  CONSTRAINT `FK_DCF4B65AA393D2FB` FOREIGN KEY (`state`) REFERENCES `world_location` (`id`),
  CONSTRAINT `FK_DCF4B65AEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cnt_address`
--

LOCK TABLES `cnt_address` WRITE;
/*!40000 ALTER TABLE `cnt_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `cnt_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cnt_contact_person`
--

DROP TABLE IF EXISTS `cnt_contact_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cnt_contact_person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cnt_contact_person`
--

LOCK TABLES `cnt_contact_person` WRITE;
/*!40000 ALTER TABLE `cnt_contact_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `cnt_contact_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cnt_phone`
--

DROP TABLE IF EXISTS `cnt_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cnt_phone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `number` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2114359CEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_2114359CEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cnt_phone`
--

LOCK TABLES `cnt_phone` WRITE;
/*!40000 ALTER TABLE `cnt_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `cnt_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cnt_phone_type`
--

DROP TABLE IF EXISTS `cnt_phone_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cnt_phone_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cnt_phone_type`
--

LOCK TABLES `cnt_phone_type` WRITE;
/*!40000 ALTER TABLE `cnt_phone_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `cnt_phone_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cnt_type`
--

DROP TABLE IF EXISTS `cnt_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cnt_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cnt_type`
--

LOCK TABLES `cnt_type` WRITE;
/*!40000 ALTER TABLE `cnt_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `cnt_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactperson_phone`
--

DROP TABLE IF EXISTS `contactperson_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactperson_phone` (
  `contactperson_id` int(11) NOT NULL,
  `phone_id` int(11) NOT NULL,
  PRIMARY KEY (`contactperson_id`,`phone_id`),
  KEY `IDX_D8688559959E62B0` (`contactperson_id`),
  KEY `IDX_D86885593B7323CB` (`phone_id`),
  CONSTRAINT `FK_D86885593B7323CB` FOREIGN KEY (`phone_id`) REFERENCES `cnt_phone` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D8688559959E62B0` FOREIGN KEY (`contactperson_id`) REFERENCES `cnt_contact_person` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactperson_phone`
--

LOCK TABLES `contactperson_phone` WRITE;
/*!40000 ALTER TABLE `contactperson_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `contactperson_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gist_pos_clock`
--

DROP TABLE IF EXISTS `gist_pos_clock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gist_pos_clock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_clock`
--

LOCK TABLES `gist_pos_clock` WRITE;
/*!40000 ALTER TABLE `gist_pos_clock` DISABLE KEYS */;
INSERT INTO `gist_pos_clock` VALUES (1,'1','2017-09-02','IN'),(2,'1','2017-09-02','OUT'),(3,'1','2017-09-02','IN'),(4,'1','2017-09-02','OUT'),(5,'1','2017-09-03','IN'),(6,'1','2017-09-03','IN'),(7,'1','2017-09-03','OUT'),(8,'1','2017-09-04','IN'),(9,'1','2017-09-04','IN'),(10,'1','2017-09-05','IN'),(11,'1','2017-09-05','OUT'),(12,'1','2017-09-06','IN'),(13,'1','2017-09-06','IN'),(14,'1','2017-09-06','OUT'),(15,'1','2017-09-13','IN'),(16,'1','2017-09-14','IN'),(17,'1','2017-09-14','IN'),(18,'1','2017-09-14','IN'),(19,'1','2017-09-14','IN'),(20,'1','2017-09-15','IN'),(21,'1','2017-09-15','IN'),(22,'1','2017-09-15','IN'),(23,'1','2017-09-15','IN'),(24,'1','2017-09-15','IN'),(25,'1','2017-09-15','IN'),(26,'1','2017-09-16','IN'),(27,'1','2017-09-16','IN'),(28,'1','2017-09-16','IN'),(29,'1','2017-09-17','IN'),(30,'1','2017-09-17','IN'),(31,'1','2017-09-18','IN'),(32,'1','2017-09-18','IN'),(33,'1','2017-09-18','IN'),(34,'1','2017-09-19','IN'),(35,'1','2017-09-19','IN'),(36,'1','2017-09-19','IN'),(37,'1','2017-09-20','IN'),(38,'1','2017-09-21','IN'),(39,'1','2017-09-21','IN'),(40,'1','2017-09-21','IN'),(41,'1','2017-09-21','IN'),(42,'1','2017-09-25','IN'),(43,'1','2017-09-25','IN'),(44,'1','2017-09-27','IN'),(45,'1','2017-09-27','IN'),(46,'7','2017-10-10','IN'),(47,'7','2017-10-12','IN');
/*!40000 ALTER TABLE `gist_pos_clock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gist_pos_customer_info`
--

DROP TABLE IF EXISTS `gist_pos_customer_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gist_pos_customer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `erp_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_id` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_email_address` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marital_status` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_married` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `home_phone` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(245) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E071D681EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E071D681EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_customer_info`
--

LOCK TABLES `gist_pos_customer_info` WRITE;
/*!40000 ALTER TABLE `gist_pos_customer_info` DISABLE KEYS */;
INSERT INTO `gist_pos_customer_info` VALUES (1,NULL,'1','John','000000001','','Doe','jd@sample.com','1234567',NULL,'','','','','','','','','','','','','2017-09-24 07:25:26'),(2,NULL,'2','Jose','000000002','','Rizal','jrizal@ph.com','863459',NULL,'','','','','','','','','','','','','2017-09-24 07:25:26'),(3,NULL,'3','Juan','000000003','','Dela Cruz','jdc@ph.com','30353485',NULL,'','','','','','','','','','','','','2017-09-24 07:25:26'),(4,NULL,'4','Mari','000000004','','San Jose','msj@sample.com','23948',NULL,'','','','','','','','','','','','','2017-09-24 07:25:26'),(5,NULL,'6','Leo','000000006','','Anano','leo@sample.com','32489',NULL,'','','','','','','','','','','','','2017-09-24 07:25:26'),(6,NULL,'9','Jeka','000000009','','Gend','g','097546',NULL,'','','08/28/2017','','08/28/2017','','','','','','','','2017-09-24 07:25:26'),(7,NULL,'11','Francis','000000011','F','Cusy','fc@sample.com','9213234',NULL,'male','married','06/22/2010','346456456','08/28/2017','dfg45345','dfgdfgdfg','Taguig','Metro Manila','Philippines','1631','No comments. ','2017-09-24 07:25:26'),(8,NULL,'12','Lois','000000012','H','Costa','lhc@sample.com','09485783',NULL,'male','single',' ','839234','08-23-2017','Taguig','Makati','Makati','NCR','Philippines','Makati','','2017-09-24 07:25:26'),(9,NULL,'13','Chard','000000013','H','Costa','ch@sample.com','09234839',NULL,'male','single',' ','2923489','06-13-1979','asdada','345ertg','asdfsdf','xc bcvbcvb','jklhjkhjk','345ertg','','2017-09-24 07:25:26'),(10,NULL,'19','Lester','000000019',' ','Giogio',' ',' ',NULL,'male','',' ',' ','06-04-1997',' ',' ',' ',' ',' ',' ','','2017-09-24 07:25:26'),(11,NULL,'20','Test Customer 1','000000020',' ','Demo',' ',' ',NULL,'','',' ',' ',' ',' ',' ',' ',' ',' ',' ','','2017-09-24 07:25:26'),(12,NULL,'21','Leo','000000021',' ','Kes','leo@sample.com','09984823',NULL,'male','single',' ','2344234234','08-16-2017','34 Makati','22 Makati','Makati','NCR','PH','22 Makati','','2017-09-24 07:25:26'),(13,NULL,'22','Nico','000000022',' ','Gab',' ','0938742',NULL,'','married','08-08-2017','342344','08-08-2017',' ',' ','Malabon','NCR',' ',' ','','2017-09-24 07:25:26'),(14,NULL,'23','Rommel','000000023','S','Pascual','qwewqewqqwe','123232132132',NULL,'male','married','12-02-2000','8338959',' ',' ',' ',' ',' ',' ',' ','','2017-09-24 07:25:26'),(15,NULL,'24','John','000000024',' ','Smith','john@smith.com','09171234567',NULL,'male','married','02-14-2010','12345668','02-02-1990','makati',' ',' ',' ',' ',' ','','2017-09-24 07:25:26'),(16,NULL,'25','Johnny','000000025',' ','Fast','john@smith.com','09171234567',NULL,'male','married','02-14-2010','12345668','02-02-1990','makati',' ',' ',' ',' ',' ','','2017-09-24 07:25:26'),(17,NULL,'26','Ashley','000000026','J','Musk','ajm@sample.com','09875504521',NULL,'female','married','09-14-2017','3294049','06-16-1988','34B','42C','Makati','NCR','Philippines','42C','','2017-09-24 07:25:26'),(18,NULL,'27','Leonor','000000027','','Connor',' ',' ',NULL,'female','',' ',' ',' ',' ',' ',' ',' ',' ',' ','sdfsdfs234234234234','2017-09-24 07:25:26'),(19,NULL,'28','Zed','000000028','C','Marco',' ',' ',NULL,'','',' ',' ',' ',' ',' ','Pasig',' ',' ',' ',' ','2017-09-24 07:25:26'),(20,NULL,'29','Max','000000029',' ','Kun','eefde','124536987',NULL,'male','married','03-15-2012','025487','06-25-1983','ghfhf',' ','fgfdghdf',' ','phil',' ',' ','2017-09-24 07:25:26'),(21,NULL,'30','rommel','000000030','s','pascual',' ',' ',NULL,'male','single',' ','8338959',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-24 07:25:26'),(22,NULL,'31','Richard','000000031','undefined','undefined','richard@sample.com','09987653434',NULL,' ','undefined',' ','undefined','undefined','undefined','undefined','undefined','undefined','undefined','1631',' ','2017-09-24 07:25:26'),(23,NULL,'32','Test Customer 2','000000032','','Demo','','',NULL,'male','single',' ','','08-28-2017','',' ','','','','',' ','2017-09-24 07:25:26'),(24,NULL,'33','12','000000033','undefined','undefined','12','sd',NULL,' ','undefined',' ','undefined','undefined','undefined',' ','undefined','undefined','undefined','dd',' ','2017-09-24 07:25:26'),(25,NULL,'34','asd','000000034','undefined','undefined','asd','asd',NULL,' ','undefined',' ','undefined','undefined','undefined',' ','undefined','undefined','undefined','asd',' ','2017-09-24 07:25:26'),(26,NULL,'35','dd','000000035','undefined','undefined','dd','dd',NULL,' ','undefined',' ','undefined','undefined','undefined',' ','undefined','undefined','undefined','12',' ','2017-09-24 07:25:26'),(27,NULL,'36','213','000000036','undefined','undefined','sadasd','ae',NULL,'male','undefined',' ','undefined','undefined','undefined',' ','undefined','undefined','undefined','qwe',' ','2017-09-24 07:25:26'),(28,NULL,'37','Ferna','000000037','undefined','undefined','ferna@sample.com','099876543212',NULL,' ','undefined',' ','undefined','undefined','undefined',' ','undefined','undefined','undefined','1111',' ','2017-09-24 07:25:26'),(29,NULL,'38','Victoria','000000038','C','Uy','victoria@sample.com','09999999',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-24 07:25:26'),(30,NULL,'39','Maria','000000039','C','C','maria@sample.com','x',NULL,' ',' ',' ',' ',' ','undefined','undefined',' ',' ',' ',' ',' ','2017-09-24 07:25:26'),(31,NULL,'40','D','000000040',' ','S',' ',' ',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-24 07:25:26'),(32,NULL,'41','D','000000041','D','D','D','D',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-24 07:25:26'),(33,NULL,'42','Richard','000000042','U','Dale','richard12@sample.com','09999xxxx',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-24 07:25:26'),(34,NULL,'43','rommel','000000043',' ','pascual',' ','09171234567',NULL,'male',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-24 07:25:26'),(35,NULL,'44',' ','','ss','Deloissa',' ','08996456',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-27 08:37:07'),(36,NULL,'45',' ','','ss','Deloissa',' ','08996456',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-27 08:37:07'),(37,NULL,'46',' ','','ss','Deloissa',' ','08996456',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-27 08:37:07'),(38,NULL,'47',' ','','ss','Deloissa',' ','08996456',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-27 08:37:07'),(39,2,'48',' Erika','000000048','G','Deloissa',' ','08996456',NULL,'','','',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-27 08:37:07'),(40,2,'49',' Genica','000000049',' ','Navarro','fnavarro@sample.com','099999999',NULL,'','','',' ','07-12-1989','ABC Townhomes, Marikina City',' ','Marikina City',' ',' ',' ','none','2017-09-27 20:16:05'),(41,7,'50',' ','000000050',' ','WES',' ','WES',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-09-28 08:34:48'),(42,7,'51',' ','000000051',' ','Lee',' ','09999',NULL,'female',' ',' ',' ','02-07-1990',' ',' ','Makati City',' ',' ',' ',' ','2017-09-28 08:59:24'),(43,NULL,'52',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(44,NULL,'53',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(45,NULL,'54',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(46,NULL,'55',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(47,NULL,'56',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(48,NULL,'57',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(49,NULL,'58',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(50,NULL,'59',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(51,NULL,'60',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(52,NULL,'61',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(53,NULL,'62',' ','','S','Bargo',' ','09171234567',NULL,'male',' ','02-02-2009','bgc',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:33:32'),(54,7,'63',' ','000000063',' ','Test 10-04',' ','00000',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-04 10:34:17'),(55,7,'64','Jillian','000000064',' ','De Guzman',' ','0999997453',NULL,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2017-10-09 13:10:50');
/*!40000 ALTER TABLE `gist_pos_customer_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gist_pos_trans`
--

DROP TABLE IF EXISTS `gist_pos_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gist_pos_trans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `trans_display_id` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_total` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_balance` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_type` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `synced_to_erp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `tax_rate` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orig_vat_amt` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `new_vat_amt` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orig_amt_net_vat` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `new_amt_net_vat` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tax_coverage` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cart_min` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cart_orig_total` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cart_new_total` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bulk_discount_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_mode` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_cc_interest` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `extra_amount` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `generic_var1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selected_bulk_discount_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selected_bulk_discount_amount` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deposit_vat_amt` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deposit_amt_net_vat` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance_vat_amt` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance_amt_net_vat` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deposit_amount` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8BCECBDE727ACA70` (`parent_id`),
  KEY `IDX_8BCECBDEEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_8BCECBDE727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `gist_pos_trans` (`id`),
  CONSTRAINT `FK_8BCECBDEEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans`
--

LOCK TABLES `gist_pos_trans` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans` DISABLE KEYS */;
INSERT INTO `gist_pos_trans` VALUES (57,7,'N-000057','2189','-11','64','reg','Paid','true','2017-10-09 13:10:52','10','199','199','1990','1990','excl','2134','2189','0','none','normal','true',NULL,'55',NULL,NULL,NULL,'none','0','0','0','-1','-10','-11','0'),(58,7,'N-000058','11100','0','64','per','Paid','true','2017-10-09 13:12:42','10','1090','1009.09','10900','10090.91','excl','6545','11990','11100','none','normal','true',NULL,'4-555',NULL,NULL,NULL,'none','0','0','0','0','0','0','0'),(59,7,'N-000059','81488','0','49','bulk','Paid','true','2017-10-09 13:13:53','10','9260','7408','92600','74080','excl','65395','101860','81488','Less 20 percent off','normal','true',NULL,'16-093',NULL,NULL,NULL,'bdisc','20','0','0','0','0','0','0'),(60,7,'Q-000060','33979','-21','49','reg','Paid','true','2017-10-09 13:14:38','10','3089','3089','30890','30890','excl','17589','33979','0','none','quotation','true',NULL,'16-390',NULL,NULL,NULL,'none','0','0','0','-1.90909090909091','-19.09090909090909','-21','0'),(61,7,'N-000061','33979','-21','49','reg','Paid','true','2017-10-09 13:14:38','10','3089','3089','30890','30890','excl','17589','33979','0','none','normal','true',60,'16-390',NULL,NULL,NULL,'none','0','0','0','-1.90909090909091','-19.09090909090909','-21','0'),(62,7,'D-000062','42000','22000','64','per','Paid','true','2017-10-09 14:13:26','10','3980','3818.18','39800','38181.82','excl','22000','43780','42000','none','Deposit','true',NULL,'20-000',NULL,NULL,NULL,'none','0','1818.1818181818198','1818.1818181818198','2000','20000','22000','20000'),(63,7,'N-000063','42000','0','64','per','Paid','true','2017-10-09 14:13:53','10','3980','NaN','39800','NaN','excl','22000','43780','42000','none','normal','true',62,'20-000',NULL,NULL,NULL,'none','0','1818.1818181818198','1818.1818181818198','0','0','0','20000'),(64,7,'N-000064','1100','0','64','per','Paid','true','2017-10-09 16:28:37','10','100','100','1000','1000','excl','1045','1100','0','none','normal','true',NULL,'55',NULL,NULL,NULL,'none','0','0','0','0','0','0','0'),(65,7,'N-000065','1100','-100','64','per','Paid','true','2017-10-09 16:29:25','10','100','100','1000','1000','excl','1045','1100','0','none','normal','true',NULL,'55',NULL,NULL,NULL,'none','0','0','0','-9.090909090909093','-90.9090909090909','-100','0'),(66,7,'D-000066','100000','50000','64','per','Paid','true','2017-10-09 18:32:38','10','9149','9090.91','91490','90909.09','excl','51634','100639','100000','none','Deposit','true',NULL,'48-366',NULL,NULL,NULL,'none','0','4545.454545454551','4545.454545454551','4545.454545454551','45454.54545454545','50000','50000'),(67,7,'N-000067','100000','0','64','per','Paid','true','2017-10-10 05:25:45','10','9149','NaN','91490','NaN','excl','51634','100639','100000','none','normal','true',66,'48-366',NULL,NULL,NULL,'none','0','4545.454545454551','4545.454545454551','0','0','0','50000'),(68,7,'N-000068','1100','0','64','reg','Paid','true','2017-10-10 05:36:14','10','100','100','1000','1000','excl','1045','1100','0','none','normal','true',NULL,'55',NULL,NULL,NULL,'none','0','0','0','0','0','0','0'),(69,7,'D-000069','13079','11079','64','per','Paid','true','2017-10-10 05:37:18','10','1189','1189','11890','11890','excl','7634','13079','0','none','Deposit','true',NULL,'5-445',NULL,NULL,NULL,'none','0','181.81818181818198','181.81818181818198','1007.1818181818198','10071.81818181818','11079','2000'),(70,7,'D-000070','12100','5000','64','per','Paid','true','2017-10-10 05:38:36','10','1189','1100','11890','11000','excl','7634','13079','12100','none','Deposit','true',69,'4-466',NULL,NULL,NULL,'none','0','645.454545454546','645.454545454546','454.54545454545496','4545.454545454545','5000','7100'),(71,7,'N-000071','44869','0','64','per','Paid','true','2017-10-10 05:45:07','10','4079','4079','40790','40790','excl','23089','44869','0','none','normal','true',NULL,'21-780',NULL,NULL,NULL,'none','0','0','0','0','0','0','0'),(72,7,'N-000072','44869','0','64','per','Paid','true','2017-10-10 05:49:04','10','4079','4079','40790','40790','excl','23089','44869','44869','none','normal','true',NULL,'21-780',NULL,NULL,NULL,'none','0','0','0','0','0','0','0'),(73,7,'N-000073','43000','0','64','per','Paid','true','2017-10-10 05:49:45','10','4079','3909.09','40790','39090.91','excl','23089','44869','43000','none','normal','true',NULL,'19-911',NULL,NULL,NULL,'none','0','0','0','0','0','0','0'),(74,7,'N-000074','12100','0','64','per','Paid','true','2017-10-10 05:51:33','10','1189','1100','11890','11000','excl','7634','13079','12100','none','normal','true',70,'4-466',NULL,NULL,NULL,'none','0','645.454545454546','645.454545454546','0','0','0','7100'),(75,7,'D-000075','14960','9960','64','reg','Paid','true','2017-10-10 14:41:34','10','1360','1360','13600','13600','excl','7480','14960','0','none','Deposit','true',NULL,'7-480',NULL,NULL,NULL,'none','0','454.54545454545496','454.54545454545496','905.454545454546','9054.545454545454','9960','5000'),(76,7,'N-000076','59800','0','49','reg','Paid','true','2017-10-11 09:23:28','10','5980','5980','53820','53820','incl','30000','59800','0','none','normal','true',NULL,'29-800',NULL,NULL,NULL,'none','0','0','0','0','0','0','0'),(77,7,'N-000077','14960','0','64','reg','Paid','true','2017-10-12 14:13:53','10','1496','1496','13464','13464','incl','7480','14960','0','none','normal','true',75,'7-480',NULL,NULL,NULL,'none','0','500','500','0','0','0','5000'),(78,7,'N-000078','12240','0','28','bulk','Paid','true','2017-10-12 14:16:05','10','1360','1224','12240','11016','incl','6800','13600','12240','Less 10 percent off','normal','true',NULL,'5-440',NULL,NULL,NULL,'bdisc','10','0','0','0','0','0','0'),(79,7,'D-000079','11560','9060','27','bulk','Paid','true','2017-10-12 14:18:33','10','1360','1156','12240','10404','incl','6800','13600','11560','Less 15 percent off','Deposit','true',NULL,'4-760',NULL,NULL,NULL,'bdisc','15','250','250','906','8154','9060','2500'),(80,7,'D-000080','11560','7060','27','bulk','Paid','true','2017-10-12 14:19:54','10','1360','1156','12240','10404','incl','6800','13600','11560','Less 15 percent off','Deposit','true',79,'4-760',NULL,NULL,NULL,'bdisc','15','450','450','706','6354','7060','4500'),(81,7,'D-000081','11560','2060','27','bulk','Paid','true','2017-10-12 14:22:52','10','1360','1156','12240','10404','incl','6800','13600','11560','Less 15 percent off','Deposit','true',80,'4-760',NULL,NULL,NULL,'bdisc','15','950','950','206','1854','2060','9500'),(82,7,'N-000082','1990','0','64','reg','Paid','true','2017-10-14 12:06:17','10','199','199','1791','1791','incl','1940','1990','0','none','normal','true',NULL,'50',NULL,NULL,NULL,'none','0','0','0','0','0','0','0'),(83,7,'D-000083','30890','15890','64','reg','Paid','true','2017-10-14 12:07:13','10','3089','3089','27801','27801','incl','15990','30890','0','none','Deposit','true',NULL,'14-900',NULL,NULL,NULL,'none','0','1500','1500','1589','14301','15890','15000'),(84,2,'N-000084','30890','0','64','reg','Paid','true','2017-10-14 12:08:05','10','3089','3089','27801','27801','incl','15990','30890','0','none','normal','true',83,'14-900',NULL,NULL,NULL,'none','0','1500','1500','0','0','0','15000'),(85,2,'D-000085','6000','3500','49','reg','Paid','true','2017-10-14 12:10:56','10','600','600','5400','5400','incl','3000','6000','0','none','Deposit','true',NULL,'3-000',NULL,NULL,NULL,'none','0','250','250','350','3150','3500','2500'),(86,2,'N-000086','6000','0','49','reg','Paid','true','2017-10-14 12:11:25','10','600','600','5400','5400','incl','3000','6000','0','none','normal','true',85,'3-000',NULL,NULL,NULL,'none','0','250','250','0','0','0','2500'),(87,2,'D-000087','1990','900','64','reg','Paid','true','2017-10-14 13:25:04','10','199','199','1791','1791','incl','1940','1990','0','none','Deposit','true',NULL,'50',NULL,NULL,NULL,'none','0','109','109','90','810','900','1090'),(88,2,'N-000088','1990','0','64','reg','Paid','true','2017-10-14 13:25:44','10','199','199','1791','1791','incl','1940','1990','0','none','normal','true',87,'50',NULL,NULL,NULL,'none','0','109','109','0','0','0','1090');
/*!40000 ALTER TABLE `gist_pos_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gist_pos_trans_item`
--

DROP TABLE IF EXISTS `gist_pos_trans_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gist_pos_trans_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `product_id` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orig_price` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `minimum_price` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adjusted_price` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discount_type` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discount_value` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `barcode` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_code` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_issued_on` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `issued` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_96F107F02FC0CB0F` (`transaction_id`),
  KEY `IDX_96F107F0EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_96F107F02FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `gist_pos_trans` (`id`),
  CONSTRAINT `FK_96F107F0EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans_item`
--

LOCK TABLES `gist_pos_trans_item` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans_item` DISABLE KEYS */;
INSERT INTO `gist_pos_trans_item` VALUES (169,57,NULL,'17','1089','1089','0','TEST','none','0','2017-10-09 13:10:53','TEST112','TEST112',NULL,1),(170,57,NULL,'18','1100','1045','0','Generic Cream','none','0','2017-10-09 13:10:53','3940349','00001',NULL,1),(171,58,NULL,'18','1100','1045','1100','Generic Cream','none','0','2017-10-09 13:12:42','3940349','00001',NULL,1),(172,58,NULL,'16','10890','5500','10000','Contura Eye Cream','discamt','890','2017-10-09 13:12:42','839901007944','267032002',NULL,1),(173,59,NULL,'7','30690','29700','0','24K Intensive Face Serum','none','0','2017-10-09 13:13:53','83990100343','83990100343',NULL,1),(174,59,NULL,'6','27390','13695','0','24K Intensive Face Cream','none','0','2017-10-09 13:13:53','839901003427','267019001',NULL,1),(175,59,NULL,'16','10890','5500','0','Contura Eye Cream','none','0','2017-10-09 13:13:53','839901007944','267032002',NULL,1),(176,59,NULL,'8','32890','16500','0','24K Intensive Mask','none','0','2017-10-09 13:13:53','839901004783','839901004783',NULL,1),(177,60,NULL,'17','1089','1089','0','TEST','none','0','2017-10-09 13:14:38','TEST112','TEST112',NULL,1),(178,60,NULL,'8','32890','16500','0','24K Intensive Mask','none','0','2017-10-09 13:14:38','839901004783','839901004783',NULL,1),(179,62,NULL,'16','10890','5500','10000','Contura Eye Cream','discamt','890','2017-10-09 14:13:26','839901007944','267032002','62',1),(180,62,NULL,'8','32890','16500','32000','24K Intensive Mask','discamt','890','2017-10-09 14:13:26','839901004783','839901004783',NULL,0),(181,63,NULL,'179','10890','5500','10000','Contura Eye Cream','discamt','890','2017-10-09 14:13:53','839901007944','267032002','62',1),(182,63,NULL,'180','32890','16500','32000','24K Intensive Mask','discamt','890','2017-10-09 14:13:53','839901004783','839901004783','63',1),(183,64,NULL,'18','1100','1045','1100','Generic Cream','none','0','2017-10-09 16:28:38','3940349','00001',NULL,1),(184,65,NULL,'18','1100','1045','1100','Generic Cream','none','0','2017-10-09 16:29:25','3940349','00001',NULL,1),(185,66,NULL,'8','32890','16500','32251','24K Intensive Mask','discamt','639','2017-10-09 18:32:38','839901004783','839901004783','66',1),(186,66,NULL,'16','10890','5500','10890','Contura Eye Cream','none','0','2017-10-09 18:32:38','839901007944','267032002','66',1),(187,66,NULL,'8','32890','16500','32890','24K Intensive Mask','none','0','2017-10-09 18:32:38','839901004783','839901004783','66',1),(188,66,NULL,'17','1089','1089','1089','TEST','none','0','2017-10-09 18:32:38','TEST112','TEST112',NULL,0),(189,66,NULL,'18','1100','1045','1100','Generic Cream','none','0','2017-10-09 18:32:38','3940349','00001',NULL,0),(190,66,NULL,'16','10890','5500','10890','Contura Eye Cream','none','0','2017-10-09 18:32:39','839901007944','267032002','66',1),(191,66,NULL,'16','10890','5500','10890','Contura Eye Cream','none','0','2017-10-09 18:32:39','839901007944','267032002','66',1),(192,67,NULL,'185','32890','16500','32251','24K Intensive Mask','discamt','639','2017-10-10 05:25:45','839901004783','839901004783','66',1),(193,67,NULL,'186','10890','5500','10890','Contura Eye Cream','none','0','2017-10-10 05:25:45','839901007944','267032002','66',1),(194,67,NULL,'187','32890','16500','32890','24K Intensive Mask','none','0','2017-10-10 05:25:45','839901004783','839901004783','66',1),(195,67,NULL,'188','1089','1089','1089','TEST','none','0','2017-10-10 05:25:45','TEST112','TEST112','67',1),(196,67,NULL,'189','1100','1045','1100','Generic Cream','none','0','2017-10-10 05:25:46','3940349','00001','67',1),(197,67,NULL,'190','10890','5500','10890','Contura Eye Cream','none','0','2017-10-10 05:25:46','839901007944','267032002','66',1),(198,67,NULL,'191','10890','5500','10890','Contura Eye Cream','none','0','2017-10-10 05:25:46','839901007944','267032002','66',1),(199,68,NULL,'18','1100','1045','0','Generic Cream','none','0','2017-10-10 05:36:14','3940349','00001',NULL,1),(200,69,NULL,'18','1100','1045','1100','Generic Cream','none','0','2017-10-10 05:37:19','3940349','00001','69',1),(201,69,NULL,'17','1089','1089','1089','TEST','none','0','2017-10-10 05:37:19','TEST112','TEST112',NULL,0),(202,69,NULL,'16','10890','5500','10890','Contura Eye Cream','none','0','2017-10-10 05:37:19','839901007944','267032002',NULL,0),(203,70,NULL,'200','1100','1045','1100','Generic Cream','none','0','2017-10-10 05:38:36','3940349','00001','69',1),(204,70,NULL,'202','10890','5500','10000','Contura Eye Cream','discamt','890','2017-10-10 05:38:36','839901007944','267032002',NULL,0),(205,70,NULL,'201','1089','1089','1000','TEST','discamt','89','2017-10-10 05:38:36','TEST112','TEST112','70',1),(206,71,NULL,'16','10890','5500','10890','Contura Eye Cream','none','0','2017-10-10 05:45:07','839901007944','267032002',NULL,1),(207,71,NULL,'8','32890','16500','32890','24K Intensive Mask','none','0','2017-10-10 05:45:07','839901004783','839901004783',NULL,1),(208,71,NULL,'17','1089','1089','1089','TEST','none','0','2017-10-10 05:45:07','TEST112','TEST112',NULL,1),(209,72,NULL,'16','10890','5500','10890','Contura Eye Cream','none','0','2017-10-10 05:49:04','839901007944','267032002',NULL,1),(210,72,NULL,'8','32890','16500','32890','24K Intensive Mask','none','0','2017-10-10 05:49:04','839901004783','839901004783',NULL,1),(211,72,NULL,'17','1089','1089','1089','TEST','none','0','2017-10-10 05:49:04','TEST112','TEST112',NULL,1),(212,73,NULL,'17','1089','1089','1000','TEST','discamt','89','2017-10-10 05:49:46','TEST112','TEST112',NULL,1),(213,73,NULL,'16','10890','5500','10000','Contura Eye Cream','discamt','890','2017-10-10 05:49:46','839901007944','267032002',NULL,1),(214,73,NULL,'8','32890','16500','32000','24K Intensive Mask','discamt','890','2017-10-10 05:49:46','839901004783','839901004783',NULL,1),(215,74,NULL,'203','1100','1045','1100','Generic Cream','none','0','2017-10-10 05:51:33','3940349','00001','69',1),(216,74,NULL,'204','10890','5500','10000','Contura Eye Cream','discamt','890','2017-10-10 05:51:33','839901007944','267032002','74',1),(217,74,NULL,'205','1089','1089','1000','TEST','discamt','89','2017-10-10 05:51:33','TEST112','TEST112','70',1),(218,75,NULL,'9','4180','2090','0','Blissful Body Butter - Springtime','none','0','2017-10-10 14:41:34','839901008019','839901008019','75',1),(219,75,NULL,'11','8360','4180','0','Clarity Peeling Gel','none','0','2017-10-10 14:41:35','839901007913','267035001',NULL,0),(220,75,NULL,'10','2420','1210','0','Body Lotion - Delicate Dew (Big)','none','0','2017-10-10 14:41:35','839901007982','267022029',NULL,0),(221,76,NULL,'8','29900','15000','0','24K Intensive Mask','none','0','2017-10-11 09:23:29','839901004783','839901004783','76',1),(222,76,NULL,'8','29900','15000','0','24K Intensive Mask','none','0','2017-10-11 09:23:29','839901004783','839901004783','76',1),(223,77,NULL,'218','4180','2090','0','Blissful Body Butter - Springtime','none','0','2017-10-12 14:13:53','839901008019','839901008019','75',1),(224,77,NULL,'219','8360','4180','0','Clarity Peeling Gel','none','0','2017-10-12 14:13:53','839901007913','267035001','77',1),(225,77,NULL,'220','2420','1210','0','Body Lotion - Delicate Dew (Big)','none','0','2017-10-12 14:13:54','839901007982','267022029','77',1),(226,78,NULL,'11','7600','3800','0','Clarity Peeling Gel','none','0','2017-10-12 14:16:05','839901007913','267035001','78',1),(227,78,NULL,'10','2200','1100','0','Body Lotion - Delicate Dew (Big)','none','0','2017-10-12 14:16:05','839901007982','267022029','78',1),(228,78,NULL,'9','3800','1900','0','Blissful Body Butter - Springtime','none','0','2017-10-12 14:16:05','839901008019','839901008019','78',1),(229,79,NULL,'9','3800','1900','0','Blissful Body Butter - Springtime','none','0','2017-10-12 14:18:33','839901008019','839901008019',NULL,0),(230,79,NULL,'11','7600','3800','0','Clarity Peeling Gel','none','0','2017-10-12 14:18:33','839901007913','267035001',NULL,0),(231,79,NULL,'10','2200','1100','0','Body Lotion - Delicate Dew (Big)','none','0','2017-10-12 14:18:33','839901007982','267022029','79',1),(232,80,NULL,'229','3800','1900','0','Blissful Body Butter - Springtime','none','0','2017-10-12 14:19:54','839901008019','839901008019','80',1),(233,80,NULL,'230','7600','3800','0','Clarity Peeling Gel','none','0','2017-10-12 14:19:54','839901007913','267035001',NULL,0),(234,80,NULL,'231','2200','1100','0','Body Lotion - Delicate Dew (Big)','none','0','2017-10-12 14:19:54','839901007982','267022029','79',1),(235,81,NULL,'232','3800','1900','0','Blissful Body Butter - Springtime','none','0','2017-10-12 14:22:54','839901008019','839901008019','80',1),(236,81,NULL,'233','7600','3800','0','Clarity Peeling Gel','none','0','2017-10-12 14:22:54','839901007913','267035001','81',1),(237,81,NULL,'234','2200','1100','0','Body Lotion - Delicate Dew (Big)','none','0','2017-10-12 14:22:54','839901007982','267022029','79',1),(238,82,NULL,'17','990','990','0','TEST','none','0','2017-10-14 12:06:17','TEST112','TEST112',NULL,1),(239,82,NULL,'18','1000','950','0','Generic Cream','none','0','2017-10-14 12:06:17','3940349','00001',NULL,1),(240,83,NULL,'8','29900','15000','0','24K Intensive Mask','none','0','2017-10-14 12:07:13','839901004783','839901004783',NULL,0),(241,83,NULL,'17','990','990','0','TEST','none','0','2017-10-14 12:07:13','TEST112','TEST112','83',1),(242,84,NULL,'240','29900','15000','0','24K Intensive Mask','none','0','2017-10-14 12:08:05','839901004783','839901004783',NULL,1),(243,84,NULL,'241','990','990','0','TEST','none','0','2017-10-14 12:08:05','TEST112','TEST112','83',1),(244,85,NULL,'10','2200','1100','0','Body Lotion - Delicate Dew (Big)','none','0','2017-10-14 12:10:56','839901007982','267022029','85',1),(245,85,NULL,'9','3800','1900','0','Blissful Body Butter - Springtime','none','0','2017-10-14 12:10:56','839901008019','839901008019',NULL,0),(246,86,NULL,'245','3800','1900','0','Blissful Body Butter - Springtime','none','0','2017-10-14 12:11:26','839901008019','839901008019',NULL,1),(247,86,NULL,'244','2200','1100','0','Body Lotion - Delicate Dew (Big)','none','0','2017-10-14 12:11:27','839901007982','267022029','85',1),(248,87,NULL,'17','990','990','0','TEST','none','0','2017-10-14 13:25:04','TEST112','TEST112',NULL,0),(249,87,NULL,'18','1000','950','0','Generic Cream','none','0','2017-10-14 13:25:04','3940349','00001','87',1),(250,88,NULL,'249','1000','950','0','Generic Cream','none','0','2017-10-14 13:25:45','3940349','00001','87',1),(251,88,NULL,'248','990','990','0','TEST','none','0','2017-10-14 13:25:45','TEST112','TEST112','88',1);
/*!40000 ALTER TABLE `gist_pos_trans_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gist_pos_trans_payment`
--

DROP TABLE IF EXISTS `gist_pos_trans_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gist_pos_trans_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `details` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `bank` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trans_date` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_expiry` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_cvv` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_terms` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_class` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_terminal_operator` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `control_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `interest` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payee` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payor` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_issued_on` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_293934682FC0CB0F` (`transaction_id`),
  KEY `IDX_29393468EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_293934682FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `gist_pos_trans` (`id`),
  CONSTRAINT `FK_29393468EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans_payment`
--

LOCK TABLES `gist_pos_trans_payment` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans_payment` DISABLE KEYS */;
INSERT INTO `gist_pos_trans_payment` VALUES (112,57,NULL,'Cash',NULL,'2200','2017-10-09 13:10:53','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','57'),(113,58,NULL,'Credit Card',NULL,'11100','2017-10-09 13:12:42','BDO',NULL,NULL,NULL,'12 - 21','123','3 months',NULL,'Tangent','1111 1111 1111 1111','no interest','null','null','WES','58'),(114,59,NULL,'Credit Card',NULL,'76000','2017-10-09 13:13:53','RCBC',NULL,NULL,NULL,'12 - 21','1232','12 months',NULL,'GlobalPay','1111 1111 1111 1111','with interest','null','null','WES','59'),(115,59,NULL,'Cash',NULL,'5488','2017-10-09 13:13:53','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','59'),(116,60,NULL,'Cash',NULL,'34000','2017-10-09 13:14:38','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','60'),(117,62,NULL,'Cash',NULL,'20000','2017-10-09 14:13:26','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','62'),(118,63,NULL,'Cash',NULL,'20000','2017-10-09 14:13:53',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','62'),(119,63,NULL,'Cash',NULL,'22000','2017-10-09 14:13:53','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','63'),(120,64,NULL,'Cash',NULL,'1100','2017-10-09 16:28:38','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','64'),(121,65,NULL,'Cash',NULL,'1200','2017-10-09 16:29:25','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','65'),(122,66,NULL,'Cash',NULL,'50000','2017-10-09 18:32:39','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','66'),(123,67,NULL,'Cash',NULL,'50000','2017-10-10 05:25:46','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','67'),(124,67,NULL,'Cash',NULL,'50000','2017-10-10 05:25:46',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','66'),(125,68,NULL,'Cash',NULL,'1100','2017-10-10 05:36:14','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','68'),(126,69,NULL,'Cash',NULL,'2000','2017-10-10 05:37:19','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','69'),(127,70,NULL,'Cash',NULL,'5100','2017-10-10 05:38:36','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','70'),(128,70,NULL,'Cash',NULL,'2000','2017-10-10 05:38:36',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','69'),(129,71,NULL,'Cash',NULL,'44869','2017-10-10 05:45:07','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','71'),(130,72,NULL,'Cash',NULL,'44869','2017-10-10 05:49:04','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','72'),(131,73,NULL,'Cash',NULL,'43000','2017-10-10 05:49:46','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','73'),(132,74,NULL,'Credit Card',NULL,'5000','2017-10-10 05:51:33','BDO',NULL,NULL,NULL,'12 - 21','123','3 months',NULL,'GHL','0789 7897 8978 9789','no interest','null','null','DER','74'),(133,74,NULL,'Cash',NULL,'2000','2017-10-10 05:51:33',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','69'),(134,74,NULL,'Cash',NULL,'5100','2017-10-10 05:51:34',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','70'),(135,75,NULL,'Cash',NULL,'5000','2017-10-10 14:41:35','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','75'),(136,76,NULL,'Cash',NULL,'59800','2017-10-11 09:23:29','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','76'),(137,77,NULL,'Cash',NULL,'5000','2017-10-12 14:13:53',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','75'),(138,77,NULL,'Cash',NULL,'9960','2017-10-12 14:13:54','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','77'),(139,78,NULL,'Cash',NULL,'12240','2017-10-12 14:16:05','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','78'),(140,79,NULL,'Cash',NULL,'500','2017-10-12 14:18:33','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','79'),(141,79,NULL,'Cash',NULL,'2000','2017-10-12 14:18:33','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','79'),(142,80,NULL,'Cash',NULL,'2000','2017-10-12 14:19:54','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','80'),(143,80,NULL,'Cash',NULL,'500','2017-10-12 14:19:55',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','79'),(144,80,NULL,'Cash',NULL,'2000','2017-10-12 14:19:55',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','79'),(145,81,NULL,'Cash',NULL,'5000','2017-10-12 14:22:54','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','81'),(146,81,NULL,'Cash',NULL,'2000','2017-10-12 14:22:54',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','80'),(147,81,NULL,'Cash',NULL,'500','2017-10-12 14:22:54',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','79'),(148,81,NULL,'Cash',NULL,'2000','2017-10-12 14:22:54',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','79'),(149,82,NULL,'Cash',NULL,'1990','2017-10-14 12:06:17','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','82'),(150,83,NULL,'Cash',NULL,'15000','2017-10-14 12:07:14','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','83'),(151,84,NULL,'Cash',NULL,'15890','2017-10-14 12:08:05','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','84'),(152,84,NULL,'Cash',NULL,'15000','2017-10-14 12:08:05',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','83'),(153,85,NULL,'Cash',NULL,'2500','2017-10-14 12:10:56','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','85'),(154,86,NULL,'Cash',NULL,'2500','2017-10-14 12:11:26',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','85'),(155,86,NULL,'Cash',NULL,'3500','2017-10-14 12:11:27','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','86'),(156,87,NULL,'Cash',NULL,'900','2017-10-14 13:25:04','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','87'),(157,87,NULL,'Cash',NULL,'190','2017-10-14 13:25:04','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','87'),(158,88,NULL,'Cash',NULL,'900','2017-10-14 13:25:45','null',NULL,NULL,NULL,'null','null','null',NULL,'null','null','null','null','null','null','88'),(159,88,NULL,'Cash',NULL,'900','2017-10-14 13:25:45',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','87'),(160,88,NULL,'Cash',NULL,'190','2017-10-14 13:25:45',' ',NULL,NULL,NULL,'null','null',' ',NULL,' ','null',' ','null','null','null','87');
/*!40000 ALTER TABLE `gist_pos_trans_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gist_pos_trans_split`
--

DROP TABLE IF EXISTS `gist_pos_trans_split`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gist_pos_trans_split` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultant_id` int(11) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `amount` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `percent` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F6CEBF4C44F779A2` (`consultant_id`),
  KEY `IDX_F6CEBF4C2FC0CB0F` (`transaction_id`),
  KEY `IDX_F6CEBF4CEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_F6CEBF4CEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_F6CEBF4C2FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `gist_pos_trans` (`id`),
  CONSTRAINT `FK_F6CEBF4C44F779A2` FOREIGN KEY (`consultant_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans_split`
--

LOCK TABLES `gist_pos_trans_split` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans_split` DISABLE KEYS */;
INSERT INTO `gist_pos_trans_split` VALUES (59,2,57,NULL,'2189.00','100.00','2017-10-09 13:11:52'),(60,2,63,NULL,'16000.00','50.00','2017-10-09 14:15:11'),(61,4,63,NULL,'16000.00','50.00','2017-10-09 14:15:11'),(62,4,65,NULL,'1100','100.00','2017-10-09 16:30:47'),(63,7,75,NULL,'2090.00','50.00','2017-10-11 11:04:47'),(64,3,75,NULL,'2090.00','50.00','2017-10-11 11:04:47'),(65,7,79,NULL,'733.33','33.33','2017-10-12 14:32:38'),(66,3,79,NULL,'733.33','33.33','2017-10-12 14:32:38'),(67,4,79,NULL,'733.33','33.33','2017-10-12 14:32:38'),(68,7,82,NULL,'1990','100.00','2017-10-14 12:06:20'),(69,7,83,NULL,'990','100.00','2017-10-14 12:07:16'),(70,2,84,NULL,'30890','100.00','2017-10-14 12:08:08'),(71,2,85,NULL,'2200','100.00','2017-10-14 12:10:59'),(72,2,86,NULL,'0','100.00','2017-10-14 12:11:28'),(73,2,87,NULL,'1000','100.00','2017-10-14 13:25:07'),(74,2,88,NULL,'990','100.00','2017-10-14 13:25:47');
/*!40000 ALTER TABLE `gist_pos_trans_split` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_location`
--

DROP TABLE IF EXISTS `hr_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E57B4B31EEFE5067` (`user_create_id`),
  KEY `IDX_E57B4B31F5B7AF75` (`address_id`),
  CONSTRAINT `FK_E57B4B31EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_E57B4B31F5B7AF75` FOREIGN KEY (`address_id`) REFERENCES `cnt_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_location`
--

LOCK TABLES `hr_location` WRITE;
/*!40000 ALTER TABLE `hr_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_account`
--

DROP TABLE IF EXISTS `inv_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `allow_negative` tinyint(1) NOT NULL,
  `date_create` datetime NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_60D5FF7DEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_60D5FF7DEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_account`
--

LOCK TABLES `inv_account` WRITE;
/*!40000 ALTER TABLE `inv_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_adjustment`
--

DROP TABLE IF EXISTS `inv_adjustment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_adjustment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `inv_account_id` int(11) DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `remarks` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4D67C2D62FC0CB0F` (`transaction_id`),
  KEY `IDX_4D67C2D64584665A` (`product_id`),
  KEY `IDX_4D67C2D65FF5E57A` (`inv_account_id`),
  CONSTRAINT `FK_4D67C2D62FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `inv_transaction` (`id`),
  CONSTRAINT `FK_4D67C2D64584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`),
  CONSTRAINT `FK_4D67C2D65FF5E57A` FOREIGN KEY (`inv_account_id`) REFERENCES `inv_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_adjustment`
--

LOCK TABLES `inv_adjustment` WRITE;
/*!40000 ALTER TABLE `inv_adjustment` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_adjustment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_bi_entry`
--

DROP TABLE IF EXISTS `inv_bi_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_bi_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowed_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_60B280F64BC3968` (`borrowed_id`),
  KEY `IDX_60B280F4584665A` (`product_id`),
  CONSTRAINT `FK_60B280F4584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`),
  CONSTRAINT `FK_60B280F64BC3968` FOREIGN KEY (`borrowed_id`) REFERENCES `inv_borrowed_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_bi_entry`
--

LOCK TABLES `inv_bi_entry` WRITE;
/*!40000 ALTER TABLE `inv_bi_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_bi_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_borrowed_transaction`
--

DROP TABLE IF EXISTS `inv_borrowed_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_borrowed_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `borrower_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date_issue` date NOT NULL,
  `status` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remarks` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A208F6AF11CE312B` (`borrower_id`),
  KEY `IDX_A208F6AFEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_A208F6AF11CE312B` FOREIGN KEY (`borrower_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_A208F6AFEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_borrowed_transaction`
--

LOCK TABLES `inv_borrowed_transaction` WRITE;
/*!40000 ALTER TABLE `inv_borrowed_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_borrowed_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_brand`
--

DROP TABLE IF EXISTS `inv_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_brand`
--

LOCK TABLES `inv_brand` WRITE;
/*!40000 ALTER TABLE `inv_brand` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_entry`
--

DROP TABLE IF EXISTS `inv_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) DEFAULT NULL,
  `inv_account_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `credit` decimal(10,2) NOT NULL,
  `debit` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4CCBA4862FC0CB0F` (`transaction_id`),
  KEY `IDX_4CCBA4865FF5E57A` (`inv_account_id`),
  KEY `IDX_4CCBA4864584665A` (`product_id`),
  CONSTRAINT `FK_4CCBA4862FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `inv_transaction` (`id`),
  CONSTRAINT `FK_4CCBA4864584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`),
  CONSTRAINT `FK_4CCBA4865FF5E57A` FOREIGN KEY (`inv_account_id`) REFERENCES `inv_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_entry`
--

LOCK TABLES `inv_entry` WRITE;
/*!40000 ALTER TABLE `inv_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_ii_entry`
--

DROP TABLE IF EXISTS `inv_ii_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_ii_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issued_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `description` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remarks` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5B613459CEEF67AD` (`issued_id`),
  KEY `IDX_5B6134594584665A` (`product_id`),
  CONSTRAINT `FK_5B6134594584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`),
  CONSTRAINT `FK_5B613459CEEF67AD` FOREIGN KEY (`issued_id`) REFERENCES `inv_issued_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_ii_entry`
--

LOCK TABLES `inv_ii_entry` WRITE;
/*!40000 ALTER TABLE `inv_ii_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_ii_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_issued_item`
--

DROP TABLE IF EXISTS `inv_issued_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_issued_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_issuedto_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date_issue` date NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_25A9973265191DCD` (`user_issuedto_id`),
  KEY `IDX_25A99732EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_25A9973265191DCD` FOREIGN KEY (`user_issuedto_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_25A99732EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_issued_item`
--

LOCK TABLES `inv_issued_item` WRITE;
/*!40000 ALTER TABLE `inv_issued_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_issued_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_product`
--

DROP TABLE IF EXISTS `inv_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `photo_id` int(11) DEFAULT NULL,
  `doc_permit_id` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `product_compositions` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_code` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `barcode` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost` decimal(13,2) DEFAULT NULL,
  `cost_currency` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `srp` decimal(13,2) DEFAULT NULL,
  `min_price` decimal(13,2) DEFAULT NULL,
  `fda_expiration_price` decimal(13,2) DEFAULT NULL,
  `permit_date_from` datetime NOT NULL,
  `permit_date_to` datetime NOT NULL,
  `description` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ingredients` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `directions` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CEA9AD74C54C8C93` (`type_id`),
  KEY `IDX_CEA9AD7444F5D008` (`brand_id`),
  KEY `IDX_CEA9AD7412469DE2` (`category_id`),
  KEY `IDX_CEA9AD747E9E4C8C` (`photo_id`),
  KEY `IDX_CEA9AD74549BA696` (`doc_permit_id`),
  CONSTRAINT `FK_CEA9AD7412469DE2` FOREIGN KEY (`category_id`) REFERENCES `inv_product_category` (`id`),
  CONSTRAINT `FK_CEA9AD7444F5D008` FOREIGN KEY (`brand_id`) REFERENCES `inv_brand` (`id`),
  CONSTRAINT `FK_CEA9AD74549BA696` FOREIGN KEY (`doc_permit_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_CEA9AD747E9E4C8C` FOREIGN KEY (`photo_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_CEA9AD74C54C8C93` FOREIGN KEY (`type_id`) REFERENCES `inv_product_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_product`
--

LOCK TABLES `inv_product` WRITE;
/*!40000 ALTER TABLE `inv_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_product_attribute`
--

DROP TABLE IF EXISTS `inv_product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_product_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `value` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_748F16CE4584665A` (`product_id`),
  CONSTRAINT `FK_748F16CE4584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_product_attribute`
--

LOCK TABLES `inv_product_attribute` WRITE;
/*!40000 ALTER TABLE `inv_product_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_product_category`
--

DROP TABLE IF EXISTS `inv_product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_id` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4D5AD55C44F5D008` (`brand_id`),
  CONSTRAINT `FK_4D5AD55C44F5D008` FOREIGN KEY (`brand_id`) REFERENCES `inv_brand` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_product_category`
--

LOCK TABLES `inv_product_category` WRITE;
/*!40000 ALTER TABLE `inv_product_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_product_group`
--

DROP TABLE IF EXISTS `inv_product_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_product_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_product_group`
--

LOCK TABLES `inv_product_group` WRITE;
/*!40000 ALTER TABLE `inv_product_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_product_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_product_type`
--

DROP TABLE IF EXISTS `inv_product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_product_type`
--

LOCK TABLES `inv_product_type` WRITE;
/*!40000 ALTER TABLE `inv_product_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_returned_item`
--

DROP TABLE IF EXISTS `inv_returned_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_returned_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) DEFAULT NULL,
  `date_returned` date DEFAULT NULL,
  `quantity` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_764740C1BA364942` (`entry_id`),
  CONSTRAINT `FK_764740C1BA364942` FOREIGN KEY (`entry_id`) REFERENCES `inv_bi_entry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_returned_item`
--

LOCK TABLES `inv_returned_item` WRITE;
/*!40000 ALTER TABLE `inv_returned_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_returned_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_service_task`
--

DROP TABLE IF EXISTS `inv_service_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_service_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `sell_price` decimal(13,2) NOT NULL,
  `cost_price` decimal(13,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7C73268B4584665A` (`product_id`),
  CONSTRAINT `FK_7C73268B4584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_service_task`
--

LOCK TABLES `inv_service_task` WRITE;
/*!40000 ALTER TABLE `inv_service_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_service_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_stock`
--

DROP TABLE IF EXISTS `inv_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_stock` (
  `product_id` int(11) NOT NULL,
  `inv_account_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  PRIMARY KEY (`product_id`,`inv_account_id`),
  KEY `IDX_2CDC6F964584665A` (`product_id`),
  KEY `IDX_2CDC6F965FF5E57A` (`inv_account_id`),
  CONSTRAINT `FK_2CDC6F964584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`),
  CONSTRAINT `FK_2CDC6F965FF5E57A` FOREIGN KEY (`inv_account_id`) REFERENCES `inv_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_stock`
--

LOCK TABLES `inv_stock` WRITE;
/*!40000 ALTER TABLE `inv_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_stock_history`
--

DROP TABLE IF EXISTS `inv_stock_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_stock_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `inv_account_id` int(11) DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A62E0E1D2FC0CB0F` (`transaction_id`),
  KEY `IDX_A62E0E1D4584665A` (`product_id`),
  KEY `IDX_A62E0E1D5FF5E57A` (`inv_account_id`),
  CONSTRAINT `FK_A62E0E1D2FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `inv_transaction` (`id`),
  CONSTRAINT `FK_A62E0E1D4584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`),
  CONSTRAINT `FK_A62E0E1D5FF5E57A` FOREIGN KEY (`inv_account_id`) REFERENCES `inv_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_stock_history`
--

LOCK TABLES `inv_stock_history` WRITE;
/*!40000 ALTER TABLE `inv_stock_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_stock_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_supplier`
--

DROP TABLE IF EXISTS `inv_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tin` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tax` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `shipment_period` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `contact_person` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `telephone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_supplier`
--

LOCK TABLES `inv_supplier` WRITE;
/*!40000 ALTER TABLE `inv_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_supplier_product`
--

DROP TABLE IF EXISTS `inv_supplier_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_supplier_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product` int(11) DEFAULT NULL,
  `price` decimal(13,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D289D6B8D34A04AD` (`product`),
  CONSTRAINT `FK_D289D6B8D34A04AD` FOREIGN KEY (`product`) REFERENCES `inv_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_supplier_product`
--

LOCK TABLES `inv_supplier_product` WRITE;
/*!40000 ALTER TABLE `inv_supplier_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_supplier_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_transaction`
--

DROP TABLE IF EXISTS `inv_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E99759DBEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E99759DBEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_transaction`
--

LOCK TABLES `inv_transaction` WRITE;
/*!40000 ALTER TABLE `inv_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_warehouse`
--

DROP TABLE IF EXISTS `inv_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `inv_account_id` int(11) DEFAULT NULL,
  `internal_code` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag_threshold` tinyint(1) DEFAULT NULL,
  `flag_shopfront` tinyint(1) DEFAULT NULL,
  `flag_finished_goods` tinyint(1) DEFAULT NULL,
  `flag_equipment` tinyint(1) DEFAULT NULL,
  `flag_purchased_goods` tinyint(1) DEFAULT NULL,
  `pm_terms` int(11) DEFAULT NULL,
  `type` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1343F305EEFE5067` (`user_create_id`),
  KEY `IDX_1343F3055FF5E57A` (`inv_account_id`),
  CONSTRAINT `FK_1343F3055FF5E57A` FOREIGN KEY (`inv_account_id`) REFERENCES `inv_account` (`id`),
  CONSTRAINT `FK_1343F305EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_warehouse`
--

LOCK TABLES `inv_warehouse` WRITE;
/*!40000 ALTER TABLE `inv_warehouse` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ledger_entry`
--

DROP TABLE IF EXISTS `ledger_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ledger_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pos_location_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `amount` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `entry_description` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_64272A692FDDA7C1` (`pos_location_id`),
  KEY `IDX_64272A69EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_64272A692FDDA7C1` FOREIGN KEY (`pos_location_id`) REFERENCES `loc_pos_locations` (`id`),
  CONSTRAINT `FK_64272A69EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ledger_entry`
--

LOCK TABLES `ledger_entry` WRITE;
/*!40000 ALTER TABLE `ledger_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `ledger_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loc_areas`
--

DROP TABLE IF EXISTS `loc_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loc_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8C817D12EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_8C817D12EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loc_areas`
--

LOCK TABLES `loc_areas` WRITE;
/*!40000 ALTER TABLE `loc_areas` DISABLE KEYS */;
/*!40000 ALTER TABLE `loc_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loc_pos_locations`
--

DROP TABLE IF EXISTS `loc_pos_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loc_pos_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_id` int(11) DEFAULT NULL,
  `barangay_clearance_file_id` int(11) DEFAULT NULL,
  `bir_0605_file_id` int(11) DEFAULT NULL,
  `mayors_permit_file_id` int(11) DEFAULT NULL,
  `bir_2303_file_id` int(11) DEFAULT NULL,
  `fire_permit_file_id` int(11) DEFAULT NULL,
  `sanitary_permit_file_id` int(11) DEFAULT NULL,
  `insurance_policy_document` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `leasor` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `coordinates` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locator_desc` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `brand` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `region` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `barangay_clearance_expiration` date NOT NULL,
  `bir_0605_expiration` date NOT NULL,
  `mayors_permit_expiration` date NOT NULL,
  `bir_2303_expiration` date NOT NULL,
  `fire_permit_expiration` date NOT NULL,
  `sanitary_permit_expiration` date NOT NULL,
  `rent_payment_amount` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_payment_due` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_security_deposit_amount` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_security_deposit_returned` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_security_deposit_returned_amount` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_security_deposit_remarks` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_dimension` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_price_per_sq_meter` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_unit_number` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_contact_person` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_cp_position` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_cp_contact_number` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_cp_email` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insurance_company` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insurance_expiration` date NOT NULL,
  `insurance_policy` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insurance_contact_person1` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insurance_contact_number1` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insurance_contact_person2` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insurance_contact_number2` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_84674C70BD0F409C` (`area_id`),
  KEY `IDX_84674C70AB3ADCB4` (`barangay_clearance_file_id`),
  KEY `IDX_84674C7019EFD317` (`bir_0605_file_id`),
  KEY `IDX_84674C70430F22CE` (`mayors_permit_file_id`),
  KEY `IDX_84674C70F7999840` (`bir_2303_file_id`),
  KEY `IDX_84674C70B28F4530` (`fire_permit_file_id`),
  KEY `IDX_84674C70699AD0D7` (`sanitary_permit_file_id`),
  KEY `IDX_84674C709A227855` (`insurance_policy_document`),
  KEY `IDX_84674C70EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_84674C7019EFD317` FOREIGN KEY (`bir_0605_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70430F22CE` FOREIGN KEY (`mayors_permit_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70699AD0D7` FOREIGN KEY (`sanitary_permit_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C709A227855` FOREIGN KEY (`insurance_policy_document`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70AB3ADCB4` FOREIGN KEY (`barangay_clearance_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70B28F4530` FOREIGN KEY (`fire_permit_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70BD0F409C` FOREIGN KEY (`area_id`) REFERENCES `loc_areas` (`id`),
  CONSTRAINT `FK_84674C70EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_84674C70F7999840` FOREIGN KEY (`bir_2303_file_id`) REFERENCES `media_upload` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loc_pos_locations`
--

LOCK TABLES `loc_pos_locations` WRITE;
/*!40000 ALTER TABLE `loc_pos_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `loc_pos_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_entry`
--

DROP TABLE IF EXISTS `log_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `date_in` datetime NOT NULL,
  `action_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `IDX_B5F762DA76ED395` (`user_id`),
  CONSTRAINT `FK_B5F762DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_entry`
--

LOCK TABLES `log_entry` WRITE;
/*!40000 ALTER TABLE `log_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_storage_localfile`
--

DROP TABLE IF EXISTS `media_storage_localfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_storage_localfile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload_id` int(11) DEFAULT NULL,
  `full_path` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_63985F3ACCCFBA31` (`upload_id`),
  CONSTRAINT `FK_63985F3ACCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_storage_localfile`
--

LOCK TABLES `media_storage_localfile` WRITE;
/*!40000 ALTER TABLE `media_storage_localfile` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_storage_localfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_upload`
--

DROP TABLE IF EXISTS `media_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `filename` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `storage_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ABC47CC1EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_ABC47CC1EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_upload`
--

LOCK TABLES `media_upload` WRITE;
/*!40000 ALTER TABLE `media_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ntf_notification`
--

DROP TABLE IF EXISTS `ntf_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ntf_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `source` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E73C19C8EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E73C19C8EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ntf_notification`
--

LOCK TABLES `ntf_notification` WRITE;
/*!40000 ALTER TABLE `ntf_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `ntf_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ntf_notification_queue`
--

DROP TABLE IF EXISTS `ntf_notification_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ntf_notification_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `flag_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_73DE7BE9EF1A9D84` (`notification_id`),
  KEY `IDX_73DE7BE9A76ED395` (`user_id`),
  CONSTRAINT `FK_73DE7BE9A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_73DE7BE9EF1A9D84` FOREIGN KEY (`notification_id`) REFERENCES `ntf_notification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ntf_notification_queue`
--

LOCK TABLES `ntf_notification_queue` WRITE;
/*!40000 ALTER TABLE `ntf_notification_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `ntf_notification_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_department`
--

DROP TABLE IF EXISTS `user_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `department_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6A7A2766FE54D947` (`group_id`),
  KEY `IDX_6A7A2766EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_6A7A2766EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_6A7A2766FE54D947` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_department`
--

LOCK TABLES `user_department` WRITE;
/*!40000 ALTER TABLE `user_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `access` longtext COLLATE utf8_unicode_ci NOT NULL,
  `job_description` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8F02BF9D5E237E06` (`name`),
  KEY `IDX_8F02BF9DAE80F5DF` (`department_id`),
  KEY `IDX_8F02BF9D727ACA70` (`parent_id`),
  CONSTRAINT `FK_8F02BF9D727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `user_group` (`id`),
  CONSTRAINT `FK_8F02BF9DAE80F5DF` FOREIGN KEY (`department_id`) REFERENCES `user_department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_items_list`
--

DROP TABLE IF EXISTS `user_items_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_items_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `serial_number` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E4439072EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E4439072EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_items_list`
--

LOCK TABLES `user_items_list` WRITE;
/*!40000 ALTER TABLE `user_items_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_items_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user`
--

DROP TABLE IF EXISTS `user_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `confirmation_token` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag_emailnotify` tinyint(1) NOT NULL,
  `first_name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agency` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `approver` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `approver_code` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `commission_type` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_number` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `erp_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `area` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `brand` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `department` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F7129A8092FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_F7129A80C05FB297` (`confirmation_token`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (2,'ad13','ad13',1,'8iz3cx9wthc0k8cogo8cowccsso00cc','V5Lgij75acC5sT1qzGosaGbsijpoUpxErl4ZO8Bcz4QvyLE/aV20lazJMLWFLRVYUqNKaWRxtPI4hsD+MnvBBw==','2017-10-14 12:07:43',NULL,NULL,'a:0:{}',NULL,1,'Adrian','Esguerra','Briones',NULL,NULL,NULL,'Straight','123','aeb@generic.com','aeb@generic.com','13',NULL,'Aqua Mineral','Sales','Junior Beauty Consultant'),(3,'abegail34','abegail34',1,'gaaklo6ud40ksoo0o44k00cgooo8o0w','NmdEEg67rfCuRaRkpA2puwDmv4eLEtdbhBO0HjRkpYo23ql8pdAgZQS/7zwb6GXxqy/QsTHQKU7/oiklmZMmvg==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Abegail','Atienza','Cataquiz',NULL,NULL,NULL,'Variable','123','aac@generic.com','aac@generic.com','14',NULL,'Aqua Mineral','Sales','Junior Beauty Consultant'),(4,'aborre','aborre',1,'9al513gfe48wskg00c8w040gcs4kgsg','F2/TRDW2Q5oryVM98JwsAn4I4NJlK2sOvlITqzWpVizg7/ZHZxW2xUHVyNis9Co1uRnVyxuPJExBWM8GjxpLxA==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Antonio','T','Borre',NULL,NULL,NULL,'Straight','13','atb@generic.com','atb@generic.com','15',NULL,'Aqua Mineral','Administrative','Area Manager'),(5,'gaguilar','gaguilar',1,'s6c0k0k3slwssggkg8s84ko8kk0kgo8','5M3XtwSpLaWJW+yC9oDVkBy/DA/pDzVy0MmawK/Xpt+9TJGDl9oAtGc4UFX7NLS/ZIIA26w+TJKewAYiK9LAIA==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Grace','G','Aguilar',NULL,NULL,NULL,'Straight','123','gga@generic.com','gga@generic.com','16',NULL,'Aqua Mineral','Administrative','Assistant Manager'),(6,'000020','000020',1,'241kCLYVSwRAWPQJwQBkCbNXyfO5JmQa8rWRNESe3UA','YSSLeGgcPeQlgRWxEkNS8PkpFNvNraH10L1hyGV4rM3gdEcYayyFr9T20rCA7sX0yFi4RUcxl4lmxgAvhVnboQ==',NULL,NULL,NULL,'a:0:{}',NULL,1,'John','K','Esguerra',NULL,NULL,NULL,'Straight','09965432222','jke@generic.com','jke@generic.com','20',NULL,'Aqua Mineral','Human Resources','HR Administrator'),(7,'admin','admin',1,'r4twVPngDTJuDsWIDboTLWRY.6W/EIykbJfgpUm1w1g','ZRPiFe9Bvix6iStVxYmlr3M/UqWzmmHVNopddiOIgcVLJaSp5Sq99OD59U1fGhkKs3iOl51HZys3Gd4J3yJB1g==','2017-10-14 12:05:44',NULL,NULL,'a:0:{}',NULL,1,'Admin','','Sys',NULL,NULL,NULL,'Variable','','sys_ad@test.com','sys_ad@test.com','1',NULL,'null','Administrative','System Administrator');
/*!40000 ALTER TABLE `user_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `world_location`
--

DROP TABLE IF EXISTS `world_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `world_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_type` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(11) NOT NULL,
  `is_visible` int(11) NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `world_location`
--

LOCK TABLES `world_location` WRITE;
/*!40000 ALTER TABLE `world_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `world_location` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-15 18:38:13
