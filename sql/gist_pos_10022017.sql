-- MySQL dump 10.14  Distrib 5.5.52-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: gist_pos
-- ------------------------------------------------------
-- Server version	5.5.52-MariaDB

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
-- Table structure for table `auth_tokens`
--

DROP TABLE IF EXISTS `auth_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `token` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_tokens`
--

LOCK TABLES `auth_tokens` WRITE;
/*!40000 ALTER TABLE `auth_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biometrics_attendance`
--

DROP TABLE IF EXISTS `biometrics_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biometrics_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `checktime` datetime DEFAULT NULL,
  `checktype` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A8AD4CA68C03F15C` (`employee_id`),
  CONSTRAINT `FK_A8AD4CA68C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biometrics_attendance`
--

LOCK TABLES `biometrics_attendance` WRITE;
/*!40000 ALTER TABLE `biometrics_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `biometrics_attendance` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `cfg_entry` VALUES ('gist_sys_area_id','1'),('gist_sys_erp_url','http://dev.gisterp2'),('gist_sys_pos_url','http://dev.gistpos');
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
-- Table structure for table `cominfo_phone`
--

DROP TABLE IF EXISTS `cominfo_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cominfo_phone` (
  `cominfo_id` int(11) NOT NULL,
  `phone_id` int(11) NOT NULL,
  PRIMARY KEY (`cominfo_id`,`phone_id`),
  KEY `IDX_D057E20AD189329C` (`cominfo_id`),
  KEY `IDX_D057E20A3B7323CB` (`phone_id`),
  CONSTRAINT `FK_D057E20A3B7323CB` FOREIGN KEY (`phone_id`) REFERENCES `cnt_phone` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D057E20AD189329C` FOREIGN KEY (`cominfo_id`) REFERENCES `comp_profile` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cominfo_phone`
--

LOCK TABLES `cominfo_phone` WRITE;
/*!40000 ALTER TABLE `cominfo_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `cominfo_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comp_profile`
--

DROP TABLE IF EXISTS `comp_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comp_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A3B2C267EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_A3B2C267EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comp_profile`
--

LOCK TABLES `comp_profile` WRITE;
/*!40000 ALTER TABLE `comp_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `comp_profile` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_clock`
--

LOCK TABLES `gist_pos_clock` WRITE;
/*!40000 ALTER TABLE `gist_pos_clock` DISABLE KEYS */;
INSERT INTO `gist_pos_clock` VALUES (1,'1','2017-09-02','IN'),(2,'1','2017-09-02','IN'),(3,'1','2017-09-02','OUT'),(4,'1','2017-09-02','IN');
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
  `erp_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E071D681EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E071D681EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_customer_info`
--

LOCK TABLES `gist_pos_customer_info` WRITE;
/*!40000 ALTER TABLE `gist_pos_customer_info` DISABLE KEYS */;
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
  `status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `transaction_type` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `synced_to_erp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8BCECBDE727ACA70` (`parent_id`),
  KEY `IDX_8BCECBDEEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_8BCECBDE727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `gist_pos_trans` (`id`),
  CONSTRAINT `FK_8BCECBDEEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans`
--

LOCK TABLES `gist_pos_trans` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans` DISABLE KEYS */;
INSERT INTO `gist_pos_trans` VALUES (31,51,'N-000031','32890','0','11','Paid','2017-10-01 07:34:58','per','true','12','7629.6','3946.8','55950.4','28943.2','incl','46200','63580','32890','none','normal','true',NULL,'-13-310',NULL,NULL,NULL),(32,51,'N-000032','32890','0','11','Paid','2017-10-01 11:29:39','reg','true','12','3946.8','3946.8','28943.2','28943.2','incl','16500','32890','0','none','normal','true',NULL,'16-390',NULL,NULL,NULL);
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
  PRIMARY KEY (`id`),
  KEY `IDX_96F107F02FC0CB0F` (`transaction_id`),
  KEY `IDX_96F107F0EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_96F107F02FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `gist_pos_trans` (`id`),
  CONSTRAINT `FK_96F107F0EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans_item`
--

