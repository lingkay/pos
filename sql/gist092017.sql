-- MySQL dump 10.13  Distrib 5.5.55, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: gist_pos
-- ------------------------------------------------------
-- Server version	5.5.55-0ubuntu0.14.04.1

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
  CONSTRAINT `FK_DCF4B65AEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_DCF4B65A2D5B0234` FOREIGN KEY (`city`) REFERENCES `world_location` (`id`),
  CONSTRAINT `FK_DCF4B65A5373C966` FOREIGN KEY (`country`) REFERENCES `world_location` (`id`),
  CONSTRAINT `FK_DCF4B65AA393D2FB` FOREIGN KEY (`state`) REFERENCES `world_location` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_clock`
--

LOCK TABLES `gist_pos_clock` WRITE;
/*!40000 ALTER TABLE `gist_pos_clock` DISABLE KEYS */;
INSERT INTO `gist_pos_clock` VALUES (1,'1','2017-09-02','IN'),(2,'1','2017-09-02','OUT'),(3,'1','2017-09-02','IN'),(4,'1','2017-09-02','OUT'),(5,'1','2017-09-03','IN'),(6,'1','2017-09-03','IN'),(7,'1','2017-09-03','OUT'),(8,'1','2017-09-04','IN'),(9,'1','2017-09-04','IN'),(10,'1','2017-09-05','IN'),(11,'1','2017-09-05','OUT'),(12,'1','2017-09-06','IN'),(13,'1','2017-09-06','IN'),(14,'1','2017-09-06','OUT');
/*!40000 ALTER TABLE `gist_pos_clock` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `IDX_8BCECBDEEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_8BCECBDEEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans`
--

LOCK TABLES `gist_pos_trans` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans` DISABLE KEYS */;
INSERT INTO `gist_pos_trans` VALUES (69,NULL,'005-000001','32000','0','23','per','Paid','true','2017-09-02 01:03:09','10','3980','2909.09','39800','29090.91','excl','22000','43780','32000','none','normal'),(70,NULL,'005-000070','32890','0','23','reg','Paid','true','2017-09-02 01:06:17','10','2990','2990','29900','29900','excl','16500','32890','0','none','normal'),(71,NULL,'005-000070','32890','0','23','reg','Paid','true','2017-09-02 01:08:14','10','2990','2990','29900','29900','excl','16500','32890','0','none','normal'),(72,NULL,'005-000072','1089','-1','22','reg','Paid','true','2017-09-02 01:12:57','10','99','99','990','990','excl','1089','1089','0','none','normal'),(73,NULL,'005-000073','32890','32890','0','none','Frozen','true','2017-09-02 01:13:12','10','2990','2990','29900','29900','excl','16500','32890','0','none','normal'),(74,NULL,'005-000074','14300','0','26','reg','Paid','true','2017-09-02 11:01:05','10','1300','1300','13000','13000','excl','7150','14300','0','none','normal'),(75,NULL,'005-000075','11979','-21','26','reg','Paid','true','2017-09-03 13:00:59','10','1089','1089','10890','10890','excl','6589','11979','0','none','normal'),(76,NULL,'005-000076','43780','-10','28','reg','Paid','true','2017-09-03 13:03:04','10','3980','3980','39800','39800','excl','22000','43780','0','none','normal'),(77,NULL,'005-000077','70382','0','29','per','Paid','true','2017-09-04 09:44:36','10','7570','6398.36','75700','63983.64','excl','41800','83270','70382','none','normal'),(78,NULL,'005-000078','43780','43780','0','none','Frozen','true','2017-09-04 09:45:32','10','3980','3980','39800','39800','excl','22000','43780','0','none','quotation'),(79,NULL,'005-000078','32890','32890','28','reg','Paid','true','2017-09-04 13:39:30','10','2990','2990','29900','29900','excl','16500','32890','0','none','quotation'),(80,NULL,'005-000078','58080','58080','0','none','Frozen','true','2017-09-06 00:08:17','10','5280','5280','52800','52800','excl','43395','58080','0','none','normal'),(81,NULL,'005-000081','32890','0','9','per','Paid','true','2017-09-06 00:11:44','10','3980','2990','39800','29900','excl','22000','43780','32890','none','quotation'),(82,NULL,'005-000081','13156','0','29','per','Paid','true','2017-09-06 00:29:17','10','2990','1196','29900','11960','excl','16500','32890','13156','none','normal'),(83,NULL,'005-000081','13156','0','29','per','Paid','true','2017-09-06 00:29:27','10','2990','1196','29900','11960','excl','16500','32890','13156','none','normal'),(84,NULL,'005-000081','13156','0','29','per','Paid','true','2017-09-06 00:29:29','10','2990','1196','29900','11960','excl','16500','32890','13156','none','normal'),(85,NULL,'005-000085','17490','0','25','reg','Paid','true','2017-09-06 06:40:05','10','1590','1590','15900','15900','excl','8800','17490','0','none','normal'),(86,NULL,'005-000086','43780','43780','9','none','Frozen','true','2017-09-07 07:08:45','10','3980','3980','39800','39800','excl','22000','43780','0','none','normal');
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
  PRIMARY KEY (`id`),
  KEY `IDX_96F107F02FC0CB0F` (`transaction_id`),
  KEY `IDX_96F107F0EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_96F107F0EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_96F107F02FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `gist_pos_trans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans_item`
--

LOCK TABLES `gist_pos_trans_item` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans_item` DISABLE KEYS */;
INSERT INTO `gist_pos_trans_item` VALUES (120,69,NULL,'1504310557800','10890','5500','0','Contura Eye Cream','gift','0','2017-09-02 01:03:09'),(121,69,NULL,'1504310557579','32890','16500','32000','24K Intensive Mask','discamt','890','2017-09-02 01:03:09'),(122,70,NULL,'1504310763899','32890','16500','0','24K Intensive Mask','none','0','2017-09-02 01:06:18'),(123,71,NULL,'1504310763899','32890','16500','0','24K Intensive Mask','none','0','2017-09-02 01:08:15'),(124,72,NULL,'1504311159015','1089','1089','0','TEST','none','0','2017-09-02 01:12:57'),(125,73,NULL,'1504311188646','32890','16500','0','24K Intensive Mask','none','0','2017-09-02 01:13:12'),(126,74,NULL,'1504346349930','14300','7150','0','Body Care Gift Set - Blue','none','0','2017-09-02 11:01:05'),(127,75,NULL,'1504465238737','1089','1089','0','TEST','none','0','2017-09-03 13:01:00'),(128,75,NULL,'1504465237176','10890','5500','0','Contura Eye Cream','none','0','2017-09-03 13:01:00'),(129,76,NULL,'1504465278374','10890','5500','0','Contura Eye Cream','none','0','2017-09-03 13:03:04'),(130,76,NULL,'1504465278066','32890','16500','0','24K Intensive Mask','none','0','2017-09-03 13:03:05'),(131,77,NULL,'1504514262505','2420','1210','0','Body Lotion - Delicate Dew (Big)','gift','0','2017-09-04 09:44:36'),(132,77,NULL,'1504514262003','4180','2090','3180','Blissful Body Butter - Springtime','discamt','1000','2017-09-04 09:44:36'),(133,77,NULL,'1504514256936','32890','16500','32890','24K Intensive Mask','none','0','2017-09-04 09:44:36'),(134,77,NULL,'1504514258908','32890','16500','26312','24K Intensive Mask','disc','20','2017-09-04 09:44:36'),(135,77,NULL,'1504514257426','10890','5500','8000','Contura Eye Cream','chg','8000','2017-09-04 09:44:36'),(136,78,NULL,'1504514717176','10890','5500','0','Contura Eye Cream','none','0','2017-09-04 09:45:32'),(137,78,NULL,'1504514716892','32890','16500','0','24K Intensive Mask','none','0','2017-09-04 09:45:32'),(138,79,NULL,'1504528751196','32890','16500','0','24K Intensive Mask','none','0','2017-09-04 13:39:30'),(139,80,NULL,'1504652924529','30690','29700','0','24K Intensive Face Serum','none','0','2017-09-06 00:08:17'),(140,80,NULL,'1504652923815','27390','13695','0','24K Intensive Face Cream','none','0','2017-09-06 00:08:18'),(141,81,NULL,'1504653090709','10890','5500','0','Contura Eye Cream','gift','0','2017-09-06 00:11:45'),(142,81,NULL,'1504653090382','32890','16500','32890','24K Intensive Mask','none','0','2017-09-06 00:11:45'),(143,82,NULL,'1504654067924','32890','16500','13156','24K Intensive Mask','disc','60','2017-09-06 00:29:17'),(144,83,NULL,'1504654067924','32890','16500','13156','24K Intensive Mask','disc','60','2017-09-06 00:29:28'),(145,84,NULL,'1504654067924','32890','16500','13156','24K Intensive Mask','disc','60','2017-09-06 00:29:30'),(146,85,NULL,'1504676145207','2420','1210','0','Body Lotion - Delicate Dew (Big)','none','0','2017-09-06 06:40:05'),(147,85,NULL,'1504676144359','4180','2090','0','Blissful Body Butter - Springtime','none','0','2017-09-06 06:40:05'),(148,85,NULL,'1504676141055','10890','5500','0','Contura Eye Cream','none','0','2017-09-06 06:40:06'),(149,86,NULL,'1504756022192','10890','5500','0','Contura Eye Cream','none','0','2017-09-07 07:08:46'),(150,86,NULL,'1504756019745','32890','16500','0','24K Intensive Mask','none','0','2017-09-07 07:08:46');
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
  PRIMARY KEY (`id`),
  KEY `IDX_293934682FC0CB0F` (`transaction_id`),
  KEY `IDX_29393468EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_29393468EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_293934682FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `gist_pos_trans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans_payment`
--

LOCK TABLES `gist_pos_trans_payment` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans_payment` DISABLE KEYS */;
INSERT INTO `gist_pos_trans_payment` VALUES (72,69,NULL,'Credit Card',NULL,'32000','2017-09-02 01:03:10'),(73,70,NULL,'Cash',NULL,'32890','2017-09-02 01:06:18'),(74,71,NULL,'Cash',NULL,'32890','2017-09-02 01:08:15'),(75,72,NULL,'Cash',NULL,'1090','2017-09-02 01:12:57'),(76,74,NULL,'Credit Card',NULL,'870','2017-09-02 11:01:05'),(77,74,NULL,'Credit Card',NULL,'12000','2017-09-02 11:01:05'),(78,74,NULL,'Cash',NULL,'1430','2017-09-02 11:01:05'),(79,75,NULL,'Cash',NULL,'12000','2017-09-03 13:01:00'),(80,76,NULL,'Credit Card',NULL,'20000','2017-09-03 13:03:05'),(81,76,NULL,'Cash',NULL,'3790','2017-09-03 13:03:05'),(82,76,NULL,'Credit Card',NULL,'10000','2017-09-03 13:03:05'),(83,76,NULL,'Check',NULL,'5000','2017-09-03 13:03:05'),(84,76,NULL,'Check',NULL,'5000','2017-09-03 13:03:05'),(85,77,NULL,'Cash',NULL,'382','2017-09-04 09:44:36'),(86,77,NULL,'Check',NULL,'15000','2017-09-04 09:44:36'),(87,77,NULL,'Credit Card',NULL,'5000','2017-09-04 09:44:36'),(88,77,NULL,'Cash',NULL,'50000','2017-09-04 09:44:36'),(89,81,NULL,'Cash',NULL,'32890','2017-09-06 00:11:45'),(90,82,NULL,'Cash',NULL,'13156','2017-09-06 00:29:17'),(91,83,NULL,'Cash',NULL,'13156','2017-09-06 00:29:28'),(92,84,NULL,'Cash',NULL,'13156','2017-09-06 00:29:30'),(93,85,NULL,'Cash',NULL,'17490','2017-09-06 06:40:06');
/*!40000 ALTER TABLE `gist_pos_trans_payment` ENABLE KEYS */;
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
  CONSTRAINT `FK_E57B4B31F5B7AF75` FOREIGN KEY (`address_id`) REFERENCES `cnt_address` (`id`),
  CONSTRAINT `FK_E57B4B31EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
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
  CONSTRAINT `FK_4D67C2D65FF5E57A` FOREIGN KEY (`inv_account_id`) REFERENCES `inv_account` (`id`),
  CONSTRAINT `FK_4D67C2D62FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `inv_transaction` (`id`),
  CONSTRAINT `FK_4D67C2D64584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`)
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
  CONSTRAINT `FK_A208F6AFEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_A208F6AF11CE312B` FOREIGN KEY (`borrower_id`) REFERENCES `user_user` (`id`)
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
  CONSTRAINT `FK_4CCBA4864584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`),
  CONSTRAINT `FK_4CCBA4862FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `inv_transaction` (`id`),
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
  CONSTRAINT `FK_25A99732EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_25A9973265191DCD` FOREIGN KEY (`user_issuedto_id`) REFERENCES `user_user` (`id`)
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
  CONSTRAINT `FK_CEA9AD74549BA696` FOREIGN KEY (`doc_permit_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_CEA9AD7412469DE2` FOREIGN KEY (`category_id`) REFERENCES `inv_product_category` (`id`),
  CONSTRAINT `FK_CEA9AD7444F5D008` FOREIGN KEY (`brand_id`) REFERENCES `inv_brand` (`id`),
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
  CONSTRAINT `FK_2CDC6F965FF5E57A` FOREIGN KEY (`inv_account_id`) REFERENCES `inv_account` (`id`),
  CONSTRAINT `FK_2CDC6F964584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`)
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
  CONSTRAINT `FK_A62E0E1D5FF5E57A` FOREIGN KEY (`inv_account_id`) REFERENCES `inv_account` (`id`),
  CONSTRAINT `FK_A62E0E1D2FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `inv_transaction` (`id`),
  CONSTRAINT `FK_A62E0E1D4584665A` FOREIGN KEY (`product_id`) REFERENCES `inv_product` (`id`)
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
  CONSTRAINT `FK_64272A69EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_64272A692FDDA7C1` FOREIGN KEY (`pos_location_id`) REFERENCES `loc_pos_locations` (`id`)
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
  CONSTRAINT `FK_84674C70EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_84674C7019EFD317` FOREIGN KEY (`bir_0605_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70430F22CE` FOREIGN KEY (`mayors_permit_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70699AD0D7` FOREIGN KEY (`sanitary_permit_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C709A227855` FOREIGN KEY (`insurance_policy_document`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70AB3ADCB4` FOREIGN KEY (`barangay_clearance_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70B28F4530` FOREIGN KEY (`fire_permit_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_84674C70BD0F409C` FOREIGN KEY (`area_id`) REFERENCES `loc_areas` (`id`),
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
  `group_id` int(11) DEFAULT NULL,
  `emp_contract_file_id` int(11) DEFAULT NULL,
  `nbi_clearance_file_id` int(11) DEFAULT NULL,
  `police_clearance_file_id` int(11) DEFAULT NULL,
  `previous_coe_file_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
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
  `nationality` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provincial_address` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_address` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `life_insurance` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `life_insurance_expiration` date DEFAULT NULL,
  `sss` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `philhealth` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pagibig` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tin` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ec_full_name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ec_contact_number` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ec_relationship` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ec_remarks` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employment_date` date DEFAULT NULL,
  `contract_expiration` date DEFAULT NULL,
  `contract_status` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employment_remarks` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `items_given` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F7129A8092FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_F7129A80C05FB297` (`confirmation_token`),
  KEY `IDX_F7129A80FE54D947` (`group_id`),
  KEY `IDX_F7129A806520A569` (`emp_contract_file_id`),
  KEY `IDX_F7129A80D8B907F6` (`nbi_clearance_file_id`),
  KEY `IDX_F7129A80A74814F2` (`police_clearance_file_id`),
  KEY `IDX_F7129A80A4C296D1` (`previous_coe_file_id`),
  KEY `IDX_F7129A80BD0F409C` (`area_id`),
  KEY `IDX_F7129A8044F5D008` (`brand_id`),
  CONSTRAINT `FK_F7129A8044F5D008` FOREIGN KEY (`brand_id`) REFERENCES `inv_brand` (`id`),
  CONSTRAINT `FK_F7129A806520A569` FOREIGN KEY (`emp_contract_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_F7129A80A4C296D1` FOREIGN KEY (`previous_coe_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_F7129A80A74814F2` FOREIGN KEY (`police_clearance_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_F7129A80BD0F409C` FOREIGN KEY (`area_id`) REFERENCES `loc_areas` (`id`),
  CONSTRAINT `FK_F7129A80D8B907F6` FOREIGN KEY (`nbi_clearance_file_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_F7129A80FE54D947` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin','admin',1,'Zn94rqaDGHoeYOJc68p8Vac9X6HOZAR442ZTAiiWf7Q','b/HwtYWivb/yh5b7PZxeDTP+OAUcJ34XlywuHz//QvBUkTU6pq3RQbcym0AiiSuKDXjGbGIwM9XaF9TBWvB3tw==','2017-09-08 06:57:11',NULL,NULL,'a:0:{}',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a@a.com','a@a.com');
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

-- Dump completed on 2017-09-10  0:41:50
