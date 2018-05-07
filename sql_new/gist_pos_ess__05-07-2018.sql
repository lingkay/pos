-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
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
-- Dumping data for table `cfg_entry`
--

LOCK TABLES `cfg_entry` WRITE;
/*!40000 ALTER TABLE `cfg_entry` DISABLE KEYS */;
INSERT INTO `cfg_entry` VALUES ('erp_gc_id','20'),('gist_sys_area_id','1'),('gist_sys_erp_url','http://dev.gisterp2'),('gist_sys_pos_loc_id','1'),('gist_sys_pos_name','SM Aura'),('gist_sys_pos_url','http://dev.gistpos');
/*!40000 ALTER TABLE `cfg_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_department`
--

LOCK TABLES `user_department` WRITE;
/*!40000 ALTER TABLE `user_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (1,'admin','admin',1,'NqT6/X5eRU2LldCFDWpWwBGfmt7chvcZYblfKTo9dw4','OIiOBv7oHePYSCRFGeiQLBYTNdpcoOMqouioFkZ2M19TCDenB63j7bh/duSwuIBKsj2sLtJTjNJaqfjSWaHXpQ==','2018-03-27 07:38:26',NULL,NULL,'a:0:{}',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a1@a.com','a1@a.com','1',NULL,NULL,NULL,NULL),(2,'ad13','ad13',1,'8iz3cx9wthc0k8cogo8cowccsso00cc','V5Lgij75acC5sT1qzGosaGbsijpoUpxErl4ZO8Bcz4QvyLE/aV20lazJMLWFLRVYUqNKaWRxtPI4hsD+MnvBBw==','2018-05-06 18:10:52',NULL,NULL,'a:0:{}',NULL,1,'Adrian','Esguerra','Briones',NULL,NULL,NULL,'Straight','123','aeb@generic.com','aeb@generic.com','13',NULL,'Aqua Mineral','Sales','Junior Beauty Consultant'),(3,'abegail34','abegail34',1,'gaaklo6ud40ksoo0o44k00cgooo8o0w','NmdEEg67rfCuRaRkpA2puwDmv4eLEtdbhBO0HjRkpYo23ql8pdAgZQS/7zwb6GXxqy/QsTHQKU7/oiklmZMmvg==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Abegail','Atienza','Cataquiz',NULL,NULL,NULL,'Variable','123','aac@generic.com','aac@generic.com','14',NULL,'Aqua Mineral','Sales','Junior Beauty Consultant'),(4,'aborre','aborre',1,'9al513gfe48wskg00c8w040gcs4kgsg','F2/TRDW2Q5oryVM98JwsAn4I4NJlK2sOvlITqzWpVizg7/ZHZxW2xUHVyNis9Co1uRnVyxuPJExBWM8GjxpLxA==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Antonio','T','Borre',NULL,NULL,NULL,'Straight','13','atb@generic.com','atb@generic.com','15',NULL,'Aqua Mineral','Administrative','Area Manager'),(5,'gaguilar','gaguilar',1,'s6c0k0k3slwssggkg8s84ko8kk0kgo8','5M3XtwSpLaWJW+yC9oDVkBy/DA/pDzVy0MmawK/Xpt+9TJGDl9oAtGc4UFX7NLS/ZIIA26w+TJKewAYiK9LAIA==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Grace','G','Aguilar',NULL,NULL,NULL,'Straight','123','gga@generic.com','gga@generic.com','16',NULL,'Aqua Mineral','Administrative','Assistant Manager'),(6,'000020','000020',1,'241kCLYVSwRAWPQJwQBkCbNXyfO5JmQa8rWRNESe3UA','YSSLeGgcPeQlgRWxEkNS8PkpFNvNraH10L1hyGV4rM3gdEcYayyFr9T20rCA7sX0yFi4RUcxl4lmxgAvhVnboQ==',NULL,NULL,NULL,'a:0:{}',NULL,1,'John','K','Esguerra',NULL,NULL,NULL,'Straight','09965432222','jke@generic.com','jke@generic.com','20',NULL,'Aqua Mineral','Human Resources','HR Administrator'),(36,'hr_admin','hr_admin',1,'91fv4dyh6gcokowgk0g48wg8woo8gww','OTpISAHGoiVLvdH9Qar0dLdWSCnQGqjkTyOkvmtiz4IrT3zFWPT4SP8GeKlCZ2iN1cm9+l8ojxziJt241Mle1g==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Victoria','Abril','Gelmo',NULL,NULL,NULL,'Straight','0','vgelmo@test.com','vgelmo@test.com','12',NULL,'','Human Resources','HR Administrator'),(37,'000019','000019',0,'h.HgCug47tNrf.9kIylk31gaj2zN4FEn.XzAYdJ4bis','7XgYT0ZjT/fNNXVCM/a73fi9tuqpt8AuIdR3hbzDGLtRlVXEYO3lUjDzcvIVt7L/fAL5FGq/ThO0Ccno+/aAVg==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Lois','M','Halero',NULL,NULL,NULL,'Straight','09657485434','lmh@generic.com','lmh@generic.com','19',NULL,'Aqua Mineral','Administrative','System Administrator'),(38,'000021','000021',0,'5YstXao2.riDEuEG1g58u/1Np.FlYvJtUh7VxGqL2KM','pKzKmZbicJwGYBnvhu8r+rZzfI2mhIWrc/hK58T+ufLRiXlu00BxtHWV7YCWcmoMx8bHQ0ne/rqW6IuKWRpLeQ==',NULL,NULL,NULL,'a:0:{}',NULL,1,'Noel','','Ken',NULL,NULL,NULL,'Variable','','','','21',NULL,'Aqua Mineral','Administrative','System Administrator'),(39,'000022','000022',1,'SmQDz3GF0PfcSv3KlBjdUYoJ8QWa0AF7nelhqeXzao4','V0C3lu5Wu4yUAwF8P5ol83I5xvmfvvPAIAIxq/RgEOCEf+wki4e9+UC2DVOldXQiuBq8MVrkbFeYZWvs0s4yFw==','2018-03-04 21:20:43',NULL,NULL,'a:0:{}',NULL,1,'Roi','Alonzo','Dizon',NULL,NULL,NULL,'Straight','09999999999','rad@local.com','rad@local.com','22',NULL,'Aqua Mineral','Sales','Senior Beauty Consultant');
/*!40000 ALTER TABLE `user_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-07 11:36:42