LOCK TABLES `gist_pos_trans_item` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans_item` DISABLE KEYS */;
INSERT INTO `gist_pos_trans_item` VALUES (166,31,NULL,'8','32890','16500','32890','24K Intensive Mask','none','0','2017-10-01 07:35:00','839901004783','839901004783'),(167,31,NULL,'7','30690','29700','0','24K Intensive Face Serum','gift','0','2017-10-01 07:35:01','83990100343','83990100343'),(168,32,NULL,'8','32890','16500','0','24K Intensive Mask','none','0','2017-10-01 11:29:40','839901004783','839901004783');
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
  `control_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_expiry` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_cvv` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_terms` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_class` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_terminal_operator` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `interest` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payee` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payor` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_293934682FC0CB0F` (`transaction_id`),
  KEY `IDX_29393468EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_293934682FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `gist_pos_trans` (`id`),
  CONSTRAINT `FK_29393468EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans_payment`
--

LOCK TABLES `gist_pos_trans_payment` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans_payment` DISABLE KEYS */;
INSERT INTO `gist_pos_trans_payment` VALUES (101,31,NULL,'Cash',NULL,'32890','2017-10-01 07:35:01','null',NULL,'null',NULL,NULL,'null','null','null',NULL,'null','null','null','null','null'),(102,32,NULL,'Cash',NULL,'32890','2017-10-01 11:29:41','null',NULL,'null',NULL,NULL,'null','null','null',NULL,'null','null','null','null','null');
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
  CONSTRAINT `FK_F6CEBF4C2FC0CB0F` FOREIGN KEY (`transaction_id`) REFERENCES `gist_pos_trans` (`id`),
  CONSTRAINT `FK_F6CEBF4C44F779A2` FOREIGN KEY (`consultant_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_F6CEBF4CEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gist_pos_trans_split`
--

LOCK TABLES `gist_pos_trans_split` WRITE;
/*!40000 ALTER TABLE `gist_pos_trans_split` DISABLE KEYS */;
/*!40000 ALTER TABLE `gist_pos_trans_split` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_advance`
--

DROP TABLE IF EXISTS `hr_advance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_advance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `releaser_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date_filed` datetime NOT NULL,
  `date_released` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `flag_deducted` tinyint(1) NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_904E2468C03F15C` (`employee_id`),
  KEY `IDX_904E24671C8FDB3` (`releaser_id`),
  KEY `IDX_904E246EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_904E24671C8FDB3` FOREIGN KEY (`releaser_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_904E2468C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_904E246EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_advance`
--

LOCK TABLES `hr_advance` WRITE;
/*!40000 ALTER TABLE `hr_advance` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_advance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app`
--

DROP TABLE IF EXISTS `hr_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `benefit_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `choice` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `first_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nickname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `app_status` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `offer_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `background_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `signing_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `appeared` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_73362912CCCFBA31` (`upload_id`),
  KEY `IDX_73362912B517B89` (`benefit_id`),
  KEY `IDX_73362912EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_73362912B517B89` FOREIGN KEY (`benefit_id`) REFERENCES `hr_benefit` (`id`),
  CONSTRAINT `FK_73362912CCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_73362912EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app`
--

LOCK TABLES `hr_app` WRITE;
/*!40000 ALTER TABLE `hr_app` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_checklist`
--

DROP TABLE IF EXISTS `hr_app_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_checklist` (
  `application_id` int(11) NOT NULL,
  `checklist_id` int(11) NOT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `date_received` date DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`application_id`,`checklist_id`),
  UNIQUE KEY `UNIQ_82DE3953CCCFBA31` (`upload_id`),
  KEY `IDX_82DE39533E030ACD` (`application_id`),
  KEY `IDX_82DE3953B16D08A7` (`checklist_id`),
  CONSTRAINT `FK_82DE39533E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_82DE3953B16D08A7` FOREIGN KEY (`checklist_id`) REFERENCES `hr_checklist` (`id`),
  CONSTRAINT `FK_82DE3953CCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_checklist`
--

LOCK TABLES `hr_app_checklist` WRITE;
/*!40000 ALTER TABLE `hr_app_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_education`
--

DROP TABLE IF EXISTS `hr_app_education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_education` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `elementary` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `highschool` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `vocational` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `college` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `post_graduate` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_5BD0AAE3E030ACD` (`application_id`),
  KEY `IDX_5BD0AAEEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_5BD0AAE3E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_5BD0AAEEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_education`
--

LOCK TABLES `hr_app_education` WRITE;
/*!40000 ALTER TABLE `hr_app_education` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_exam`
--

DROP TABLE IF EXISTS `hr_app_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `exam_date` datetime DEFAULT NULL,
  `exam_time` datetime DEFAULT NULL,
  `exam_result` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `result` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8670419C3E030ACD` (`application_id`),
  KEY `IDX_8670419CEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_8670419C3E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_8670419CEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_exam`
--

LOCK TABLES `hr_app_exam` WRITE;
/*!40000 ALTER TABLE `hr_app_exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_experience`
--

DROP TABLE IF EXISTS `hr_app_experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_experience` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `name_address_company` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `salary_start` int(11) NOT NULL,
  `salary_last` int(11) NOT NULL,
  `reason` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5CFD4B403E030ACD` (`application_id`),
  KEY `IDX_5CFD4B40EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_5CFD4B403E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_5CFD4B40EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_experience`
--

LOCK TABLES `hr_app_experience` WRITE;
/*!40000 ALTER TABLE `hr_app_experience` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_interview`
--

DROP TABLE IF EXISTS `hr_app_interview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_interview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `interview_result` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_11AA68483E030ACD` (`application_id`),
  KEY `IDX_11AA6848EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_11AA68483E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_11AA6848EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_interview`
--

LOCK TABLES `hr_app_interview` WRITE;
/*!40000 ALTER TABLE `hr_app_interview` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_interview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_other_info`
--

DROP TABLE IF EXISTS `hr_app_other_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_other_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `forced_resign` tinyint(1) NOT NULL,
  `crime_convicted` tinyint(1) NOT NULL,
  `serious_disease` tinyint(1) NOT NULL,
  `license` tinyint(1) NOT NULL,
  `license_type` tinyint(1) DEFAULT NULL,
  `sss_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tin_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `philhealth_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pagibig_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_FBA0EDC63E030ACD` (`application_id`),
  KEY `IDX_FBA0EDC6EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_FBA0EDC63E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_FBA0EDC6EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_other_info`
--

LOCK TABLES `hr_app_other_info` WRITE;
/*!40000 ALTER TABLE `hr_app_other_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_other_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_profile`
--

DROP TABLE IF EXISTS `hr_app_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `my_phone_id` int(11) DEFAULT NULL,
  `contact_phone_id` int(11) DEFAULT NULL,
  `home_address` int(11) DEFAULT NULL,
  `permanent_address` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `birth_date` datetime NOT NULL,
  `birth_place` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `height` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `contact_person` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `civil_status` smallint(6) NOT NULL,
  `no_dependents` smallint(6) NOT NULL,
  `spouse_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `no_children` smallint(6) NOT NULL,
  `father_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `father_occupation` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `mother_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `mother_occupation` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_FDF57FC43E030ACD` (`application_id`),
  UNIQUE KEY `UNIQ_FDF57FC4921B684` (`my_phone_id`),
  UNIQUE KEY `UNIQ_FDF57FC4A156BF5C` (`contact_phone_id`),
  UNIQUE KEY `UNIQ_FDF57FC4B86EA4D9` (`home_address`),
  UNIQUE KEY `UNIQ_FDF57FC4367E8A28` (`permanent_address`),
  KEY `IDX_FDF57FC4EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_FDF57FC4367E8A28` FOREIGN KEY (`permanent_address`) REFERENCES `cnt_address` (`id`),
  CONSTRAINT `FK_FDF57FC43E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_FDF57FC4921B684` FOREIGN KEY (`my_phone_id`) REFERENCES `cnt_phone` (`id`),
  CONSTRAINT `FK_FDF57FC4A156BF5C` FOREIGN KEY (`contact_phone_id`) REFERENCES `cnt_phone` (`id`),
  CONSTRAINT `FK_FDF57FC4B86EA4D9` FOREIGN KEY (`home_address`) REFERENCES `cnt_address` (`id`),
  CONSTRAINT `FK_FDF57FC4EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_profile`
--

LOCK TABLES `hr_app_profile` WRITE;
/*!40000 ALTER TABLE `hr_app_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_reference`
--

DROP TABLE IF EXISTS `hr_app_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_reference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `phone_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `salutation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `relationship` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_70141D6F3E030ACD` (`application_id`),
  KEY `IDX_70141D6F3B7323CB` (`phone_id`),
  KEY `IDX_70141D6FEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_70141D6F3B7323CB` FOREIGN KEY (`phone_id`) REFERENCES `cnt_phone` (`id`),
  CONSTRAINT `FK_70141D6F3E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_70141D6FEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_reference`
--

LOCK TABLES `hr_app_reference` WRITE;
/*!40000 ALTER TABLE `hr_app_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_skills`
--

DROP TABLE IF EXISTS `hr_app_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `computer` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `related` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `hobbies` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AB0B6ABE3E030ACD` (`application_id`),
  KEY `IDX_AB0B6ABEEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_AB0B6ABE3E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_AB0B6ABEEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_skills`
--

LOCK TABLES `hr_app_skills` WRITE;
/*!40000 ALTER TABLE `hr_app_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_appraisal`
--

DROP TABLE IF EXISTS `hr_appraisal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_appraisal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `preset_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `overall_quali` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `overall_quanti` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7A39D5108C03F15C` (`employee_id`),
  KEY `IDX_7A39D51080688E6F` (`preset_id`),
  KEY `IDX_7A39D510EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_7A39D51080688E6F` FOREIGN KEY (`preset_id`) REFERENCES `hr_appraisal_settings` (`id`),
  CONSTRAINT `FK_7A39D5108C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_7A39D510EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_appraisal`
--

LOCK TABLES `hr_appraisal` WRITE;
/*!40000 ALTER TABLE `hr_appraisal` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_appraisal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_appraisal_settings`
--

DROP TABLE IF EXISTS `hr_appraisal_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_appraisal_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `obj_count` int(11) DEFAULT NULL,
  `obj_percentage` double DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BEFA118AEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_BEFA118AEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_appraisal_settings`
--

LOCK TABLES `hr_appraisal_settings` WRITE;
/*!40000 ALTER TABLE `hr_appraisal_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_appraisal_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_attendance`
--

DROP TABLE IF EXISTS `hr_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `approver_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `status` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `time_in` datetime DEFAULT NULL,
  `time_out` datetime DEFAULT NULL,
  `undertime` int(11) DEFAULT NULL,
  `late` int(11) DEFAULT NULL,
  `overtime` int(11) DEFAULT NULL,
  `adjustment_date` datetime DEFAULT NULL,
  `adjusted_time_in` datetime DEFAULT NULL,
  `adjusted_time_out` datetime DEFAULT NULL,
  `adjustment_status` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reason` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adjust_approved` datetime DEFAULT NULL,
  `overtime_date` datetime DEFAULT NULL,
  `overtime_pending` int(11) DEFAULT NULL,
  `overtime_status` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `overtime_reason` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `overtime_approved` datetime DEFAULT NULL,
  `halfday` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F6DA1CDFCCCFBA31` (`upload_id`),
  UNIQUE KEY `attendance_idx` (`employee_id`,`date`),
  KEY `IDX_F6DA1CDF8C03F15C` (`employee_id`),
  KEY `IDX_F6DA1CDFBB23766C` (`approver_id`),
  KEY `IDX_F6DA1CDFEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_F6DA1CDF8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_F6DA1CDFBB23766C` FOREIGN KEY (`approver_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_F6DA1CDFCCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_F6DA1CDFEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_attendance`
--

LOCK TABLES `hr_attendance` WRITE;
/*!40000 ALTER TABLE `hr_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_benefit`
--

DROP TABLE IF EXISTS `hr_benefit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_benefit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `emp_status` longtext COLLATE utf8_unicode_ci,
  `type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `department` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B20EF9AAEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_B20EF9AAEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_benefit`
--

LOCK TABLES `hr_benefit` WRITE;
/*!40000 ALTER TABLE `hr_benefit` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_benefit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_benefit_characteristic`
--

DROP TABLE IF EXISTS `hr_benefit_characteristic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_benefit_characteristic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8A622FC0EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_8A622FC0EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_benefit_characteristic`
--

LOCK TABLES `hr_benefit_characteristic` WRITE;
/*!40000 ALTER TABLE `hr_benefit_characteristic` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_benefit_characteristic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_checklist`
--

DROP TABLE IF EXISTS `hr_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_checklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_1BA93EFEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_1BA93EFEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_checklist`
--

LOCK TABLES `hr_checklist` WRITE;
/*!40000 ALTER TABLE `hr_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_department`
--

DROP TABLE IF EXISTS `hr_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_head_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_5624F0C45E237E06` (`name`),
  UNIQUE KEY `UNIQ_5624F0C4CF74E3A9` (`dept_head_id`),
  KEY `IDX_5624F0C4727ACA70` (`parent_id`),
  KEY `IDX_5624F0C4EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_5624F0C4727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `FK_5624F0C4CF74E3A9` FOREIGN KEY (`dept_head_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_5624F0C4EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_department`
--

LOCK TABLES `hr_department` WRITE;
/*!40000 ALTER TABLE `hr_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_dependent`
--

DROP TABLE IF EXISTS `hr_dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_dependent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `relation` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `flag_qualified` tinyint(1) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E64389648C03F15C` (`employee_id`),
  KEY `IDX_E6438964EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E64389648C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_E6438964EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_dependent`
--

LOCK TABLES `hr_dependent` WRITE;
/*!40000 ALTER TABLE `hr_dependent` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_downloadables`
--

DROP TABLE IF EXISTS `hr_downloadables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_downloadables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_5D195B26CCCFBA31` (`upload_id`),
  KEY `IDX_5D195B26EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_5D195B26CCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_5D195B26EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_downloadables`
--

LOCK TABLES `hr_downloadables` WRITE;
/*!40000 ALTER TABLE `hr_downloadables` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_downloadables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_employee`
--

DROP TABLE IF EXISTS `hr_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) DEFAULT NULL,
  `job_title_id` int(11) DEFAULT NULL,
  `job_level_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `schedules_id` int(11) DEFAULT NULL,
  `pay_period_id` int(11) DEFAULT NULL,
  `pay_schedule_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `first_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employment_status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pay_rate` decimal(10,2) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `email` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_hired` date NOT NULL,
  `marital_status` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag_new` tinyint(1) NOT NULL,
  `dependents` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `exemption` tinyint(1) NOT NULL,
  `cashbond_rate` decimal(10,2) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_E67AB75B3E030ACD` (`application_id`),
  KEY `IDX_E67AB75BAE80F5DF` (`department_id`),
  KEY `IDX_E67AB75B6DD822C6` (`job_title_id`),
  KEY `IDX_E67AB75B38F6EEDC` (`job_level_id`),
  KEY `IDX_E67AB75B64D218E` (`location_id`),
  KEY `IDX_E67AB75B116C90BC` (`schedules_id`),
  KEY `IDX_E67AB75BC185C5A2` (`pay_period_id`),
  KEY `IDX_E67AB75B7C5F773C` (`pay_schedule_id`),
  KEY `IDX_E67AB75B727ACA70` (`parent_id`),
  KEY `IDX_E67AB75BEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E67AB75B116C90BC` FOREIGN KEY (`schedules_id`) REFERENCES `hr_schedule` (`id`),
  CONSTRAINT `FK_E67AB75B38F6EEDC` FOREIGN KEY (`job_level_id`) REFERENCES `hr_job_level` (`id`),
  CONSTRAINT `FK_E67AB75B3E030ACD` FOREIGN KEY (`application_id`) REFERENCES `hr_app` (`id`),
  CONSTRAINT `FK_E67AB75B64D218E` FOREIGN KEY (`location_id`) REFERENCES `hr_location` (`id`),
  CONSTRAINT `FK_E67AB75B6DD822C6` FOREIGN KEY (`job_title_id`) REFERENCES `hr_job_title` (`id`),
  CONSTRAINT `FK_E67AB75B727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_E67AB75B7C5F773C` FOREIGN KEY (`pay_schedule_id`) REFERENCES `pay_period` (`id`),
  CONSTRAINT `FK_E67AB75BAE80F5DF` FOREIGN KEY (`department_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `FK_E67AB75BC185C5A2` FOREIGN KEY (`pay_period_id`) REFERENCES `pay_period` (`id`),
  CONSTRAINT `FK_E67AB75BEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_employee`
--

LOCK TABLES `hr_employee` WRITE;
/*!40000 ALTER TABLE `hr_employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_employee_benefits`
--

DROP TABLE IF EXISTS `hr_employee_benefits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_employee_benefits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `benefit_id` int(11) DEFAULT NULL,
  `leave_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1CAB7B718C03F15C` (`employee_id`),
  KEY `IDX_1CAB7B71B517B89` (`benefit_id`),
  KEY `IDX_1CAB7B711B2ADB5C` (`leave_id`),
  CONSTRAINT `FK_1CAB7B711B2ADB5C` FOREIGN KEY (`leave_id`) REFERENCES `leave_type` (`id`),
  CONSTRAINT `FK_1CAB7B718C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_1CAB7B71B517B89` FOREIGN KEY (`benefit_id`) REFERENCES `hr_benefit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_employee_benefits`
--

LOCK TABLES `hr_employee_benefits` WRITE;
/*!40000 ALTER TABLE `hr_employee_benefits` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_employee_benefits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_employee_checklist`
--

DROP TABLE IF EXISTS `hr_employee_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_employee_checklist` (
  `profile_id` int(11) NOT NULL,
  `checklist_id` int(11) NOT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `date_received` date DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`profile_id`,`checklist_id`),
  UNIQUE KEY `UNIQ_21E402ACCCCFBA31` (`upload_id`),
  KEY `IDX_21E402ACCCFA12B8` (`profile_id`),
  KEY `IDX_21E402ACB16D08A7` (`checklist_id`),
  CONSTRAINT `FK_21E402ACB16D08A7` FOREIGN KEY (`checklist_id`) REFERENCES `hr_checklist` (`id`),
  CONSTRAINT `FK_21E402ACCCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_21E402ACCCFA12B8` FOREIGN KEY (`profile_id`) REFERENCES `hr_employee_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_employee_checklist`
--

LOCK TABLES `hr_employee_checklist` WRITE;
/*!40000 ALTER TABLE `hr_employee_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_employee_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_employee_leaves`
--

DROP TABLE IF EXISTS `hr_employee_leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_employee_leaves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `leave_id` int(11) DEFAULT NULL,
  `avail_leaves` double NOT NULL,
  `leave_year` int(11) NOT NULL,
  `approved_count` int(11) DEFAULT NULL,
  `pending_count` int(11) DEFAULT NULL,
  `used_count` int(11) DEFAULT NULL,
  `accumulated_leave` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_21E32D68C03F15C` (`employee_id`),
  KEY `IDX_21E32D61B2ADB5C` (`leave_id`),
  CONSTRAINT `FK_21E32D61B2ADB5C` FOREIGN KEY (`leave_id`) REFERENCES `leave_type` (`id`),
  CONSTRAINT `FK_21E32D68C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_employee_leaves`
--

LOCK TABLES `hr_employee_leaves` WRITE;
/*!40000 ALTER TABLE `hr_employee_leaves` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_employee_leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_employee_profile`
--

DROP TABLE IF EXISTS `hr_employee_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_employee_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `tin` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sss` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `philhealth` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pagibig` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_account` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_15ACC9148C03F15C` (`employee_id`),
  UNIQUE KEY `UNIQ_15ACC914CCCFBA31` (`upload_id`),
  KEY `IDX_15ACC914F5B7AF75` (`address_id`),
  CONSTRAINT `FK_15ACC9148C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_15ACC914CCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_15ACC914F5B7AF75` FOREIGN KEY (`address_id`) REFERENCES `cnt_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_employee_profile`
--

LOCK TABLES `hr_employee_profile` WRITE;
/*!40000 ALTER TABLE `hr_employee_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_employee_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_evaluator`
--

DROP TABLE IF EXISTS `hr_evaluator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_evaluator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appraisal_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `status` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `quali_rating` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `quanti_rating` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_details` longtext COLLATE utf8_unicode_ci,
  `pqc_details` longtext COLLATE utf8_unicode_ci,
  `comments` longtext COLLATE utf8_unicode_ci,
  `date_evaluated` datetime DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_28D866CFDD670628` (`appraisal_id`),
  KEY `IDX_28D866CF8C03F15C` (`employee_id`),
  KEY `IDX_28D866CFEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_28D866CF8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_28D866CFDD670628` FOREIGN KEY (`appraisal_id`) REFERENCES `hr_appraisal` (`id`),
  CONSTRAINT `FK_28D866CFEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_evaluator`
--

LOCK TABLES `hr_evaluator` WRITE;
/*!40000 ALTER TABLE `hr_evaluator` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_evaluator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_event`
--

DROP TABLE IF EXISTS `hr_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `date_from` datetime NOT NULL,
  `date_to` datetime NOT NULL,
  `holiday_type` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1D8FE2FDEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_1D8FE2FDEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_event`
--

LOCK TABLES `hr_event` WRITE;
/*!40000 ALTER TABLE `hr_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_holiday`
--

DROP TABLE IF EXISTS `hr_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_holiday` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_321F4B81EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_321F4B81EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_holiday`
--

LOCK TABLES `hr_holiday` WRITE;
/*!40000 ALTER TABLE `hr_holiday` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_incident_report`
--

DROP TABLE IF EXISTS `hr_incident_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_incident_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date_filed` datetime NOT NULL,
  `date_happened` datetime NOT NULL,
  `products` longtext COLLATE utf8_unicode_ci,
  `concerns` longtext COLLATE utf8_unicode_ci,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_DF7A907CA76ED395` (`user_id`),
  KEY `IDX_DF7A907C3E23E247` (`dept_id`),
  KEY `IDX_DF7A907C8C03F15C` (`employee_id`),
  KEY `IDX_DF7A907C64D218E` (`location_id`),
  KEY `IDX_DF7A907CEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_DF7A907C3E23E247` FOREIGN KEY (`dept_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `FK_DF7A907C64D218E` FOREIGN KEY (`location_id`) REFERENCES `hr_location` (`id`),
  CONSTRAINT `FK_DF7A907C8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_DF7A907CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_DF7A907CEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_incident_report`
--

LOCK TABLES `hr_incident_report` WRITE;
/*!40000 ALTER TABLE `hr_incident_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_incident_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_issued_property`
--

DROP TABLE IF EXISTS `hr_issued_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_issued_property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `item_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `item_name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_code` tinytext COLLATE utf8_unicode_ci,
  `item_desc` longtext COLLATE utf8_unicode_ci,
  `addtl_details` longtext COLLATE utf8_unicode_ci,
  `date_issued` datetime NOT NULL,
  `date_returned` datetime DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C29BA927CCCFBA31` (`upload_id`),
  KEY `IDX_C29BA9278C03F15C` (`employee_id`),
  KEY `IDX_C29BA927EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_C29BA9278C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_C29BA927CCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_C29BA927EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_issued_property`
--

LOCK TABLES `hr_issued_property` WRITE;
/*!40000 ALTER TABLE `hr_issued_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_issued_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_job_level`
--

DROP TABLE IF EXISTS `hr_job_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_job_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C6658FA3EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_C6658FA3EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_job_level`
--

LOCK TABLES `hr_job_level` WRITE;
/*!40000 ALTER TABLE `hr_job_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_job_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_job_title`
--

DROP TABLE IF EXISTS `hr_job_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_job_title` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `type` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_77B93BDB3E23E247` (`dept_id`),
  KEY `IDX_77B93BDB727ACA70` (`parent_id`),
  KEY `IDX_77B93BDBEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_77B93BDB3E23E247` FOREIGN KEY (`dept_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `FK_77B93BDB727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `hr_job_title` (`id`),
  CONSTRAINT `FK_77B93BDBEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_job_title`
--

LOCK TABLES `hr_job_title` WRITE;
/*!40000 ALTER TABLE `hr_job_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_job_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_leave`
--

DROP TABLE IF EXISTS `hr_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_leave` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `emp_leave_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `approved_by` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_filed` datetime NOT NULL,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `date_approved` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `applied_leave_days` int(11) DEFAULT NULL,
  `accept_sat` tinyint(1) NOT NULL,
  `date_reviewed_hr` datetime DEFAULT NULL,
  `date_reviewed_dept_head` datetime DEFAULT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_BD91688A8C03F15C` (`employee_id`),
  KEY `IDX_BD91688A75CE0942` (`emp_leave_id`),
  KEY `IDX_BD91688AEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_BD91688A75CE0942` FOREIGN KEY (`emp_leave_id`) REFERENCES `hr_employee_leaves` (`id`),
  CONSTRAINT `FK_BD91688A8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_BD91688AEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_leave`
--

LOCK TABLES `hr_leave` WRITE;
/*!40000 ALTER TABLE `hr_leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_leave` ENABLE KEYS */;
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
-- Table structure for table `hr_manpower_request`
--

DROP TABLE IF EXISTS `hr_manpower_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_manpower_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approver_id` int(11) DEFAULT NULL,
  `recommended_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date_received` datetime DEFAULT NULL,
  `date_approved` datetime DEFAULT NULL,
  `date_filed` datetime DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `gender` longtext COLLATE utf8_unicode_ci,
  `age_from` int(11) DEFAULT NULL,
  `age_to` int(11) DEFAULT NULL,
  `experience` longtext COLLATE utf8_unicode_ci,
  `education` longtext COLLATE utf8_unicode_ci,
  `required_courses` longtext COLLATE utf8_unicode_ci,
  `skills` longtext COLLATE utf8_unicode_ci,
  `terms_of_employment` longtext COLLATE utf8_unicode_ci,
  `purpose` longtext COLLATE utf8_unicode_ci,
  `personnel_type` longtext COLLATE utf8_unicode_ci,
  `internal_source_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `external_source_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internal_candidates` longtext COLLATE utf8_unicode_ci,
  `external_candidates` longtext COLLATE utf8_unicode_ci,
  `vacancy` int(11) DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  `noted_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_80C9A85CBB23766C` (`approver_id`),
  KEY `IDX_80C9A85C70C20237` (`recommended_id`),
  KEY `IDX_80C9A85C31989A70` (`noted_id`),
  KEY `IDX_80C9A85CDD842E46` (`position_id`),
  KEY `IDX_80C9A85CEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_80C9A85C70C20237` FOREIGN KEY (`recommended_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_80C9A85CBB23766C` FOREIGN KEY (`approver_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_80C9A85CDD842E46` FOREIGN KEY (`position_id`) REFERENCES `hr_job_title` (`id`),
  CONSTRAINT `FK_80C9A85CEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_manpower_request`
--

LOCK TABLES `hr_manpower_request` WRITE;
/*!40000 ALTER TABLE `hr_manpower_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_manpower_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_memo`
--

DROP TABLE IF EXISTS `hr_memo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_memo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `reviewed_id` int(11) DEFAULT NULL,
  `approved_id` int(11) DEFAULT NULL,
  `noted_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `date_issued` datetime NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5392661A8C03F15C` (`employee_id`),
  KEY `IDX_5392661A5254E55` (`reviewed_id`),
  KEY `IDX_5392661ACE517E2F` (`approved_id`),
  KEY `IDX_5392661A31989A70` (`noted_id`),
  KEY `IDX_5392661AEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_5392661A31989A70` FOREIGN KEY (`noted_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_5392661A5254E55` FOREIGN KEY (`reviewed_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_5392661A8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_5392661ACE517E2F` FOREIGN KEY (`approved_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_5392661AEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_memo`
--

LOCK TABLES `hr_memo` WRITE;
/*!40000 ALTER TABLE `hr_memo` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_memo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_rating_system`
--

DROP TABLE IF EXISTS `hr_rating_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_rating_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `range_start` int(11) NOT NULL,
  `range_end` int(11) NOT NULL,
  `rating` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_rating_system`
--

LOCK TABLES `hr_rating_system` WRITE;
/*!40000 ALTER TABLE `hr_rating_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_rating_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_reimbursement`
--

DROP TABLE IF EXISTS `hr_reimbursement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_reimbursement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `approver_id` int(11) DEFAULT NULL,
  `request_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `date_filed` datetime NOT NULL,
  `date_approved` datetime DEFAULT NULL,
  `receipt_no` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expense_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6851DFE427EB8A5` (`request_id`),
  UNIQUE KEY `UNIQ_6851DFECCCFBA31` (`upload_id`),
  KEY `IDX_6851DFE8C03F15C` (`employee_id`),
  KEY `IDX_6851DFEBB23766C` (`approver_id`),
  KEY `IDX_6851DFEEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_6851DFE427EB8A5` FOREIGN KEY (`request_id`) REFERENCES `hr_request` (`id`),
  CONSTRAINT `FK_6851DFE8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_6851DFEBB23766C` FOREIGN KEY (`approver_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_6851DFECCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_6851DFEEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_reimbursement`
--

LOCK TABLES `hr_reimbursement` WRITE;
/*!40000 ALTER TABLE `hr_reimbursement` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_reimbursement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_request`
--

DROP TABLE IF EXISTS `hr_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `approved_by` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `request_type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_filed` datetime NOT NULL,
  `date_approved` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_D512762A8C03F15C` (`employee_id`),
  KEY `IDX_D512762AEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_D512762A8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_D512762AEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_request`
--

LOCK TABLES `hr_request` WRITE;
/*!40000 ALTER TABLE `hr_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_requirements`
--

DROP TABLE IF EXISTS `hr_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leave_type_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `req_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_74F478EA8313F474` (`leave_type_id`),
  KEY `IDX_74F478EAEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_74F478EA8313F474` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_type` (`id`),
  CONSTRAINT `FK_74F478EAEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_requirements`
--

LOCK TABLES `hr_requirements` WRITE;
/*!40000 ALTER TABLE `hr_requirements` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_resign`
--

DROP TABLE IF EXISTS `hr_resign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_resign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `approver_id` int(11) DEFAULT NULL,
  `request_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `date_filed` datetime NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_approved` datetime DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_935822B4427EB8A5` (`request_id`),
  UNIQUE KEY `UNIQ_935822B4CCCFBA31` (`upload_id`),
  KEY `IDX_935822B48C03F15C` (`employee_id`),
  KEY `IDX_935822B4BB23766C` (`approver_id`),
  KEY `IDX_935822B4EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_935822B4427EB8A5` FOREIGN KEY (`request_id`) REFERENCES `hr_request` (`id`),
  CONSTRAINT `FK_935822B48C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_935822B4BB23766C` FOREIGN KEY (`approver_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `FK_935822B4CCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_935822B4EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_resign`
--

LOCK TABLES `hr_resign` WRITE;
/*!40000 ALTER TABLE `hr_resign` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_resign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_salary_history`
--

DROP TABLE IF EXISTS `hr_salary_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_salary_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `base_pay` decimal(10,2) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BFC8CBB88C03F15C` (`employee_id`),
  KEY `IDX_BFC8CBB8EC8B7ADE` (`period_id`),
  KEY `IDX_BFC8CBB8EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_BFC8CBB88C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_BFC8CBB8EC8B7ADE` FOREIGN KEY (`period_id`) REFERENCES `pay_period` (`id`),
  CONSTRAINT `FK_BFC8CBB8EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_salary_history`
--

LOCK TABLES `hr_salary_history` WRITE;
/*!40000 ALTER TABLE `hr_salary_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_salary_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_schedule`
--

DROP TABLE IF EXISTS `hr_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `day_start` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `day_end` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `grace_period` int(11) NOT NULL,
  `half_day` int(11) NOT NULL,
  `type` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `required_hours` double DEFAULT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E1DDD301EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E1DDD301EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_schedule`
--

LOCK TABLES `hr_schedule` WRITE;
/*!40000 ALTER TABLE `hr_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_schedule` ENABLE KEYS */;
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
-- Table structure for table `leave_rules`
--

DROP TABLE IF EXISTS `leave_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leave_type_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `job_level_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `gender` longtext COLLATE utf8_unicode_ci,
  `emp_status` longtext COLLATE utf8_unicode_ci,
  `accrue_enabled` tinyint(1) NOT NULL,
  `accrue_count` double DEFAULT NULL,
  `accrue_rule` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `carried_enabled` tinyint(1) NOT NULL,
  `carry_percentage` int(11) DEFAULT NULL,
  `carry_period` int(11) DEFAULT NULL,
  `leave_count` double NOT NULL,
  `count_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `service_months` int(11) DEFAULT NULL,
  `payment_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `override` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `effectivity` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_4C4EC0968313F474` (`leave_type_id`),
  KEY `IDX_4C4EC0968C03F15C` (`employee_id`),
  KEY `IDX_4C4EC096AE80F5DF` (`department_id`),
  KEY `IDX_4C4EC09638F6EEDC` (`job_level_id`),
  KEY `IDX_4C4EC096EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_4C4EC09638F6EEDC` FOREIGN KEY (`job_level_id`) REFERENCES `hr_job_level` (`id`),
  CONSTRAINT `FK_4C4EC0968313F474` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_type` (`id`),
  CONSTRAINT `FK_4C4EC0968C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_4C4EC096AE80F5DF` FOREIGN KEY (`department_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `FK_4C4EC096EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_rules`
--

LOCK TABLES `leave_rules` WRITE;
/*!40000 ALTER TABLE `leave_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `leave_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_type`
--

DROP TABLE IF EXISTS `leave_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_create_id` int(11) DEFAULT NULL,
  `gender` longtext COLLATE utf8_unicode_ci,
  `emp_status` longtext COLLATE utf8_unicode_ci,
  `accrue_enabled` tinyint(1) NOT NULL,
  `accrue_count` double DEFAULT NULL,
  `accrue_rule` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `carried_enabled` tinyint(1) NOT NULL,
  `carry_percentage` int(11) DEFAULT NULL,
  `carry_period` int(11) DEFAULT NULL,
  `leave_count` double NOT NULL,
  `count_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `service_months` int(11) DEFAULT NULL,
  `payment_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `addtl_requirements` longtext COLLATE utf8_unicode_ci,
  `date_create` datetime NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_E2BC4391EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_E2BC4391EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_type`
--

LOCK TABLES `leave_type` WRITE;
/*!40000 ALTER TABLE `leave_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `leave_type` ENABLE KEYS */;
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
-- Table structure for table `pay_13th`
--

DROP TABLE IF EXISTS `pay_13th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_13th` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `total_taxable` decimal(10,2) NOT NULL,
  `tax` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `year` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `flag_locked` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_145D9C2E8C03F15C` (`employee_id`),
  CONSTRAINT `FK_145D9C2E8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_13th`
--

LOCK TABLES `pay_13th` WRITE;
/*!40000 ALTER TABLE `pay_13th` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_13th` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_13thentry`
--

DROP TABLE IF EXISTS `pay_13thentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_13thentry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_period_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `pay13th_id` int(11) DEFAULT NULL,
  `total_earning` decimal(10,2) NOT NULL,
  `total_deduction` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E88C38BF5DD5005B` (`payroll_period_id`),
  KEY `IDX_E88C38BF8C03F15C` (`employee_id`),
  KEY `IDX_E88C38BFAFEAC96` (`pay13th_id`),
  CONSTRAINT `FK_E88C38BF5DD5005B` FOREIGN KEY (`payroll_period_id`) REFERENCES `pay_payroll_period` (`id`),
  CONSTRAINT `FK_E88C38BF8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_E88C38BFAFEAC96` FOREIGN KEY (`pay13th_id`) REFERENCES `pay_13th` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_13thentry`
--

LOCK TABLES `pay_13thentry` WRITE;
/*!40000 ALTER TABLE `pay_13thentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_13thentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_deduction_entry`
--

DROP TABLE IF EXISTS `pay_deduction_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_deduction_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `flag_taxable` tinyint(1) NOT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_5FBCC334DBA340EA` (`payroll_id`),
  CONSTRAINT `FK_5FBCC334DBA340EA` FOREIGN KEY (`payroll_id`) REFERENCES `pay_payroll` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_deduction_entry`
--

LOCK TABLES `pay_deduction_entry` WRITE;
/*!40000 ALTER TABLE `pay_deduction_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_deduction_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_earning_entry`
--

DROP TABLE IF EXISTS `pay_earning_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_earning_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `flag_taxable` tinyint(1) NOT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_99E320F9DBA340EA` (`payroll_id`),
  CONSTRAINT `FK_99E320F9DBA340EA` FOREIGN KEY (`payroll_id`) REFERENCES `pay_payroll` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_earning_entry`
--

LOCK TABLES `pay_earning_entry` WRITE;
/*!40000 ALTER TABLE `pay_earning_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_earning_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_govbenefits_paid`
--

DROP TABLE IF EXISTS `pay_govbenefits_paid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_govbenefits_paid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `type` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `fs_month` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `fs_year` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F9D370878C03F15C` (`employee_id`),
  CONSTRAINT `FK_F9D370878C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_govbenefits_paid`
--

LOCK TABLES `pay_govbenefits_paid` WRITE;
/*!40000 ALTER TABLE `pay_govbenefits_paid` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_govbenefits_paid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_overtime_rate`
--

DROP TABLE IF EXISTS `pay_overtime_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_overtime_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_overtime_rate`
--

LOCK TABLES `pay_overtime_rate` WRITE;
/*!40000 ALTER TABLE `pay_overtime_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_overtime_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_payroll`
--

DROP TABLE IF EXISTS `pay_payroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_payroll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_period_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `total_earning` decimal(10,2) NOT NULL,
  `total_deduction` decimal(10,2) NOT NULL,
  `total_taxable` decimal(10,2) NOT NULL,
  `total_nontaxable` decimal(10,2) NOT NULL,
  `tax` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `flag_locked` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AF757B0D5DD5005B` (`payroll_period_id`),
  KEY `IDX_AF757B0D8C03F15C` (`employee_id`),
  CONSTRAINT `FK_AF757B0D5DD5005B` FOREIGN KEY (`payroll_period_id`) REFERENCES `pay_payroll_period` (`id`),
  CONSTRAINT `FK_AF757B0D8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_payroll`
--

LOCK TABLES `pay_payroll` WRITE;
/*!40000 ALTER TABLE `pay_payroll` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_payroll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_payroll_period`
--

DROP TABLE IF EXISTS `pay_payroll_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_payroll_period` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `period_id` int(11) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `fs_month` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `fs_year` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_18830363EC8B7ADE` (`period_id`),
  CONSTRAINT `FK_18830363EC8B7ADE` FOREIGN KEY (`period_id`) REFERENCES `pay_period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_payroll_period`
--

LOCK TABLES `pay_payroll_period` WRITE;
/*!40000 ALTER TABLE `pay_payroll_period` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_payroll_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_period`
--

DROP TABLE IF EXISTS `pay_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_period` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paydays` int(11) NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_period`
--

LOCK TABLES `pay_period` WRITE;
/*!40000 ALTER TABLE `pay_period` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_philhealth_rate`
--

DROP TABLE IF EXISTS `pay_philhealth_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_philhealth_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salary_bracket` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `min_amount` decimal(10,2) NOT NULL,
  `max_amount` decimal(10,2) NOT NULL,
  `employee_contribution` decimal(10,2) NOT NULL,
  `employer_contribution` decimal(10,2) NOT NULL,
  `total_contribution` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_philhealth_rate`
--

LOCK TABLES `pay_philhealth_rate` WRITE;
/*!40000 ALTER TABLE `pay_philhealth_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_philhealth_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_schedule`
--

DROP TABLE IF EXISTS `pay_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `period_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `start_end` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5668E004EC8B7ADE` (`period_id`),
  KEY `IDX_5668E004EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_5668E004EC8B7ADE` FOREIGN KEY (`period_id`) REFERENCES `pay_period` (`id`),
  CONSTRAINT `FK_5668E004EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_schedule`
--

LOCK TABLES `pay_schedule` WRITE;
/*!40000 ALTER TABLE `pay_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_sss_rate`
--

DROP TABLE IF EXISTS `pay_sss_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_sss_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salary_bracket` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `min_amount` decimal(15,2) NOT NULL,
  `max_amount` decimal(15,2) NOT NULL,
  `salary_credit` decimal(10,2) NOT NULL,
  `employee_contribution` decimal(10,2) NOT NULL,
  `employer_contribution` decimal(10,2) NOT NULL,
  `total_contribution` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_sss_rate`
--

LOCK TABLES `pay_sss_rate` WRITE;
/*!40000 ALTER TABLE `pay_sss_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_sss_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_tax`
--

DROP TABLE IF EXISTS `pay_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_id` int(11) DEFAULT NULL,
  `taxmatrix_id` int(11) DEFAULT NULL,
  `taxable_amount` decimal(10,2) NOT NULL,
  `excess_amount` decimal(10,2) NOT NULL,
  `taxed_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A4C02D84DBA340EA` (`payroll_id`),
  UNIQUE KEY `UNIQ_A4C02D846454EF39` (`taxmatrix_id`),
  CONSTRAINT `FK_A4C02D846454EF39` FOREIGN KEY (`taxmatrix_id`) REFERENCES `pay_taxmatrix` (`id`),
  CONSTRAINT `FK_A4C02D84DBA340EA` FOREIGN KEY (`payroll_id`) REFERENCES `pay_payroll` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_tax`
--

LOCK TABLES `pay_tax` WRITE;
/*!40000 ALTER TABLE `pay_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_tax_rate`
--

DROP TABLE IF EXISTS `pay_tax_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_tax_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taxstatus_id` int(11) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL,
  `bracket` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount_from` decimal(10,2) NOT NULL,
  `amount_to` decimal(10,2) NOT NULL,
  `amount_tax` decimal(10,2) NOT NULL,
  `percent_of_excess` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CF33C13EA5A3E463` (`taxstatus_id`),
  KEY `IDX_CF33C13EEC8B7ADE` (`period_id`),
  CONSTRAINT `FK_CF33C13EA5A3E463` FOREIGN KEY (`taxstatus_id`) REFERENCES `pay_taxstatus` (`id`),
  CONSTRAINT `FK_CF33C13EEC8B7ADE` FOREIGN KEY (`period_id`) REFERENCES `pay_period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_tax_rate`
--

LOCK TABLES `pay_tax_rate` WRITE;
/*!40000 ALTER TABLE `pay_tax_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_tax_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_taxmatrix`
--

DROP TABLE IF EXISTS `pay_taxmatrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_taxmatrix` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taxrate_id` int(11) DEFAULT NULL,
  `taxstatus_id` int(11) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL,
  `base_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EC7FE70E97012B7` (`taxrate_id`),
  KEY `IDX_EC7FE70EA5A3E463` (`taxstatus_id`),
  KEY `IDX_EC7FE70EEC8B7ADE` (`period_id`),
  CONSTRAINT `FK_EC7FE70E97012B7` FOREIGN KEY (`taxrate_id`) REFERENCES `pay_tax_rate` (`id`),
  CONSTRAINT `FK_EC7FE70EA5A3E463` FOREIGN KEY (`taxstatus_id`) REFERENCES `pay_taxstatus` (`id`),
  CONSTRAINT `FK_EC7FE70EEC8B7ADE` FOREIGN KEY (`period_id`) REFERENCES `pay_period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_taxmatrix`
--

LOCK TABLES `pay_taxmatrix` WRITE;
/*!40000 ALTER TABLE `pay_taxmatrix` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_taxmatrix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_taxstatus`
--

DROP TABLE IF EXISTS `pay_taxstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_taxstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `personal_exemption` decimal(10,2) NOT NULL,
  `additional_exemption` decimal(10,2) NOT NULL,
  `total_exemption` decimal(10,2) NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_taxstatus`
--

LOCK TABLES `pay_taxstatus` WRITE;
/*!40000 ALTER TABLE `pay_taxstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_taxstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_thirteenth`
--

DROP TABLE IF EXISTS `pay_thirteenth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_thirteenth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `fs_year` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `total_taxable` decimal(10,2) NOT NULL,
  `tax` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `flag_locked` tinyint(1) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_91B4247B8C03F15C` (`employee_id`),
  KEY `IDX_91B4247BEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_91B4247B8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_91B4247BEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_thirteenth`
--

LOCK TABLES `pay_thirteenth` WRITE;
/*!40000 ALTER TABLE `pay_thirteenth` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_thirteenth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_phone`
--

DROP TABLE IF EXISTS `profile_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_phone` (
  `profile_id` int(11) NOT NULL,
  `phone_id` int(11) NOT NULL,
  PRIMARY KEY (`profile_id`,`phone_id`),
  KEY `IDX_B39B080FCCFA12B8` (`profile_id`),
  KEY `IDX_B39B080F3B7323CB` (`phone_id`),
  CONSTRAINT `FK_B39B080F3B7323CB` FOREIGN KEY (`phone_id`) REFERENCES `cnt_phone` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B39B080FCCFA12B8` FOREIGN KEY (`profile_id`) REFERENCES `hr_employee_profile` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_phone`
--

LOCK TABLES `profile_phone` WRITE;
/*!40000 ALTER TABLE `profile_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rem_cashbond`
--

DROP TABLE IF EXISTS `rem_cashbond`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rem_cashbond` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2F81110E8C03F15C` (`employee_id`),
  KEY `IDX_2F81110EEEFE5067` (`user_create_id`),
  CONSTRAINT `FK_2F81110E8C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_2F81110EEEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rem_cashbond`
--

LOCK TABLES `rem_cashbond` WRITE;
/*!40000 ALTER TABLE `rem_cashbond` DISABLE KEYS */;
/*!40000 ALTER TABLE `rem_cashbond` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rem_cashbondloan`
--

DROP TABLE IF EXISTS `rem_cashbondloan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rem_cashbondloan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `cashbond_id` int(11) DEFAULT NULL,
  `approver_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date_approved` datetime DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B1A127248C03F15C` (`employee_id`),
  KEY `IDX_B1A12724B8793F9C` (`cashbond_id`),
  KEY `IDX_B1A12724BB23766C` (`approver_id`),
  KEY `IDX_B1A12724EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_B1A127248C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_B1A12724B8793F9C` FOREIGN KEY (`cashbond_id`) REFERENCES `rem_cashbond` (`id`),
  CONSTRAINT `FK_B1A12724BB23766C` FOREIGN KEY (`approver_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_B1A12724EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rem_cashbondloan`
--

LOCK TABLES `rem_cashbondloan` WRITE;
/*!40000 ALTER TABLE `rem_cashbondloan` DISABLE KEYS */;
/*!40000 ALTER TABLE `rem_cashbondloan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rem_cashbondtransaction`
--

DROP TABLE IF EXISTS `rem_cashbondtransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rem_cashbondtransaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cashbond_id` int(11) DEFAULT NULL,
  `payroll_period_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `debit` decimal(10,2) NOT NULL,
  `credit` decimal(10,2) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B955A0F7B8793F9C` (`cashbond_id`),
  KEY `IDX_B955A0F75DD5005B` (`payroll_period_id`),
  KEY `IDX_B955A0F7EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_B955A0F75DD5005B` FOREIGN KEY (`payroll_period_id`) REFERENCES `pay_payroll_period` (`id`),
  CONSTRAINT `FK_B955A0F7B8793F9C` FOREIGN KEY (`cashbond_id`) REFERENCES `rem_cashbond` (`id`),
  CONSTRAINT `FK_B955A0F7EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rem_cashbondtransaction`
--

LOCK TABLES `rem_cashbondtransaction` WRITE;
/*!40000 ALTER TABLE `rem_cashbondtransaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `rem_cashbondtransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rem_incentive`
--

DROP TABLE IF EXISTS `rem_incentive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rem_incentive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `approver_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `date_filed` datetime NOT NULL,
  `date_approved` datetime DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A0509AA7CCCFBA31` (`upload_id`),
  KEY `IDX_A0509AA78C03F15C` (`employee_id`),
  KEY `IDX_A0509AA7BB23766C` (`approver_id`),
  KEY `IDX_A0509AA7EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_A0509AA78C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_A0509AA7BB23766C` FOREIGN KEY (`approver_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_A0509AA7CCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_A0509AA7EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rem_incentive`
--

LOCK TABLES `rem_incentive` WRITE;
/*!40000 ALTER TABLE `rem_incentive` DISABLE KEYS */;
/*!40000 ALTER TABLE `rem_incentive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rem_loan_payments`
--

DROP TABLE IF EXISTS `rem_loan_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rem_loan_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `date_paid` datetime NOT NULL,
  `payment` decimal(10,2) NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C8309007CE73868F` (`loan_id`),
  KEY `IDX_C8309007EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_C8309007CE73868F` FOREIGN KEY (`loan_id`) REFERENCES `rem_loans` (`id`),
  CONSTRAINT `FK_C8309007EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rem_loan_payments`
--

LOCK TABLES `rem_loan_payments` WRITE;
/*!40000 ALTER TABLE `rem_loan_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `rem_loan_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rem_loans`
--

DROP TABLE IF EXISTS `rem_loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rem_loans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `approver_id` int(11) DEFAULT NULL,
  `user_create_id` int(11) DEFAULT NULL,
  `upload_id` int(11) DEFAULT NULL,
  `date_filed` datetime NOT NULL,
  `date_approved` datetime DEFAULT NULL,
  `type` longtext COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL,
  `paid` decimal(10,2) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `flag_auto` tinyint(1) NOT NULL,
  `code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `notes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F30E7C84CCCFBA31` (`upload_id`),
  KEY `IDX_F30E7C848C03F15C` (`employee_id`),
  KEY `IDX_F30E7C84BB23766C` (`approver_id`),
  KEY `IDX_F30E7C84EEFE5067` (`user_create_id`),
  CONSTRAINT `FK_F30E7C848C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_F30E7C84BB23766C` FOREIGN KEY (`approver_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `FK_F30E7C84CCCFBA31` FOREIGN KEY (`upload_id`) REFERENCES `media_upload` (`id`),
  CONSTRAINT `FK_F30E7C84EEFE5067` FOREIGN KEY (`user_create_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rem_loans`
--

LOCK TABLES `rem_loans` WRITE;
/*!40000 ALTER TABLE `rem_loans` DISABLE KEYS */;
/*!40000 ALTER TABLE `rem_loans` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (45,'ad13','ad13',1,'8iz3cx9wthc0k8cogo8cowccsso00cc','V5Lgij75acC5sT1qzGosaGbsijpoUpxErl4ZO8Bcz4QvyLE/aV20lazJMLWFLRVYUqNKaWRxtPI4hsD+MnvBBw==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Adrian','Esguerra','Briones',NULL,NULL,NULL,'Straight','123','aeb@generic.com','aeb@generic.com','13',NULL,'Aqua Mineral','Sales','Junior Beauty Consultant'),(46,'abegail34','abegail34',1,'gaaklo6ud40ksoo0o44k00cgooo8o0w','NmdEEg67rfCuRaRkpA2puwDmv4eLEtdbhBO0HjRkpYo23ql8pdAgZQS/7zwb6GXxqy/QsTHQKU7/oiklmZMmvg==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Abegail','Atienza','Cataquiz',NULL,NULL,NULL,'Variable','123','aac@generic.com','aac@generic.com','14',NULL,'Aqua Mineral','Sales','Junior Beauty Consultant'),(47,'aborre','aborre',1,'9al513gfe48wskg00c8w040gcs4kgsg','F2/TRDW2Q5oryVM98JwsAn4I4NJlK2sOvlITqzWpVizg7/ZHZxW2xUHVyNis9Co1uRnVyxuPJExBWM8GjxpLxA==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Antonio','T','Borre',NULL,NULL,NULL,'Straight','13','atb@generic.com','atb@generic.com','15',NULL,'Aqua Mineral','Administrative','Area Manager'),(48,'gaguilar','gaguilar',1,'s6c0k0k3slwssggkg8s84ko8kk0kgo8','5M3XtwSpLaWJW+yC9oDVkBy/DA/pDzVy0MmawK/Xpt+9TJGDl9oAtGc4UFX7NLS/ZIIA26w+TJKewAYiK9LAIA==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Grace','G','Aguilar',NULL,NULL,NULL,'Straight','123','gga@generic.com','gga@generic.com','16',NULL,'Aqua Mineral','Administrative','Assistant Manager'),(49,'000019','000019',0,'h.HgCug47tNrf.9kIylk31gaj2zN4FEn.XzAYdJ4bis','7XgYT0ZjT/fNNXVCM/a73fi9tuqpt8AuIdR3hbzDGLtRlVXEYO3lUjDzcvIVt7L/fAL5FGq/ThO0Ccno+/aAVg==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Lois','M','Halero',NULL,NULL,NULL,'Straight','09657485434','lmh@generic.com','lmh@generic.com','19',NULL,'Aqua Mineral','Administrative','System Administrator'),(50,'000021','000021',0,'5YstXao2.riDEuEG1g58u/1Np.FlYvJtUh7VxGqL2KM','pKzKmZbicJwGYBnvhu8r+rZzfI2mhIWrc/hK58T+ufLRiXlu00BxtHWV7YCWcmoMx8bHQ0ne/rqW6IuKWRpLeQ==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Noel','','Ken',NULL,NULL,NULL,'Variable','','','','21',NULL,'Aqua Mineral','Administrative','System Administrator'),(51,'admin','admin',1,'fhqsoge52l4c8kw0cow0gsc8kscww80','I+1fZU2kCil0Jr0X7eWaEuY3WWtNlrsVXR3MvJSjbh6KKcePiUD1+iiVJptrzKvPqcJ7oZOQr9TlLeJ9egroxQ==','2017-10-02 13:58:05',NULL,NULL,'a:0:{}',NULL,1,'Richard','G','Gaza',NULL,NULL,NULL,'Variable','','sys_ad@test.com','sys_ad@test.com','1',NULL,'null','Administrative','System Administrator');
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

-- Dump completed on 2017-10-02  6:21:19
