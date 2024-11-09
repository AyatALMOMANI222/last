-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: laravel4
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accepted_flights`
--

DROP TABLE IF EXISTS `accepted_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accepted_flights` (
  `accepted_flight_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `flight_id` bigint unsigned NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `admin_set_deadline` timestamp NULL DEFAULT NULL,
  `ticket_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issued_at` timestamp NULL DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `is_free` tinyint(1) NOT NULL DEFAULT '0',
  `departure_time` time DEFAULT NULL,
  PRIMARY KEY (`accepted_flight_id`),
  KEY `accepted_flights_flight_id_foreign` (`flight_id`),
  CONSTRAINT `accepted_flights_flight_id_foreign` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accepted_flights`
--

LOCK TABLES `accepted_flights` WRITE;
/*!40000 ALTER TABLE `accepted_flights` DISABLE KEYS */;
INSERT INTO `accepted_flights` VALUES (57,68,45.00,NULL,NULL,NULL,NULL,NULL,'2024-11-02 15:03:40','2024-11-02 15:03:40','2024-11-22',0,'13:01:00'),(58,70,45.00,NULL,NULL,NULL,NULL,NULL,'2024-11-02 15:03:40','2024-11-02 15:03:40','2024-11-29',0,'13:02:00'),(59,69,56.00,NULL,NULL,NULL,NULL,NULL,'2024-11-02 15:03:40','2024-11-02 15:03:40','2024-11-23',0,'13:01:00');
/*!40000 ALTER TABLE `accepted_flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `additional_options`
--

DROP TABLE IF EXISTS `additional_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trip_id` bigint unsigned NOT NULL,
  `option_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `additional_options_trip_id_foreign` (`trip_id`),
  CONSTRAINT `additional_options_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_options`
--

LOCK TABLES `additional_options` WRITE;
/*!40000 ALTER TABLE `additional_options` DISABLE KEYS */;
INSERT INTO `additional_options` VALUES (1,1,'dinner','┘è┘è',22.00),(2,1,'lunch','┘ü┘ü',33.00),(3,1,'breakfast','╪º╪º',66.00);
/*!40000 ALTER TABLE `additional_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport_transfer_bookings`
--

DROP TABLE IF EXISTS `airport_transfer_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport_transfer_bookings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trip_type` enum('One-way trip from the airport to the hotel','One-way trip from the hotel to the airport','Round trip') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'One-way trip from the airport to the hotel',
  `arrival_date` date NOT NULL,
  `arrival_time` time NOT NULL,
  `departure_date` date DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `flight_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `companion_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conference_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `airport_transfer_bookings_conference_id_foreign` (`conference_id`),
  KEY `airport_transfer_bookings_user_id_foreign` (`user_id`),
  CONSTRAINT `airport_transfer_bookings_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `airport_transfer_bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport_transfer_bookings`
--

LOCK TABLES `airport_transfer_bookings` WRITE;
/*!40000 ALTER TABLE `airport_transfer_bookings` DISABLE KEYS */;
INSERT INTO `airport_transfer_bookings` VALUES (1,'One-way trip from the airport to the hotel','2024-10-16','21:35:00','2024-10-14','20:35:00','8','╪┤╪║╪┤┘ü',1,2,'2024-10-30 02:37:47','2024-10-30 02:37:47'),(2,'One-way trip from the airport to the hotel','2024-10-17','03:33:00','2024-10-03','02:22:00','2',NULL,1,2,'2024-10-30 02:55:12','2024-10-30 02:55:12'),(3,'One-way trip from the hotel to the airport','2024-11-05','18:32:00','2024-11-13','22:30:00','22','aya',2,1,'2024-11-04 12:30:54','2024-11-04 12:30:54'),(4,'One-way trip from the airport to the hotel','2024-10-30','00:41:00','2024-11-19','22:44:00','88','┘à┘à',3,29,'2024-11-07 04:41:35','2024-11-07 04:41:35');
/*!40000 ALTER TABLE `airport_transfer_bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport_transfer_prices`
--

DROP TABLE IF EXISTS `airport_transfer_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport_transfer_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned DEFAULT NULL,
  `from_airport_price` decimal(8,2) DEFAULT NULL,
  `to_airport_price` decimal(8,2) DEFAULT NULL,
  `round_trip_price` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `airport_transfer_prices_conference_id_foreign` (`conference_id`),
  CONSTRAINT `airport_transfer_prices_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport_transfer_prices`
--

LOCK TABLES `airport_transfer_prices` WRITE;
/*!40000 ALTER TABLE `airport_transfer_prices` DISABLE KEYS */;
INSERT INTO `airport_transfer_prices` VALUES (1,1,22.00,22.00,44.00,'2024-10-30 02:39:19','2024-10-30 02:39:19'),(2,1,NULL,NULL,NULL,'2024-11-05 05:26:24','2024-11-05 05:26:24'),(3,1,40.00,20.00,33.00,'2024-11-05 05:26:47','2024-11-05 05:26:47'),(4,1,NULL,NULL,NULL,'2024-11-05 06:56:59','2024-11-05 06:56:59'),(5,1,33.00,31.00,32.00,'2024-11-05 06:57:17','2024-11-05 06:57:17'),(6,1,NULL,NULL,NULL,'2024-11-05 06:57:36','2024-11-05 06:57:36');
/*!40000 ALTER TABLE `airport_transfer_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applicant_job`
--

DROP TABLE IF EXISTS `applicant_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applicant_job` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `applicant_id` bigint unsigned NOT NULL,
  `job_id` bigint unsigned NOT NULL,
  `status` enum('Pending','Reviewed','Rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `applicant_job_applicant_id_foreign` (`applicant_id`),
  KEY `applicant_job_job_id_foreign` (`job_id`),
  CONSTRAINT `applicant_job_applicant_id_foreign` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `applicant_job_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `available_jobs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applicant_job`
--

LOCK TABLES `applicant_job` WRITE;
/*!40000 ALTER TABLE `applicant_job` DISABLE KEYS */;
INSERT INTO `applicant_job` VALUES (1,1,1,'Pending','2024-11-05 11:31:15','2024-11-05 11:31:15'),(2,2,1,'Pending','2024-11-05 11:31:50','2024-11-05 11:31:50'),(3,3,1,'Pending','2024-11-05 12:05:51','2024-11-05 12:05:51'),(4,4,2,'Pending','2024-11-05 12:08:38','2024-11-05 12:08:38'),(5,5,2,'Pending','2024-11-05 12:10:34','2024-11-05 12:10:34'),(6,6,2,'Pending','2024-11-06 04:43:30','2024-11-06 04:43:30'),(7,7,1,'Pending','2024-11-06 04:49:17','2024-11-06 04:49:17'),(8,8,1,'Pending','2024-11-06 06:16:58','2024-11-06 06:16:58'),(9,10,1,'Pending','2024-11-06 06:22:09','2024-11-06 06:22:09'),(10,12,1,'Pending','2024-11-06 06:25:00','2024-11-06 06:25:00'),(11,13,2,'Pending','2024-11-06 06:25:14','2024-11-06 06:25:14'),(12,14,3,'Pending','2024-11-06 06:25:33','2024-11-06 06:25:33'),(13,15,4,'Pending','2024-11-06 06:26:40','2024-11-06 06:26:40'),(14,16,9,'Pending','2024-11-06 06:27:23','2024-11-06 06:27:23'),(15,18,7,'Pending','2024-11-06 06:27:38','2024-11-06 06:27:38'),(16,19,1,'Pending','2024-11-06 07:05:59','2024-11-06 07:05:59'),(17,21,1,'Pending','2024-11-06 07:37:44','2024-11-06 07:37:44');
/*!40000 ALTER TABLE `applicant_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applicants`
--

DROP TABLE IF EXISTS `applicants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applicants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `home_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position_applied_for` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `educational_qualification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resume` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `applicants_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applicants`
--

LOCK TABLES `applicants` WRITE;
/*!40000 ALTER TABLE `applicants` DISABLE KEYS */;
INSERT INTO `applicants` VALUES (1,'John','Doe','123456789','987654321','john.doe@example.com','Jordanian','123 Main St','Events Coordinator','Bachelor\'s Degree','resumes/wdICJYX9oSYxP5wLV81BT9yozk4fYba84blBQXIc.pdf','2024-11-05 11:31:15','2024-11-05 11:31:15'),(2,'John','Doe','123456789','987654321','joh╪¬n.doe@example.com','Jordanian','123 Main St','Events Coordinator','Bachelor\'s Degree','resumes/9aWdyEwaWsD4CcZa32VPiFXBagINI18KsOrTlmhL.pdf','2024-11-05 11:31:50','2024-11-05 11:31:50'),(3,'dd','d','ddd','4444','ayatalmomani655@gmail.com','jj','lll','KKK','ll','resumes/D7iPum0nHONnWQ80tPlXNTH78DO9DKSuIK41i6iC.pdf','2024-11-05 12:05:51','2024-11-05 12:05:51'),(4,'dd','d','ddd','4444','ayatalmomani==655@gmail.com','jj','lll','KKK','ll','resumes/pJGCjEKI7gdOuVodipe4SgJfR2LSQ7HzODwzN6As.pdf','2024-11-05 12:08:38','2024-11-05 12:08:38'),(5,'dd','d','ddd','4444','ayatalmomaoni==655@gmail.com','jj','lll','KKK','ll','resumes/ycTH3M5ZSqnQBkiYWTQypuuJgJPotmkE4wB8yrWt.pdf','2024-11-05 12:10:34','2024-11-05 12:10:34'),(6,'Ayat','Almomani','0787002103','4444','ayatalmomgani655@gmail.com','jordan','alzarqaa','jjjjjjjj','mmmmmm','resumes/BCjoOuel2OdEFJGkbYr0HtCnZ5N4MvyrjYmjFqsT.pdf','2024-11-06 04:43:30','2024-11-06 04:43:30'),(7,'Ayat','Almomani','0787002103','4444','ayatalmomadni655@gmail.com','rr','alzarqaa','╪í┘è','rr','resumes/8PFLwGU1VZd1HMCEZyCHZIwQd9IMlTMjnbg1PURy.pdf','2024-11-06 04:49:17','2024-11-06 04:49:17'),(8,'Ayat','Almomani','0787002103','4444','ayatalmomanhi655@gmail.com','jordan','alzarqaa','jjjjjjjj','ll','resumes/sz8UWCBzHbN7wihf4ceMH8zIX0qYBnYSCDMowTmE.pdf','2024-11-06 06:16:58','2024-11-06 06:16:58'),(10,'Ayat','Almomani','0787002103','4444','ayatalmomani6d5@gmail.com','jordan','alzarqaa','jjjjjjjj','ll','resumes/DlKJuCbIMIzYDSfDdoYzoYpTxv2grEO5hjHALpew.pdf','2024-11-06 06:22:09','2024-11-06 06:22:09'),(12,'Ayat','Almomani','0787002103','555555','ayatalmomjani655@gmail.com','rr','alzarqaa','╪í┘è','mmmmmm','resumes/HM9MP5kIDbZG4AupbU7UQBP4aNiLievE1zhVmYcm.pdf','2024-11-06 06:25:00','2024-11-06 06:25:00'),(13,'Ayat','Almomani','0787002103','555555','ayatalmomjanit655@gmail.com','rr','alzarqaa','╪í┘è','mmmmmm','resumes/WFho14stxhDS43l2mcovlxEM0WTE5i85fSZQPcUE.pdf','2024-11-06 06:25:14','2024-11-06 06:25:14'),(14,'Ayat','Almomani','0787002103','555555','ayatalmomjanitbb655@gmail.com','rr','alzarqaa','╪í┘è','mmmmmm','resumes/Fe8tddJheotuAONLJc93m5toUYK9TfQylTWps5kQ.pdf','2024-11-06 06:25:33','2024-11-06 06:25:33'),(15,'Ayat','Almomani','0787002103','555555','ayatalmomjadnitbb655@gmail.com','rr','alzarqaa','╪í┘è','mmmmmm','resumes/Om5Z9sdWLooBzYJLINZlNNmn1V8r7uPdQ6n8oaGK.docx','2024-11-06 06:26:40','2024-11-06 06:26:40'),(16,'Ayat','Almomani','0787002103','555555','ayatalmomddani655@gmail.com','vvv','alzarqaa','╪í┘è','rr','resumes/VT0cAsnI4Jc2fW7fyflqaQvvMklRlnGqOgD3Lxur.pdf','2024-11-06 06:27:23','2024-11-06 06:27:23'),(18,'Ayat','Almomani','0787002103','555555','ayatalmomddafni655@gmail.com','vvv','alzarqaa','╪í┘è','rr','resumes/tldPbi7onyX6CCQNpSKBkzgJvlKcJT1grYkpdMRg.pdf','2024-11-06 06:27:38','2024-11-06 06:27:38'),(19,'Ayat','Almomani','0787002103','4444','ayatalmomani6j55@gmail.com','rr','alzarqaa','jjjjjjjj','mmmmmm','resumes/xn0sKwa3X4xrfF1n3zib98gllpDLyAueb0VTnQ9T.pdf','2024-11-06 07:05:59','2024-11-06 07:05:59'),(21,'Ayat','Almomani','0787002103','4444','ayatalmomanji655@gmail.com','jordan','alzarqaa','╪í┘è','Enginerr','resumes/kJR2ngzKF4kop5Ye1DVtZbxL3owhOcXDcnwiYHiz.pdf','2024-11-06 07:37:44','2024-11-06 07:37:44');
/*!40000 ALTER TABLE `applicants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `conference_id` bigint unsigned NOT NULL,
  `registration_fee` decimal(8,2) DEFAULT NULL,
  `includes_conference_bag` tinyint(1) DEFAULT '1',
  `includes_conference_badge` tinyint(1) DEFAULT '1',
  `includes_conference_book` tinyint(1) DEFAULT '1',
  `includes_certificate` tinyint(1) DEFAULT '1',
  `includes_lecture_attendance` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_user_id_foreign` (`user_id`),
  KEY `attendance_conference_id_foreign` (`conference_id`),
  CONSTRAINT `attendance_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendance_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (1,12,1,NULL,1,1,1,1,1,NULL,NULL),(2,14,1,NULL,1,1,1,1,1,NULL,NULL),(3,25,1,100.00,1,1,1,1,1,'2024-11-07 05:14:35','2024-11-07 05:14:35');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `available_jobs`
--

DROP TABLE IF EXISTS `available_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `events_coordinator` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `responsibilities` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_jobs`
--

LOCK TABLES `available_jobs` WRITE;
/*!40000 ALTER TABLE `available_jobs` DISABLE KEYS */;
INSERT INTO `available_jobs` VALUES (1,'Events Coordinator','Plan and coordinate events.','Responsible for managing events.','2024-11-05 09:39:20','2024-11-05 09:39:20'),(2,'Events Coordinator2','Plan and coordinate events.','Responsible for managing events.','2024-11-05 09:39:31','2024-11-05 09:39:31'),(3,'Events Coordinator3','Plan and coordinate events.','Responsible for managing events.','2024-11-05 09:39:36','2024-11-05 09:39:36'),(4,'Events Coordinator4','Plan and coordinate events.','Responsible for managing events.','2024-11-05 09:40:09','2024-11-05 09:40:09'),(6,'╪¬╪¬','╪¬╪¬','uuuuuuuuuuu','2024-11-05 10:41:11','2024-11-05 10:49:53'),(7,'engineer','╪¬╪¬','┘å┘å','2024-11-05 10:41:22','2024-11-05 10:41:22'),(8,'engineer','programmer','saaaaaaaaaaaaa','2024-11-05 10:41:37','2024-11-05 10:41:37'),(9,'engineer','programmer','saaaaaaaaaaaaa','2024-11-05 10:41:40','2024-11-05 10:41:40'),(10,'ll',';;;',';;;','2024-11-06 07:06:35','2024-11-06 07:06:35'),(11,'KKK','KKKKKKKKK','KKKKKKK','2024-11-06 07:18:48','2024-11-06 07:18:48'),(12,'jjjj','jjjjjj','jj','2024-11-06 07:38:06','2024-11-06 07:38:06');
/*!40000 ALTER TABLE `available_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `committee_members`
--

DROP TABLE IF EXISTS `committee_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `committee_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `committee_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conference_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `committee_members_conference_id_foreign` (`conference_id`),
  CONSTRAINT `committee_members_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `committee_members`
--

LOCK TABLES `committee_members` WRITE;
/*!40000 ALTER TABLE `committee_members` DISABLE KEYS */;
INSERT INTO `committee_members` VALUES (1,'kkk','committee_images/FKlGz963ZJuhdMEbijcHf6b8ITgL38H0VXO9XodM.png',5,'2024-11-01 06:45:06','2024-11-01 06:45:06'),(2,'hhhy','committee_images/XweySPrxkiWb49SXyG0Y8TLjDyfk22dRirVV7c9j.png',6,'2024-11-01 10:27:45','2024-11-01 10:27:45'),(3,'iii','committee_images/kcIz7qnjgnzMw00SY9c9O7ZgUzkhAuALuueLep9t.jpg',7,'2024-11-01 10:29:56','2024-11-01 10:29:56'),(4,'mmmmmmm','committee_images/Qss6BjdnnrbwaiNSGDuQhlE9ckgDO6zWn8Q8yDCl.png',9,'2024-11-01 10:40:59','2024-11-01 10:40:59'),(5,'ooooooooo','committee_images/ddopXzWjWRB4AVxxQWFfNUADEczQ59VxaxPhuj87.jpg',10,'2024-11-01 10:42:17','2024-11-01 10:42:17'),(6,'iiiiiii','committee_images/WG8HTk88tRcy4LmNfEZ7GaEdmaYZXxZEPuJClAzZ.png',11,'2024-11-01 10:43:17','2024-11-01 10:43:17');
/*!40000 ALTER TABLE `committee_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference_image`
--

DROP TABLE IF EXISTS `conference_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conference_image` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned NOT NULL,
  `conference_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_image_conference_id_foreign` (`conference_id`),
  CONSTRAINT `conference_image_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference_image`
--

LOCK TABLES `conference_image` WRITE;
/*!40000 ALTER TABLE `conference_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `conference_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference_prices`
--

DROP TABLE IF EXISTS `conference_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conference_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned NOT NULL,
  `price_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_prices_conference_id_foreign` (`conference_id`),
  CONSTRAINT `conference_prices_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference_prices`
--

LOCK TABLES `conference_prices` WRITE;
/*!40000 ALTER TABLE `conference_prices` DISABLE KEYS */;
INSERT INTO `conference_prices` VALUES (1,1,'test',22.00,NULL,'2024-10-21 09:19:22','2024-10-21 09:19:22'),(2,2,'r',44.00,'dd','2024-11-01 06:09:48','2024-11-01 06:09:48'),(3,3,'aaa',2.00,NULL,'2024-11-01 06:16:37','2024-11-01 06:16:37'),(4,4,'aaa',2.00,NULL,'2024-11-01 06:17:09','2024-11-01 06:17:09'),(5,5,'kkk',77.00,'lll','2024-11-01 06:45:05','2024-11-01 06:45:05'),(6,6,'yytt',23.00,'lll','2024-11-01 10:27:44','2024-11-01 10:27:44'),(7,7,'ooo',33.00,'lll','2024-11-01 10:29:55','2024-11-01 10:29:55'),(8,8,'uuyy',232.00,'iiii','2024-11-01 10:31:12','2024-11-01 10:31:12'),(9,9,'kkkkkkk',66.00,'mmmmmmm','2024-11-01 10:40:58','2024-11-01 10:40:58'),(10,10,'tttt',45.00,'oooooo','2024-11-01 10:42:17','2024-11-01 10:42:17'),(11,11,'kkkkkkkk',90.00,'lllllll','2024-11-01 10:43:17','2024-11-01 10:43:17'),(12,12,'r',34.00,'333dv','2024-11-04 08:30:49','2024-11-04 08:30:49');
/*!40000 ALTER TABLE `conference_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference_trip`
--

DROP TABLE IF EXISTS `conference_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conference_trip` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned NOT NULL,
  `trip_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_trip_conference_id_foreign` (`conference_id`),
  KEY `conference_trip_trip_id_foreign` (`trip_id`),
  CONSTRAINT `conference_trip_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conference_trip_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference_trip`
--

LOCK TABLES `conference_trip` WRITE;
/*!40000 ALTER TABLE `conference_trip` DISABLE KEYS */;
/*!40000 ALTER TABLE `conference_trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference_user`
--

DROP TABLE IF EXISTS `conference_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conference_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `conference_id` bigint unsigned NOT NULL,
  `is_visa_payment_required` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_user_user_id_foreign` (`user_id`),
  KEY `conference_user_conference_id_foreign` (`conference_id`),
  CONSTRAINT `conference_user_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conference_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference_user`
--

LOCK TABLES `conference_user` WRITE;
/*!40000 ALTER TABLE `conference_user` DISABLE KEYS */;
INSERT INTO `conference_user` VALUES (1,1,2,1,NULL,NULL),(2,2,1,1,NULL,NULL),(3,9,1,1,NULL,NULL),(4,15,10,1,NULL,NULL),(5,11,1,1,NULL,NULL),(6,13,1,1,NULL,NULL),(7,21,3,1,NULL,'2024-11-01 13:08:15'),(8,24,10,0,NULL,'2024-11-01 13:03:22'),(9,25,3,NULL,NULL,NULL),(10,26,3,0,NULL,'2024-11-07 05:27:53'),(11,27,3,NULL,NULL,NULL),(12,28,3,NULL,NULL,NULL),(13,29,3,1,NULL,'2024-11-07 04:18:23');
/*!40000 ALTER TABLE `conference_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conferences`
--

DROP TABLE IF EXISTS `conferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conferences` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('upcoming','past') COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `first_announcement_pdf` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `second_announcement_pdf` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conference_brochure_pdf` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conference_scientific_program_pdf` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companion_dinner_price` decimal(8,2) DEFAULT NULL COMMENT 'Price for companion dinner',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `visa_price` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conferences`
--

LOCK TABLES `conferences` WRITE;
/*!40000 ALTER TABLE `conferences` DISABLE KEYS */;
INSERT INTO `conferences` VALUES (1,'test','test','2024-11-06','2024-11-06','amman','upcoming','conference_images/GOb9WDZAfBlSV52YyZYe9a1KLshFKoxUP9b48zZ2.png','conference_announcements/gtTlW5rbyzct8pPijauI1pOGK2XsbGymQ01RXVzV.pdf','conference_announcements/HNrcW7Vfxl1t4RfPkC55KkuAQrq3U8mB5XV0wMIO.pdf','conference_brochures/ygA0B4GrYd4PwTOwSttRZOw9iJ3CHekeS3FuVjPO.pdf','conference_programs/Y1cjts8VKafwGRlez1iGGBeWciFMo9oycHxeOYyh.pdf',20.00,'2024-10-21 12:19:22','2024-10-21 12:19:22',555.00),(2,'┘ä┘ä','┘ä┘ä','2024-11-05','2024-11-21','aaman','past','conference_images/3Y6LyGgJydddG6AhhKiIZlGlJVckavPvCOX5ujAs.jpg','conference_announcements/hILFMdmVZh32TSpoN0jQ2a67m0Mv5feJgjfI7JAV.pdf','conference_announcements/KP6z3AZNWW7PiWZtWPTFqIuTiuQQV4ezg4hwPQ7X.pdf','conference_brochures/S4Uxv8sD3a9BgvRWkAH3DQ0VvZOBW8bS18ArtslY.pdf','conference_programs/gtm2IWOtBd6jdxDz063QEis1WKlb2Hfo7u4WwSdb.pdf',22.00,'2024-11-01 09:09:48','2024-11-01 09:09:48',33.00),(3,'title22','fffffff','2024-11-21','2024-11-12','22','upcoming','conference_images/YBvRYQClfCeiNaqK70m5XiXMALi8gcRjq8rwWNXI.png','conference_announcements/Tv2NTR7eRqWCYGqlvI5HcrkSMcuCjObanTNoA7VD.pdf','conference_announcements/UvrHCtju45kZacpf4AI89M399FGgIAbdPXsfw54r.pdf','conference_brochures/JZpZuhVvgXetFwoTW5TcwQKOXeeq4BOKAQkloJKg.pdf','conference_programs/1y00CVIrgseOvsLOeWWdiSd00wZPOSDCRollUyxs.pdf',33.00,'2024-11-01 09:16:37','2024-11-01 09:16:37',666.00),(4,'title22','fffffff','2024-11-21','2024-11-12','22','upcoming','conference_images/0TPco2L0xtURsUYtZTgErIuxztse0daSf9GcuLTd.png','conference_announcements/JkKitXPXunSuNulya1ZbQXTYevH33GI88EzxrQ4D.pdf','conference_announcements/x6vQ2oVrsKU5N0azpnoE0WaRraSobHwCmCydYI0S.pdf','conference_brochures/lK9Pszkm2fewLfv4IgpX3iAoJ8gs7AQ4VEvrunRH.pdf','conference_programs/OQOAw86sqN4TGX6GLkxUU92JjzTTyqUbYQu9Uyyv.pdf',33.00,'2024-11-01 09:17:09','2024-11-01 09:17:09',NULL),(5,'ttttttttt','ttt','2024-11-12','2024-11-19','iiiii','upcoming','conference_images/gSVu4bAE40u3qjWBGxJs6FewsQQHbxpDkIHeRO8h.png','conference_announcements/SFHiPjcRnzHAqLbaCoZIkWmdAAX6UPlh8sTzWKY2.pdf','conference_announcements/L0Annfp8pva1DqclbTpo3DHt6ErjH3HEXs08ZXHL.pdf','conference_brochures/WcSeCaMjrgdt1mgtDD46uO32nb8H4Ci9Xtz1wA8A.pdf','conference_programs/XuIk4nlH7tpGMp5JLd13y1rDVMgt5UaL1AKRUC3a.pdf',34.00,'2024-11-01 09:45:05','2024-11-01 09:45:05',444.00),(6,'InnovateTech Summit 2024','Join us at the InnovateTech Summit 2024, a premier gathering for technology enthusiasts, industry leaders','2024-11-02','2024-11-15','yyyy','past','conference_images/hvOtkkhVubduImiaZflQSWCsyjNhbVtfJnmRtdJw.png','conference_announcements/nF7druq5JvwMleEE2D8WyuaNhsdpHBMyFOttVQuN.pdf','conference_announcements/BH81SkwuASIz2vOZK4o5LP8RmFkBgu8OuJBYlqO6.pdf','conference_brochures/kme7xZtZ1Ps2u29fi8SoWbbJcFZ0IqrfaTxZz0Bx.pdf','conference_programs/vsHM3TG3sF18Q3vpAR6VSBCPWcGyYKmJbDVbt2Y3.pdf',455.00,'2024-11-01 13:27:44','2024-11-01 13:27:44',555.00),(7,'ggggg','gggggggggg','2024-11-12','2024-11-26','rrrrrrrr','upcoming','conference_images/jTdl3gJmGKcOtjgluK9W3RhCN3rbBfECmIqZAvgr.png','conference_announcements/Cs7xDke8SpR3SrWvTFx0SS8MwEDDOdQS9zKFNjrN.pdf','conference_announcements/aH6fo20VOG8Xto95c8PZhZtRQf6CmzRRwrGAo1su.pdf','conference_brochures/5tT9lhgBS5rKCXO82RluSRBhRYYQlNNVAmcszOwJ.pdf','conference_programs/cjqJPD0uynR3PrQvdEfQEKFZUVwvh8vjH65Y3YSz.pdf',66.00,'2024-11-01 13:29:55','2024-11-01 13:29:55',999.00),(8,'oooooooooo','iiiiiiiiiiiiiii','2024-10-27','2024-10-29','uin','upcoming','conference_images/BG6MMMUvwPP88QrINavfJEGpWTYKqODuhnTnxmZW.jpg','conference_announcements/bJKFWXEv4ttbzeeInqcC2qpISUOVrS51uUzhiABJ.pdf','conference_announcements/5mw0PhuiudXd5AnLo8IxKqyDAcqtA19H2rcFluPR.pdf','conference_brochures/0Cvp803Ilqpy41gH0KvZtILU1iXFFaZXwntNu0gk.pdf','conference_programs/huqaVLsGwA9Dpc7aNWQXjQkmWBLS2AMybUuOFlD9.pdf',66.00,'2024-11-01 13:31:12','2024-11-01 13:31:12',988.00),(9,'gggggg','ffffffffff','2024-10-03','2024-10-31','uuuuuuuuu','past','conference_images/mYfwruXjg8Bq2kbduy24N9OpBAvw1PdXPtwQ3Oqw.jpg','conference_announcements/Xnt0goN1lFopdvZsWMGazUBce4HA3cu1c3i9EvyS.pdf','conference_announcements/f6YoqwCVvZqY3p38EPOJNe5TqNvnDgLUk1CXQCSr.pdf','conference_brochures/cfrrS4uLdNGWJSGOSJg3HsPkDEaNEqoEhool2GSR.pdf','conference_programs/xiiuijEveXYp4ZqN2GXkzIvJXhIOonSIOrEKqnGP.pdf',77.00,'2024-11-01 13:40:58','2024-11-01 13:40:58',899.00),(10,'tttttttt','ttttttt','2024-11-22','2024-11-26','tttttttt','upcoming','conference_images/mJLD77sJcVN2YbXDWkMUwN3u3DS4FksNWdwg8Yq5.png','conference_announcements/Bi9oENO9uUnQWvi6L9UqiDpp0wCd5rS8aIjbF1EQ.pdf','conference_announcements/jOvQscqADhAOQZWZAwvjr3ctTDJiktjWyuDfmodb.pdf','conference_brochures/QIltkHZIrocFpXFA4C7dlUGXFtOjgYYnDMG7EQbk.pdf','conference_programs/mvHhsbQ4CdQlyorqiASasuImnjBr32EKJT7NAKhe.pdf',88.00,'2024-11-01 13:42:17','2024-11-01 13:42:17',889.00),(11,'yyyyyyyyyy','yyyy','2024-11-11','2024-11-12','tttttttt','past','conference_images/PH60O40qlztRq4G2Axdmfas5nAGMHcJQ1YwJu3ep.png','conference_announcements/hzMuhEITZicuLpwd1hahCBsxa20qm9LISqMuSQ3w.pdf','conference_announcements/AMCe18n5LzKVItG1PaToCcDlNmtVVz1irKAn7Frw.pdf','conference_brochures/J5e7BHjW8GAlqOasY8eHVXHGpuuooRVyuMgTP6MF.pdf','conference_programs/OlVWw1iniCOvhICldtW0B9Ds9n3Ee1qazU4udq5w.pdf',99.00,'2024-11-01 13:43:16','2024-11-01 13:43:16',789.00),(12,'yyyyyyyy','yyyyyy','2024-11-06','2024-11-28','yyyyyyyy','upcoming','conference_images/KJQevNKLUoGGgm352TXTxT2lnmEtODsHivfrZ5Kx.jpg','conference_announcements/Yxph9Csp0dVRAalYeJHc0VXgxU1EpSHJBqGka5fk.pdf','conference_announcements/07eRZMI4DpGrpLqjP1SG0TGJQq88alX9STqT7icE.pdf','conference_brochures/Kmff47A4bqT5Filiwcj5SFchOQmgwQls2TR0BSNL.pdf','conference_programs/1Sm1QdnXmndM6TvzoXyqq33ZlaR2wsaZ2FwCjORz.pdf',44.00,'2024-11-04 11:30:49','2024-11-04 11:30:49',22.00);
/*!40000 ALTER TABLE `conferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dinner_attendees`
--

DROP TABLE IF EXISTS `dinner_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dinner_attendees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `speaker_id` bigint unsigned NOT NULL,
  `companion_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `paid` tinyint(1) NOT NULL DEFAULT '1',
  `is_companion_fee_applicable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `companion_price` decimal(8,2) DEFAULT NULL,
  `conference_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dinner_attendees_speaker_id_foreign` (`speaker_id`),
  CONSTRAINT `dinner_attendees_speaker_id_foreign` FOREIGN KEY (`speaker_id`) REFERENCES `speakers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dinner_attendees`
--

LOCK TABLES `dinner_attendees` WRITE;
/*!40000 ALTER TABLE `dinner_attendees` DISABLE KEYS */;
INSERT INTO `dinner_attendees` VALUES (27,2,'maria',NULL,1,0,'2024-11-05 05:06:49','2024-11-05 05:06:49',20.00,1),(28,2,'ameer',NULL,1,0,'2024-11-05 05:24:07','2024-11-05 05:24:07',20.00,1),(29,8,'┘à╪┤┘à╪┤',NULL,1,0,'2024-11-07 04:41:03','2024-11-07 04:41:03',33.00,3);
/*!40000 ALTER TABLE `dinner_attendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dinner_details`
--

DROP TABLE IF EXISTS `dinner_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dinner_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned NOT NULL,
  `dinner_date` datetime DEFAULT NULL,
  `restaurant_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gathering_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transportation_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gathering_time` time DEFAULT NULL,
  `dinner_time` time DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `dress_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dinner_details_conference_id_foreign` (`conference_id`),
  CONSTRAINT `dinner_details_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dinner_details`
--

LOCK TABLES `dinner_details` WRITE;
/*!40000 ALTER TABLE `dinner_details` DISABLE KEYS */;
INSERT INTO `dinner_details` VALUES (1,2,'2024-10-10 00:00:00','flowers','amman','amman','bus','03:22:00','04:44:00',30,'aaa','2024-10-30 02:17:20','2024-10-30 02:17:20'),(2,1,'2024-10-10 00:00:00','flowers','amman','amman','bus','03:22:00','04:44:00',30,'aaa','2024-10-30 02:19:10','2024-10-30 02:19:10'),(3,1,'2024-11-14 00:00:00','flower','ggg','ggg','ggg','10:45:00','00:45:00',30,'dd','2024-11-04 02:45:43','2024-11-04 02:45:43'),(4,4,'2024-11-13 00:00:00','flower3','amman','amman','bus','02:22:00','03:33:00',30,'cotton','2024-11-04 03:33:49','2024-11-04 03:33:49'),(5,1,'2024-11-13 00:00:00','flower3','amman','amman','bus','02:22:00','03:33:00',30,'cotton','2024-11-04 03:34:02','2024-11-04 03:34:02'),(6,3,'2024-11-18 00:00:00','flower3','amman','amman','bus','02:22:00','03:33:00',30,'cotton','2024-11-04 03:34:12','2024-11-04 03:34:12'),(7,10,'2024-11-13 00:00:00','flower3','amman','amman','bus','02:22:00','03:33:00',30,'cotton','2024-11-04 03:34:18','2024-11-04 03:34:18'),(8,2,'2024-11-26 00:00:00','flowe','madaba','12fds','car','04:55:00','03:45:00',66,'bg','2024-11-05 07:30:53','2024-11-05 07:30:53'),(9,2,'2024-11-26 00:00:00','flowe','madaba','12fds','car','04:55:00','03:45:00',66,'bg','2024-11-05 07:30:55','2024-11-05 07:30:55'),(10,2,'2024-11-26 00:00:00','flowe','madaba','12fds','car','04:55:00','03:45:00',66,'bg','2024-11-05 07:31:03','2024-11-05 07:31:03'),(11,4,'2024-11-26 00:00:00','flowe','madaba','12fds','car','04:55:00','03:45:00',66,'bg','2024-11-05 07:31:14','2024-11-05 07:31:14'),(12,10,'2024-11-26 00:00:00','flowe','madaba','12fds','car','04:55:00','03:45:00',66,'bg','2024-11-05 07:31:20','2024-11-05 07:31:20'),(13,10,'2024-11-26 00:00:00','flowe','madaba','12fds','car','04:55:00','03:45:00',66,'bg','2024-11-05 07:32:57','2024-11-05 07:32:57');
/*!40000 ALTER TABLE `dinner_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dinner_speaker_companion_fees`
--

DROP TABLE IF EXISTS `dinner_speaker_companion_fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dinner_speaker_companion_fees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `dinner_id` bigint unsigned NOT NULL,
  `speaker_id` bigint unsigned NOT NULL,
  `companion_fee` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dinner_speaker_companion_fees_dinner_id_foreign` (`dinner_id`),
  KEY `dinner_speaker_companion_fees_speaker_id_foreign` (`speaker_id`),
  CONSTRAINT `dinner_speaker_companion_fees_dinner_id_foreign` FOREIGN KEY (`dinner_id`) REFERENCES `dinner_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dinner_speaker_companion_fees_speaker_id_foreign` FOREIGN KEY (`speaker_id`) REFERENCES `speakers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dinner_speaker_companion_fees`
--

LOCK TABLES `dinner_speaker_companion_fees` WRITE;
/*!40000 ALTER TABLE `dinner_speaker_companion_fees` DISABLE KEYS */;
/*!40000 ALTER TABLE `dinner_speaker_companion_fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_option`
--

DROP TABLE IF EXISTS `discount_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_option` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `trip_id` bigint unsigned NOT NULL,
  `option_id` bigint unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `show_price` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discount_option_user_id_foreign` (`user_id`),
  KEY `discount_option_trip_id_foreign` (`trip_id`),
  KEY `discount_option_option_id_foreign` (`option_id`),
  CONSTRAINT `discount_option_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `additional_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discount_option_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discount_option_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_option`
--

LOCK TABLES `discount_option` WRITE;
/*!40000 ALTER TABLE `discount_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exhibition_images`
--

DROP TABLE IF EXISTS `exhibition_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exhibition_images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `exhibition_id` bigint unsigned NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exhibition_images_exhibition_id_foreign` (`exhibition_id`),
  CONSTRAINT `exhibition_images_exhibition_id_foreign` FOREIGN KEY (`exhibition_id`) REFERENCES `exhibitions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibition_images`
--

LOCK TABLES `exhibition_images` WRITE;
/*!40000 ALTER TABLE `exhibition_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `exhibition_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exhibitions`
--

DROP TABLE IF EXISTS `exhibitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exhibitions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `status` enum('upcoming','past') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'upcoming',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conference_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exhibitions_conference_id_foreign` (`conference_id`),
  CONSTRAINT `exhibitions_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibitions`
--

LOCK TABLES `exhibitions` WRITE;
/*!40000 ALTER TABLE `exhibitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `exhibitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `flight_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `is_companion` tinyint(1) NOT NULL DEFAULT '0',
  `main_user_id` bigint unsigned DEFAULT NULL,
  `passport_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departure_airport` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `arrival_airport` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date NOT NULL,
  `flight_number` text COLLATE utf8mb4_unicode_ci,
  `seat_preference` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upgrade_class` tinyint(1) NOT NULL DEFAULT '0',
  `ticket_count` int DEFAULT '1',
  `additional_requests` text COLLATE utf8mb4_unicode_ci,
  `passenger_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `last_speaker_update_at` timestamp NULL DEFAULT NULL,
  `last_admin_update_at` timestamp NULL DEFAULT NULL,
  `business_class_upgrade_cost` decimal(8,2) DEFAULT '0.00',
  `reserved_seat_cost` decimal(8,2) DEFAULT '0.00',
  `additional_baggage_cost` decimal(8,2) DEFAULT '0.00',
  `other_additional_costs` decimal(8,2) DEFAULT '0.00',
  `admin_update_deadline` datetime DEFAULT NULL,
  `is_free` tinyint(1) NOT NULL DEFAULT '0',
  `ticket_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_available_for_download` tinyint(1) NOT NULL DEFAULT '0',
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `download_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `specific_flight_time` time DEFAULT NULL,
  `base_ticket_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`flight_id`),
  KEY `flights_user_id_foreign` (`user_id`),
  CONSTRAINT `flights_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (68,13,0,NULL,NULL,'test','test','2024-11-14','2024-11-02',NULL,'5565',1,1,'test','ahmad',0,NULL,'2024-11-02 20:38:07',54.00,55.00,0.00,45.00,NULL,0,NULL,0,NULL,NULL,NULL,'2024-11-02 18:00:07','2024-11-02 17:38:07',NULL,NULL),(69,NULL,1,13,NULL,'test','test','2024-11-14','2024-11-02',NULL,'5656',1,1,'5445','ali',0,NULL,'2024-11-02 20:38:07',45.00,34.00,0.00,56.00,NULL,0,NULL,0,NULL,NULL,NULL,'2024-11-02 18:00:07','2024-11-02 17:38:07',NULL,NULL),(70,NULL,1,13,NULL,'test','test','2024-11-23','2024-11-13',NULL,'6556',1,1,'test','omar',0,NULL,'2024-11-02 20:38:07',45.00,34.00,0.00,45.00,NULL,0,NULL,0,NULL,NULL,NULL,'2024-11-02 18:00:07','2024-11-02 17:38:07',NULL,NULL);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_registrations`
--

DROP TABLE IF EXISTS `group_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_registrations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `contact_person` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number_of_doctors` int DEFAULT NULL,
  `excel_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `update_deadline` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conference_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_registrations_user_id_foreign` (`user_id`),
  KEY `group_registrations_conference_id_foreign` (`conference_id`),
  CONSTRAINT `group_registrations_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE SET NULL,
  CONSTRAINT `group_registrations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_registrations`
--

LOCK TABLES `group_registrations` WRITE;
/*!40000 ALTER TABLE `group_registrations` DISABLE KEYS */;
INSERT INTO `group_registrations` VALUES (1,3,'Jane Doe',5,NULL,1,'2024-11-17 21:00:00','2024-10-21 10:15:36','2024-11-03 03:24:45',NULL,NULL),(2,4,'Jane Doe',5,'excel_files/s0CrrwrbpBdlhXItqs2xBkegiYMfmpW8ad6dTd49.xlsx',0,'2024-10-21 11:09:26','2024-10-21 11:09:26','2024-10-22 12:42:08',NULL,NULL),(3,1,'Jane Doe',5,NULL,0,'2024-10-21 11:09:26','2024-10-21 12:04:00','2024-10-21 12:04:00',NULL,NULL),(4,6,'ayat',34,NULL,0,NULL,'2024-10-22 10:28:37','2024-10-22 10:28:37',NULL,NULL),(5,7,'Jane Doe',5,'excel_files/a2uwCuT3mLfPxy4DNwjrrlytCFcONpZF7j3epKA2.xlsx',0,NULL,'2024-10-22 12:48:50','2024-10-22 14:18:42',NULL,NULL),(6,8,'HHH',66,NULL,0,NULL,'2024-10-22 14:40:33','2024-10-22 14:40:33',NULL,NULL),(7,17,'alaa',40,NULL,0,NULL,'2024-11-03 02:29:15','2024-11-03 02:29:15',NULL,NULL),(8,18,'alaa',40,NULL,0,NULL,'2024-11-03 02:31:20','2024-11-03 02:31:20',NULL,NULL),(9,19,'gggg',4,'excel_files/nfkNvjvYdUuijNuSgG89DZ6dU5rQMnEfewHfbx2H.xlsx',1,'2024-11-26 21:00:00','2024-11-03 02:47:25','2024-11-04 14:51:14',NULL,NULL),(10,20,'ayat',30,NULL,0,NULL,'2024-11-03 08:34:38','2024-11-03 08:34:38',NULL,NULL),(11,21,'ayat',5,'excel_files/rgpcq1EswBARCuUrrxm8ePVIqRe3MxrThpSnjGG6.xlsx',1,'2024-12-04 21:00:00','2024-11-03 10:52:16','2024-11-06 10:23:07',NULL,NULL),(12,22,'yy',3,'excel_files/8Qe9ZPOBkePp0EHPTwzPqEnYPexo6vmxri7ZSQBw.xlsx',1,'2024-11-13 21:00:00','2024-11-03 11:56:40','2024-11-03 12:21:28',NULL,NULL),(13,23,'ayat',20,'excel_files/MakzwJA26uLiLhRbun3ljjgRXnAXYSitNQH98Vd2.xlsx',1,'2024-11-23 21:00:00','2024-11-03 13:23:19','2024-11-04 12:49:08',NULL,NULL),(14,24,'ayat',10,'excel_files/bE9VcUxLjbEQUyIc7VQeNEb2CnkHJ0jM9NfgWW5u.xlsx',1,'2024-11-17 21:00:00','2024-11-03 13:29:00','2024-11-03 13:30:08',NULL,NULL);
/*!40000 ALTER TABLE `group_registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_trip_participants`
--

DROP TABLE IF EXISTS `group_trip_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_trip_participants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `trip_id` bigint unsigned NOT NULL,
  `selected_date` date NOT NULL,
  `companions_count` int NOT NULL DEFAULT '0',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_trip_participants_user_id_foreign` (`user_id`),
  KEY `group_trip_participants_trip_id_foreign` (`trip_id`),
  CONSTRAINT `group_trip_participants_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_trip_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_trip_participants`
--

LOCK TABLES `group_trip_participants` WRITE;
/*!40000 ALTER TABLE `group_trip_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_trip_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (1,'default','{\"uuid\":\"3c97b740-8e18-4bf5-88bf-378261ced9c5\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:399;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730963855,1730963855),(2,'default','{\"uuid\":\"cabfb410-96d2-4b9a-a708-fd6fd326e84a\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:400;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730963855,1730963855),(3,'default','{\"uuid\":\"5d826daa-8f10-4f53-b8f7-f63304d842d9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:401;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730963903,1730963903),(4,'default','{\"uuid\":\"2f37664f-2946-4998-b10b-0a15f8a2ae9e\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:402;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730965225,1730965225),(5,'default','{\"uuid\":\"d65200ec-d6ac-41b6-905e-03acf3a4c776\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:403;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730965225,1730965225),(6,'default','{\"uuid\":\"1331e329-8414-409c-a677-db244fde246b\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:404;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730965263,1730965263),(7,'default','{\"uuid\":\"a6be2ba5-7364-4d53-bde8-ca96c2fbd5cb\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:405;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730965295,1730965295),(8,'default','{\"uuid\":\"b943199c-191f-47cd-aa8c-4c1e8fbff544\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:406;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730968074,1730968074),(9,'default','{\"uuid\":\"54670828-fdc2-4219-af63-c268a77b6c1c\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:407;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1730968152,1730968152);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'Ahmad','ahmad@example.com','┘à╪┤┘â┘ä╪⌐ ┘ü┘è ╪º┘ä┘à┘ê┘é╪╣','╪ú╪▒┘è╪» ┘à╪│╪º╪╣╪»╪⌐ ┘ü┘è ╪Ñ╪╡┘ä╪º╪¡ ╪º┘ä╪«╪╖╪ú ╪º┘ä╪░┘è ┘è╪╕┘ç╪▒ ┘ä┘è ┘ü┘è ╪º┘ä╪╡┘ü╪¡╪⌐ ╪º┘ä╪▒╪ª┘è╪│┘è╪⌐.','2024-11-06 05:09:58','2024-11-06 05:09:58'),(2,'Ahmad','ahmad@example.com','┘à╪┤┘â┘ä╪⌐ ┘ü┘è ╪º┘ä┘à┘ê┘é╪╣','╪ú╪▒┘è╪» ┘à╪│╪º╪╣╪»╪⌐ ┘ü┘è ╪Ñ╪╡┘ä╪º╪¡ ╪º┘ä╪«╪╖╪ú ╪º┘ä╪░┘è ┘è╪╕┘ç╪▒ ┘ä┘è ┘ü┘è ╪º┘ä╪╡┘ü╪¡╪⌐ ╪º┘ä╪▒╪ª┘è╪│┘è╪⌐.','2024-11-06 05:10:59','2024-11-06 05:10:59'),(3,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:10:13','2024-11-06 06:10:13'),(4,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:11:39','2024-11-06 06:11:39'),(5,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:11:51','2024-11-06 06:11:51'),(6,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:12:41','2024-11-06 06:12:41'),(7,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:12:56','2024-11-06 06:12:56'),(8,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:13:09','2024-11-06 06:13:09'),(9,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:14:00','2024-11-06 06:14:00'),(10,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:14:07','2024-11-06 06:14:07'),(11,'alaa','ayatalmomani655@gmail.com','aaaa','helfpl.g, llcv,,vvvvvvvvvvvvvvvv','2024-11-06 06:14:28','2024-11-06 06:14:28'),(12,'┘å','ayatalmomani655@gmail.com','╪«╪«','╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º','2024-11-06 06:14:43','2024-11-06 06:14:43'),(13,'ggggg','ayatalmomani655@gmail.com','aaaa','iiiiiiiiiiii','2024-11-06 06:16:03','2024-11-06 06:16:03'),(14,'Ayat Almomani','ayatalmomani655@gmail.com','╪«╪«','iiiiiiiii','2024-11-06 06:40:58','2024-11-06 06:40:58'),(15,'Ayat Almomani','ayatalmomajni655@gmail.com','╪«╪«','hhhhhhhh','2024-11-06 07:05:30','2024-11-06 07:05:30'),(16,'maria','ayata55@gmail.com','f','helllo','2024-11-06 07:34:00','2024-11-06 07:34:00'),(17,'ayat','ayatalmojmani655@gmail.com','a','msg','2024-11-06 07:36:43','2024-11-06 07:36:43');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2024_09_03_062848_create_conferences_table',1),(5,'2024_09_03_065551_create_conference_image_table',1),(6,'2024_09_03_073118_create_committee_members_table',1),(7,'2024_09_03_082314_create_scientific_topics_table',1),(8,'2024_09_03_082802_create_conference_prices_table',1),(9,'2024_09_03_093540_create_scientific_papers_table',1),(10,'2024_09_03_115452_create_exhibitions_table',1),(11,'2024_09_03_122725_create_tourist_sites_table',1),(12,'2024_09_04_061903_update_users_table',1),(13,'2024_09_04_065553_update_conferences_table',1),(14,'2024_09_05_120747_modify_name_column_in_users_table',1),(15,'2024_09_05_160656_make_conference_img_nullable',1),(16,'2024_09_05_160846_update_conference_img_column',1),(17,'2024_09_05_162332_change_committee_image_column_in_committee_members_table',1),(18,'2024_09_10_220245_create_personal_access_tokens_table',1),(19,'2024_09_12_143405_create_speakers_table',1),(20,'2024_09_12_155012_create_attendance_table',1),(21,'2024_09_12_155327_create_sponsors_table',1),(22,'2024_09_12_161020_create_group_registrations_table',1),(23,'2024_09_12_212631_add_status_to_users_table',1),(24,'2024_09_14_103631_create_exhibition_images_table',1),(25,'2024_09_16_095352_create_notifications_table',2),(26,'2024_09_16_223522_add_column_to_notifications_table',2),(27,'2024_09_17_132654_create_visas_table',2),(28,'2024_09_17_145154_update_visas_table',2),(29,'2024_09_19_162524_create_flights_table',2),(30,'2024_09_19_162757_create_available_flights_table',2),(31,'2024_09_22_102500_modify_admin_update_deadline_column_in_flights_table',2),(32,'2024_09_22_142132_create_accepted_flights_table',2),(33,'2024_09_22_160324_add_departure_details_to_accepted_flights_table',2),(34,'2024_09_25_141323_update_ticket_count_default_in_flights_table',2),(35,'2024_09_27_180053_create_conference_user_table',2),(36,'2024_09_27_192519_add_specific_flight_time_to_flights_table',2),(37,'2024_09_28_022942_make_user_id_nullable_in_flights_table',2),(38,'2024_09_28_062022_add_conference_id_to_exhibitions_table',2),(39,'2024_10_01_050157_create_reservations_table',2),(40,'2024_10_01_050246_create_rooms_table',2),(41,'2024_10_03_053130_add_update_deadline_to_reservations_table',2),(42,'2024_10_03_093606_create_trips_table',2),(43,'2024_10_03_100913_create_trip_participants_table',2),(44,'2024_10_04_121859_create_group_trip_participants_table',2),(45,'2024_10_06_143350_create_conference_trip_table',2),(46,'2024_10_06_154441_create_additional_options_table',2),(47,'2024_10_06_155127_create_user_final_prices_table',2),(48,'2024_10_09_112106_create_dinner_details_table',3),(49,'2024_10_09_112107_create_dinner_attendees_table',3),(50,'2024_10_09_123210_create_airport_transfer_bookings_table',4),(51,'2024_10_09_140643_create_dinner_speaker_companion_fees_table',4),(52,'2024_10_10_070827_add_trip_costs_to_speakers_table',4),(53,'2024_10_10_152424_modify_foreign_key_on_dinner_attendees',4),(54,'2024_10_11_100200_create_discount_option_table',4),(55,'2024_10_12_092152_create_trip_options_participants_table',4),(56,'2024_10_12_130532_modify_trip_participants_nullable_columns',4),(57,'2024_10_13_062851_create_airport_transfer_prices_table',5),(58,'2024_10_16_100356_add_conference_id_to_notifications_table',6),(59,'2024_10_19_110657_make_password_nullable_in_users_table',6),(60,'2024_10_20_084001_add_updated_at_by_admin_to_visas_table',6),(61,'2024_10_21_051547_add_visa_price_to_conferences_table',6),(62,'2024_10_21_122214_add_is_admin_to_users_table',7),(63,'2024_10_21_130937_add_password_to_group_registrations_table',8),(64,'2024_10_21_145828_add_conference_id_to_group_registrations_table',9),(65,'2024_10_22_234531_add_base_ticket_price_to_flights_table',10),(66,'2024_10_25_124630_create_room_prices_table',11),(67,'2024_10_25_133459_add_room_type_and_nights_covered_to_speakers_table',12),(68,'2024_10_26_140006_make_columns_nullable_in_trips_table',13),(69,'2024_10_29_081049_create_ourclients_table',14),(70,'2024_11_01_094355_rename_visa_price_in_conferences_table',15),(71,'2024_11_01_153250_add_is_visa_payment_required_to_conference_user_table',16),(73,'2024_11_04_102722_add_companion_dinner_price_to_conferences_table',17),(74,'2024_11_04_103759_add_companion_dinner_price_to_conferences_table',18),(75,'2024_11_04_151523_add_companion_price_to_dinner_attendees_table',19),(77,'2024_11_05_051427_add_conference_id_to_dinner_attendees_table',20),(79,'2024_11_05_112318_create_jobs_applicants_and_job_applications_tables',21),(80,'2024_11_05_133759_rename_events_coordinator_column_in_available_jobs_table',22),(81,'2024_11_06_080507_create_messages_table',23),(82,'2024_11_06_105517_create_sponsorship_options_table',24),(83,'2024_11_06_145221_create_conference_sponsorship_options_table',25),(84,'2024_11_06_151147_rename_conference_sponsorship_options_to_sponsorships',26);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `register_id` bigint unsigned DEFAULT NULL,
  `conference_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',1,'2024-10-21 09:23:15','2024-11-02 07:10:29',1,1),(2,2,'New speaker registration: amero',0,'2024-10-21 09:25:15','2024-10-21 09:25:15',2,1),(3,2,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-10-21 09:25:15','2024-10-21 09:25:15',2,1),(4,3,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-10-21 10:15:36','2024-10-21 10:15:36',NULL,1),(5,2,'New group registration: johndoe@example.com',0,'2024-10-21 10:15:36','2024-10-21 10:15:36',3,NULL),(6,3,'Now you can access the activated file and download the registered names.',0,'2024-10-21 10:32:07','2024-10-21 10:32:07',NULL,NULL),(7,3,'Now you can access the activated file and download the registered names.',0,'2024-10-21 10:32:33','2024-10-21 10:32:33',NULL,NULL),(8,4,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-10-21 11:09:26','2024-10-21 11:09:26',NULL,1),(9,2,'New group registration: m@example.com',0,'2024-10-21 11:09:26','2024-10-21 11:09:26',4,NULL),(10,5,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-10-21 12:04:00','2024-10-21 12:04:00',NULL,1),(11,2,'New group registration: mf@example.com',0,'2024-10-21 12:04:00','2024-10-21 12:04:00',5,NULL),(12,6,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-10-22 10:28:37','2024-10-22 10:28:37',NULL,1),(13,2,'New group registration: aya@gmail.com',0,'2024-10-22 10:28:37','2024-10-22 10:28:37',6,NULL),(14,3,'Now you can access the activated file and download the registered names.',0,'2024-10-22 12:22:10','2024-10-22 12:22:10',NULL,NULL),(15,3,'Now you can access the activated file and download the registered names.',0,'2024-10-22 12:24:18','2024-10-22 12:24:18',NULL,NULL),(16,3,'Now you can access the activated file and download the registered names.',0,'2024-10-22 12:39:35','2024-10-22 12:39:35',NULL,NULL),(17,7,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-10-22 12:48:50','2024-10-22 12:48:50',NULL,1),(18,2,'New group registration: ma@example.com',0,'2024-10-22 12:48:50','2024-10-22 12:48:50',7,NULL),(19,8,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-10-22 14:40:33','2024-10-22 14:40:33',NULL,1),(20,2,'New group registration: jor@GMAIL.COM',0,'2024-10-22 14:40:33','2024-10-22 14:40:33',8,NULL),(21,1,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-23 07:19:01','2024-10-23 07:19:01',NULL,NULL),(22,2,'New flight registered byamero. Log in to adjust the price.',0,'2024-10-23 07:19:01','2024-10-23 07:19:01',1,NULL),(23,1,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-23 10:43:57','2024-10-23 10:43:57',1,NULL),(24,1,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-23 20:53:52','2024-10-23 20:53:52',1,NULL),(25,1,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-24 03:58:49','2024-10-24 03:58:49',1,NULL),(26,1,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-24 04:07:31','2024-10-24 04:07:31',1,NULL),(27,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-24 04:59:49','2024-10-24 04:59:49',NULL,NULL),(28,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-24 04:59:49','2024-10-24 04:59:49',2,NULL),(29,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-24 04:59:50','2024-10-24 04:59:50',NULL,NULL),(30,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-24 04:59:50','2024-10-24 04:59:50',2,NULL),(31,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-24 05:00:03','2024-10-24 05:00:03',NULL,NULL),(32,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-24 05:00:03','2024-10-24 05:00:03',2,NULL),(33,2,'Flight number 27 has been modified by user amero',0,'2024-10-24 05:01:19','2024-10-24 05:01:19',NULL,NULL),(34,2,'Flight number 27 has been modified by user amero',0,'2024-10-24 05:05:59','2024-10-24 05:05:59',NULL,NULL),(35,2,'Flight number 8 has been modified by user amero',0,'2024-10-24 05:24:26','2024-10-24 05:24:26',NULL,NULL),(36,2,'Flight number 20 has been modified by user amero',0,'2024-10-24 06:23:04','2024-10-24 06:23:04',NULL,NULL),(37,1,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-24 09:47:18','2024-10-24 09:47:18',NULL,NULL),(38,7,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-24 09:49:41','2024-10-24 09:49:41',NULL,NULL),(39,1,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-24 10:25:27','2024-10-24 10:25:27',NULL,NULL),(40,7,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-24 10:26:53','2024-10-24 10:26:53',NULL,NULL),(41,2,'New speaker registration: alaa',0,'2024-10-28 07:24:45','2024-10-28 07:24:45',9,1),(42,9,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-10-28 07:24:46','2024-10-28 07:24:46',9,1),(43,2,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-10-28 07:26:46','2024-10-28 07:26:46',NULL,1),(44,9,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-10-28 07:31:44','2024-10-28 07:31:44',NULL,1),(45,2,'New speaker registration: mm',0,'2024-10-28 07:42:06','2024-10-28 07:42:06',10,1),(46,10,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-10-28 07:42:06','2024-10-28 07:42:06',10,1),(47,2,'New speaker registration: jjj',0,'2024-10-28 07:43:39','2024-10-28 07:43:39',11,1),(48,11,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-10-28 07:43:39','2024-10-28 07:43:39',11,1),(49,11,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-10-28 07:45:42','2024-10-28 07:45:42',NULL,1),(50,12,'We are pleased to inform you that you have been successfully registered, and your profile is now active on the website. You can log in to it now.',0,'2024-10-28 08:28:14','2024-10-28 08:28:14',NULL,NULL),(51,2,'New Attendance registration: ╪┤╪║',0,'2024-10-28 08:28:15','2024-10-28 08:28:15',12,1),(52,2,'New speaker registration: mm',0,'2024-10-28 08:34:46','2024-10-28 08:34:46',13,1),(53,13,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-10-28 08:34:46','2024-10-28 08:34:46',13,1),(54,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 05:23:49','2024-10-29 05:23:49',NULL,NULL),(55,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 05:23:49','2024-10-29 05:23:49',13,NULL),(56,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:29:55','2024-10-29 08:29:55',NULL,NULL),(57,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:29:55','2024-10-29 08:29:55',13,NULL),(58,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:29:57','2024-10-29 08:29:57',NULL,NULL),(59,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:29:57','2024-10-29 08:29:57',13,NULL),(60,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:29:57','2024-10-29 08:29:57',NULL,NULL),(61,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:29:57','2024-10-29 08:29:57',13,NULL),(62,13,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-10-29 08:36:17','2024-10-29 08:36:17',NULL,1),(63,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:47:38','2024-10-29 08:47:38',NULL,NULL),(64,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:47:38','2024-10-29 08:47:38',13,NULL),(65,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:47:38','2024-10-29 08:47:38',NULL,NULL),(66,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:47:38','2024-10-29 08:47:38',13,NULL),(67,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:47:38','2024-10-29 08:47:38',NULL,NULL),(68,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:47:38','2024-10-29 08:47:38',13,NULL),(69,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:48:03','2024-10-29 08:48:03',NULL,NULL),(70,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:48:03','2024-10-29 08:48:03',13,NULL),(71,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:48:03','2024-10-29 08:48:03',NULL,NULL),(72,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:48:03','2024-10-29 08:48:03',13,NULL),(73,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:48:03','2024-10-29 08:48:03',NULL,NULL),(74,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:48:03','2024-10-29 08:48:03',13,NULL),(75,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:56:47','2024-10-29 08:56:47',NULL,NULL),(76,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:56:47','2024-10-29 08:56:47',13,NULL),(77,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:56:47','2024-10-29 08:56:47',NULL,NULL),(78,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:56:47','2024-10-29 08:56:47',13,NULL),(79,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:56:47','2024-10-29 08:56:47',NULL,NULL),(80,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:56:47','2024-10-29 08:56:47',13,NULL),(81,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:59:07','2024-10-29 08:59:07',NULL,NULL),(82,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:59:07','2024-10-29 08:59:07',13,NULL),(83,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:59:07','2024-10-29 08:59:07',NULL,NULL),(84,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:59:07','2024-10-29 08:59:07',13,NULL),(85,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 08:59:07','2024-10-29 08:59:07',NULL,NULL),(86,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 08:59:07','2024-10-29 08:59:07',13,NULL),(87,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-29 12:24:10','2024-10-29 12:24:10',13,NULL),(88,13,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-29 09:41:17','2024-10-29 09:41:17',NULL,NULL),(89,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 10:10:55','2024-10-29 10:10:55',NULL,NULL),(90,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 10:10:55','2024-10-29 10:10:55',13,NULL),(91,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 10:10:58','2024-10-29 10:10:58',NULL,NULL),(92,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 10:10:58','2024-10-29 10:10:58',13,NULL),(93,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 10:10:58','2024-10-29 10:10:58',NULL,NULL),(94,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-29 10:10:58','2024-10-29 10:10:58',13,NULL),(95,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-29 13:12:07','2024-10-29 13:12:07',13,NULL),(96,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-29 13:12:52','2024-10-29 13:12:52',13,NULL),(97,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-29 13:59:18','2024-10-29 13:59:18',13,NULL),(98,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 11:37:21','2024-10-29 11:37:21',NULL,NULL),(99,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-29 11:37:21','2024-10-29 11:37:21',2,NULL),(100,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 11:37:22','2024-10-29 11:37:22',NULL,NULL),(101,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-29 11:37:22','2024-10-29 11:37:22',2,NULL),(102,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 11:38:02','2024-10-29 11:38:02',NULL,NULL),(103,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-29 11:38:02','2024-10-29 11:38:02',2,NULL),(104,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 11:38:02','2024-10-29 11:38:02',NULL,NULL),(105,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-29 11:38:02','2024-10-29 11:38:02',2,NULL),(106,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 12:10:05','2024-10-29 12:10:05',NULL,NULL),(107,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-29 12:10:05','2024-10-29 12:10:05',2,NULL),(108,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 12:11:44','2024-10-29 12:11:44',NULL,NULL),(109,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-29 12:11:44','2024-10-29 12:11:44',2,NULL),(110,2,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-29 12:11:44','2024-10-29 12:11:44',NULL,NULL),(111,2,'New flight registered by amero. Log in to adjust the price.',0,'2024-10-29 12:11:44','2024-10-29 12:11:44',2,NULL),(112,2,'You will receive a confirmation message on WhatsApp with the driverΓÇÖs name and phone number.',0,'2024-10-30 02:55:12','2024-10-30 02:55:12',2,NULL),(113,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-30 06:47:28','2024-10-30 06:47:28',NULL,NULL),(114,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-30 06:47:28','2024-10-30 06:47:28',13,NULL),(115,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-30 06:47:31','2024-10-30 06:47:31',NULL,NULL),(116,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-30 06:47:31','2024-10-30 06:47:31',13,NULL),(117,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-10-30 06:47:31','2024-10-30 06:47:31',NULL,NULL),(118,2,'New flight registered by mm. Log in to adjust the price.',0,'2024-10-30 06:47:31','2024-10-30 06:47:31',13,NULL),(119,13,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-30 07:20:03','2024-10-30 07:20:03',NULL,NULL),(120,13,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-30 07:20:39','2024-10-30 07:20:39',NULL,NULL),(121,14,'We are pleased to inform you that you have been successfully registered, and your profile is now active on the website. You can log in to it now.',0,'2024-10-31 01:39:31','2024-10-31 01:39:31',NULL,NULL),(122,2,'New Attendance registration: ayat',0,'2024-10-31 01:39:33','2024-10-31 01:39:33',14,1),(123,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 03:57:15','2024-10-31 03:57:15',13,NULL),(124,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 03:59:58','2024-10-31 03:59:58',13,NULL),(125,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:01:41','2024-10-31 04:01:41',13,NULL),(126,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:02:39','2024-10-31 04:02:39',13,NULL),(127,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:06:31','2024-10-31 04:06:31',13,NULL),(128,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:11:17','2024-10-31 04:11:17',13,NULL),(129,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:13:17','2024-10-31 04:13:17',13,NULL),(130,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:14:59','2024-10-31 04:14:59',13,NULL),(131,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:35:30','2024-10-31 04:35:30',NULL,NULL),(132,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:36:08','2024-10-31 04:36:08',NULL,NULL),(133,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:41:53','2024-10-31 04:41:53',13,NULL),(134,2,'New speaker registration: ',0,'2024-10-31 04:41:53','2024-10-31 04:41:53',NULL,NULL),(135,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:43:39','2024-10-31 04:43:39',13,NULL),(136,2,'New speaker registration: ',0,'2024-10-31 04:43:40','2024-10-31 04:43:40',NULL,NULL),(137,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:47:17','2024-10-31 04:47:17',13,NULL),(138,2,'New visa request from user: mm',0,'2024-10-31 04:47:17','2024-10-31 04:47:17',NULL,NULL),(139,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:52:44','2024-10-31 04:52:44',13,NULL),(140,2,'New visa request from user: mm for conference ID: ',0,'2024-10-31 04:52:44','2024-10-31 04:52:44',NULL,NULL),(141,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:54:48','2024-10-31 04:54:48',13,NULL),(142,2,'New visa request from user: mm for conference ID: ',0,'2024-10-31 04:54:48','2024-10-31 04:54:48',NULL,NULL),(143,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 04:57:10','2024-10-31 04:57:10',13,1),(144,2,'New visa request from user: mm for conference ID: 1',0,'2024-10-31 04:57:10','2024-10-31 04:57:10',NULL,1),(145,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 05:00:18','2024-10-31 05:00:18',13,1),(146,2,'New visa request from user: mm for conference: test',0,'2024-10-31 05:00:18','2024-10-31 05:00:18',NULL,1),(147,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-31 09:58:33','2024-10-31 09:58:33',13,NULL),(148,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-31 09:59:41','2024-10-31 09:59:41',13,NULL),(149,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-31 10:01:08','2024-10-31 10:01:08',13,NULL),(150,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-31 10:01:15','2024-10-31 10:01:15',13,NULL),(151,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-31 10:01:33','2024-10-31 10:01:33',13,NULL),(152,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-10-31 10:31:09','2024-10-31 10:31:09',13,NULL),(153,14,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 07:39:27','2024-10-31 07:39:27',14,NULL),(154,2,'New visa request from user: ayat for conference: ',0,'2024-10-31 07:39:27','2024-10-31 07:39:27',NULL,NULL),(155,11,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-10-31 07:41:48','2024-10-31 07:41:48',11,1),(156,2,'New visa request from user: jjj for conference: test',0,'2024-10-31 07:41:48','2024-10-31 07:41:48',NULL,1),(157,13,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-31 08:08:43','2024-10-31 08:08:43',NULL,NULL),(158,13,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-31 08:09:19','2024-10-31 08:09:19',NULL,NULL),(159,13,'You can visit your profile; the requested ticket is now available on the website.',0,'2024-10-31 08:12:14','2024-10-31 08:12:14',NULL,NULL),(160,13,'Your visa has been approved.',0,'2024-11-01 09:45:06','2024-11-01 09:45:06',13,NULL),(161,13,'Your visa has been approved.',0,'2024-11-01 09:48:02','2024-11-01 09:48:02',13,NULL),(162,13,'Your visa has been approved.',0,'2024-11-01 10:11:50','2024-11-01 10:11:50',13,NULL),(163,13,'Your visa is currently pending. Please wait for further updates.',1,'2024-11-01 10:15:29','2024-11-02 11:12:49',13,NULL),(164,13,'Your visa is currently pending. Please wait for further updates.',1,'2024-11-01 10:16:14','2024-11-02 08:05:27',13,NULL),(165,13,'Unfortunately, your visa has been rejected.',1,'2024-11-01 10:16:26','2024-11-02 08:05:23',13,NULL),(166,2,'New speaker registration: ┘ä┘ä┘ä┘ä┘ä┘ä┘ä',0,'2024-11-01 12:31:13','2024-11-01 12:31:13',15,3),(167,15,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-11-01 12:31:13','2024-11-01 12:31:13',15,3),(168,2,'New speaker registration: ┘ä┘ä┘ä┘ä┘ä┘ä┘ä',0,'2024-11-01 12:39:09','2024-11-01 12:39:09',16,3),(169,16,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-11-01 12:39:09','2024-11-01 12:39:09',16,3),(170,16,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-11-01 13:03:22','2024-11-01 13:03:22',NULL,3),(171,15,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-11-01 13:04:34','2024-11-01 13:04:34',NULL,3),(172,15,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-11-01 13:08:15','2024-11-01 13:08:15',NULL,3),(173,16,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-01 16:36:12','2024-11-01 16:36:12',16,3),(174,2,'New visa request from user: ┘ä┘ä┘ä┘ä┘ä┘ä┘ä for conference: title22',0,'2024-11-01 16:36:15','2024-11-01 16:36:15',NULL,3),(175,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-11-01 16:41:08','2024-11-02 08:04:51',13,1),(176,2,'New visa request from user: mm for conference: test',0,'2024-11-01 16:41:08','2024-11-01 16:41:08',NULL,1),(177,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-11-01 16:43:16','2024-11-02 08:03:02',13,1),(178,2,'New visa request from user: mm for conference: test',0,'2024-11-01 16:43:16','2024-11-01 16:43:16',NULL,1),(179,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-11-01 16:46:44','2024-11-02 07:57:12',13,1),(180,2,'New visa request from user: mm for conference: test',0,'2024-11-01 16:46:45','2024-11-01 16:46:45',NULL,1),(181,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-11-01 16:52:43','2024-11-02 08:00:45',13,1),(182,2,'New visa request from user: mm for conference: test',0,'2024-11-01 16:52:43','2024-11-01 16:52:43',NULL,1),(183,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-11-01 16:52:44','2024-11-02 07:58:58',13,1),(184,2,'New visa request from user: mm for conference: test',0,'2024-11-01 16:52:44','2024-11-01 16:52:44',NULL,1),(185,13,'Your visa has been approved.',1,'2024-11-01 16:54:43','2024-11-02 07:59:19',13,NULL),(186,13,'Your visa has been approved.',1,'2024-11-01 16:54:48','2024-11-02 07:57:06',13,NULL),(187,13,'Your visa has been approved.',1,'2024-11-01 16:56:06','2024-11-02 07:46:49',13,NULL),(188,13,'Your visa has been approved.',1,'2024-11-01 16:58:38','2024-11-02 07:58:56',13,NULL),(189,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',1,'2024-11-02 06:50:19','2024-11-02 07:58:55',NULL,NULL),(190,2,'New flight registered by mm. Log in to adjust the price.',1,'2024-11-02 06:50:19','2024-11-02 08:07:00',13,NULL),(191,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',1,'2024-11-02 06:50:21','2024-11-02 07:58:53',NULL,NULL),(192,2,'New flight registered by mm. Log in to adjust the price.',1,'2024-11-02 06:50:21','2024-11-02 08:06:57',13,NULL),(193,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',1,'2024-11-02 11:25:05','2024-11-02 11:12:48',13,NULL),(194,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 12:30:51','2024-11-02 12:30:51',13,1),(195,2,'New visa request from user: mm for conference: test',1,'2024-11-02 12:30:54','2024-11-02 12:46:27',NULL,1),(196,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-11-02 12:30:56','2024-11-02 12:45:52',13,1),(197,2,'New visa request from user: mm for conference: test',1,'2024-11-02 12:30:56','2024-11-02 12:46:25',NULL,1),(198,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-11-02 12:45:21','2024-11-02 12:45:51',13,1),(199,2,'New visa request from user: mm for conference: test',1,'2024-11-02 12:45:21','2024-11-02 12:46:24',NULL,1),(200,13,'Your visa has been approved.',0,'2024-11-02 12:51:05','2024-11-02 12:51:05',13,NULL),(201,13,'Your visa has been approved.',0,'2024-11-02 12:51:39','2024-11-02 12:51:39',13,NULL),(202,13,'Your visa is currently pending. Please wait for further updates.',0,'2024-11-02 12:51:47','2024-11-02 12:51:47',13,NULL),(203,13,'Unfortunately, your visa has been rejected.',0,'2024-11-02 12:52:39','2024-11-02 12:52:39',13,NULL),(204,13,'Your visa has been approved.',0,'2024-11-02 12:54:17','2024-11-02 12:54:17',13,NULL),(205,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 13:08:43','2024-11-02 13:08:43',13,1),(206,2,'New visa request from user: mm for conference: test',0,'2024-11-02 13:08:43','2024-11-02 13:08:43',NULL,1),(207,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 13:13:20','2024-11-02 13:13:20',13,1),(208,2,'New visa request from user: mm for conference: test',0,'2024-11-02 13:13:20','2024-11-02 13:13:20',NULL,1),(209,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 13:18:08','2024-11-02 13:18:08',13,1),(210,2,'New visa request from user: mm for conference: test',0,'2024-11-02 13:18:08','2024-11-02 13:18:08',NULL,1),(211,13,'Your visa has been approved.',0,'2024-11-02 13:18:36','2024-11-02 13:18:36',13,NULL),(212,13,'Your visa has been approved.',0,'2024-11-02 13:18:43','2024-11-02 13:18:43',13,NULL),(213,13,'Your visa has been approved.',0,'2024-11-02 13:18:49','2024-11-02 13:18:49',13,NULL),(214,13,'Your visa has been approved.',0,'2024-11-02 13:23:15','2024-11-02 13:23:15',13,NULL),(215,13,'Your visa has been approved.',0,'2024-11-02 13:24:32','2024-11-02 13:24:32',13,NULL),(216,13,'Your visa has been approved.',0,'2024-11-02 13:25:40','2024-11-02 13:25:40',13,NULL),(217,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 13:32:11','2024-11-02 13:32:11',13,1),(218,2,'New visa request from user: ahmad for conference: test',0,'2024-11-02 13:32:11','2024-11-02 13:32:11',NULL,1),(219,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 14:13:13','2024-11-02 14:13:13',13,1),(220,2,'New visa request from user: ahmad for conference: test',0,'2024-11-02 14:13:13','2024-11-02 14:13:13',NULL,1),(221,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 14:15:40','2024-11-02 14:15:40',13,1),(222,2,'New visa request from user: ahmad for conference: test',0,'2024-11-02 14:15:40','2024-11-02 14:15:40',NULL,1),(223,13,'Your visa has been approved.',0,'2024-11-02 14:16:10','2024-11-02 14:16:10',13,NULL),(224,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 14:28:08','2024-11-02 14:28:08',13,1),(225,2,'New visa request from user: ahmad for conference: test',0,'2024-11-02 14:28:08','2024-11-02 14:28:08',NULL,1),(226,13,'Your visa has been approved.',0,'2024-11-02 14:28:40','2024-11-02 14:28:40',13,NULL),(227,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 14:38:10','2024-11-02 14:38:10',13,1),(228,2,'New visa request from user: ahmad for conference: test',0,'2024-11-02 14:38:10','2024-11-02 14:38:10',NULL,1),(229,13,'Your visa has been approved.',0,'2024-11-02 14:38:43','2024-11-02 14:38:43',13,NULL),(230,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 14:44:48','2024-11-02 14:44:48',NULL,NULL),(231,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 14:44:48','2024-11-02 14:44:48',13,NULL),(232,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 14:44:48','2024-11-02 14:44:48',NULL,NULL),(233,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 14:44:48','2024-11-02 14:44:48',13,NULL),(234,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 14:44:49','2024-11-02 14:44:49',NULL,NULL),(235,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 14:44:49','2024-11-02 14:44:49',13,NULL),(236,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 14:44:49','2024-11-02 14:44:49',NULL,NULL),(237,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 14:44:49','2024-11-02 14:44:49',13,NULL),(238,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 14:47:19','2024-11-02 14:47:19',13,1),(239,2,'New visa request from user: ahmad for conference: test',0,'2024-11-02 14:47:19','2024-11-02 14:47:19',NULL,1),(240,13,'Your visa has been approved.',0,'2024-11-02 14:47:48','2024-11-02 14:47:48',13,NULL),(241,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 14:50:02','2024-11-02 14:50:02',NULL,NULL),(242,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 14:50:02','2024-11-02 14:50:02',13,NULL),(243,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 14:50:02','2024-11-02 14:50:02',NULL,NULL),(244,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 14:50:02','2024-11-02 14:50:02',13,NULL),(245,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 14:50:02','2024-11-02 14:50:02',NULL,NULL),(246,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 14:50:02','2024-11-02 14:50:02',13,NULL),(247,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-11-02 17:54:25','2024-11-02 17:54:25',13,NULL),(248,13,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-02 14:57:43','2024-11-02 14:57:43',13,1),(249,2,'New visa request from user: ahmad for conference: test',0,'2024-11-02 14:57:43','2024-11-02 14:57:43',NULL,1),(250,13,'Your visa has been approved.',0,'2024-11-02 14:58:12','2024-11-02 14:58:12',13,NULL),(251,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 15:00:07','2024-11-02 15:00:07',NULL,NULL),(252,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 15:00:07','2024-11-02 15:00:07',13,NULL),(253,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 15:00:07','2024-11-02 15:00:07',NULL,NULL),(254,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 15:00:07','2024-11-02 15:00:07',13,NULL),(255,13,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',0,'2024-11-02 15:00:07','2024-11-02 15:00:07',NULL,NULL),(256,2,'New flight registered by ahmad. Log in to adjust the price.',0,'2024-11-02 15:00:07','2024-11-02 15:00:07',13,NULL),(257,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-11-02 18:02:45','2024-11-02 18:02:45',13,NULL),(258,13,'You can now visit the website to check the available flight options within the requested dates. Please visit the site as soon as possible and select the appropriate flight to proceed with the necessary arrangements.',0,'2024-11-02 20:38:05','2024-11-02 20:38:05',13,NULL),(259,17,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-11-03 02:29:15','2024-11-03 02:29:15',NULL,3),(260,2,'New group registration: alala@gmail.com',0,'2024-11-03 02:29:15','2024-11-03 02:29:15',17,NULL),(261,18,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-11-03 02:31:20','2024-11-03 02:31:20',NULL,3),(262,2,'New group registration: alalaa@gmail.com',0,'2024-11-03 02:31:20','2024-11-03 02:31:20',18,NULL),(263,19,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-11-03 02:47:25','2024-11-03 02:47:25',NULL,3),(264,2,'New group registration: ggg@gmail.com',0,'2024-11-03 02:47:25','2024-11-03 02:47:25',19,NULL),(265,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:15:25','2024-11-03 03:15:25',NULL,NULL),(266,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:15:42','2024-11-03 03:15:42',NULL,NULL),(267,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:16:27','2024-11-03 03:16:27',NULL,NULL),(268,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:16:46','2024-11-03 03:16:46',NULL,NULL),(269,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:17:00','2024-11-03 03:17:00',NULL,NULL),(270,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:19:59','2024-11-03 03:19:59',NULL,NULL),(271,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:20:45','2024-11-03 03:20:45',NULL,NULL),(272,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:22:11','2024-11-03 03:22:11',NULL,NULL),(273,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:23:04','2024-11-03 03:23:04',NULL,NULL),(274,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:24:38','2024-11-03 03:24:38',NULL,NULL),(275,3,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:24:45','2024-11-03 03:24:45',NULL,NULL),(276,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:25:19','2024-11-03 03:25:19',NULL,NULL),(277,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:25:39','2024-11-03 03:25:39',NULL,NULL),(278,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 03:57:13','2024-11-03 03:57:13',NULL,NULL),(279,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 04:01:49','2024-11-03 04:01:49',NULL,NULL),(280,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 04:01:52','2024-11-03 04:01:52',NULL,NULL),(281,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 04:02:01','2024-11-03 04:02:01',NULL,NULL),(282,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 04:08:12','2024-11-03 04:08:12',NULL,NULL),(283,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 04:08:12','2024-11-03 04:08:12',NULL,NULL),(284,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 04:08:17','2024-11-03 04:08:17',NULL,NULL),(285,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 04:08:41','2024-11-03 04:08:41',NULL,NULL),(286,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:05:17','2024-11-03 05:05:17',NULL,NULL),(287,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:07:53','2024-11-03 05:07:53',NULL,NULL),(288,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:08:16','2024-11-03 05:08:16',NULL,NULL),(289,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:08:20','2024-11-03 05:08:20',NULL,NULL),(290,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:08:25','2024-11-03 05:08:25',NULL,NULL),(291,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:08:38','2024-11-03 05:08:38',NULL,NULL),(292,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:08:42','2024-11-03 05:08:42',NULL,NULL),(293,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:08:46','2024-11-03 05:08:46',NULL,NULL),(294,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:22:28','2024-11-03 05:22:28',NULL,NULL),(295,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:22:34','2024-11-03 05:22:34',NULL,NULL),(296,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:25:36','2024-11-03 05:25:36',NULL,NULL),(297,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:25:41','2024-11-03 05:25:41',NULL,NULL),(298,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:33:06','2024-11-03 05:33:06',NULL,NULL),(299,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:36:19','2024-11-03 05:36:19',NULL,NULL),(300,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:36:23','2024-11-03 05:36:23',NULL,NULL),(301,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:48:38','2024-11-03 05:48:38',NULL,NULL),(302,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:49:17','2024-11-03 05:49:17',NULL,NULL),(303,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:49:37','2024-11-03 05:49:37',NULL,NULL),(304,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:54:42','2024-11-03 05:54:42',NULL,NULL),(305,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:56:58','2024-11-03 05:56:58',NULL,NULL),(306,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 05:58:45','2024-11-03 05:58:45',NULL,NULL),(307,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 06:00:37','2024-11-03 06:00:37',NULL,NULL),(308,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 06:03:37','2024-11-03 06:03:37',NULL,NULL),(309,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 06:09:00','2024-11-03 06:09:00',NULL,NULL),(310,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 06:09:07','2024-11-03 06:09:07',NULL,NULL),(311,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 06:10:15','2024-11-03 06:10:15',NULL,NULL),(312,20,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-11-03 08:34:38','2024-11-03 08:34:38',NULL,3),(313,2,'New group registration: toto@gmail.com',0,'2024-11-03 08:34:42','2024-11-03 08:34:42',20,NULL),(314,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:15:27','2024-11-03 10:15:27',NULL,NULL),(315,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:26:25','2024-11-03 10:26:25',NULL,NULL),(316,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:26:31','2024-11-03 10:26:31',NULL,NULL),(317,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:28:40','2024-11-03 10:28:40',NULL,NULL),(318,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:28:43','2024-11-03 10:28:43',NULL,NULL),(319,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:28:51','2024-11-03 10:28:51',NULL,NULL),(320,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:29:39','2024-11-03 10:29:39',NULL,NULL),(321,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:31:11','2024-11-03 10:31:11',NULL,NULL),(322,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:32:21','2024-11-03 10:32:21',NULL,NULL),(323,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:33:15','2024-11-03 10:33:15',NULL,NULL),(324,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:34:47','2024-11-03 10:34:47',NULL,NULL),(325,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:36:21','2024-11-03 10:36:21',NULL,NULL),(326,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:38:57','2024-11-03 10:38:57',NULL,NULL),(327,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:39:32','2024-11-03 10:39:32',NULL,NULL),(328,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:39:59','2024-11-03 10:39:59',NULL,NULL),(329,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:40:15','2024-11-03 10:40:15',NULL,NULL),(330,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:51:22','2024-11-03 10:51:22',NULL,NULL),(331,21,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-11-03 10:52:16','2024-11-03 10:52:16',NULL,4),(332,2,'New group registration: ameer@gmail.com',0,'2024-11-03 10:52:16','2024-11-03 10:52:16',21,NULL),(333,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 10:52:48','2024-11-03 10:52:48',NULL,NULL),(334,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 11:00:39','2024-11-03 11:00:39',NULL,NULL),(335,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 11:01:29','2024-11-03 11:01:29',NULL,NULL),(336,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 11:02:09','2024-11-03 11:02:09',NULL,NULL),(337,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 11:03:14','2024-11-03 11:03:14',NULL,NULL),(338,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 11:11:52','2024-11-03 11:11:52',NULL,NULL),(339,19,'Now you can access the activated file and download the registered names.',0,'2024-11-03 11:12:34','2024-11-03 11:12:34',NULL,NULL),(340,21,'Now you can access the activated file and download the registered names.',0,'2024-11-03 11:13:32','2024-11-03 11:13:32',NULL,NULL),(341,22,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-11-03 11:56:40','2024-11-03 11:56:40',NULL,3),(342,2,'New group registration: yy@gmail.com',0,'2024-11-03 11:56:41','2024-11-03 11:56:41',22,NULL),(343,21,'Now you can access the activated file and download the registered names.',0,'2024-11-03 12:01:08','2024-11-03 12:01:08',NULL,NULL),(344,22,'Now you can access the activated file and download the registered names.',0,'2024-11-03 12:17:04','2024-11-03 12:17:04',NULL,NULL),(345,23,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-11-03 13:23:19','2024-11-03 13:23:19',NULL,3),(346,2,'New group registration: ll@gmail.com',0,'2024-11-03 13:23:20','2024-11-03 13:23:20',23,NULL),(347,23,'Now you can access the activated file and download the registered names.',0,'2024-11-03 13:24:00','2024-11-03 13:24:00',NULL,NULL),(348,24,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-11-03 13:29:00','2024-11-03 13:29:00',NULL,3),(349,2,'New group registration: kk@gmail.com',0,'2024-11-03 13:29:00','2024-11-03 13:29:00',24,NULL),(350,24,'Now you can access the activated file and download the registered names.',0,'2024-11-03 13:29:33','2024-11-03 13:29:33',NULL,NULL),(351,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 11:50:51','2024-11-04 11:50:51',1,NULL),(352,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 11:51:44','2024-11-04 11:51:44',1,NULL),(353,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:00:22','2024-11-04 12:00:22',1,NULL),(354,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:02:28','2024-11-04 12:02:28',1,NULL),(355,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:07:34','2024-11-04 12:07:34',1,NULL),(356,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:07:56','2024-11-04 12:07:56',1,NULL),(357,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:11:27','2024-11-04 12:11:27',1,NULL),(358,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:11:56','2024-11-04 12:11:56',1,NULL),(359,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:23:45','2024-11-04 12:23:45',1,NULL),(360,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:23:53','2024-11-04 12:23:53',1,NULL),(361,1,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-04 12:25:23','2024-11-04 12:25:23',1,NULL),(362,1,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-11-04 12:30:54','2024-11-04 12:30:54',1,NULL),(363,24,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-04 12:47:53','2024-11-04 12:47:53',24,10),(364,2,'New visa request from user: gggg for conference: tttttttt',0,'2024-11-04 12:47:54','2024-11-04 12:47:54',NULL,10),(365,23,'Now you can access the activated file and download the registered names.',0,'2024-11-04 12:49:08','2024-11-04 12:49:08',NULL,NULL),(366,24,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-04 13:26:06','2024-11-04 13:26:06',24,10),(367,2,'New visa request from user: gggg for conference: tttttttt',0,'2024-11-04 13:26:06','2024-11-04 13:26:06',24,10),(368,24,'Your visa has been approved.',0,'2024-11-04 13:29:52','2024-11-04 13:29:52',24,NULL),(369,24,'Your visa has been approved.',0,'2024-11-04 13:31:20','2024-11-04 13:31:20',24,NULL),(370,24,'Unfortunately, your visa has been rejected.',0,'2024-11-04 13:32:28','2024-11-04 13:32:28',24,NULL),(371,24,'Your visa has been approved.',0,'2024-11-04 14:29:10','2024-11-04 14:29:10',24,NULL),(372,19,'Now you can access the activated file and download the registered names.',0,'2024-11-04 14:51:14','2024-11-04 14:51:14',NULL,NULL),(373,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:20:02','2024-11-05 02:20:02',21,NULL),(374,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:25:52','2024-11-05 02:25:52',21,NULL),(375,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:27:03','2024-11-05 02:27:03',21,NULL),(376,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:27:56','2024-11-05 02:27:56',21,NULL),(377,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:29:38','2024-11-05 02:29:38',21,NULL),(378,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:30:56','2024-11-05 02:30:56',21,NULL),(379,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:32:24','2024-11-05 02:32:24',21,NULL),(380,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:33:47','2024-11-05 02:33:47',21,NULL),(381,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:33:52','2024-11-05 02:33:52',21,NULL),(382,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:35:59','2024-11-05 02:35:59',21,NULL),(383,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:38:11','2024-11-05 02:38:11',21,NULL),(384,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:40:03','2024-11-05 02:40:03',21,NULL),(385,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:41:43','2024-11-05 02:41:43',21,NULL),(386,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:43:02','2024-11-05 02:43:02',21,NULL),(387,21,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 02:43:47','2024-11-05 02:43:47',21,NULL),(388,24,'Unfortunately, your visa has been rejected.',0,'2024-11-05 03:01:47','2024-11-05 03:01:47',24,NULL),(389,2,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 05:06:49','2024-11-05 05:06:49',2,NULL),(390,24,'Your visa has been approved.',0,'2024-11-05 05:11:22','2024-11-05 05:11:22',24,NULL),(391,2,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-05 05:24:07','2024-11-05 05:24:07',2,NULL),(392,21,'Now you can access the activated file and download the registered names.',0,'2024-11-06 10:23:07','2024-11-06 10:23:07',NULL,NULL),(393,24,'Your visa has been approved.',0,'2024-11-07 03:24:20','2024-11-07 03:24:20',24,NULL),(394,1,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-07 03:48:05','2024-11-07 03:48:05',1,2),(395,2,'New speaker registration: aa',0,'2024-11-07 03:54:29','2024-11-07 03:54:29',25,3),(396,2,'New speaker registration: aa',0,'2024-11-07 03:55:28','2024-11-07 03:55:28',26,3),(397,2,'New speaker registration: aa',0,'2024-11-07 03:56:00','2024-11-07 03:56:00',27,3),(398,2,'New speaker registration: ayat',0,'2024-11-07 03:59:22','2024-11-07 03:59:22',28,3),(399,2,'New speaker registration: ayat',0,'2024-11-07 04:17:35','2024-11-07 04:17:35',29,3),(400,29,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-11-07 04:17:35','2024-11-07 04:17:35',29,3),(401,29,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-11-07 04:18:23','2024-11-07 04:18:23',NULL,3),(402,29,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-11-07 04:40:23','2024-11-07 04:40:23',29,3),(403,2,'New visa request from user: ayat for conference: title22',0,'2024-11-07 04:40:25','2024-11-07 04:40:25',29,3),(404,29,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-11-07 04:41:03','2024-11-07 04:41:03',29,NULL),(405,29,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-11-07 04:41:35','2024-11-07 04:41:35',29,NULL),(406,26,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-11-07 05:27:53','2024-11-07 05:27:53',NULL,3),(407,29,'Your visa has been approved.',0,'2024-11-07 05:29:12','2024-11-07 05:29:12',29,NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ourclients`
--

DROP TABLE IF EXISTS `ourclients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ourclients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ourclients`
--

LOCK TABLES `ourclients` WRITE;
/*!40000 ALTER TABLE `ourclients` DISABLE KEYS */;
INSERT INTO `ourclients` VALUES (17,'images/JdZlGvlfPOGbyWaCBj8cIqTGv0HAh3qsjwizq2mU.png','This is a sample client description','2024-10-29 06:59:37','2024-10-29 06:59:37'),(18,'images/fsNVUCRowPxjScTDr5IdlBvURVsnCq3E2TxDWuZg.jpg','This is a sample client description','2024-10-29 06:59:47','2024-10-29 06:59:47'),(19,'images/mB4GGLSjQ609SGojVH90VU5dC88WetXOvq52N40i.jpg','This is a sample client description','2024-10-29 06:59:58','2024-10-29 06:59:58'),(20,'images/t2fkU3rqlyD24Qo7TaYcbJZ0naPJ4lOpNMS2ceaU.jpg','This is a sample client description','2024-10-29 07:00:09','2024-10-29 07:00:09'),(22,'images/TNwJfCQ0vy3vdO2IaxmDOVHp3kfL3Dt3tVYoDssA.jpg','This is a sample client description','2024-10-29 07:00:41','2024-10-29 07:00:41'),(25,'images/DRgQ2iSyfES7pKwu7IOO0PeuSf2I7uwCOR6gTJZA.jpg','This is a sample client description','2024-10-29 07:01:26','2024-10-29 07:01:26'),(26,'images/8kTK6iJMTaQ9CXt8Mv4vFP9jTtMeHZaPjF0dVELS.jpg','This is a sample client description','2024-10-29 07:01:37','2024-10-29 07:01:37'),(28,'images/QKjnAhwQj7SYoj7ZN1KCNgOVbdO2GltQcVDG9Nbt.png','This is a sample client description','2024-10-29 07:05:53','2024-10-29 07:05:53'),(29,'images/6e285A1nJAjhxLGmcftMTGRhWWjqSQNCdwFB7usR.jpg','This is a sample client description','2024-10-29 07:10:57','2024-10-29 07:10:57');
/*!40000 ALTER TABLE `ourclients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=421 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',1,'laravel','ef7efdc44c61eff3aa634ac32fd1409856e1666f49b0732f198af6d533964ce6','[\"*\"]','2024-10-21 09:25:57',NULL,'2024-10-21 09:25:56','2024-10-21 09:25:57'),(2,'App\\Models\\User',2,'laravel','bb2609ccc965d382f502c5ee1b01f3a6b1b99141da24c8b20b51fc74e2ebe0d7','[\"*\"]','2024-10-21 09:30:25',NULL,'2024-10-21 09:30:24','2024-10-21 09:30:25'),(3,'App\\Models\\User',1,'laravel','276e6cf4d4ed062cffa737f2e78ff44fb3c30264c900d9d98afb87ed83ece832','[\"*\"]','2024-10-21 10:46:59',NULL,'2024-10-21 09:30:58','2024-10-21 10:46:59'),(4,'App\\Models\\User',2,'laravel','06a920f6ed76690a88272c2d6af03337046735d1d6034b27cf59e4bbd481a31a','[\"*\"]','2024-10-22 12:42:36',NULL,'2024-10-21 10:47:23','2024-10-22 12:42:36'),(5,'App\\Models\\User',2,'laravel','5eaffabcba9f5a5a12e330be0744227b589c8afc21f0a80bc7cb430df3cfe2ee','[\"*\"]','2024-10-22 11:23:43',NULL,'2024-10-22 08:14:17','2024-10-22 11:23:43'),(6,'App\\Models\\User',1,'laravel','e2afa58fea4953c8658182abcde7d030adb57b26ae80cfeb466cc63b9729d917','[\"*\"]','2024-10-22 11:25:30',NULL,'2024-10-22 11:25:27','2024-10-22 11:25:30'),(7,'App\\Models\\User',1,'laravel','12c43a0c919e4b307be3bcff8c33cb87ae093c4011a5b64add3efbc2c00cf79c','[\"*\"]','2024-10-22 12:19:55',NULL,'2024-10-22 11:25:29','2024-10-22 12:19:55'),(8,'App\\Models\\User',1,'laravel','241ab3fe90649ca1300a3f25f526d30f7e0a5a5805736236bc5bdd41220c9497','[\"*\"]','2024-10-22 12:21:19',NULL,'2024-10-22 12:20:25','2024-10-22 12:21:19'),(9,'App\\Models\\User',2,'laravel','e8bfca6496246a32c70bc2580dae379783904c5d4885185dff0783d00d93e584','[\"*\"]','2024-10-22 12:24:18',NULL,'2024-10-22 12:21:41','2024-10-22 12:24:18'),(10,'App\\Models\\User',1,'laravel','bf45f7aab38dc8c719b5d25777219d282e33a9e87cffc244942d97dba47b3b70','[\"*\"]','2024-10-22 12:35:48',NULL,'2024-10-22 12:34:49','2024-10-22 12:35:48'),(11,'App\\Models\\User',2,'laravel','4b581091717c15a72785695f449b48226ac1909eaf46fe39c4f46b6a8776b8d0','[\"*\"]','2024-10-22 13:06:11',NULL,'2024-10-22 12:39:15','2024-10-22 13:06:11'),(12,'App\\Models\\User',7,'laravel','8c939239909378268ec8019c51c650f5f378e66df483b8c83e10a061be86623a','[\"*\"]','2024-10-30 08:32:01',NULL,'2024-10-22 12:48:50','2024-10-30 08:32:01'),(13,'App\\Models\\User',7,'laravel','246eb32d0bd535443798b654086fb308ad513e3eaf1675a849e65b25bdb01f33','[\"*\"]','2024-10-22 12:50:44',NULL,'2024-10-22 12:49:12','2024-10-22 12:50:44'),(14,'App\\Models\\User',7,'laravel','e8b5ece62500f6067c017c10f8f7ceb90cf601fbb32e2a85963a39f9294e62a4','[\"*\"]','2024-10-22 14:06:52',NULL,'2024-10-22 13:01:15','2024-10-22 14:06:52'),(15,'App\\Models\\User',7,'laravel','c47533d3397b4e85b7aec07ce7b486b3295b10579ac2ec2316e0e886cdade82b','[\"*\"]','2024-10-22 14:18:42',NULL,'2024-10-22 14:15:22','2024-10-22 14:18:42'),(16,'App\\Models\\User',7,'laravel','735f3a9c3c1169e8ffe26fea4a9f8287127d8781369a86d53767f83081b83b0a','[\"*\"]','2024-10-22 15:04:53',NULL,'2024-10-22 14:31:11','2024-10-22 15:04:53'),(17,'App\\Models\\User',8,'laravel','ad2134c307776e0713b9c4e8777ab666c719600e12df8722c8a1066e1c48b91f','[\"*\"]',NULL,NULL,'2024-10-22 14:40:33','2024-10-22 14:40:33'),(18,'App\\Models\\User',2,'laravel','0950d556e7d6141afb200c3ae13b0567704e9ab14ef891f852e50ccf0503b4c4','[\"*\"]','2024-10-22 18:49:11',NULL,'2024-10-22 15:05:05','2024-10-22 18:49:11'),(19,'App\\Models\\User',1,'laravel','b0471414807edfad1c6c07e2bd59a980c2be1c60bc5ac28487e3a0ff58701c41','[\"*\"]','2024-10-22 18:58:15',NULL,'2024-10-22 18:49:38','2024-10-22 18:58:15'),(20,'App\\Models\\User',2,'laravel','c89a8861755f99bea362c4d6ba050ed6182d3fbbbab4cc55d330828acdbd38a7','[\"*\"]','2024-10-22 19:16:09',NULL,'2024-10-22 18:58:37','2024-10-22 19:16:09'),(21,'App\\Models\\User',1,'laravel','27e7cdb9c4ccda31fd32f010db6c383d7f0512c4b3508cda2994b6b41e6f928e','[\"*\"]','2024-10-22 19:26:38',NULL,'2024-10-22 19:16:39','2024-10-22 19:26:38'),(22,'App\\Models\\User',2,'laravel','f33a53b8be2c8a9069f722d9f17e05a1e2b7d16e8922122426f710045e412359','[\"*\"]','2024-10-22 19:27:49',NULL,'2024-10-22 19:26:56','2024-10-22 19:27:49'),(23,'App\\Models\\User',2,'laravel','e40ebd930f566df8d1a13c90eaeedb402441df42cc2680a38a26a8c99aa6cf8e','[\"*\"]','2024-10-22 20:26:45',NULL,'2024-10-22 20:26:40','2024-10-22 20:26:45'),(24,'App\\Models\\User',2,'laravel','662e424e07613c942fc0c3b1abb78554a9ce95d17332073139092c4065d0a666','[\"*\"]','2024-10-22 20:27:35',NULL,'2024-10-22 20:26:43','2024-10-22 20:27:35'),(25,'App\\Models\\User',2,'laravel','dd98291915e602da7b03ee514f50e5c16cc5369a94005e476901dca311ca30ee','[\"*\"]','2024-10-24 09:49:41',NULL,'2024-10-22 20:28:00','2024-10-24 09:49:41'),(26,'App\\Models\\User',2,'laravel','f387e2f5c5abcf1af9e99f7240cc8fec2ccab374a681e0a4253341114b76d6d0','[\"*\"]','2024-10-22 21:05:38',NULL,'2024-10-22 20:49:36','2024-10-22 21:05:38'),(27,'App\\Models\\User',1,'laravel','bec4c29eb69c3f7969a54fa3ffd1a16de832fd7ec46fe81b34d2f4376e3aa01f','[\"*\"]','2024-10-23 03:24:04',NULL,'2024-10-23 03:15:48','2024-10-23 03:24:04'),(28,'App\\Models\\User',2,'laravel','5bb0f6bd0fd1399dd5b277e0e9ab84d61e8f47762aa61872efa35f458c69f5e2','[\"*\"]','2024-10-23 05:28:00',NULL,'2024-10-23 03:24:24','2024-10-23 05:28:00'),(29,'App\\Models\\User',1,'laravel','86b9cce4f8dbfdf251c3c1266fb17af469f39a99db1b919ace5b35fdba547462','[\"*\"]','2024-10-23 07:18:59',NULL,'2024-10-23 05:28:53','2024-10-23 07:18:59'),(30,'App\\Models\\User',2,'laravel','976b6de3c44fa661fecdddaceb0d767716e69bf6d778bb234de9cc9dd8a5138b','[\"*\"]','2024-10-23 07:19:52',NULL,'2024-10-23 07:19:20','2024-10-23 07:19:52'),(31,'App\\Models\\User',1,'laravel','c1976bbcf18bfc5fd6a0580c796ae37e74e92ab3ce140777966b8ac3543a36a5','[\"*\"]','2024-10-23 07:20:39',NULL,'2024-10-23 07:20:18','2024-10-23 07:20:39'),(32,'App\\Models\\User',2,'laravel','5f5f1e99e3ceb0dedc763baf4c04a3a559c5ebce5dcea67d16f58089f5b3e1a7','[\"*\"]','2024-10-23 07:43:57',NULL,'2024-10-23 07:21:45','2024-10-23 07:43:57'),(33,'App\\Models\\User',1,'laravel','672b57ce18dce022200115ed21322511d8dd2985f6688a65dc39bf03526b04b3','[\"*\"]','2024-10-23 08:16:10',NULL,'2024-10-23 07:44:15','2024-10-23 08:16:10'),(34,'App\\Models\\User',2,'laravel','adb8c85aafa6a2ba2b63bcb6e0c145d800b061464e60b18d281e69fd24aa0a2d','[\"*\"]','2024-10-23 08:47:12',NULL,'2024-10-23 08:16:25','2024-10-23 08:47:12'),(35,'App\\Models\\User',2,'laravel','0eaf0717b767e5f355a3a341f5d9b1823cdf04e0993e0376d844c3294a672ad4','[\"*\"]','2024-10-24 07:01:03',NULL,'2024-10-23 08:50:53','2024-10-24 07:01:03'),(36,'App\\Models\\User',2,'laravel','37333a56ae4a6d91ac1836574dc1f888b00c0b6a0fccade9ed04976d5e14168b','[\"*\"]','2024-10-24 02:20:07',NULL,'2024-10-24 02:15:33','2024-10-24 02:20:07'),(37,'App\\Models\\User',2,'laravel','6ed4015014ca6ed5bb7ec292c9a854dc1ddf4067408ddd36917520be5683de29','[\"*\"]','2024-10-24 09:47:18',NULL,'2024-10-24 02:24:28','2024-10-24 09:47:18'),(38,'App\\Models\\User',2,'laravel','c5b8ada921e910f2ec5d7bf2923091ecca037483169634112a04625aeb5b3151','[\"*\"]','2024-10-24 05:21:57',NULL,'2024-10-24 02:44:52','2024-10-24 05:21:57'),(39,'App\\Models\\User',2,'laravel','3ef4c37c16394a1d3f39b591a3bf6aa077be66a0d877ed9329dd63065c14ad7c','[\"*\"]','2024-10-24 06:01:45',NULL,'2024-10-24 05:22:44','2024-10-24 06:01:45'),(40,'App\\Models\\User',1,'laravel','2a3cd63bb8e61f8cd7d66f306f06fa6ec1d383f5512871807a5bb14e5617eab2','[\"*\"]','2024-10-24 06:58:18',NULL,'2024-10-24 06:03:21','2024-10-24 06:58:18'),(41,'App\\Models\\User',2,'laravel','93a8ed99b8feb7de0ce0e9908c5a7b24db60478a1a6d0cb87d59f5cb16645bb8','[\"*\"]','2024-10-24 06:58:49',NULL,'2024-10-24 06:58:38','2024-10-24 06:58:49'),(42,'App\\Models\\User',1,'laravel','9acf84adeb5618f20085312ad29f1c6fb5ee6c69aa7ef4bc301636151c6b89a3','[\"*\"]','2024-10-24 09:07:57',NULL,'2024-10-24 07:01:24','2024-10-24 09:07:57'),(43,'App\\Models\\User',1,'laravel','d7ab4a305e6ea65a099b2a9955ff6bc8066c9c1f77e8a664b8c974496f2947a9','[\"*\"]','2024-10-24 09:54:07',NULL,'2024-10-24 09:50:04','2024-10-24 09:54:07'),(44,'App\\Models\\User',2,'laravel','cf3d0cf54127661e6b0b344945fde1fd6ce430c59e32b3ebce439e55a93ec298','[\"*\"]','2024-10-24 10:27:03',NULL,'2024-10-24 09:54:58','2024-10-24 10:27:03'),(45,'App\\Models\\User',1,'laravel','83e6f1b3c16cd2d884c0d0d5f30e47b0dfe5cf170782fc12fe07c958966acc14','[\"*\"]','2024-10-24 10:27:40',NULL,'2024-10-24 10:27:25','2024-10-24 10:27:40'),(46,'App\\Models\\User',1,'laravel','6855aeba7e8de8b92e78c969df4e162d43a8fbae5d0417cb07e0bf1d2cc8f6b8','[\"*\"]','2024-10-24 12:34:02',NULL,'2024-10-24 12:30:11','2024-10-24 12:34:02'),(47,'App\\Models\\User',2,'laravel','0d979fe07c872dd993ef7b061c3b611e7775054dc0f660b1627ce3436f7a0e5f','[\"*\"]','2024-10-24 12:40:27',NULL,'2024-10-24 12:34:19','2024-10-24 12:40:27'),(48,'App\\Models\\User',2,'laravel','13283416699f063becef305e10d8198517ad565a1ae9028b028b2a58f7bc8676','[\"*\"]','2024-10-24 18:09:07',NULL,'2024-10-24 12:40:51','2024-10-24 18:09:07'),(49,'App\\Models\\User',1,'laravel','7731928c7c63461a1409b0730718658cd156d48dd751625c43279d042d897615','[\"*\"]','2024-10-24 18:19:19',NULL,'2024-10-24 18:09:25','2024-10-24 18:19:19'),(50,'App\\Models\\User',1,'laravel','4537aee9e4c88c39600b75e85d8ec886a93579bfe841ed9dba627ba1870d0775','[\"*\"]','2024-10-25 10:18:24',NULL,'2024-10-24 18:19:56','2024-10-25 10:18:24'),(51,'App\\Models\\User',2,'laravel','b896ef4e4c4f572b60e4a1dbe72b5669bdcd7ee00ac8a151d01d84151a4199a9','[\"*\"]','2024-10-26 08:41:37',NULL,'2024-10-25 10:18:43','2024-10-26 08:41:37'),(52,'App\\Models\\User',1,'laravel','d24dc6254d068673323e584c3f600ce73154154f53b91eac4c49ffb5e709189d','[\"*\"]','2024-10-26 10:17:44',NULL,'2024-10-26 10:17:41','2024-10-26 10:17:44'),(53,'App\\Models\\User',1,'laravel','4039f84b69b61942f63bca38d80a84471f1ad3de41854e785531fac5ea665399','[\"*\"]','2024-10-26 11:01:40',NULL,'2024-10-26 10:17:43','2024-10-26 11:01:40'),(54,'App\\Models\\User',2,'laravel','8835840b2d820da329bd980f0f14108b7e382f4dcdfd4ea4be050b98de50aa21','[\"*\"]','2024-10-26 10:20:00',NULL,'2024-10-26 10:19:38','2024-10-26 10:20:00'),(55,'App\\Models\\User',2,'laravel','0a0a3d1eb565830db508169f31686322d6075c6bb02123a07158960a38b10922','[\"*\"]','2024-10-27 08:12:38',NULL,'2024-10-26 10:20:16','2024-10-27 08:12:38'),(56,'App\\Models\\User',1,'laravel','aaee6d8c2b2cc0b8844fde8642cc14bcbe4e24f5092f1f83e5e17fd0585165f9','[\"*\"]','2024-10-27 12:43:35',NULL,'2024-10-27 08:13:42','2024-10-27 12:43:35'),(57,'App\\Models\\User',2,'laravel','db6006adcff8f9e429001b0c798d811441bfa701720c7350b47baf11156e10d5','[\"*\"]','2024-10-28 04:50:21',NULL,'2024-10-27 12:44:00','2024-10-28 04:50:21'),(58,'App\\Models\\User',1,'laravel','d7b08a2a77ac7691848b6dbe75b24367bad471a3de41790a9cf65cbd6e20a281','[\"*\"]','2024-10-28 04:50:39',NULL,'2024-10-28 04:50:35','2024-10-28 04:50:39'),(59,'App\\Models\\User',1,'laravel','2261100a6fe676e70da49d77d07930388f4462c8eb557c30363e45a8cb5a66bf','[\"*\"]','2024-10-28 06:16:36',NULL,'2024-10-28 04:50:38','2024-10-28 06:16:36'),(60,'App\\Models\\User',9,'laravel','a95e4246d1aa55062e83e2ec3a0bb7ab1bea028ae01a7687e82cbc11bb65bc0d','[\"*\"]','2024-10-28 07:25:05',NULL,'2024-10-28 07:25:04','2024-10-28 07:25:05'),(61,'App\\Models\\User',2,'laravel','629c60ac746591c7d48126fc6a294ebdf79c122fd8e85f8d7beb072d2134c877','[\"*\"]','2024-10-28 07:26:59',NULL,'2024-10-28 07:26:02','2024-10-28 07:26:59'),(62,'App\\Models\\User',9,'laravel','1a5ceb506126db68cfb99b685f0d94bfb73a9aed6297f5777f62ee6f93b80f2e','[\"*\"]','2024-10-28 07:29:21',NULL,'2024-10-28 07:28:24','2024-10-28 07:29:21'),(63,'App\\Models\\User',9,'laravel','00d7c298b0ca64cdab962ae6952afe192dd3ad2b941444044c524ff176fe13a5','[\"*\"]','2024-10-28 07:30:39',NULL,'2024-10-28 07:29:43','2024-10-28 07:30:39'),(64,'App\\Models\\User',9,'laravel','85ccd0e316efec1cf50158bbde2cbb2dd21e15250f302aa982abcc5740362f69','[\"*\"]','2024-10-28 07:30:58',NULL,'2024-10-28 07:30:57','2024-10-28 07:30:58'),(65,'App\\Models\\User',2,'laravel','0ffa78d4b35b3d02b1b1daaf5efee18ae9ccee2b6d5a6fb11b2605ae9bceff94','[\"*\"]','2024-10-28 07:31:56',NULL,'2024-10-28 07:31:20','2024-10-28 07:31:56'),(66,'App\\Models\\User',9,'laravel','346ed4b9f318d6ae87f8b1d7deb994b21c88c6739444f1b358e444f0f5124c1b','[\"*\"]','2024-10-28 07:32:30',NULL,'2024-10-28 07:32:13','2024-10-28 07:32:30'),(67,'App\\Models\\User',9,'laravel','df2635834c0c7ded0b205d24cbca1ddee9e7f3e3a689ff1895ec61a2f12cb946','[\"*\"]','2024-10-28 07:33:16',NULL,'2024-10-28 07:33:03','2024-10-28 07:33:16'),(68,'App\\Models\\User',9,'laravel','11264f2b4145f27291e8e875703a00ee2abe7781e999834218f7a4e962f494c1','[\"*\"]','2024-10-28 07:33:42',NULL,'2024-10-28 07:33:41','2024-10-28 07:33:42'),(69,'App\\Models\\User',1,'laravel','7812939d9d56a927499202030f708f64f3d7024038bcbe65af06e33402ff2a30','[\"*\"]','2024-10-28 07:35:13',NULL,'2024-10-28 07:34:07','2024-10-28 07:35:13'),(70,'App\\Models\\User',2,'laravel','ddc9e8620512ee0c981bef0ff3dbd3f82ec7271987efc9b589a69b203409f2ac','[\"*\"]','2024-10-28 07:38:16',NULL,'2024-10-28 07:38:13','2024-10-28 07:38:16'),(71,'App\\Models\\User',9,'laravel','9926dcd2938b1647f9693819c65e72c1e7d4dbdd006aa6b350a5a08c4089d614','[\"*\"]',NULL,NULL,'2024-10-28 07:41:02','2024-10-28 07:41:02'),(72,'App\\Models\\User',11,'laravel','5c35b42979229c94c06f9ce6af10d3efc069acc81cdcf7b40db9207322de29b9','[\"*\"]','2024-10-28 07:43:57',NULL,'2024-10-28 07:43:54','2024-10-28 07:43:57'),(73,'App\\Models\\User',2,'laravel','287f7a0918a68161a7d4279971bb5a99e39d023ac10488420729b9e97d32c804','[\"*\"]','2024-10-28 07:45:56',NULL,'2024-10-28 07:44:40','2024-10-28 07:45:56'),(74,'App\\Models\\User',11,'laravel','03e9839f0fc605f91b81e5a65098a387b1a28e1301f795143d8c4a47a4066a6a','[\"*\"]','2024-10-28 08:26:44',NULL,'2024-10-28 07:46:13','2024-10-28 08:26:44'),(75,'App\\Models\\User',12,'laravel','b0961b35339d0cc30399a4135001cf9c832d2b794fdb56dd3f07421583579353','[\"*\"]','2024-10-28 08:28:31',NULL,'2024-10-28 08:28:30','2024-10-28 08:28:31'),(76,'App\\Models\\User',2,'laravel','509a50578b2424acee25ebcbf3b1a97f5cb3791b4079a5bcf44a5a657b95f7c9','[\"*\"]','2024-10-28 08:30:57',NULL,'2024-10-28 08:29:00','2024-10-28 08:30:57'),(77,'App\\Models\\User',12,'laravel','e1f535146ed275274718980a218d7da49356cd2f5d14483abbc0d7a01932c279','[\"*\"]','2024-10-28 08:33:22',NULL,'2024-10-28 08:33:21','2024-10-28 08:33:22'),(78,'App\\Models\\User',13,'laravel','43afa3cf0f70e5b4abf760a37370a62a3297b28ec25c1ca105263a2948610df7','[\"*\"]','2024-10-28 08:47:25',NULL,'2024-10-28 08:35:03','2024-10-28 08:47:25'),(79,'App\\Models\\User',13,'laravel','d6aa2d27b64392fab48e9dac9b4ecfe89846e177a3cbfa03db2e857b26b42d23','[\"*\"]',NULL,NULL,'2024-10-28 08:52:54','2024-10-28 08:52:54'),(80,'App\\Models\\User',13,'laravel','47fb48ac57ad661e979dd2944c0b8139430ae26c503ffba9a4872a120041efeb','[\"*\"]','2024-10-28 09:15:30',NULL,'2024-10-28 08:56:25','2024-10-28 09:15:30'),(81,'App\\Models\\User',13,'laravel','6fe3f609c712d3bb3ee3be75e10e2fb4a2fd63fcaeb4e104b107987bc101575c','[\"*\"]','2024-10-29 05:08:45',NULL,'2024-10-29 05:08:44','2024-10-29 05:08:45'),(82,'App\\Models\\User',13,'laravel','b42334ba2fbc70e9ba6636d4ca047721f53d339672a6e2369a3cbf62e9d60707','[\"*\"]','2024-10-29 05:39:50',NULL,'2024-10-29 05:22:19','2024-10-29 05:39:50'),(83,'App\\Models\\User',13,'laravel','83560f7b487d2ca0c8beaccb973c389f3a67620e57ea1e39457df85a944a2b07','[\"*\"]','2024-10-29 05:41:47',NULL,'2024-10-29 05:40:21','2024-10-29 05:41:47'),(84,'App\\Models\\User',2,'laravel','86863ce2efc25f557e1b9bf1ae3d77c1c94cf102b2ad22f0125b111bebf7004b','[\"*\"]','2024-10-29 07:18:01',NULL,'2024-10-29 05:42:06','2024-10-29 07:18:01'),(85,'App\\Models\\User',13,'laravel','829d06ef8f2cc52b34277ebbe6d7d8fd433b1458905f70563db7bcd415242c12','[\"*\"]','2024-10-30 07:02:05',NULL,'2024-10-29 07:33:18','2024-10-30 07:02:05'),(86,'App\\Models\\User',13,'laravel','c7424ec28a861b24fe2e8b5317e6dd9407023c21c4b2f3d50dd87ea6d493d452','[\"*\"]','2024-10-29 08:35:38',NULL,'2024-10-29 08:35:14','2024-10-29 08:35:38'),(87,'App\\Models\\User',2,'laravel','c217cdbffa37c4d1f3015d5a489084f13976b9a25d142970451e7b0d8c32d833','[\"*\"]','2024-10-29 08:36:29',NULL,'2024-10-29 08:35:54','2024-10-29 08:36:29'),(88,'App\\Models\\User',13,'laravel','64a451371d8fe98018fbeab9c4fbd3daf2851a0fd429e6b06cf732f46b926793','[\"*\"]','2024-10-29 09:02:35',NULL,'2024-10-29 08:36:39','2024-10-29 09:02:35'),(89,'App\\Models\\User',2,'laravel','da6c503d42eef7b977b576abb6060ba34eab309102dd36c87b7f938b4965a415','[\"*\"]','2024-10-29 09:41:17',NULL,'2024-10-29 09:02:46','2024-10-29 09:41:17'),(90,'App\\Models\\User',13,'laravel','8f4a1dfe73eaf61da47bbf5af90f129fac8e909bc2fba13eac59dc0a832e2f6b','[\"*\"]','2024-10-29 09:48:04',NULL,'2024-10-29 09:41:27','2024-10-29 09:48:04'),(91,'App\\Models\\User',2,'laravel','b6ac2ece7e8171011f47108ff5b05f51ff33ea191c9b570fc0c88c522898c9f3','[\"*\"]','2024-10-29 10:08:02',NULL,'2024-10-29 09:48:21','2024-10-29 10:08:02'),(92,'App\\Models\\User',13,'laravel','1513d0ac2e0d224f766209147959b3bbbc8639583a0c824a3577bfddf4f0727d','[\"*\"]','2024-10-29 10:08:11',NULL,'2024-10-29 10:08:09','2024-10-29 10:08:11'),(93,'App\\Models\\User',13,'laravel','1b4e76b30ee9a0792e596e59a56521031c65ac10d65d4b42d00738edebd55a13','[\"*\"]','2024-10-29 10:10:33',NULL,'2024-10-29 10:08:10','2024-10-29 10:10:33'),(94,'App\\Models\\User',2,'laravel','06a9eb144fb1687d84f50d3df5e32f09dcd25f45304bd5941a41f03ea6950e74','[\"*\"]','2024-10-29 10:12:07',NULL,'2024-10-29 10:11:04','2024-10-29 10:12:07'),(95,'App\\Models\\User',2,'laravel','bb72b1267fc798d1678b24570e653a9ab0f997dc9cf50bbdb9b0f4f7f504d8cf','[\"*\"]','2024-10-29 10:13:03',NULL,'2024-10-29 10:12:18','2024-10-29 10:13:03'),(96,'App\\Models\\User',13,'laravel','59580cd2e1c78d93fffdd917a8a6453b8ca8b01edf6b7ad25d69e1e0e54b3152','[\"*\"]','2024-10-29 10:20:47',NULL,'2024-10-29 10:13:08','2024-10-29 10:20:47'),(97,'App\\Models\\User',2,'laravel','e31cf95a34b538fa6825379a0aa657ac51ff1f063dab1f803aa2c9ac0940c29b','[\"*\"]','2024-10-29 10:24:11',NULL,'2024-10-29 10:20:54','2024-10-29 10:24:11'),(98,'App\\Models\\User',13,'laravel','7c05c0d3397a9ce0f10ec21228ff07bdfbb0c711d5df6db1dc7769a9057c710f','[\"*\"]','2024-10-29 10:25:32',NULL,'2024-10-29 10:24:15','2024-10-29 10:25:32'),(99,'App\\Models\\User',13,'laravel','6f144348a93cd2ff4f2d4162e9c2890bed750803ffdebdcb88c8104102c7ecaf','[\"*\"]','2024-10-29 10:29:57',NULL,'2024-10-29 10:25:46','2024-10-29 10:29:57'),(100,'App\\Models\\User',2,'laravel','2afb4cedd75dbdfde1121d1f285dbac84a5262ed9fe1a1f47b52bdaa85d081db','[\"*\"]','2024-10-29 10:31:51',NULL,'2024-10-29 10:30:05','2024-10-29 10:31:51'),(101,'App\\Models\\User',13,'laravel','7bc4e1e7945ebe26dc027fe58faaec272fbfdd01b44765dae678651dec70c8ee','[\"*\"]','2024-10-29 10:42:00',NULL,'2024-10-29 10:32:00','2024-10-29 10:42:00'),(102,'App\\Models\\User',2,'laravel','25cb11df4bbe6a550c05d1b318400870a9d10ce591c70a7ac319e3cadc90c940','[\"*\"]','2024-10-29 12:11:44',NULL,'2024-10-29 10:43:29','2024-10-29 12:11:44'),(103,'App\\Models\\User',2,'laravel','4a90c79d3eb1197cac0195f8675dd02c9a201e983f0285741ce9fb5188304223','[\"*\"]','2024-10-29 12:15:29',NULL,'2024-10-29 12:13:50','2024-10-29 12:15:29'),(104,'App\\Models\\User',13,'laravel','f0edd2a67f01cc60e1d8f6a0b3850d74a3bc6acdd7e6bbe6a65b5cdc5a1409d1','[\"*\"]','2024-10-29 12:15:47',NULL,'2024-10-29 12:15:44','2024-10-29 12:15:47'),(105,'App\\Models\\User',13,'laravel','08a583cfe8d8a82ddbfd3a59a039a13665b7da740eb5566c5dc6475ff8467132','[\"*\"]','2024-10-29 16:12:14',NULL,'2024-10-29 12:15:46','2024-10-29 16:12:14'),(106,'App\\Models\\User',13,'laravel','195f0965c43546741626f5e6931d51eb3b990945fcbbbe406d4c6970b6231251','[\"*\"]','2024-10-30 02:13:17',NULL,'2024-10-29 16:12:32','2024-10-30 02:13:17'),(107,'App\\Models\\User',2,'laravel','31586365d2ed58c4c1066d682c2a64bbc4862c5e3cad5147714b3546427293cc','[\"*\"]','2024-10-30 03:47:23',NULL,'2024-10-30 02:13:33','2024-10-30 03:47:23'),(108,'App\\Models\\User',2,'laravel','7afcc6649ff0a75acf1e3c67f730ff40081522a4af45a24b307c88514b84a0fc','[\"*\"]','2024-11-04 10:11:32',NULL,'2024-10-30 07:18:28','2024-11-04 10:11:32'),(109,'App\\Models\\User',2,'laravel','eb163d647b25ce3c267c99fd1823c3a38588cdedf3642aa82d9887b73d9525b8','[\"*\"]','2024-10-31 01:57:29',NULL,'2024-10-31 01:57:28','2024-10-31 01:57:29'),(110,'App\\Models\\User',13,'laravel','434e47166f10f922dbdcd94b6e3ade88566372fdff062ce95eda6660d83f980e','[\"*\"]','2024-10-31 02:26:49',NULL,'2024-10-31 02:26:40','2024-10-31 02:26:49'),(111,'App\\Models\\User',2,'laravel','98d6deeca366574edcbd44952d74e57e1b6b42c583e60562128c861eb0c70ba1','[\"*\"]','2024-10-31 02:36:30',NULL,'2024-10-31 02:34:56','2024-10-31 02:36:30'),(112,'App\\Models\\User',13,'laravel','43c0e1e820dd3100b31ab851aa96d540c23374fe733f6f2b991ae37468c4b80e','[\"*\"]','2024-10-31 02:37:34',NULL,'2024-10-31 02:37:25','2024-10-31 02:37:34'),(113,'App\\Models\\User',2,'laravel','2cb4c3613c11ff14d6ae36b79b5fbdead7b03360e0bd9e20621c4059e990685b','[\"*\"]','2024-10-31 02:49:09',NULL,'2024-10-31 02:43:24','2024-10-31 02:49:09'),(114,'App\\Models\\User',2,'laravel','a658761342302d26f92e73c4db97e065bbef216bc6f1da0f1f78034354012abf','[\"*\"]','2024-10-31 02:52:22',NULL,'2024-10-31 02:52:21','2024-10-31 02:52:22'),(115,'App\\Models\\User',13,'laravel','67d005e736534b56b3e6ae07e4c1c6a32bea48997a81b83af170bfc73d11a080','[\"*\"]','2024-10-31 04:02:39',NULL,'2024-10-31 02:52:44','2024-10-31 04:02:39'),(116,'App\\Models\\User',13,'laravel','e830a4538118e7010b4828db57e16633ab17ccab7cc01963790ebcf9cdca4189','[\"*\"]','2024-10-31 04:06:31',NULL,'2024-10-31 04:05:04','2024-10-31 04:06:31'),(117,'App\\Models\\User',2,'laravel','bf5b396940d61472dc2610996ca8a46d01b2e3d65775a9539a827f3e70cca25f','[\"*\"]','2024-10-31 04:07:43',NULL,'2024-10-31 04:07:43','2024-10-31 04:07:43'),(118,'App\\Models\\User',13,'laravel','e12bd7fbfe13d05cf73830e00f181db5ef02876c32046bcf94049ff1b9e3df89','[\"*\"]','2024-10-31 04:43:47',NULL,'2024-10-31 04:07:59','2024-10-31 04:43:47'),(119,'App\\Models\\User',2,'laravel','7b35f6b433135c4cad88a472bb08a70fe48420c216cf524d2107aef0d8791e49','[\"*\"]','2024-10-31 04:46:50',NULL,'2024-10-31 04:44:00','2024-10-31 04:46:50'),(120,'App\\Models\\User',13,'laravel','53ec7d5a3fae6e839556f327dfea08626e48d32ade38042195f60061467bc0d7','[\"*\"]','2024-10-31 04:47:21',NULL,'2024-10-31 04:46:59','2024-10-31 04:47:21'),(121,'App\\Models\\User',2,'laravel','975b53b3b4911c67da4c48c5909cf4e25d2b923bcb24fe0c740daabcc48c848a','[\"*\"]','2024-10-31 04:52:15',NULL,'2024-10-31 04:47:28','2024-10-31 04:52:15'),(122,'App\\Models\\User',13,'laravel','95339dd60abfc6a11077dd210ebf3f8a06089c37d0df24c61bf169a79494b5d6','[\"*\"]','2024-10-31 04:52:48',NULL,'2024-10-31 04:52:26','2024-10-31 04:52:48'),(123,'App\\Models\\User',2,'laravel','54c74a1030925b1bd96d8c8449527ba99847829a4e1fb9b8d18be7c3700be77b','[\"*\"]','2024-10-31 04:52:55',NULL,'2024-10-31 04:52:54','2024-10-31 04:52:55'),(124,'App\\Models\\User',13,'laravel','668aa7da0cd28f47b8660c08e6c0abf9ab221e62732b4d7bef8eb18e37e7ce4c','[\"*\"]','2024-10-31 04:54:49',NULL,'2024-10-31 04:54:23','2024-10-31 04:54:49'),(125,'App\\Models\\User',2,'laravel','a854b161a51033cc0b492779c23e64ce22ba02b5a9e2df8fe37ba82fd97ae3a0','[\"*\"]','2024-10-31 04:55:02',NULL,'2024-10-31 04:55:01','2024-10-31 04:55:02'),(126,'App\\Models\\User',13,'laravel','a5de0a06c8aa0179e4cdf8dda2f181033d25694ddffd025fb2b9d1aa870774b2','[\"*\"]','2024-10-31 04:57:11',NULL,'2024-10-31 04:56:42','2024-10-31 04:57:11'),(127,'App\\Models\\User',2,'laravel','78845a81cf51e43d514ae05d931e24814dc697dc8ced30bbeedd9890744332cc','[\"*\"]','2024-10-31 04:57:18',NULL,'2024-10-31 04:57:18','2024-10-31 04:57:18'),(128,'App\\Models\\User',13,'laravel','cb6266b56f062bb923b1de9d4552f5e8d6b89e348fe6a366c0ea0e564fb4c317','[\"*\"]','2024-10-31 05:00:19',NULL,'2024-10-31 04:59:56','2024-10-31 05:00:19'),(129,'App\\Models\\User',2,'laravel','451642f2b6c090f1f9cda789d2127e413489d91c8f5406e90a3e2ff10d82b463','[\"*\"]','2024-10-31 05:00:26',NULL,'2024-10-31 05:00:25','2024-10-31 05:00:26'),(130,'App\\Models\\User',13,'laravel','6214828bf7fd65b85d40ac3e768de5621becedd635a46273e52b28a226908211','[\"*\"]','2024-10-31 05:13:07',NULL,'2024-10-31 05:02:32','2024-10-31 05:13:07'),(131,'App\\Models\\User',2,'laravel','6e6a7b2dfa8d5be695e33d7ce6d12b479651dffc23810a830ee44237d2bba54c','[\"*\"]','2024-10-31 07:28:12',NULL,'2024-10-31 05:13:18','2024-10-31 07:28:12'),(132,'App\\Models\\User',2,'laravel','166f97669d47cdd04931b4bedeb77df722ca8b530f47d3dacffbd6b98e3f5c8f','[\"*\"]','2024-10-31 07:28:18',NULL,'2024-10-31 07:28:15','2024-10-31 07:28:18'),(133,'App\\Models\\User',2,'laravel','3f9cc9bd7d24bfa2d862c3cc64630cb35e7f4ed1d70d71ed181f6fd8e2653038','[\"*\"]','2024-10-31 07:31:08',NULL,'2024-10-31 07:28:16','2024-10-31 07:31:08'),(134,'App\\Models\\User',14,'laravel','aae73a9dc0ce801cfb3d76ed87a97133aeaaff8cd9b18acdde8ba2daa90e2d6c','[\"*\"]','2024-10-31 07:39:37',NULL,'2024-10-31 07:39:04','2024-10-31 07:39:37'),(135,'App\\Models\\User',2,'laravel','a3050f0a2e8e008b1dcf7c25d0bc3cc786fd214f8bc31e19ac4377748d54765c','[\"*\"]','2024-10-31 07:39:46',NULL,'2024-10-31 07:39:46','2024-10-31 07:39:46'),(136,'App\\Models\\User',11,'laravel','a818ea828669e4d244c44dd1e543bbf2299f80153d736e684e9371fc981578cc','[\"*\"]','2024-10-31 07:41:49',NULL,'2024-10-31 07:41:25','2024-10-31 07:41:49'),(137,'App\\Models\\User',2,'laravel','02fa3dc1f289f7fa9a9cdc3c98cbf4509b8414cd3caa2d89f6e8fe27330c142f','[\"*\"]','2024-11-01 06:02:05',NULL,'2024-10-31 07:41:57','2024-11-01 06:02:05'),(138,'App\\Models\\User',13,'laravel','e2808b6779df77ec81ee040c3adcb149bb6ccb91c4642daa47413cd9687de41b','[\"*\"]','2024-11-01 06:38:27',NULL,'2024-11-01 06:02:40','2024-11-01 06:38:27'),(139,'App\\Models\\User',2,'laravel','e77d1c447da035ae59b2cc4e4185b997ec680599228f03a4e6636c73320136c9','[\"*\"]','2024-11-01 06:51:28',NULL,'2024-11-01 06:39:29','2024-11-01 06:51:28'),(140,'App\\Models\\User',2,'laravel','c12e0257b1aeca83d636292aae4a2c69ad8d18afb62f65f06447d30dff1717d3','[\"*\"]','2024-11-01 10:11:50',NULL,'2024-11-01 09:29:15','2024-11-01 10:11:50'),(141,'App\\Models\\User',13,'laravel','596e3862d32deb408d2e472f8fa5f0f11afdd4991445f92f18f27d9cdd88ebee','[\"*\"]','2024-11-01 10:10:45',NULL,'2024-11-01 09:47:57','2024-11-01 10:10:45'),(142,'App\\Models\\User',2,'laravel','4999d7f09be4b7f2613f0a24d00729b9356954b915635d3db02bffe70b6a2688','[\"*\"]','2024-11-01 10:16:25',NULL,'2024-11-01 10:11:00','2024-11-01 10:16:25'),(143,'App\\Models\\User',13,'laravel','5d8b258d84f4084a1ad82aa6df3f2ed647469c583be05fb5945492f7e24cab5d','[\"*\"]','2024-11-01 10:16:33',NULL,'2024-11-01 10:16:31','2024-11-01 10:16:33'),(144,'App\\Models\\User',2,'laravel','9f39370dccc8cb14c6def9a2300ccc28a17bfb27736111ec3ed0c46fb48c0c1c','[\"*\"]','2024-11-01 10:16:49',NULL,'2024-11-01 10:16:47','2024-11-01 10:16:49'),(145,'App\\Models\\User',2,'laravel','6621c36efa48bed333a86131199be97832bb78173af6de92bde2182de393a14d','[\"*\"]','2024-11-01 10:43:17',NULL,'2024-11-01 10:26:26','2024-11-01 10:43:17'),(146,'App\\Models\\User',2,'laravel','68fa58c18093d328d532f0d22dc758c47c4d6d67b5ca25d6a84eb64248f49267','[\"*\"]','2024-11-01 12:53:12',NULL,'2024-11-01 12:53:10','2024-11-01 12:53:12'),(147,'App\\Models\\User',2,'laravel','341162fc81e34d6d39f3a5adfe378023ddcc8ee588f81111adc045c8cdad2635','[\"*\"]','2024-11-01 13:08:15',NULL,'2024-11-01 12:53:11','2024-11-01 13:08:15'),(148,'App\\Models\\User',16,'laravel','d1952213ce0928a755ec1ac0835d5310e06392a375da3b44ab208576d7875d6b','[\"*\"]',NULL,NULL,'2024-11-01 13:19:56','2024-11-01 13:19:56'),(149,'App\\Models\\User',16,'laravel','4370ea33efd7c9b3d2cc2d4d2fe1543d7fc20e645b69a95a7eb52e9306587036','[\"*\"]','2024-11-01 13:20:00',NULL,'2024-11-01 13:19:57','2024-11-01 13:20:00'),(150,'App\\Models\\User',16,'laravel','266fdf33cf3e745693a358bc96cedf969c8208bf635125e28f3fcfb5e7e4594f','[\"*\"]',NULL,NULL,'2024-11-01 13:19:58','2024-11-01 13:19:58'),(151,'App\\Models\\User',16,'laravel','b3e5778595b9204cf36a38667f2471dfeb6716dda0de89c6cdc377611bee5610','[\"*\"]','2024-11-01 13:31:47',NULL,'2024-11-01 13:20:00','2024-11-01 13:31:47'),(152,'App\\Models\\User',16,'laravel','27d92e0a34dc01c1a5dab1def6295170a3c033c298fcb05675cf90c5810c53a7','[\"*\"]','2024-11-01 16:36:16',NULL,'2024-11-01 13:32:05','2024-11-01 16:36:16'),(153,'App\\Models\\User',13,'laravel','a7930a96abb3f80cf151e8a3960a20f7016c0ca5d199d816c387d665cab30212','[\"*\"]','2024-11-01 16:37:31',NULL,'2024-11-01 16:37:29','2024-11-01 16:37:31'),(154,'App\\Models\\User',13,'laravel','d9bd42d4d218c85499137236c8c19d23c7e663aef846b4e4194a4c7f527ed2a0','[\"*\"]','2024-11-01 16:52:45',NULL,'2024-11-01 16:37:55','2024-11-01 16:52:45'),(155,'App\\Models\\User',2,'laravel','81d8e059bad24d71b152a942a0ec7e2e91fae8ddc91f69524ee9093cb68b9435','[\"*\"]','2024-11-02 04:39:24',NULL,'2024-11-01 16:54:03','2024-11-02 04:39:24'),(156,'App\\Models\\User',13,'laravel','dc0e086b094024ab56206e888d0a9fe5b561672213c816f84c24f010f2970b47','[\"*\"]',NULL,NULL,'2024-11-02 04:58:41','2024-11-02 04:58:41'),(157,'App\\Models\\User',13,'laravel','281b00781b162f5df8664cc74e8ef9ee311be4280e946dbdea88f6b2fa6481d2','[\"*\"]',NULL,NULL,'2024-11-02 04:58:43','2024-11-02 04:58:43'),(158,'App\\Models\\User',13,'laravel','e1a006a8561171ada0206b1c86fba52e6847360c49d3488cb7f98813dc682391','[\"*\"]',NULL,NULL,'2024-11-02 04:58:44','2024-11-02 04:58:44'),(159,'App\\Models\\User',13,'laravel','3c9cff26aac9dffd3fe04b5e6ddf68d5db5c0487809d828f823209fb7f2ebd8b','[\"*\"]',NULL,NULL,'2024-11-02 04:58:45','2024-11-02 04:58:45'),(160,'App\\Models\\User',13,'laravel','2e4c2af7f57d08386a6c8674656341d1514bcd585853a869e9cd4a18c15ff58f','[\"*\"]','2024-11-02 05:46:11',NULL,'2024-11-02 04:58:46','2024-11-02 05:46:11'),(161,'App\\Models\\User',13,'laravel','4b5724bbac7f10ce91e352af841f50d156e6b84dfe7d03cc1d6426411a9e02e9','[\"*\"]','2024-11-02 05:46:19',NULL,'2024-11-02 05:46:17','2024-11-02 05:46:19'),(162,'App\\Models\\User',2,'laravel','d8c6adf49f456608e4b6a588e59f16176dfe7e615d5186273eb9bbbb00986a8d','[\"*\"]','2024-11-02 06:18:20',NULL,'2024-11-02 05:46:36','2024-11-02 06:18:20'),(163,'App\\Models\\User',13,'laravel','22d14e9629241b5a4bfe7c820c7229c14047606677beb79cdc99e8a7e72ca903','[\"*\"]','2024-11-02 08:06:23',NULL,'2024-11-02 06:18:30','2024-11-02 08:06:23'),(164,'App\\Models\\User',2,'laravel','ecf2bc28a0e2f31ca8e7e08c39e9f2d38fbd3df465ab72af46d105290c50a8db','[\"*\"]','2024-11-02 08:06:41',NULL,'2024-11-02 08:06:40','2024-11-02 08:06:41'),(165,'App\\Models\\User',2,'laravel','0df4b06568878f6ecc044aab920a8f79d16f1e50b7552fa12c64a7f6873529f3','[\"*\"]','2024-11-02 08:20:41',NULL,'2024-11-02 08:06:52','2024-11-02 08:20:41'),(166,'App\\Models\\User',13,'laravel','54105f1df528f412bbe4c2c247f1a2afdfd487ddd44b3b42083665e5309a72b6','[\"*\"]','2024-11-02 08:22:54',NULL,'2024-11-02 08:22:23','2024-11-02 08:22:54'),(167,'App\\Models\\User',2,'laravel','120dbb297bd12900586d9dd0afd65a692e47b015952c9bf3c069ed0e99526c73','[\"*\"]','2024-11-02 08:25:07',NULL,'2024-11-02 08:23:02','2024-11-02 08:25:07'),(168,'App\\Models\\User',13,'laravel','b37c74028a32ca30db9bd937573002ff301ef4f14bf63676f8e07c04056c0a40','[\"*\"]','2024-11-02 09:14:36',NULL,'2024-11-02 08:25:21','2024-11-02 09:14:36'),(169,'App\\Models\\User',2,'laravel','a13016b16346d4da7bc5ea7ee171b85e3d8f0c73368f929b52b5bfc1ffd2bcc8','[\"*\"]','2024-11-02 09:15:43',NULL,'2024-11-02 09:14:43','2024-11-02 09:15:43'),(170,'App\\Models\\User',13,'laravel','1525297a747e8d63b9017e6cbae9ba3f96d23b18151e15ff3918ba2f4937e01b','[\"*\"]','2024-11-02 11:22:43',NULL,'2024-11-02 09:15:50','2024-11-02 11:22:43'),(171,'App\\Models\\User',13,'laravel','ad2b09788a86a86fce3a134f7b5fb8da7e5e62273113217471e80e85595b4581','[\"*\"]','2024-11-02 11:40:18',NULL,'2024-11-02 11:35:13','2024-11-02 11:40:18'),(172,'App\\Models\\User',13,'laravel','11ad91a849e121758fd785aba1c07603237f5ca4ae3ef83acf7cd01b52418f3e','[\"*\"]','2024-11-04 04:35:11',NULL,'2024-11-02 11:40:40','2024-11-04 04:35:11'),(173,'App\\Models\\User',13,'laravel','4e59df024cf5276e7ffeda6c8a83c557d78dfa242936c1568896f444c5c9d334','[\"*\"]','2024-11-02 12:05:29',NULL,'2024-11-02 12:05:26','2024-11-02 12:05:29'),(174,'App\\Models\\User',13,'laravel','d79c1989976333f6005659935c2f4b0e8de63325d0a53a2c24b7eb218df6e415','[\"*\"]','2024-11-02 12:06:44',NULL,'2024-11-02 12:06:41','2024-11-02 12:06:44'),(175,'App\\Models\\User',13,'laravel','6028102c3abdd9a21b206e2ac47248ddac15f8ee136559d7c235bd279e043669','[\"*\"]','2024-11-02 12:45:52',NULL,'2024-11-02 12:09:55','2024-11-02 12:45:52'),(176,'App\\Models\\User',2,'laravel','22c14c23ce59cac9859692949465711ba722fa92d13a8f3d1a23be0a194d048e','[\"*\"]','2024-11-02 12:54:17',NULL,'2024-11-02 12:46:04','2024-11-02 12:54:17'),(177,'App\\Models\\User',2,'laravel','553c2b7e260edd20fafdc12ea451c60022bb8012c19ad2f3bc2543935eb0d10b','[\"*\"]','2024-11-02 12:54:30',NULL,'2024-11-02 12:54:29','2024-11-02 12:54:30'),(178,'App\\Models\\User',13,'laravel','c246fe0428aa74105591dd71a1fee0235b2c94000cbfbc1fc4d836487853519e','[\"*\"]','2024-11-02 13:18:08',NULL,'2024-11-02 12:55:35','2024-11-02 13:18:08'),(179,'App\\Models\\User',2,'laravel','2f5f45e1ba3bd502e44f6ed6d75269fa384e8fa1a8e25a5f4a06020ba487b727','[\"*\"]','2024-11-02 13:25:40',NULL,'2024-11-02 13:18:23','2024-11-02 13:25:40'),(180,'App\\Models\\User',13,'laravel','727603c657ad9f3873f8ba5e57d6104d5d3cfb9e0ab463669b94c673a16c1de6','[\"*\"]','2024-11-02 13:32:12',NULL,'2024-11-02 13:30:36','2024-11-02 13:32:12'),(181,'App\\Models\\User',2,'laravel','176628bfd82e01f26da85be637d0173cc5591fae6daf967c32c07890350b7eef','[\"*\"]','2024-11-02 13:43:05',NULL,'2024-11-02 13:43:04','2024-11-02 13:43:05'),(182,'App\\Models\\User',2,'laravel','a606b67249d29456ffe96122fbd600acd4df07517d552d04a4d7225622251c05','[\"*\"]','2024-11-02 13:43:08',NULL,'2024-11-02 13:43:06','2024-11-02 13:43:08'),(183,'App\\Models\\User',2,'laravel','22a47819a8dd6d1b84b287759b0f0b54e222ab130b4a593f37f46d40e1078766','[\"*\"]','2024-11-02 13:46:15',NULL,'2024-11-02 13:43:07','2024-11-02 13:46:15'),(184,'App\\Models\\User',2,'laravel','bbd66cfb3a30c3dd0a5c3fc703eda0cbf1f24ae53987c54a262d647eb4704254','[\"*\"]','2024-11-02 13:46:42',NULL,'2024-11-02 13:46:18','2024-11-02 13:46:42'),(185,'App\\Models\\User',13,'laravel','c711a33537ad255bf0d7b5b4bb8ae0237fff15cf4276be7d2eb33890b741118c','[\"*\"]','2024-11-02 13:49:16',NULL,'2024-11-02 13:47:23','2024-11-02 13:49:16'),(186,'App\\Models\\User',13,'laravel','6acf890763b042ee659bf51b8af4b21bba1ad57f77c84715b0dfef79711b4473','[\"*\"]','2024-11-02 14:06:08',NULL,'2024-11-02 13:50:03','2024-11-02 14:06:08'),(187,'App\\Models\\User',2,'laravel','4e3c94c97581313fea76b35111165d6d383dd594ee8eab91c18581d14598e4df','[\"*\"]','2024-11-02 14:08:13',NULL,'2024-11-02 14:07:27','2024-11-02 14:08:13'),(188,'App\\Models\\User',13,'laravel','a0196a914b0f9d53e8b46d287ad51ee3198e8dafdd44d98f69028032472d00f5','[\"*\"]','2024-11-02 14:11:29',NULL,'2024-11-02 14:08:22','2024-11-02 14:11:29'),(189,'App\\Models\\User',13,'laravel','fbe12c36207d40cc2d6f8938c96a96a76d02945bae3174bce3941408c5238947','[\"*\"]','2024-11-02 14:15:41',NULL,'2024-11-02 14:12:30','2024-11-02 14:15:41'),(190,'App\\Models\\User',2,'laravel','9a193c522b657308f6c5fc2c7dca42974002a033eb893b61972752deebbfdae0','[\"*\"]','2024-11-02 14:22:14',NULL,'2024-11-02 14:15:57','2024-11-02 14:22:14'),(191,'App\\Models\\User',13,'laravel','fa2e9fca9e894f0a3a81f97888dbdaa004c14a4870ec5f7def9fa6f46c70adef','[\"*\"]','2024-11-02 14:28:08',NULL,'2024-11-02 14:27:37','2024-11-02 14:28:08'),(192,'App\\Models\\User',2,'laravel','8320a196e0ad3e04dfe26973d065d5b7497cdff00c34bc37eb37311774b6a7ff','[\"*\"]','2024-11-02 14:28:40',NULL,'2024-11-02 14:28:19','2024-11-02 14:28:40'),(193,'App\\Models\\User',13,'laravel','8327f46f82c32d51b0a76036702eed76f2beadbc1ef0578511747a7170799397','[\"*\"]','2024-11-02 14:29:02',NULL,'2024-11-02 14:28:53','2024-11-02 14:29:02'),(194,'App\\Models\\User',13,'laravel','585f7f00d4eb02ab87c05f9cf060f4a818117d895503c5ac2c761be3714379ee','[\"*\"]','2024-11-02 14:34:19',NULL,'2024-11-02 14:34:13','2024-11-02 14:34:19'),(195,'App\\Models\\User',13,'laravel','9d2402900a976e9283d76e3bee971fe862456748f33c990230755d1b830509a2','[\"*\"]','2024-11-02 14:36:24',NULL,'2024-11-02 14:36:19','2024-11-02 14:36:24'),(196,'App\\Models\\User',13,'laravel','fa9f3cab104da7b56cddff6aa9941390a93ce1b6460c1aed27224049a59e77c1','[\"*\"]','2024-11-02 14:38:10',NULL,'2024-11-02 14:37:42','2024-11-02 14:38:10'),(197,'App\\Models\\User',2,'laravel','a9978d3c10b5bfd6debc78a5fa252367fcb1db795b7a5a5a203526e949e7f3be','[\"*\"]','2024-11-02 14:38:43',NULL,'2024-11-02 14:38:24','2024-11-02 14:38:43'),(198,'App\\Models\\User',13,'laravel','15686cc4aa1db998c05b6b5df019c29d6fc361ac2f5ab1a14fc58bcf5b8f666d','[\"*\"]','2024-11-02 14:44:49',NULL,'2024-11-02 14:38:57','2024-11-02 14:44:49'),(199,'App\\Models\\User',13,'laravel','6fc2ae26e2b58df3a261cd9603f1444c31dddca9f5f81144b551d84a7994f1d4','[\"*\"]','2024-11-02 14:47:19',NULL,'2024-11-02 14:46:51','2024-11-02 14:47:19'),(200,'App\\Models\\User',2,'laravel','a166ee1cc2cbd37382821ae03ef2c461fab418d158cef62e26c52fac89fedbf2','[\"*\"]','2024-11-02 14:47:48',NULL,'2024-11-02 14:47:32','2024-11-02 14:47:48'),(201,'App\\Models\\User',13,'laravel','fc4dc2e890e9cd776c4c6c8bc5046cd7f422ae5c82c1d7df192c4a0f074761e7','[\"*\"]','2024-11-02 14:50:02',NULL,'2024-11-02 14:48:02','2024-11-02 14:50:02'),(202,'App\\Models\\User',2,'laravel','3c2a08588a5e6463753d8b79dcb67e1eb433eba9ec776af93a2d19da0467d964','[\"*\"]','2024-11-02 14:54:25',NULL,'2024-11-02 14:50:14','2024-11-02 14:54:25'),(203,'App\\Models\\User',13,'laravel','dda5a901cb59d5888cb80584481b596cb8d6df447543b06a1879f260a5f645b2','[\"*\"]','2024-11-02 14:57:43',NULL,'2024-11-02 14:57:14','2024-11-02 14:57:43'),(204,'App\\Models\\User',2,'laravel','c26dae24b9c8c55ce3e64a831ac8cfda59c8ff9619a139d890b05e039e824616','[\"*\"]','2024-11-02 14:58:12',NULL,'2024-11-02 14:58:00','2024-11-02 14:58:12'),(205,'App\\Models\\User',13,'laravel','ae495f52ba05ca8a5a3901202752674a833f418ba9dbef9f38c14fc24e83f07a','[\"*\"]','2024-11-02 15:00:07',NULL,'2024-11-02 14:58:26','2024-11-02 15:00:07'),(206,'App\\Models\\User',2,'laravel','cbf9e320559c48a38d756aae13b61548704b775cca446b2a01df5fe6e619e392','[\"*\"]','2024-11-02 15:02:45',NULL,'2024-11-02 15:00:21','2024-11-02 15:02:45'),(207,'App\\Models\\User',13,'laravel','de9babe146287b7e39ec70fd48aef7635ebfdb5d6a52cc44e309450876343e4f','[\"*\"]','2024-11-02 15:03:40',NULL,'2024-11-02 15:03:03','2024-11-02 15:03:40'),(208,'App\\Models\\User',2,'laravel','4475abb4d22a5af0663c35498a67fb117b16e2f118992bfd85858580d9b7fdb2','[\"*\"]','2024-11-02 17:35:38',NULL,'2024-11-02 17:35:30','2024-11-02 17:35:38'),(209,'App\\Models\\User',2,'laravel','c92556d0089d64b2c21d76225373884efd6b062c94ad4d7e4cc602744cba4ef9','[\"*\"]','2024-11-02 17:35:38',NULL,'2024-11-02 17:35:32','2024-11-02 17:35:38'),(210,'App\\Models\\User',2,'laravel','025e4654aaf270c48334dfa25caaf25259e5621008a9a6c00d40254dc7cf2021','[\"*\"]','2024-11-02 17:38:07',NULL,'2024-11-02 17:35:35','2024-11-02 17:38:07'),(211,'App\\Models\\User',17,'laravel','ae7ec62a95b0d06e95d0523c45044d5d4743df404b951b230a23771baaaf99a7','[\"*\"]',NULL,NULL,'2024-11-03 02:29:15','2024-11-03 02:29:15'),(212,'App\\Models\\User',18,'laravel','ce4371ca22d01258da337976bd8f9fe01142dddaafe9a84e310a173a33d414f2','[\"*\"]',NULL,NULL,'2024-11-03 02:31:20','2024-11-03 02:31:20'),(213,'App\\Models\\User',19,'laravel','5caac99efd05f52bdaad7250d28d607d638996c8040bb8a30c903efaaaa300d2','[\"*\"]',NULL,NULL,'2024-11-03 02:47:25','2024-11-03 02:47:25'),(214,'App\\Models\\User',2,'laravel','c2c7baa90a41ac1dbcd3790b30c34a64ac75004e169b47596a5760253c20f3e5','[\"*\"]','2024-11-03 03:01:56',NULL,'2024-11-03 03:01:54','2024-11-03 03:01:56'),(215,'App\\Models\\User',2,'laravel','f8aff925a3a93179fc8716af7dc5eb0ab64b297f28cdc84c647f4158e98b472c','[\"*\"]','2024-11-03 03:25:39',NULL,'2024-11-03 03:12:33','2024-11-03 03:25:39'),(216,'App\\Models\\User',19,'laravel','8255a8a75902163e38884e09ca7a2004c97260c6734b36a669faf00c2abbd704','[\"*\"]','2024-11-03 03:27:42',NULL,'2024-11-03 03:27:39','2024-11-03 03:27:42'),(217,'App\\Models\\User',2,'laravel','5ba622cb7fd946535debff99749043886b8c6da51f65eef201c650caf6e94b9b','[\"*\"]','2024-11-03 03:57:13',NULL,'2024-11-03 03:56:53','2024-11-03 03:57:13'),(218,'App\\Models\\User',19,'laravel','b12d381815576caaad1e3816a6f7dfb8b794de0b686de0357b4403df2f83fdda','[\"*\"]','2024-11-03 03:57:34',NULL,'2024-11-03 03:57:31','2024-11-03 03:57:34'),(219,'App\\Models\\User',2,'laravel','8d265c8ad6ce459bf2bd94acb6c8c97f41994f585f0db4ff398da1ac5ec20820','[\"*\"]','2024-11-03 04:02:01',NULL,'2024-11-03 04:01:39','2024-11-03 04:02:01'),(220,'App\\Models\\User',2,'laravel','0fb5cbaebadf566d331d12a6a38105c2fcb5b751efc0a293dcf005da66d026ee','[\"*\"]','2024-11-03 04:08:41',NULL,'2024-11-03 04:05:54','2024-11-03 04:08:41'),(221,'App\\Models\\User',13,'laravel','a68e523e009f11175a72cbf7cbb9d2287d43171ffc4ffdadd5b8a5b6d8fcf0b0','[\"*\"]','2024-11-03 04:36:15',NULL,'2024-11-03 04:36:13','2024-11-03 04:36:15'),(222,'App\\Models\\User',2,'laravel','6ad615fe53899e881743a66f9040c6bf1f9eae2bf54bec8ca92753224bd965e2','[\"*\"]','2024-11-03 05:08:46',NULL,'2024-11-03 05:04:30','2024-11-03 05:08:46'),(223,'App\\Models\\User',19,'laravel','92dd5c3925ad69c505ae1954ee9cbbeb2ebcf80514372c5c81adb2b9da17025a','[\"*\"]','2024-11-03 05:12:27',NULL,'2024-11-03 05:10:36','2024-11-03 05:12:27'),(224,'App\\Models\\User',2,'laravel','3173a3fd535f3bae438e7b050c8e59cb5b997162f113f13b8033bd911f54f5e6','[\"*\"]','2024-11-03 05:22:34',NULL,'2024-11-03 05:22:18','2024-11-03 05:22:34'),(225,'App\\Models\\User',19,'laravel','9880719907e8a10fd79a7c9d6773a2b9a41b1415525284738a25c0ff46d02021','[\"*\"]','2024-11-03 05:22:41',NULL,'2024-11-03 05:22:39','2024-11-03 05:22:41'),(226,'App\\Models\\User',2,'laravel','95ec136a34333fe9dbdc1a60c8981031ed116e34f78a28bd534645f9aa95e9be','[\"*\"]','2024-11-03 05:25:41',NULL,'2024-11-03 05:25:02','2024-11-03 05:25:41'),(227,'App\\Models\\User',19,'laravel','8160beec85c29da6b682b8786d94c4987883e718453fe01d8a2795815cd4ff72','[\"*\"]','2024-11-03 05:25:50',NULL,'2024-11-03 05:25:47','2024-11-03 05:25:50'),(228,'App\\Models\\User',2,'laravel','23a15af3752d0b7fc901149c8fd4f2ac8c7eb3917d01775ea8b910fbc80f26c7','[\"*\"]','2024-11-03 05:28:09',NULL,'2024-11-03 05:28:07','2024-11-03 05:28:09'),(229,'App\\Models\\User',2,'laravel','7a75f621451870c506a51d75824d6522946c06b42d3294d13e60b1b0ee0db60a','[\"*\"]','2024-11-03 05:33:06',NULL,'2024-11-03 05:32:58','2024-11-03 05:33:06'),(230,'App\\Models\\User',19,'laravel','f3c0411b1bebd0c6425d5d34b4cbe0df1161340106c204a0ce56ceeac1a9ec64','[\"*\"]','2024-11-03 05:33:26',NULL,'2024-11-03 05:33:24','2024-11-03 05:33:26'),(231,'App\\Models\\User',2,'laravel','d589db0ec25515f9a653c9f440e3e959baa740e880285e8e964c7e05006fe920','[\"*\"]','2024-11-03 05:36:23',NULL,'2024-11-03 05:35:24','2024-11-03 05:36:23'),(232,'App\\Models\\User',19,'laravel','7d2a3dcbe7f1257863eaa9af696b3f9e6570b1c7d3886815d666b82735a28470','[\"*\"]',NULL,NULL,'2024-11-03 05:36:49','2024-11-03 05:36:49'),(233,'App\\Models\\User',19,'laravel','7559b8e48285fa27d2c0ec51b7d7eb76b5434f8ee5c153b2e3f58618001fcb41','[\"*\"]',NULL,NULL,'2024-11-03 05:36:50','2024-11-03 05:36:50'),(234,'App\\Models\\User',2,'laravel','95f00407592e1b897ded8434048f5388dfaba824434c79e91a5319842a6eb824','[\"*\"]','2024-11-03 05:49:37',NULL,'2024-11-03 05:48:29','2024-11-03 05:49:37'),(235,'App\\Models\\User',2,'laravel','d6035216bcc17a310414078d79616adbb1d791143f1821dd3b6df79b5b45f83d','[\"*\"]','2024-11-03 06:10:15',NULL,'2024-11-03 05:54:34','2024-11-03 06:10:15'),(236,'App\\Models\\User',19,'laravel','589324e67bf8121c8888064c5982f2c13cc9e76087a9174016ffbf03989b46b8','[\"*\"]','2024-11-03 06:20:14',NULL,'2024-11-03 06:12:56','2024-11-03 06:20:14'),(237,'App\\Models\\User',19,'laravel','8407751b0f8163fce3edd2a12640c1887d38416946e76af7f8e31a1f7b3c726f','[\"*\"]',NULL,NULL,'2024-11-03 07:21:47','2024-11-03 07:21:47'),(238,'App\\Models\\User',19,'laravel','031370cf09e3f6c7f8775bcb8a62f88a894f4f12ab552975bf9e5632e5a23ac3','[\"*\"]','2024-11-03 07:46:24',NULL,'2024-11-03 07:21:48','2024-11-03 07:46:24'),(239,'App\\Models\\User',19,'laravel','e2ff176fb87b2e2b83d2aa1fa0a1b06b4f25dcacd8d26c93840d369c914614d1','[\"*\"]','2024-11-03 08:13:18',NULL,'2024-11-03 07:46:45','2024-11-03 08:13:18'),(240,'App\\Models\\User',19,'laravel','2a756f2c50b99dd13f6f09330e78dc020ff9aebc5c51aca80521909f7a491627','[\"*\"]','2024-11-03 08:16:06',NULL,'2024-11-03 08:16:02','2024-11-03 08:16:06'),(241,'App\\Models\\User',19,'laravel','f3e0a50fc6dfd7ef196efe5ca1b560967a2eb42bad49fded41b123b86e1b1a88','[\"*\"]','2024-11-03 08:31:38',NULL,'2024-11-03 08:16:04','2024-11-03 08:31:38'),(242,'App\\Models\\User',19,'laravel','de732e1d83f8d42e46159943f2bd4aff5527ffc0837afc4f9a9047c1891213a7','[\"*\"]','2024-11-03 13:41:13',NULL,'2024-11-03 08:16:51','2024-11-03 13:41:13'),(243,'App\\Models\\User',19,'laravel','b6bb870a722c352fbde90bc560a8f2ecc5c775b9cbc80a9b2c152a813453efd0','[\"*\"]','2024-11-03 08:32:36',NULL,'2024-11-03 08:32:33','2024-11-03 08:32:36'),(244,'App\\Models\\User',20,'laravel','8ea14f03a8600b767084c0dcc10fc37ad85ee93ed87825e4f0dd4dae07dc14a5','[\"*\"]',NULL,NULL,'2024-11-03 08:34:38','2024-11-03 08:34:38'),(245,'App\\Models\\User',2,'laravel','c4941b98b366312fbeaf2088058a3c6f3991bc6cb9052b21ecc01f170b523ca5','[\"*\"]','2024-11-03 09:21:56',NULL,'2024-11-03 09:21:55','2024-11-03 09:21:56'),(246,'App\\Models\\User',2,'laravel','c788c4cf35be0d6dbecf42b86d8c794db9843a6ea81651a9d98c921f5db70a6c','[\"*\"]','2024-11-03 09:39:06',NULL,'2024-11-03 09:30:56','2024-11-03 09:39:06'),(247,'App\\Models\\User',2,'laravel','886621b975cfe650028217ee88f217e67b9a6ad86144de360998ca528197f396','[\"*\"]','2024-11-03 09:39:13',NULL,'2024-11-03 09:39:12','2024-11-03 09:39:13'),(248,'App\\Models\\User',2,'laravel','4e50fb9b47bea81070d180ca41cba053cea42a6551f57d5d7dca439cd2ef50f2','[\"*\"]','2024-11-03 09:40:01',NULL,'2024-11-03 09:39:59','2024-11-03 09:40:01'),(249,'App\\Models\\User',2,'laravel','eb1701ee142ab08fd8be317da67b3d917fa1d4b6ea67e18f053604babe268b52','[\"*\"]','2024-11-03 09:40:54',NULL,'2024-11-03 09:40:53','2024-11-03 09:40:54'),(250,'App\\Models\\User',2,'laravel','55dff72933207467ec19e17b8e461d4f67d100c354fe0d718616668744e3a84a','[\"*\"]','2024-11-03 09:42:46',NULL,'2024-11-03 09:42:45','2024-11-03 09:42:46'),(251,'App\\Models\\User',2,'laravel','348e8ad57cff84f2d17448f03d223ecce068fa3426b469daab2434976239eca9','[\"*\"]','2024-11-03 09:52:22',NULL,'2024-11-03 09:52:21','2024-11-03 09:52:22'),(252,'App\\Models\\User',2,'laravel','07d07e9015a70b98e068d79b8371fcb42197669e7f6501da54b97cc96a6c3a29','[\"*\"]','2024-11-03 09:52:54',NULL,'2024-11-03 09:52:53','2024-11-03 09:52:54'),(253,'App\\Models\\User',2,'laravel','cd599a5a14ee4cd6459306d712b4766213916c7647466456b07d9ec904bf7e04','[\"*\"]','2024-11-03 09:53:30',NULL,'2024-11-03 09:53:29','2024-11-03 09:53:30'),(254,'App\\Models\\User',2,'laravel','480fc500bcb7e1bbaf5e054eac33e0044214cf7814aad7cc8914976efaeca27d','[\"*\"]','2024-11-03 10:02:20',NULL,'2024-11-03 10:02:19','2024-11-03 10:02:20'),(255,'App\\Models\\User',2,'laravel','117ec579addda83ec07dbd7bd4c368c76bfb50cb9b8be5f52ce788ebcaa5b181','[\"*\"]','2024-11-03 10:03:44',NULL,'2024-11-03 10:03:42','2024-11-03 10:03:44'),(256,'App\\Models\\User',2,'laravel','92135d420353acff983a653d4d74c701f43c4f9ad9c668712c991d93f11fead7','[\"*\"]','2024-11-03 10:04:32',NULL,'2024-11-03 10:04:31','2024-11-03 10:04:32'),(257,'App\\Models\\User',2,'laravel','27af79f7812d1735debbd55afb65b43851eef71aa43c48597388e259a514c889','[\"*\"]','2024-11-03 10:07:32',NULL,'2024-11-03 10:07:31','2024-11-03 10:07:32'),(258,'App\\Models\\User',2,'laravel','37d771f1dd77e6e445edc65a32d09f936c77a12d2e422447e4afffbae2989a0d','[\"*\"]','2024-11-03 10:08:09',NULL,'2024-11-03 10:08:08','2024-11-03 10:08:09'),(259,'App\\Models\\User',19,'laravel','8c7eb4a6154e51f3dee017903f2a62e800b01674170771261b60946b0736f99a','[\"*\"]','2024-11-03 10:08:22',NULL,'2024-11-03 10:08:20','2024-11-03 10:08:22'),(260,'App\\Models\\User',2,'laravel','ab7150d321f41ecdb189e837dac74be0e5b46697d479dc8c93a2da8776e1e439','[\"*\"]','2024-11-03 10:15:27',NULL,'2024-11-03 10:15:18','2024-11-03 10:15:27'),(261,'App\\Models\\User',13,'laravel','0f505b33c331d701eef6f2909bff045c16aebff2a9c155b93e810a90f5868a0a','[\"*\"]','2024-11-03 10:15:42',NULL,'2024-11-03 10:15:41','2024-11-03 10:15:42'),(262,'App\\Models\\User',19,'laravel','a83d20c3cd95f77e3ba7f59e1e34ce3cd389d7a2403a96e5edebc82f6c1a7fed','[\"*\"]','2024-11-03 10:16:20',NULL,'2024-11-03 10:16:02','2024-11-03 10:16:20'),(263,'App\\Models\\User',13,'laravel','811775e0bd339a0318a7d7892bb7c07b58e1d5813421b3344b78fae6e50d0947','[\"*\"]','2024-11-03 10:16:46',NULL,'2024-11-03 10:16:45','2024-11-03 10:16:46'),(264,'App\\Models\\User',2,'laravel','9fa903d7f6c73ab47dd580e99906d40f333597261fedd806d813993ec63f80da','[\"*\"]','2024-11-03 10:51:22',NULL,'2024-11-03 10:26:14','2024-11-03 10:51:22'),(265,'App\\Models\\User',21,'laravel','e51d8c0002f4fa4537074ff126c6805ee3a96a18a5720bb349190e128443e07d','[\"*\"]',NULL,NULL,'2024-11-03 10:52:16','2024-11-03 10:52:16'),(266,'App\\Models\\User',2,'laravel','6ff82607cffb488766456ec4f0ef22df599622fc3a6403668e8a83fcc7052d67','[\"*\"]','2024-11-03 10:52:48',NULL,'2024-11-03 10:52:33','2024-11-03 10:52:48'),(267,'App\\Models\\User',2,'laravel','6b404102fb532fd4d04203419fb94c7005c7fdc17a7b23fe683a9dd843a427d3','[\"*\"]','2024-11-03 10:54:19',NULL,'2024-11-03 10:54:17','2024-11-03 10:54:19'),(268,'App\\Models\\User',19,'laravel','c7fba51eb771e58a10fbd2942ddd064e5fee7594e30d78fabd08dd905c47c50a','[\"*\"]','2024-11-03 10:57:32',NULL,'2024-11-03 10:56:19','2024-11-03 10:57:32'),(269,'App\\Models\\User',21,'laravel','bb08ee3ba905ff3c801fefd883c2cf7d46f836e64d866d56da9a6a6e40ce3f21','[\"*\"]','2024-11-03 10:59:29',NULL,'2024-11-03 10:59:28','2024-11-03 10:59:29'),(270,'App\\Models\\User',2,'laravel','a8b0144f4701797d55ac8e81eb9b9bfddc52f5b74ab28fabd589c2cb60160206','[\"*\"]','2024-11-03 11:00:39',NULL,'2024-11-03 10:59:56','2024-11-03 11:00:39'),(271,'App\\Models\\User',21,'laravel','81a193dad859baff0a4429ad1c981da832febc0662aa88ea96b791e8c80a7001','[\"*\"]','2024-11-03 11:01:04',NULL,'2024-11-03 11:01:00','2024-11-03 11:01:04'),(272,'App\\Models\\User',21,'laravel','98a41a9a39645d1d611c073652bb5c42a137e12a1be15a4c4d6c37f0a7feaec1','[\"*\"]','2024-11-03 11:01:05',NULL,'2024-11-03 11:01:02','2024-11-03 11:01:05'),(273,'App\\Models\\User',2,'laravel','ac7dcaec04ce69b1c592297443120ce6bbb739df72fedceaa682e6dcbc1192a5','[\"*\"]','2024-11-03 11:03:14',NULL,'2024-11-03 11:01:19','2024-11-03 11:03:14'),(274,'App\\Models\\User',2,'laravel','727e83e591eab8e23b25e60b72620d5c95b05686fbdd4416716da073d29bb337','[\"*\"]','2024-11-03 11:04:40',NULL,'2024-11-03 11:04:39','2024-11-03 11:04:40'),(275,'App\\Models\\User',2,'laravel','56a3950fbadd58f26174e2ca1d344979fe00ba80cf3367efa4dd8f46e0b30330','[\"*\"]','2024-11-03 11:05:07',NULL,'2024-11-03 11:05:06','2024-11-03 11:05:07'),(276,'App\\Models\\User',2,'laravel','39c129d05e31060ddbdbfa9057b91a333e65c02e8805d7ed295b9446af27eedb','[\"*\"]','2024-11-03 11:13:32',NULL,'2024-11-03 11:05:30','2024-11-03 11:13:32'),(277,'App\\Models\\User',21,'laravel','ea820e24fa1f2a3aa58d3aab3d007ac996bc5652f67ece3540dd0b5ba3811206','[\"*\"]','2024-11-03 11:55:33',NULL,'2024-11-03 11:13:59','2024-11-03 11:55:33'),(278,'App\\Models\\User',22,'laravel','11d2a145fd45e58ae211483d5b51a0cdaea738baacb8164ac0f7f20a1e6bf33f','[\"*\"]',NULL,NULL,'2024-11-03 11:56:40','2024-11-03 11:56:40'),(279,'App\\Models\\User',2,'laravel','3c5a53331f634a827256761d79541368e22dd56e4d9d99bfa75e6bbaa5aad43b','[\"*\"]','2024-11-03 12:01:08',NULL,'2024-11-03 11:58:18','2024-11-03 12:01:08'),(280,'App\\Models\\User',2,'laravel','c9a82540d2a1437970c02bbc19a7af6b3d13603e5c0495b9128a5e1bd00abba2','[\"*\"]','2024-11-03 12:17:03',NULL,'2024-11-03 12:01:43','2024-11-03 12:17:03'),(281,'App\\Models\\User',22,'laravel','9ca9684daa3dc7ec4bb761c95d9ee0ef4cd7c4a07ec6b36a97fa981c360a2bba','[\"*\"]','2024-11-03 12:18:07',NULL,'2024-11-03 12:18:02','2024-11-03 12:18:07'),(282,'App\\Models\\User',22,'laravel','7c2d2f76786d7b347c47184c726e4dbc1e15a723075f5efcb93a4cdd4f7b0a74','[\"*\"]','2024-11-03 12:18:07',NULL,'2024-11-03 12:18:05','2024-11-03 12:18:07'),(283,'App\\Models\\User',22,'laravel','71e924c998f5a26c0b1e5b2a718a045f5599836537fb9f92cc7b6df1e1cff6bc','[\"*\"]','2024-11-03 12:21:29',NULL,'2024-11-03 12:18:15','2024-11-03 12:21:29'),(284,'App\\Models\\User',23,'laravel','c31b25425c872802c0236543e86dc165f889ef5dada406a0c7beb7c2c505fbe2','[\"*\"]',NULL,NULL,'2024-11-03 13:23:19','2024-11-03 13:23:19'),(285,'App\\Models\\User',2,'laravel','e297d8f496cea2e26da8c82c770aac3248fc0847193a7ec35e75e9804eb18f05','[\"*\"]','2024-11-03 13:24:00',NULL,'2024-11-03 13:23:48','2024-11-03 13:24:00'),(286,'App\\Models\\User',23,'laravel','c4e1bcaf6a8072e5b98d01b1b9184167f74eb3fe173fa462252bc8f984c045e6','[\"*\"]','2024-11-03 13:26:58',NULL,'2024-11-03 13:24:16','2024-11-03 13:26:58'),(287,'App\\Models\\User',24,'laravel','575fe52bffec59b897fb45d2cc592541786a7f0b6166364a97b25a054d6c8bee','[\"*\"]',NULL,NULL,'2024-11-03 13:29:00','2024-11-03 13:29:00'),(288,'App\\Models\\User',2,'laravel','85dc1708852f893eda6fb025cf007fb587ff967734b96061bb0b413ac84d43db','[\"*\"]','2024-11-03 13:29:33',NULL,'2024-11-03 13:29:23','2024-11-03 13:29:33'),(289,'App\\Models\\User',24,'laravel','bcf6937a8782dee4e866a63897fe4bb3803861c4c66e97a30365e8f408883b20','[\"*\"]','2024-11-04 02:44:43',NULL,'2024-11-03 13:29:48','2024-11-04 02:44:43'),(290,'App\\Models\\User',2,'laravel','e3b0a94d5e2073f7ad473dcdd92d0b24ae202ae2e6f0a39057b5520e91051c32','[\"*\"]','2024-11-04 03:36:03',NULL,'2024-11-04 02:44:54','2024-11-04 03:36:03'),(291,'App\\Models\\User',13,'laravel','70837d7f84be6461094e6785b42a8d50481d3abf97d486e9fc66d0fb3bf77b96','[\"*\"]','2024-11-04 04:00:05',NULL,'2024-11-04 03:40:31','2024-11-04 04:00:05'),(292,'App\\Models\\User',1,'laravel','d994b695a25991e1d50b0f3e118ac55c60b55e7ceba896473c429624b38557f7','[\"*\"]','2024-11-04 04:04:36',NULL,'2024-11-04 04:02:32','2024-11-04 04:04:36'),(293,'App\\Models\\User',24,'laravel','d2449f57efdd393b6dfc0087f15bf96be888226e40992f88fd253273c846ed5a','[\"*\"]','2024-11-04 04:18:07',NULL,'2024-11-04 04:10:03','2024-11-04 04:18:07'),(294,'App\\Models\\User',24,'laravel','03d3c6d319eb58a4caf71d83e6c9f895e178cad554a735bfc203da5a75f54d9c','[\"*\"]','2024-11-04 04:19:02',NULL,'2024-11-04 04:18:53','2024-11-04 04:19:02'),(295,'App\\Models\\User',14,'laravel','10b1bba2d43575af7be48f6b704e6877533afd14abc9b12e3de5a32710762742','[\"*\"]','2024-11-04 04:20:48',NULL,'2024-11-04 04:19:26','2024-11-04 04:20:48'),(296,'App\\Models\\User',24,'laravel','ca9b982e685ab0688f373c997ce08a50b0a5e30e7a723fbb9a7fe9d661611fe1','[\"*\"]','2024-11-04 04:22:40',NULL,'2024-11-04 04:20:54','2024-11-04 04:22:40'),(297,'App\\Models\\User',24,'laravel','0f2aa2c1c65829170af24948b7e7a669abbb6a7cd803adc068f4c292a893cae9','[\"*\"]','2024-11-04 04:23:12',NULL,'2024-11-04 04:23:11','2024-11-04 04:23:12'),(298,'App\\Models\\User',24,'laravel','1defbaa4a94cbc12281299fcd29fd3b469ac7c1529079d9a539fe59ee8b4798a','[\"*\"]','2024-11-04 04:25:20',NULL,'2024-11-04 04:24:32','2024-11-04 04:25:20'),(299,'App\\Models\\User',24,'laravel','7a862cfa3d3b15029fda941d1d328dd854dbdbfbae3b7d8bf0cfa413964463a2','[\"*\"]','2024-11-04 04:25:29',NULL,'2024-11-04 04:25:28','2024-11-04 04:25:29'),(300,'App\\Models\\User',24,'laravel','03402b328b590639d53a44a9077f526cafd8ce5137a66a211e79873b1bcf594d','[\"*\"]','2024-11-04 04:26:50',NULL,'2024-11-04 04:26:35','2024-11-04 04:26:50'),(301,'App\\Models\\User',24,'laravel','9b566cdc80d406c8f4b503aa8c4d1f7121bd760f09aef8adbfea6b5df0bb28cd','[\"*\"]','2024-11-04 04:35:43',NULL,'2024-11-04 04:28:06','2024-11-04 04:35:43'),(302,'App\\Models\\User',13,'laravel','736175119fd220f5eeb48905ad1457823b7cff9e2ed4901b1573496c4e717e77','[\"*\"]','2024-11-04 04:35:58',NULL,'2024-11-04 04:35:49','2024-11-04 04:35:58'),(303,'App\\Models\\User',24,'laravel','6bcd3a128d7a254ceaa21ae4aa259de8d3b9487990434e419bae18f26734ff33','[\"*\"]','2024-11-04 04:37:19',NULL,'2024-11-04 04:36:05','2024-11-04 04:37:19'),(304,'App\\Models\\User',24,'laravel','d401949eccbe2af5fcb17de53ef7b6003cdd75eb79a31deffa2bd7f40827a94f','[\"*\"]','2024-11-04 04:40:18',NULL,'2024-11-04 04:37:35','2024-11-04 04:40:18'),(305,'App\\Models\\User',24,'laravel','6938746af483d3470e7b4d9aaf84e83c4b7853ed6a37d79368dbfc11874a26f7','[\"*\"]','2024-11-04 04:40:35',NULL,'2024-11-04 04:40:23','2024-11-04 04:40:35'),(306,'App\\Models\\User',15,'laravel','e32748056b95cdcd7f9647f900329bb92fef5bdba4327a00b8c216f68420315b','[\"*\"]','2024-11-04 04:43:08',NULL,'2024-11-04 04:43:00','2024-11-04 04:43:08'),(307,'App\\Models\\User',15,'laravel','4b9d5673335f961cd28ec38279ca27d06605842b60592f1f26d5b1a05d710111','[\"*\"]','2024-11-04 04:44:52',NULL,'2024-11-04 04:44:14','2024-11-04 04:44:52'),(308,'App\\Models\\User',1,'laravel','6361b5c69da18364aa9406796c4e935c9e157f61ca495705c1b20bac7fc7f537','[\"*\"]','2024-11-04 04:45:23',NULL,'2024-11-04 04:45:22','2024-11-04 04:45:23'),(309,'App\\Models\\User',13,'laravel','de480b01af8cd8cd2d25a30ab83eed0a9eb720eec1dbecf38de1b97147dc12c5','[\"*\"]','2024-11-04 04:45:48',NULL,'2024-11-04 04:45:47','2024-11-04 04:45:48'),(310,'App\\Models\\User',1,'laravel','1f5201576ca23dbd6b1fa555f98154c164e1bd5b0bcde652cd1a40436e7d2e51','[\"*\"]','2024-11-04 04:45:59',NULL,'2024-11-04 04:45:58','2024-11-04 04:45:59'),(311,'App\\Models\\User',23,'laravel','85bd4a46e24aa66ecd14b4c01bb1dc8c1a27b25403dd27a42bdf5b98c3c02380','[\"*\"]','2024-11-04 04:47:25',NULL,'2024-11-04 04:47:24','2024-11-04 04:47:25'),(312,'App\\Models\\User',22,'laravel','488012414c249146571efbcd1b4a7666af36d934f55ba64ccb450db2cbb3b332','[\"*\"]','2024-11-04 05:11:48',NULL,'2024-11-04 04:48:27','2024-11-04 05:11:48'),(313,'App\\Models\\User',24,'laravel','ce56b6aeb0042cdf956dd00e9ef177181b2a8255a33b5625b45f391ba1c6d7d5','[\"*\"]','2024-11-04 05:12:18',NULL,'2024-11-04 05:12:10','2024-11-04 05:12:18'),(314,'App\\Models\\User',1,'laravel','6fb89cb90585fed692d01ff4f708188f06b7e9f2dbcb02cbd9a61e1eaecae57d','[\"*\"]','2024-11-04 05:16:16',NULL,'2024-11-04 05:12:36','2024-11-04 05:16:16'),(315,'App\\Models\\User',1,'laravel','ae41985a8b57afda969f105b077156b14673c353b80659d46147a9de42b5b84f','[\"*\"]','2024-11-04 05:22:39',NULL,'2024-11-04 05:22:38','2024-11-04 05:22:39'),(316,'App\\Models\\User',24,'laravel','9bf725888d0471ad971a9a9d324e24ad4f9aef14f5b37d58fe40d41def2095b8','[\"*\"]','2024-11-04 05:28:47',NULL,'2024-11-04 05:28:42','2024-11-04 05:28:47'),(317,'App\\Models\\User',24,'laravel','212c4006ecdf89e69d706454102ad04bc532ec8bf8ad21d84750ff3e81af8a77','[\"*\"]','2024-11-04 05:50:35',NULL,'2024-11-04 05:50:24','2024-11-04 05:50:35'),(318,'App\\Models\\User',1,'laravel','0d1b6f10424a6a740f01e9c8b499b2f6180abafb0a1a867869f5735b88d3240c','[\"*\"]','2024-11-04 08:30:50',NULL,'2024-11-04 05:50:42','2024-11-04 08:30:50'),(319,'App\\Models\\User',24,'laravel','88a7a1fe92aa47fce6ede4a9e1bf624ba8d0530d2664a64fb26edcb99564351c','[\"*\"]','2024-11-04 08:34:34',NULL,'2024-11-04 08:34:18','2024-11-04 08:34:34'),(320,'App\\Models\\User',1,'laravel','649ff7b97ff3f1de0709e4ad7f2c503ff0ec8f9329615877c7d1a9e53c2ace81','[\"*\"]','2024-11-04 08:35:20',NULL,'2024-11-04 08:34:40','2024-11-04 08:35:20'),(321,'App\\Models\\User',14,'laravel','532ee249762a6c199198fbe889c9943121b3be45830fef6d0500ca319287ccb0','[\"*\"]','2024-11-04 08:36:04',NULL,'2024-11-04 08:35:55','2024-11-04 08:36:04'),(322,'App\\Models\\User',15,'laravel','9f02e5cb5a71947e91fbce2ecd429426a3b217f410c77e709c8ac6e25dbc15c7','[\"*\"]','2024-11-04 08:38:20',NULL,'2024-11-04 08:36:17','2024-11-04 08:38:20'),(323,'App\\Models\\User',24,'laravel','a9294ce1baf5d5e282c55070e3bda2fb69a4482077adb6260379e4afecc9dcb0','[\"*\"]','2024-11-04 08:39:53',NULL,'2024-11-04 08:39:35','2024-11-04 08:39:53'),(324,'App\\Models\\User',15,'laravel','7c302c7fba42916a7db3f8de4743eceaf186971ea553ef449df1554de1716254','[\"*\"]','2024-11-04 08:44:00',NULL,'2024-11-04 08:40:09','2024-11-04 08:44:00'),(325,'App\\Models\\User',2,'laravel','eb0bf1d79dd6d288e0a0695f598ea49cc6b3bc44d45610ce34de5eed9d98f4a7','[\"*\"]','2024-11-04 08:44:27',NULL,'2024-11-04 08:44:12','2024-11-04 08:44:27'),(326,'App\\Models\\User',15,'laravel','5df08fe01815a6898dceef26bf37b3899e046d174687e928ebbb1b0e6bcd6d24','[\"*\"]','2024-11-04 08:44:56',NULL,'2024-11-04 08:44:40','2024-11-04 08:44:56'),(327,'App\\Models\\User',23,'laravel','7b3e7414237519ae68b9a50df3cceca679152d48c61c8a016c5a8de482fb55c4','[\"*\"]','2024-11-04 08:45:40',NULL,'2024-11-04 08:45:11','2024-11-04 08:45:40'),(328,'App\\Models\\User',23,'laravel','d788bf54aeba0a137d05d49d1793a50d90e969d66f0fc226d08399430e75412d','[\"*\"]','2024-11-04 09:05:52',NULL,'2024-11-04 08:48:32','2024-11-04 09:05:52'),(329,'App\\Models\\User',23,'laravel','9e50f6b2487dcb6bb015fa8fc9a138450119f5a05743328e2b65daf5552261bb','[\"*\"]','2024-11-04 09:06:09',NULL,'2024-11-04 09:06:05','2024-11-04 09:06:09'),(330,'App\\Models\\User',23,'laravel','e6a76d14695a153ff19c82039c9e0ed065fbd6831802b8bf1dd5fe28e04f5cae','[\"*\"]','2024-11-04 09:12:16',NULL,'2024-11-04 09:06:08','2024-11-04 09:12:16'),(331,'App\\Models\\User',15,'laravel','ab934946552c4dd1080ecce1fd83dfad42993b105d9490ee2b850e6ff7312b42','[\"*\"]','2024-11-04 09:41:30',NULL,'2024-11-04 09:41:13','2024-11-04 09:41:30'),(332,'App\\Models\\User',23,'laravel','a2cffbf7a875c4daf3d6f410f248c5400e4da592d26ce98264cf47cc8b358ad6','[\"*\"]','2024-11-04 09:48:33',NULL,'2024-11-04 09:41:44','2024-11-04 09:48:33'),(333,'App\\Models\\User',2,'laravel','5813c40c821151fe3953852ca84390909fa96e091601e14dde05e0be0e233683','[\"*\"]','2024-11-04 09:48:40',NULL,'2024-11-04 09:48:39','2024-11-04 09:48:40'),(334,'App\\Models\\User',23,'laravel','5e1f3655e5c674e0c23c0eeecc91b9eac428df8674154a98ebcc40969e8e0417','[\"*\"]','2024-11-04 09:48:57',NULL,'2024-11-04 09:48:55','2024-11-04 09:48:57'),(335,'App\\Models\\User',15,'laravel','12d756c143c5adf434f93c9106507bf0948da30429cabe298e8eed233436bba3','[\"*\"]','2024-11-04 09:51:24',NULL,'2024-11-04 09:49:14','2024-11-04 09:51:24'),(336,'App\\Models\\User',24,'laravel','800e45c15a0dc8e1349a6f534aa4e72ffc0cb7885772ef2a98efe7ceeebbf8ec','[\"*\"]','2024-11-04 09:51:30',NULL,'2024-11-04 09:51:29','2024-11-04 09:51:30'),(337,'App\\Models\\User',24,'laravel','c6e098437c53c54e211a7314a16ba9c84ab9fd522b36ffba6eee6f5a2db449a4','[\"*\"]','2024-11-04 09:52:36',NULL,'2024-11-04 09:52:25','2024-11-04 09:52:36'),(338,'App\\Models\\User',2,'laravel','fb1d7460fcee7502beb4af8878dccccafe8d7cc8607bd0e73bcde4eb4abc4982','[\"*\"]',NULL,NULL,'2024-11-04 09:52:55','2024-11-04 09:52:55'),(339,'App\\Models\\User',2,'laravel','26755b7e723784fab939718b49949e500a6fc581da3fdb55e120b167d26cd1c7','[\"*\"]','2024-11-04 09:57:52',NULL,'2024-11-04 09:53:09','2024-11-04 09:57:52'),(340,'App\\Models\\User',1,'laravel','b5f3e5c2f38263e58cf32602937150646937f5e06525d765d37e48ef48fe0f5c','[\"*\"]','2024-11-04 10:01:37',NULL,'2024-11-04 10:01:35','2024-11-04 10:01:37'),(341,'App\\Models\\User',24,'laravel','36bf220efd3c285725bd6e1ac55f29804c42786f9da0d4a544e7be4bf0d5bbf9','[\"*\"]','2024-11-04 10:30:55',NULL,'2024-11-04 10:03:58','2024-11-04 10:30:55'),(342,'App\\Models\\User',2,'laravel','f1074d73a6c1cc6b01d1873cfbf1f9747b95a20ccd62b506c1aa96105ca3319b','[\"*\"]','2024-11-04 10:10:53',NULL,'2024-11-04 10:10:52','2024-11-04 10:10:53'),(343,'App\\Models\\User',2,'laravel','0130307a9cee984e91e8b39e0eec4c08b54d295671db456df7215d0ca4b19a66','[\"*\"]','2024-11-04 10:13:01',NULL,'2024-11-04 10:13:00','2024-11-04 10:13:01'),(344,'App\\Models\\User',2,'laravel','22454f3a1fdff801b51adeb7e486981d4682c7b80904b16a3f6a1736e1b9cfad','[\"*\"]',NULL,NULL,'2024-11-04 10:24:59','2024-11-04 10:24:59'),(345,'App\\Models\\User',2,'laravel','e2cc31b7655929f5b2942c31c94669dd5aca2874c4a40711ebd97aa76e840adf','[\"*\"]','2024-11-04 10:25:23',NULL,'2024-11-04 10:25:07','2024-11-04 10:25:23'),(346,'App\\Models\\User',24,'laravel','355f78bb1bd35a1202bb72b1e340b42081599a6455008551a779b5c845f83ac5','[\"*\"]','2024-11-04 10:29:07',NULL,'2024-11-04 10:26:55','2024-11-04 10:29:07'),(347,'App\\Models\\User',15,'laravel','057e173b212c2b1a3b3be74ea76bf64bafb66e773d1c18775731940789b061e5','[\"*\"]','2024-11-04 11:39:08',NULL,'2024-11-04 10:31:37','2024-11-04 11:39:08'),(348,'App\\Models\\User',2,'laravel','b0b9313b5fbad95d43758a0e479ba0072723c51d8b0eb2bb78b02e40a4248a8d','[\"*\"]','2024-11-04 11:49:50',NULL,'2024-11-04 11:48:54','2024-11-04 11:49:50'),(349,'App\\Models\\User',1,'laravel','d9584bba7bcff996ee632a6c31a822d8db418cfe5bc19685eb4168b11ff2a95a','[\"*\"]','2024-11-04 12:43:31',NULL,'2024-11-04 11:50:29','2024-11-04 12:43:31'),(350,'App\\Models\\User',1,'laravel','a4e3551c6d30ffe165dd766e4d55c7c914d0ce57ea899f14d8805f76638a430c','[\"*\"]','2024-11-04 12:47:34',NULL,'2024-11-04 12:43:41','2024-11-04 12:47:34'),(351,'App\\Models\\User',24,'laravel','f77017f5dc1795dd8c61fc0f9d94a057a402cd71c6eb870ce778af43fa0b6644','[\"*\"]','2024-11-04 12:47:54',NULL,'2024-11-04 12:47:42','2024-11-04 12:47:54'),(352,'App\\Models\\User',2,'laravel','40bec11d0d1811b93ea7f54db5b8d205e453531334c1e2dca61878f2ee1c6a16','[\"*\"]','2024-11-04 12:58:03',NULL,'2024-11-04 12:48:05','2024-11-04 12:58:03'),(353,'App\\Models\\User',24,'laravel','47d0ab9c12112089a5e7efad9eacd446a3b03a5a673079a3141a412129c02df9','[\"*\"]','2024-11-04 13:08:27',NULL,'2024-11-04 13:08:26','2024-11-04 13:08:27'),(354,'App\\Models\\User',2,'laravel','9ab6eddc8b8ae3216c36ee09920c7fbaaf06510d840ba048452f5b28e6f0d614','[\"*\"]','2024-11-04 13:24:08',NULL,'2024-11-04 13:08:33','2024-11-04 13:24:08'),(355,'App\\Models\\User',24,'laravel','19a4f7dd79cacd31927584807f68ad6a0027970310a54c42ca05f53757be1088','[\"*\"]','2024-11-04 13:24:24',NULL,'2024-11-04 13:24:21','2024-11-04 13:24:24'),(356,'App\\Models\\User',24,'laravel','890f4a4865b90dbeeb2dff65edda419e0350c8c0d634f9ef70eab68d810078c7','[\"*\"]','2024-11-04 13:26:07',NULL,'2024-11-04 13:24:23','2024-11-04 13:26:07'),(357,'App\\Models\\User',2,'laravel','98191d6f8434201405b4a2df1c7bda912ac4b2562eae78383d8ee03a5aaf62da','[\"*\"]','2024-11-04 13:31:20',NULL,'2024-11-04 13:26:14','2024-11-04 13:31:20'),(358,'App\\Models\\User',24,'laravel','6579883ac96dc27c060a066315b6daf500ebca83edd4df52cfdc2da62cd072dd','[\"*\"]','2024-11-04 13:31:32',NULL,'2024-11-04 13:31:31','2024-11-04 13:31:32'),(359,'App\\Models\\User',2,'laravel','61a7febbeba7a9a04dd363ddafc93ce6e0a676c741c870c13b93764b959cf623','[\"*\"]','2024-11-04 13:32:28',NULL,'2024-11-04 13:32:18','2024-11-04 13:32:28'),(360,'App\\Models\\User',24,'laravel','ecbb4c641657353827f3807f9deb04d5e562a7b98b830dd1d0e3e415be1efff0','[\"*\"]','2024-11-04 13:32:39',NULL,'2024-11-04 13:32:38','2024-11-04 13:32:39'),(361,'App\\Models\\User',2,'laravel','0f921f748691d3bfb1a2726df9ce587e0e03e23ba4baa9829265aa681de8fc98','[\"*\"]','2024-11-04 14:29:10',NULL,'2024-11-04 13:34:52','2024-11-04 14:29:10'),(362,'App\\Models\\User',2,'laravel','ad7ed66faadf6405306cd3ea177a77511b7b71bdb4a6157cbefa19c8e77be05f','[\"*\"]','2024-11-04 15:16:19',NULL,'2024-11-04 14:32:39','2024-11-04 15:16:19'),(363,'App\\Models\\User',2,'laravel','c3cf39ba82304ab1a4a161f9decaf2bc8492b777d23e20011e053a09ec0dee89','[\"*\"]','2024-11-04 15:22:22',NULL,'2024-11-04 15:16:37','2024-11-04 15:22:22'),(364,'App\\Models\\User',2,'laravel','032f7836eba97dc1e15c48a0729f80cd8ddbd9aa1d3fd77d50dac2b42cb7684e','[\"*\"]','2024-11-04 15:57:20',NULL,'2024-11-04 15:56:57','2024-11-04 15:57:20'),(365,'App\\Models\\User',24,'laravel','52ea5475684512db218ff726aa05a9759250cef7f7ee14d136d444bc1a886e24','[\"*\"]','2024-11-04 16:22:53',NULL,'2024-11-04 15:58:27','2024-11-04 16:22:53'),(366,'App\\Models\\User',2,'laravel','3899a02ff7d9dfcb2a7454555afc19bc629cfdbae188e3fb55717641ecc74288','[\"*\"]','2024-11-04 17:02:42',NULL,'2024-11-04 16:22:59','2024-11-04 17:02:42'),(367,'App\\Models\\User',2,'laravel','ee6ea99e9862db94d16283f1778da6df07f480c81679cef29464b02215a89907','[\"*\"]','2024-11-05 04:50:29',NULL,'2024-11-04 17:10:10','2024-11-05 04:50:29'),(368,'App\\Models\\User',24,'laravel','ef49ac1c9fcbdb2ee4b78619dce1be1164a5beda2c6f5674eec7f3891968cbf9','[\"*\"]','2024-11-05 02:16:21',NULL,'2024-11-05 02:16:05','2024-11-05 02:16:21'),(369,'App\\Models\\User',21,'laravel','39d35380620a5bd3f793c9121654e0e4fd726901e87a96e1c696c90d70892d33','[\"*\"]','2024-11-05 02:17:57',NULL,'2024-11-05 02:16:31','2024-11-05 02:17:57'),(370,'App\\Models\\User',21,'laravel','15463618be506cbbd13ce2a31dddbec7adfff7404c99548d40e06f906a6187c9','[\"*\"]','2024-11-05 02:52:06',NULL,'2024-11-05 02:18:08','2024-11-05 02:52:06'),(371,'App\\Models\\User',2,'laravel','ed977127841868e834340dd9530f394b7a0e35dbaea4fe3c0aa8bd52bdb03980','[\"*\"]','2024-11-05 05:22:09',NULL,'2024-11-05 02:52:16','2024-11-05 05:22:09'),(372,'App\\Models\\User',2,'laravel','75043a8c0845fc43db03fcc8bae66c79db047b5d32a0c1534552775a81df9cb1','[\"*\"]','2024-11-05 07:24:06',NULL,'2024-11-05 05:22:15','2024-11-05 07:24:06'),(373,'App\\Models\\User',2,'laravel','026004873e0b2a71cd26c37fef2be9b3c263d957c87cdc29e505bcf81911ac1a','[\"*\"]','2024-11-05 07:34:08',NULL,'2024-11-05 07:24:16','2024-11-05 07:34:08'),(374,'App\\Models\\User',2,'laravel','1f36c5d2effc52cd5cd393b6c0eab799fa42124f0a6ac1812e87aa5ee1f11db9','[\"*\"]','2024-11-05 09:31:15',NULL,'2024-11-05 09:31:06','2024-11-05 09:31:15'),(375,'App\\Models\\User',2,'laravel','e39f5a2b6d566aa4332ea50935f2072992dae09dffb7cf672591f7d58bcffc0b','[\"*\"]','2024-11-05 09:31:15',NULL,'2024-11-05 09:31:11','2024-11-05 09:31:15'),(376,'App\\Models\\User',2,'laravel','8ceda3d0c70462ec32ada8629258c389f81d4c89ac0cdfae7c3b4348708bfdd2','[\"*\"]','2024-11-06 06:30:53',NULL,'2024-11-05 09:31:12','2024-11-06 06:30:53'),(377,'App\\Models\\User',2,'laravel','fca4e56e16907f4ee85abfab293ed6aa3c3aa0627b2c39ad05e6a9e9824f622d','[\"*\"]','2024-11-06 07:19:14',NULL,'2024-11-06 06:31:07','2024-11-06 07:19:14'),(378,'App\\Models\\User',2,'laravel','6bd31538e1c604e4f8f7f86765414022151ee9553297010f1bcad479a4b5fb72','[\"*\"]','2024-11-06 12:07:34',NULL,'2024-11-06 07:23:29','2024-11-06 12:07:34'),(379,'App\\Models\\User',2,'laravel','9a19f30ea19eb07384d453adbd6279199be56df47b6128e65c6d902f5f982abd','[\"*\"]','2024-11-06 10:22:42',NULL,'2024-11-06 07:33:17','2024-11-06 10:22:42'),(380,'App\\Models\\User',2,'laravel','803ad21a94cc17cf84f5bb84adc7e2bc2ccd1743f24d237d9f84a5c829f6ab0c','[\"*\"]','2024-11-06 11:04:31',NULL,'2024-11-06 10:22:53','2024-11-06 11:04:31'),(381,'App\\Models\\User',2,'laravel','b5762d2db0fa40eb9d07a4c51e5386b1eba8fcf71bfffbd558d590b9d5d15256','[\"*\"]','2024-11-06 11:25:38',NULL,'2024-11-06 11:04:40','2024-11-06 11:25:38'),(382,'App\\Models\\User',2,'laravel','42157d6eb2cee8f17198c6d758507568519fe86dd578b515ea72753f4b7d93fb','[\"*\"]',NULL,NULL,'2024-11-06 12:03:51','2024-11-06 12:03:51'),(383,'App\\Models\\User',2,'laravel','166914b4a445f331cdd882b45f4a81f45597339bd1f3bb68881b9b52a160da9f','[\"*\"]','2024-11-06 12:04:02',NULL,'2024-11-06 12:03:55','2024-11-06 12:04:02'),(384,'App\\Models\\User',2,'laravel','d7c304afd4cf4b099909a241a0318db0970778ef37c020f5bdef64b42af2e56e','[\"*\"]','2024-11-06 12:52:55',NULL,'2024-11-06 12:03:57','2024-11-06 12:52:55'),(385,'App\\Models\\User',2,'laravel','46d04512f07373b5a3c647e07f08cd9f796d1fd83b97b91a3337d3fb72edfb87','[\"*\"]','2024-11-06 12:26:51',NULL,'2024-11-06 12:24:31','2024-11-06 12:26:51'),(386,'App\\Models\\User',2,'laravel','b407b45b4322bc1c9a4a608db62b0b98c885d3073efda937a2068f6259c6eba8','[\"*\"]','2024-11-06 13:51:22',NULL,'2024-11-06 12:27:19','2024-11-06 13:51:22'),(387,'App\\Models\\User',2,'laravel','55a7e3a77364508bd74287b85629842d3c8866dd6c5ddcb5dbd3a476aa79d29c','[\"*\"]','2024-11-06 13:59:04',NULL,'2024-11-06 13:51:24','2024-11-06 13:59:04'),(388,'App\\Models\\User',2,'laravel','06942bedea6b7d9ec8253abd4eac59f519cfbf82a327bba43b51ebe4f77e6fbc','[\"*\"]','2024-11-06 13:59:11',NULL,'2024-11-06 13:59:08','2024-11-06 13:59:11'),(389,'App\\Models\\User',2,'laravel','9a14a194d6dfd20f0aa77a4790ed0384654c3c574c7676154108bdb98c731b19','[\"*\"]','2024-11-06 14:03:59',NULL,'2024-11-06 14:03:57','2024-11-06 14:03:59'),(390,'App\\Models\\User',2,'laravel','c5e7bff731b8bbef127414a6bfab4fc82c09a0a3cef238ec6e350c001f7f9c7d','[\"*\"]','2024-11-06 14:06:56',NULL,'2024-11-06 14:05:32','2024-11-06 14:06:56'),(391,'App\\Models\\User',2,'laravel','9cd3e4558cf166d373e2890ec5f5e5015887b007b488d587f0112f7b2937cf64','[\"*\"]','2024-11-06 14:07:38',NULL,'2024-11-06 14:07:01','2024-11-06 14:07:38'),(392,'App\\Models\\User',2,'laravel','c404ef169e5950d1e65a0519cc2b2d00b45658740a3a2cb3dbf9776ea41a2c3f','[\"*\"]','2024-11-06 14:09:27',NULL,'2024-11-06 14:07:44','2024-11-06 14:09:27'),(393,'App\\Models\\User',2,'laravel','fab958305e68376f24dca45f7b0a4b08d5c1f5760f97d22b2a345cd0ae83fe49','[\"*\"]','2024-11-06 14:09:34',NULL,'2024-11-06 14:09:31','2024-11-06 14:09:34'),(394,'App\\Models\\User',2,'laravel','f5b66f53d2de639d8608008830c2de641da0e6b607f6258df5805229b4da3bf4','[\"*\"]',NULL,NULL,'2024-11-06 14:10:10','2024-11-06 14:10:10'),(395,'App\\Models\\User',2,'laravel','936dc5258037ce62f993ede544646523ffcef2d7e9190a5b1f5b9e3b1440762f','[\"*\"]','2024-11-06 14:10:21',NULL,'2024-11-06 14:10:19','2024-11-06 14:10:21'),(396,'App\\Models\\User',2,'laravel','894a0e101c2499c4e4150b552f4c961e86edcbdc718a9549e2d30e13e3e17d0c','[\"*\"]',NULL,NULL,'2024-11-06 14:12:39','2024-11-06 14:12:39'),(397,'App\\Models\\User',2,'laravel','4da34f650acba2cd186744119d257a7014261058057d2817425b6b6dc2e13184','[\"*\"]','2024-11-06 14:13:42',NULL,'2024-11-06 14:12:50','2024-11-06 14:13:42'),(398,'App\\Models\\User',2,'laravel','6692f69c2b788f5007486d9be51f8d24ab5fa052199e3405cf3f47b667e93d08','[\"*\"]','2024-11-06 14:16:07',NULL,'2024-11-06 14:13:48','2024-11-06 14:16:07'),(399,'App\\Models\\User',2,'laravel','81d4f77d157187e0b288c16fea34d48c1496534ba5e2dd71e36dcd5b01c20e3f','[\"*\"]','2024-11-06 14:16:14',NULL,'2024-11-06 14:16:11','2024-11-06 14:16:14'),(400,'App\\Models\\User',2,'laravel','e5663aea831c699b5563dd74dca402b0102a31abde806383682e490140014333','[\"*\"]','2024-11-06 14:19:15',NULL,'2024-11-06 14:19:13','2024-11-06 14:19:15'),(401,'App\\Models\\User',2,'laravel','dcab1ccb2b8e6db8c04341d311890ea14caaf47a339a5a9ef35d1536c3552c3f','[\"*\"]','2024-11-06 14:22:34',NULL,'2024-11-06 14:22:32','2024-11-06 14:22:34'),(402,'App\\Models\\User',2,'laravel','ed898daa72f15ebc2244e0fdb4c96f3fe431d0e87fe587486202bb2e00799dfc','[\"*\"]','2024-11-06 14:27:39',NULL,'2024-11-06 14:27:38','2024-11-06 14:27:39'),(403,'App\\Models\\User',2,'laravel','5b84a28354ab7422c9aa4be6dacb113aaa02ab087bde391ef0f61171749efa28','[\"*\"]','2024-11-06 14:29:37',NULL,'2024-11-06 14:29:34','2024-11-06 14:29:37'),(404,'App\\Models\\User',2,'laravel','45e75214ac329f72b58afae12b1d226204dd47807c8c1752df29519fcd4153a0','[\"*\"]','2024-11-06 14:30:06',NULL,'2024-11-06 14:30:05','2024-11-06 14:30:06'),(405,'App\\Models\\User',2,'laravel','588db3bd24b5072387a6c6b50daabcf197f6b35c8b5bc89c2cda506f17be7d2c','[\"*\"]','2024-11-06 14:31:02',NULL,'2024-11-06 14:31:00','2024-11-06 14:31:02'),(406,'App\\Models\\User',2,'laravel','be040e1b661c559c231e9568171ee8e68b411e4b53947c430536d5dde73d2983','[\"*\"]','2024-11-06 14:31:22',NULL,'2024-11-06 14:31:20','2024-11-06 14:31:22'),(407,'App\\Models\\User',2,'laravel','599af5e5f41cbd82d055717bf535e4b8bd9be0c4781a61d9cbe01410b5db4cd8','[\"*\"]','2024-11-06 14:32:22',NULL,'2024-11-06 14:32:20','2024-11-06 14:32:22'),(408,'App\\Models\\User',2,'laravel','3d4c7bbb4791e1d297f6d43db41a89d3ba7507a76f2e07b21ce6087bbbed0473','[\"*\"]','2024-11-06 14:33:48',NULL,'2024-11-06 14:33:47','2024-11-06 14:33:48'),(409,'App\\Models\\User',2,'laravel','fb9ab441a54308b41fb164f75582d5bca8896332f6568a51945d54616563eb85','[\"*\"]','2024-11-07 03:30:12',NULL,'2024-11-06 14:33:56','2024-11-07 03:30:12'),(410,'App\\Models\\User',2,'laravel','632ab6e0bbfd4583ae019a5918350dbd64728d7a24804fbfa387ec5ff894345b','[\"*\"]','2024-11-07 03:41:19',NULL,'2024-11-07 03:30:18','2024-11-07 03:41:19'),(411,'App\\Models\\User',1,'laravel','769123fd9234ea3fb127613b7289446ae7a2e46197eec34f703b804538798598','[\"*\"]','2024-11-07 03:48:23',NULL,'2024-11-07 03:41:38','2024-11-07 03:48:23'),(412,'App\\Models\\User',1,'laravel','3b11b1fda3432feffe64b33d4e858b13496acd5f304c6f2cce82f69f008aab1d','[\"*\"]','2024-11-07 03:49:47',NULL,'2024-11-07 03:48:32','2024-11-07 03:49:47'),(413,'App\\Models\\User',1,'laravel','031ff1909d5c02d80d9388149d7621b950c4ad6603735a726b4257429168fd25','[\"*\"]','2024-11-07 03:50:58',NULL,'2024-11-07 03:49:52','2024-11-07 03:50:58'),(414,'App\\Models\\User',24,'laravel','553a58c19d3336fff4bec8788bc0f5ac5e097242cd38cc938908a724157c3007','[\"*\"]','2024-11-07 03:51:20',NULL,'2024-11-07 03:51:07','2024-11-07 03:51:20'),(415,'App\\Models\\User',2,'laravel','a7f336ef2cbc92ef1695d0194a50a30d027efeba79bb78407db282f9302e5e52','[\"*\"]','2024-11-07 04:20:12',NULL,'2024-11-07 04:18:11','2024-11-07 04:20:12'),(416,'App\\Models\\User',29,'laravel','b9c13a4c1cc173edaa7c0cc3d9f91dcc9e24cd4e7e9bb2bf784f01c4c0a0fbb4','[\"*\"]','2024-11-07 04:41:35',NULL,'2024-11-07 04:20:25','2024-11-07 04:41:35'),(417,'App\\Models\\User',29,'laravel','f8b363e65d3ba28419705ee7561eaed23df1fd074befc2a70acaa7b90c6b6520','[\"*\"]','2024-11-07 05:23:51',NULL,'2024-11-07 05:02:28','2024-11-07 05:23:51'),(418,'App\\Models\\User',2,'laravel','91b7fb5b8e711a79ae9dfb298ab649deae4f8a1784d56c3432bfda4c34a6c22a','[\"*\"]','2024-11-07 07:53:14',NULL,'2024-11-07 05:24:23','2024-11-07 07:53:14'),(419,'App\\Models\\User',1,'laravel','d21e497c21d90214ac27aab616fe16957e30acb145e3437c611c6ca7059bc852','[\"*\"]','2024-11-07 07:53:45',NULL,'2024-11-07 07:53:24','2024-11-07 07:53:45'),(420,'App\\Models\\User',1,'laravel','885d9365d4ef56654b60020564c5ce42e117768a6ca71f8136493fb92ece157b','[\"*\"]','2024-11-07 09:35:43',NULL,'2024-11-07 07:56:00','2024-11-07 09:35:43');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `room_count` int DEFAULT '1',
  `companions_count` int NOT NULL DEFAULT '0',
  `companions_names` text COLLATE utf8mb4_unicode_ci,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `update_deadline` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservations_user_id_foreign` (`user_id`),
  CONSTRAINT `reservations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (2,1,2,1,'Ali, Sara',0,'2024-11-30 00:00:00','2024-10-25 11:56:46','2024-10-25 11:56:46'),(3,1,2,1,'Ali, Sara',0,'2024-11-30 00:00:00','2024-10-25 11:57:03','2024-10-25 11:57:03'),(4,1,2,1,'Ali, Sara',0,'2024-11-30 00:00:00','2024-10-25 11:58:35','2024-10-25 11:58:35'),(5,1,2,1,'Ali, Sara',0,'2024-11-30 00:00:00','2024-10-30 07:36:34','2024-10-30 07:36:34'),(6,1,2,1,'John Doe',0,'2024-11-30 00:00:00','2024-10-30 07:37:17','2024-10-30 07:37:17'),(7,1,2,1,'John Doe',0,'2024-11-30 00:00:00','2024-10-30 07:37:32','2024-10-30 07:37:32'),(8,1,2,1,'John Doe',0,'2024-11-30 00:00:00','2024-10-30 07:44:14','2024-10-30 07:44:14'),(9,1,2,2,'Jane Doe, John Smith',0,'2024-11-11 00:00:00','2024-10-30 07:47:36','2024-11-04 10:11:32');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_prices`
--

DROP TABLE IF EXISTS `room_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `room_type` enum('Single','Double','Triple') COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `companion_price` decimal(10,2) NOT NULL,
  `early_check_in_price` decimal(10,2) NOT NULL,
  `late_check_out_price` decimal(10,2) NOT NULL,
  `conference_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_prices_conference_id_foreign` (`conference_id`),
  CONSTRAINT `room_prices_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_prices`
--

LOCK TABLES `room_prices` WRITE;
/*!40000 ALTER TABLE `room_prices` DISABLE KEYS */;
INSERT INTO `room_prices` VALUES (1,'Single',100.00,50.00,20.00,30.00,NULL,'2024-10-25 10:05:29','2024-10-25 10:05:29'),(2,'Double',200.00,100.00,40.00,60.00,NULL,'2024-10-25 10:05:29','2024-10-25 10:05:29'),(3,'Triple',300.00,150.00,60.00,90.00,NULL,'2024-10-25 10:05:29','2024-10-25 10:05:29'),(4,'Single',22.00,22.00,22.00,22.00,NULL,'2024-10-25 10:19:18','2024-10-25 10:19:18'),(5,'Double',33.00,33.00,33.00,33.00,NULL,'2024-10-25 10:19:18','2024-10-25 10:19:18'),(6,'Triple',55.00,55.00,55.00,55.00,NULL,'2024-10-25 10:19:18','2024-10-25 10:19:18'),(7,'Single',1.00,1.00,2.00,2.00,NULL,'2024-10-25 10:25:55','2024-10-25 10:25:55'),(8,'Double',3.00,3.00,4.00,4.00,NULL,'2024-10-25 10:25:55','2024-10-25 10:25:55'),(9,'Triple',5.00,5.00,66.00,6.00,NULL,'2024-10-25 10:25:55','2024-10-25 10:25:55'),(10,'Single',5.00,5.00,5.00,5.00,NULL,'2024-10-25 10:27:02','2024-10-25 10:27:02'),(11,'Double',66.00,6.00,6666.00,666.00,NULL,'2024-10-25 10:27:02','2024-10-25 10:27:02'),(12,'Triple',77.00,7.00,7777.00,777.00,NULL,'2024-10-25 10:27:02','2024-10-25 10:27:02'),(13,'Single',2.00,2.00,2.00,2.00,NULL,'2024-10-25 10:29:07','2024-10-25 10:29:07'),(14,'Double',2.00,2.00,2.00,2.00,NULL,'2024-10-25 10:29:07','2024-10-25 10:29:07'),(15,'Triple',2.00,2.00,2.00,2.00,NULL,'2024-10-25 10:29:07','2024-10-25 10:29:07'),(16,'Single',2.00,2.00,2.00,2.00,1,'2024-10-25 10:31:16','2024-10-25 10:31:16'),(17,'Double',2.00,2.00,2.00,2.00,1,'2024-10-25 10:31:16','2024-10-25 10:31:16'),(18,'Triple',2.00,2.00,2.00,2.00,1,'2024-10-25 10:31:16','2024-10-25 10:31:16');
/*!40000 ALTER TABLE `room_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint unsigned NOT NULL,
  `room_type` enum('Single','Double','Triple') COLLATE utf8mb4_unicode_ci NOT NULL,
  `occupant_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `special_requests` text COLLATE utf8mb4_unicode_ci,
  `check_in_date` datetime NOT NULL,
  `check_out_date` datetime NOT NULL,
  `late_check_out` tinyint(1) NOT NULL DEFAULT '0',
  `early_check_in` tinyint(1) NOT NULL DEFAULT '0',
  `total_nights` int NOT NULL,
  `user_type` enum('main','companion') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `cost` decimal(10,2) DEFAULT NULL,
  `additional_cost` decimal(10,2) DEFAULT '0.00',
  `update_deadline` datetime DEFAULT NULL,
  `is_confirmed` tinyint(1) DEFAULT '0',
  `confirmation_message_pdf` text COLLATE utf8mb4_unicode_ci,
  `last_user_update_at` timestamp NULL DEFAULT NULL,
  `last_admin_update_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rooms_reservation_id_foreign` (`reservation_id`),
  CONSTRAINT `rooms_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,4,'Double','Alice Smith','Late check-in','2024-12-01 00:00:00','2024-12-06 00:00:00',0,0,5,'main',0,450.00,50.00,'2024-11-24 14:58:35',0,NULL,'2024-10-30 11:00:30','2024-10-30 11:00:30','2024-10-25 11:58:35','2024-10-30 11:00:30'),(2,4,'Single','Bob Johnson',NULL,'2024-12-01 00:00:00','2024-12-06 00:00:00',0,0,5,'main',0,350.00,20.00,'2024-11-24 14:58:35',0,NULL,'2024-10-30 11:00:30','2024-10-30 11:00:30','2024-10-25 11:58:35','2024-10-30 11:00:30'),(3,5,'Single','John Doe','Late check-in','2024-12-01 00:00:00','2024-12-05 00:00:00',0,0,4,'main',0,200.00,50.00,'2024-11-29 10:36:34',0,NULL,NULL,NULL,'2024-10-30 07:36:34','2024-10-30 07:36:34'),(4,5,'Double','Jane Doe',NULL,'2024-12-01 00:00:00','2024-12-03 00:00:00',0,0,2,'main',0,100.00,0.00,'2024-11-29 10:36:34',0,NULL,NULL,NULL,'2024-10-30 07:36:34','2024-10-30 07:36:34'),(5,6,'Double','Alice Smith',NULL,'2024-12-01 00:00:00','2024-12-05 00:00:00',0,0,4,'main',0,400.00,50.00,'2024-11-29 10:37:17',0,NULL,NULL,NULL,'2024-10-30 07:37:17','2024-10-30 07:37:17'),(6,6,'Single','Bob Johnson',NULL,'2024-12-01 00:00:00','2024-12-05 00:00:00',0,0,4,'main',0,320.00,30.00,'2024-11-29 10:37:17',0,NULL,NULL,NULL,'2024-10-30 07:37:17','2024-10-30 07:37:17'),(7,7,'Double','Alice Smith',NULL,'2024-12-01 00:00:00','2024-12-05 00:00:00',0,0,4,'main',0,400.00,50.00,'2024-11-29 10:37:32',0,NULL,NULL,NULL,'2024-10-30 07:37:32','2024-10-30 07:37:32'),(8,7,'Single','Bob Johnson',NULL,'2024-12-01 00:00:00','2024-12-05 00:00:00',0,0,4,'main',0,320.00,30.00,'2024-11-29 10:37:32',0,NULL,NULL,NULL,'2024-10-30 07:37:32','2024-10-30 07:37:32'),(9,8,'Double','Alice Smith',NULL,'2024-12-01 00:00:00','2024-12-05 00:00:00',0,0,4,'main',0,400.00,50.00,'2024-11-29 10:44:14',0,NULL,NULL,NULL,'2024-10-30 07:44:14','2024-10-30 07:44:14'),(10,8,'Single','Bob Johnson',NULL,'2024-12-01 00:00:00','2024-12-05 00:00:00',0,0,4,'main',0,320.00,30.00,'2024-11-29 10:44:14',0,NULL,NULL,NULL,'2024-10-30 07:44:14','2024-10-30 07:44:14'),(11,9,'Double','Alice Smith',NULL,'2024-12-01 00:00:00','2024-12-06 00:00:00',0,0,5,'main',0,450.00,50.00,'2024-11-29 10:47:36',0,NULL,'2024-11-04 13:11:32','2024-11-04 13:11:32','2024-10-30 07:47:36','2024-11-04 13:11:32'),(12,9,'Single','Bob Johnson',NULL,'2024-12-01 00:00:00','2024-12-06 00:00:00',0,0,5,'main',0,350.00,20.00,'2024-11-29 10:47:36',0,NULL,'2024-11-04 13:11:32','2024-11-04 13:11:32','2024-10-30 07:47:36','2024-11-04 13:11:32');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scientific_papers`
--

DROP TABLE IF EXISTS `scientific_papers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scientific_papers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned NOT NULL,
  `author_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `whatsapp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('under_review','accepted','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'under_review',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scientific_papers_conference_id_foreign` (`conference_id`),
  CONSTRAINT `scientific_papers_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scientific_papers`
--

LOCK TABLES `scientific_papers` WRITE;
/*!40000 ALTER TABLE `scientific_papers` DISABLE KEYS */;
INSERT INTO `scientific_papers` VALUES (1,1,'Dr. John Doe','Professor','johndoe@example.com','+1234567890','+1234567890','USA','American','$2y$12$2cqygJaY.Ox1vOWMKk.amuzoEf0kRHoY/vA80NxU2qfK430T.s2Wq','papers/MPj0Kq3MX3gnYgYA2JoFixYPfc7y2g5eQOgKM60J.pdf','under_review','2024-11-07 06:22:53','2024-11-07 06:22:53'),(2,1,'ayat','aaay','mm@gmail.com','962888888','962777777','[object Object]','jordanian','$2y$12$8BnBqSp/zijKrJvCMQi2cuSnDOGTkcR6bD.QsN1p00t3pY78hE672','papers/aEHhwMy7xwnztJTMSVGz2pWU5Q3AGRIBHHsdy46I.pdf','under_review','2024-11-07 06:53:32','2024-11-07 06:53:32');
/*!40000 ALTER TABLE `scientific_papers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scientific_topics`
--

DROP TABLE IF EXISTS `scientific_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scientific_topics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `speaker_names` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goal` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scientific_topics_conference_id_foreign` (`conference_id`),
  CONSTRAINT `scientific_topics_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scientific_topics`
--

LOCK TABLES `scientific_topics` WRITE;
/*!40000 ALTER TABLE `scientific_topics` DISABLE KEYS */;
INSERT INTO `scientific_topics` VALUES (1,1,'test',NULL,NULL,NULL,'2024-10-21 09:19:22','2024-10-21 09:19:22'),(2,2,'gg',NULL,NULL,NULL,'2024-11-01 06:09:48','2024-11-01 06:09:48'),(3,3,'eee',NULL,NULL,NULL,'2024-11-01 06:16:37','2024-11-01 06:16:37'),(4,4,'eee',NULL,NULL,NULL,'2024-11-01 06:17:09','2024-11-01 06:17:09'),(5,5,'kkkkkkkkk',NULL,NULL,NULL,'2024-11-01 06:45:05','2024-11-01 06:45:05'),(6,6,'yyyy',NULL,NULL,NULL,'2024-11-01 10:27:44','2024-11-01 10:27:44'),(7,7,'oopo',NULL,NULL,NULL,'2024-11-01 10:29:55','2024-11-01 10:29:55'),(8,8,'jjhh',NULL,NULL,NULL,'2024-11-01 10:31:12','2024-11-01 10:31:12'),(9,9,'kkkkkkkk',NULL,NULL,NULL,'2024-11-01 10:40:58','2024-11-01 10:40:58'),(10,10,'uuu',NULL,NULL,NULL,'2024-11-01 10:42:17','2024-11-01 10:42:17'),(11,11,'llllllllll',NULL,NULL,NULL,'2024-11-01 10:43:17','2024-11-01 10:43:17'),(12,12,'rr',NULL,NULL,NULL,'2024-11-04 08:30:49','2024-11-04 08:30:49');
/*!40000 ALTER TABLE `scientific_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('7nMyt5NuAMkp5KOe6JPD5voId5GzwtzlmZbp2AD3',NULL,'127.0.0.1','PostmanRuntime/7.42.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ1V2Yk12UjFYY2FzaHQ3bGh1NDdUVHZWOENnTVRhS0JFV2U2Wm5iNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1730810111);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speakers`
--

DROP TABLE IF EXISTS `speakers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `speakers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `conference_id` bigint unsigned NOT NULL,
  `abstract` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `topics` text COLLATE utf8mb4_unicode_ci,
  `presentation_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `online_participation` tinyint(1) NOT NULL DEFAULT '0',
  `is_online_approved` tinyint(1) NOT NULL DEFAULT '0',
  `accommodation_status` tinyint(1) NOT NULL DEFAULT '0',
  `ticket_status` tinyint(1) NOT NULL DEFAULT '0',
  `dinner_invitation` tinyint(1) NOT NULL DEFAULT '0',
  `airport_pickup` tinyint(1) NOT NULL DEFAULT '0',
  `free_trip` tinyint(1) NOT NULL DEFAULT '0',
  `certificate_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_certificate_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cost_airport_to_hotel` decimal(10,2) DEFAULT NULL,
  `cost_hotel_to_airport` decimal(10,2) DEFAULT NULL,
  `cost_round_trip` decimal(10,2) DEFAULT NULL,
  `room_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nights_covered` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `speakers_user_id_foreign` (`user_id`),
  KEY `speakers_conference_id_foreign` (`conference_id`),
  CONSTRAINT `speakers_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `speakers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speakers`
--

LOCK TABLES `speakers` WRITE;
/*!40000 ALTER TABLE `speakers` DISABLE KEYS */;
INSERT INTO `speakers` VALUES (1,1,1,NULL,NULL,NULL,0,1,0,1,1,1,1,NULL,1,'2024-10-28 07:26:46','2024-10-28 07:26:46',NULL,NULL,NULL,NULL,NULL),(2,2,1,NULL,'[null]',NULL,0,1,0,1,1,1,1,NULL,1,'2024-10-28 07:31:44','2024-11-06 06:46:55',NULL,NULL,NULL,NULL,NULL),(3,11,1,NULL,NULL,NULL,0,1,0,1,1,1,1,NULL,1,'2024-10-28 07:45:42','2024-10-28 07:45:42',NULL,NULL,NULL,NULL,NULL),(4,21,3,'abstracts/447hV6FPDkVdWlL5RQqADliPD9ThyKOfdidiUbnf.pdf','[\"uuuuuuuuu\"]','presentations/6aS8X0bYAclkdpa5hyex37kYlOBpuHPgCxVfoOZu.pptx',1,0,0,1,1,1,1,NULL,1,'2024-10-29 08:36:17','2024-10-29 08:37:29',NULL,NULL,NULL,NULL,NULL),(7,15,3,NULL,NULL,NULL,0,1,0,1,1,1,1,NULL,1,'2024-11-01 13:08:15','2024-11-01 13:08:15',NULL,NULL,NULL,NULL,NULL),(8,29,3,'abstracts/7OSzF26CgmVUgFCGELaHZMdqvkMGhEjITVrXYZZf.pdf','[\"╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º╪º\",\"╪▓╪▓╪▓╪▓╪▓╪▓╪▓╪▓╪▓╪▓╪▓╪▓\"]',NULL,1,1,0,1,1,1,1,NULL,1,'2024-11-07 04:18:23','2024-11-07 04:40:06',NULL,NULL,NULL,NULL,NULL),(9,26,3,NULL,NULL,NULL,0,1,0,1,1,1,1,NULL,1,'2024-11-07 05:27:53','2024-11-07 05:27:53',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `speakers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsors`
--

DROP TABLE IF EXISTS `sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_person` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sponsors_user_id_foreign` (`user_id`),
  CONSTRAINT `sponsors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsors`
--

LOCK TABLES `sponsors` WRITE;
/*!40000 ALTER TABLE `sponsors` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsorship_options`
--

DROP TABLE IF EXISTS `sponsorship_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsorship_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sponsorship_options_conference_id_foreign` (`conference_id`),
  CONSTRAINT `sponsorship_options_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsorship_options`
--

LOCK TABLES `sponsorship_options` WRITE;
/*!40000 ALTER TABLE `sponsorship_options` DISABLE KEYS */;
INSERT INTO `sponsorship_options` VALUES (8,1,'Scientific Book Program','500 printed copies (23 cm ├ù 17 cm) distributed free to VIP guests, delegates, media, and speakers.','USD 1500',NULL,NULL),(9,1,'Website Banner','300 ├ù 300 pixels banner with company logo linked to the sponsorΓÇÖs website.','USD 1000',NULL,NULL),(10,1,'Logo on Floor Plans','Displayed on 2 floor plans at the exhibition entrance and conference exit.','USD 500',NULL,NULL),(11,1,'Delegate Bags','500 bags (for VIP guests, media, and delegates) with printed sponsor logo.','USD 8000',NULL,NULL),(12,1,'Lanyards','500 lanyards distributed to all conference participants with the sponsorΓÇÖs logo.','USD 1500',NULL,NULL),(13,1,'Inserts in Delegate Bags','1 booklet/pen and notebook or 1 flyer per bag for 500 bags.','USD 1000',NULL,NULL),(14,1,'Exclusive Registration Area','Company logo displayed in the registration lounge.','USD 2000',NULL,NULL),(15,1,'USB Flash Drive Sponsorship','Sponsor logo printed on the USB drive.','USD 3500',NULL,NULL),(16,1,'Exhibition Hall','20 banners (1m ├ù 1.80m) placed in the exhibition area.','USD 2000',NULL,NULL),(17,1,'Conference Room Sponsorship','2 sponsor banners in the conference halls next to the stage.','USD 1000',NULL,NULL);
/*!40000 ALTER TABLE `sponsorship_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsorships`
--

DROP TABLE IF EXISTS `sponsorships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsorships` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint unsigned NOT NULL,
  `item` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_sponsors` int NOT NULL,
  `booth_size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booklet_ad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_ad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bags_inserts` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `backdrop_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `non_residential_reg` int NOT NULL,
  `residential_reg` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_sponsorship_options_conference_id_foreign` (`conference_id`),
  CONSTRAINT `conference_sponsorship_options_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsorships`
--

LOCK TABLES `sponsorships` WRITE;
/*!40000 ALTER TABLE `sponsorships` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsorships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourist_sites`
--

DROP TABLE IF EXISTS `tourist_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourist_sites` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `additional_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourist_sites`
--

LOCK TABLES `tourist_sites` WRITE;
/*!40000 ALTER TABLE `tourist_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `tourist_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip_options_participants`
--

DROP TABLE IF EXISTS `trip_options_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip_options_participants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trip_id` bigint unsigned NOT NULL,
  `option_id` bigint unsigned NOT NULL,
  `participant_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_options_participants_trip_id_foreign` (`trip_id`),
  KEY `trip_options_participants_option_id_foreign` (`option_id`),
  KEY `trip_options_participants_participant_id_foreign` (`participant_id`),
  CONSTRAINT `trip_options_participants_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `additional_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_options_participants_participant_id_foreign` FOREIGN KEY (`participant_id`) REFERENCES `trip_participants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_options_participants_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip_options_participants`
--

LOCK TABLES `trip_options_participants` WRITE;
/*!40000 ALTER TABLE `trip_options_participants` DISABLE KEYS */;
INSERT INTO `trip_options_participants` VALUES (29,1,1,237,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(30,1,1,238,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(31,1,1,239,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(32,1,2,237,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(33,1,2,238,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(34,1,2,239,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(35,1,3,237,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(36,1,3,238,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(37,1,3,239,'2024-10-27 07:28:51','2024-10-27 07:28:51'),(38,1,1,240,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(39,1,1,241,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(40,1,1,242,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(41,1,2,240,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(42,1,2,241,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(43,1,2,242,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(44,1,3,240,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(45,1,3,241,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(46,1,3,242,'2024-10-27 07:30:09','2024-10-27 07:30:09'),(47,1,1,243,'2024-10-27 12:20:05','2024-10-27 12:20:05'),(48,1,1,244,'2024-10-27 12:20:05','2024-10-27 12:20:05'),(49,1,1,245,'2024-10-27 12:20:05','2024-10-27 12:20:05'),(50,1,2,243,'2024-10-27 12:20:05','2024-10-27 12:20:05'),(51,1,2,244,'2024-10-27 12:20:05','2024-10-27 12:20:05'),(52,1,2,245,'2024-10-27 12:20:05','2024-10-27 12:20:05'),(53,1,1,246,'2024-10-27 12:33:29','2024-10-27 12:33:29'),(54,1,1,247,'2024-10-27 12:33:29','2024-10-27 12:33:29'),(55,1,1,248,'2024-10-27 12:33:29','2024-10-27 12:33:29'),(56,1,2,246,'2024-10-27 12:33:29','2024-10-27 12:33:29'),(57,1,2,247,'2024-10-27 12:33:29','2024-10-27 12:33:29'),(58,1,2,248,'2024-10-27 12:33:29','2024-10-27 12:33:29'),(59,1,1,249,'2024-10-27 12:33:31','2024-10-27 12:33:31'),(60,1,1,250,'2024-10-27 12:33:31','2024-10-27 12:33:31'),(61,1,1,251,'2024-10-27 12:33:31','2024-10-27 12:33:31'),(62,1,2,249,'2024-10-27 12:33:31','2024-10-27 12:33:31'),(63,1,2,250,'2024-10-27 12:33:31','2024-10-27 12:33:31'),(64,1,2,251,'2024-10-27 12:33:31','2024-10-27 12:33:31'),(65,1,1,252,'2024-10-27 12:39:18','2024-10-27 12:39:18'),(66,1,1,253,'2024-10-27 12:39:18','2024-10-27 12:39:18'),(67,1,2,252,'2024-10-27 12:39:18','2024-10-27 12:39:18'),(68,1,2,253,'2024-10-27 12:39:18','2024-10-27 12:39:18'),(69,1,3,252,'2024-10-27 12:39:18','2024-10-27 12:39:18'),(70,1,3,253,'2024-10-27 12:39:18','2024-10-27 12:39:18'),(71,1,1,254,'2024-10-27 12:40:16','2024-10-27 12:40:16'),(72,1,1,255,'2024-10-27 12:40:16','2024-10-27 12:40:16'),(73,1,2,254,'2024-10-27 12:40:16','2024-10-27 12:40:16'),(74,1,2,255,'2024-10-27 12:40:16','2024-10-27 12:40:16'),(75,1,3,254,'2024-10-27 12:40:16','2024-10-27 12:40:16'),(76,1,3,255,'2024-10-27 12:40:16','2024-10-27 12:40:16'),(77,1,1,256,'2024-10-30 08:32:01','2024-10-30 08:32:01'),(78,1,1,257,'2024-10-30 08:32:01','2024-10-30 08:32:01'),(79,1,1,258,'2024-10-30 08:32:01','2024-10-30 08:32:01'),(80,1,2,256,'2024-10-30 08:32:01','2024-10-30 08:32:01'),(81,1,2,257,'2024-10-30 08:32:01','2024-10-30 08:32:01'),(82,1,2,258,'2024-10-30 08:32:01','2024-10-30 08:32:01'),(86,1,2,262,'2024-10-30 08:59:53','2024-10-30 08:59:53'),(87,1,2,263,'2024-10-30 08:59:53','2024-10-30 08:59:53'),(88,1,2,264,'2024-10-30 08:59:53','2024-10-30 08:59:53'),(89,1,2,265,'2024-10-30 09:00:22','2024-10-30 09:00:22'),(90,1,2,266,'2024-10-30 09:00:22','2024-10-30 09:00:22'),(91,1,2,267,'2024-10-30 09:00:22','2024-10-30 09:00:22'),(107,1,3,259,'2024-10-30 09:04:41','2024-10-30 09:04:41'),(108,1,3,260,'2024-10-30 09:04:41','2024-10-30 09:04:41'),(109,1,3,261,'2024-10-30 09:04:41','2024-10-30 09:04:41');
/*!40000 ALTER TABLE `trip_options_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip_participants`
--

DROP TABLE IF EXISTS `trip_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip_participants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `main_user_id` bigint unsigned DEFAULT NULL,
  `trip_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_companion` tinyint(1) NOT NULL DEFAULT '0',
  `include_accommodation` tinyint(1) NOT NULL DEFAULT '0',
  `accommodation_stars` int DEFAULT NULL,
  `nights_count` int DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_participants_user_id_foreign` (`user_id`),
  KEY `trip_participants_trip_id_foreign` (`trip_id`),
  CONSTRAINT `trip_participants_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip_participants`
--

LOCK TABLES `trip_participants` WRITE;
/*!40000 ALTER TABLE `trip_participants` DISABLE KEYS */;
INSERT INTO `trip_participants` VALUES (1,1,NULL,1,'John Doe','Jordanian','123456789','987654321',0,1,3,2,'2024-10-26','2024-10-28',NULL,NULL),(2,NULL,1,1,'Jane Doe','Jordanian','123456789','987654321',1,1,3,2,'2024-10-26','2024-10-28',NULL,NULL),(3,1,NULL,1,'ayat Doe','Jordanian','123456789','987654321',0,1,5,2,'2024-10-26','2024-10-28',NULL,NULL),(4,NULL,1,1,'hedaya Doe','Jordanian','123456789','987654321',1,1,5,2,'2024-10-26','2024-10-28',NULL,NULL),(5,NULL,1,1,'alaa Doe','Jordanian','123456789','987654321',1,1,5,2,'2024-10-26','2024-10-28',NULL,NULL),(6,7,NULL,1,'John Doe',NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL),(7,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(8,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(9,7,NULL,1,'John Doe',NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL),(10,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(11,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(12,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(13,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(14,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(15,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(16,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(17,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(18,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(19,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(20,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(21,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(22,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(23,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(24,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,1,'2024-10-26','2024-10-27',NULL,NULL),(25,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(26,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(27,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(28,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(29,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(30,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(31,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(32,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(33,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(34,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(35,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(36,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(37,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(38,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(39,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(40,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(41,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(42,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(43,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(44,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(45,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(46,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(47,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(48,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(49,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(50,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(51,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(52,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(53,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(54,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(55,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(56,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(57,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(58,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(59,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(60,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(61,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(62,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(63,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(64,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(65,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(66,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(67,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(68,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(69,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(70,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(71,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(72,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(73,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(74,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(75,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(76,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(77,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(78,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(79,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(80,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(81,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(82,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(83,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(84,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(85,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(86,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(87,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(88,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(89,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(90,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(91,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(92,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(93,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(94,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(95,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(96,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(97,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(98,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(99,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(100,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(101,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(102,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(103,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(104,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(105,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(106,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(107,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(108,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(109,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(110,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(111,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(112,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(113,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(114,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(115,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(116,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(117,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(118,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(119,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(120,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(121,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(122,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(123,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(124,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(125,NULL,7,1,'John Doe','jordanian','321','123',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(126,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(127,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(128,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(129,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(130,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(131,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(132,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(133,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(134,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(135,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(136,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(137,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(138,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(139,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(140,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(141,7,NULL,1,'John Doe','jordanian','321','123',0,0,NULL,NULL,NULL,NULL,NULL,NULL),(142,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(143,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(144,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26',NULL,NULL),(145,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(146,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(147,7,NULL,1,'John Doe','jordanian','321','123',0,1,2,3,'2024-10-24','2024-10-26',NULL,NULL),(148,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(149,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(150,7,NULL,1,'John Doe','jordanian','321','123',0,1,2,3,'2024-10-20','2024-10-26',NULL,NULL),(151,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(152,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(153,7,NULL,1,'John Doe','jordanian','321','123',0,1,2,3,'2024-10-20','2024-10-26',NULL,NULL),(154,NULL,7,1,'John Doe','jordanian','321','123',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(155,NULL,7,1,'John Doe','jordanian','321','123',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(156,7,NULL,1,'John Doe','jordanian','321','123',0,1,2,3,'2024-10-20','2024-10-26',NULL,NULL),(157,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(158,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(159,7,NULL,1,'John Doe','jordanian','321','123',0,1,NULL,3,'2024-10-20','2024-10-26',NULL,NULL),(160,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(161,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(162,7,NULL,1,'John Doe','jordanian','321','123',0,1,NULL,3,'2024-10-20','2024-10-26',NULL,NULL),(163,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(164,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(165,7,NULL,1,'John Doe','jordanian','321','123',0,1,NULL,3,'2024-10-20','2024-10-26',NULL,NULL),(166,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(167,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(168,7,NULL,1,'John Doe','jordanian','321','123',0,1,1,3,'2024-10-20','2024-10-26',NULL,NULL),(169,NULL,7,1,'ayat','afghan','9624555','96245',1,1,4,45,'2024-10-25','2024-11-01',NULL,NULL),(170,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(171,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26',NULL,NULL),(172,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(173,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(174,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26',NULL,NULL),(175,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(176,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(177,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26',NULL,NULL),(178,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(179,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(180,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26',NULL,NULL),(181,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(182,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(183,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26',NULL,NULL),(184,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(185,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(186,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26',NULL,NULL),(187,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(188,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(189,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26',NULL,NULL),(190,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01',NULL,NULL),(191,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26',NULL,NULL),(192,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:00:10','2024-10-27 05:00:10'),(193,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:00:10','2024-10-27 05:00:10'),(194,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:00:10','2024-10-27 05:00:10'),(195,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:00:25','2024-10-27 05:00:25'),(196,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:00:25','2024-10-27 05:00:25'),(197,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:00:25','2024-10-27 05:00:25'),(198,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:01:32','2024-10-27 05:01:32'),(199,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:01:32','2024-10-27 05:01:32'),(200,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:01:32','2024-10-27 05:01:32'),(201,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:02:46','2024-10-27 05:02:46'),(202,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:02:46','2024-10-27 05:02:46'),(203,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:02:46','2024-10-27 05:02:46'),(204,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:05:07','2024-10-27 05:05:07'),(205,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:05:07','2024-10-27 05:05:07'),(206,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:05:07','2024-10-27 05:05:07'),(207,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:07:57','2024-10-27 05:07:57'),(208,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:07:57','2024-10-27 05:07:57'),(209,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:07:57','2024-10-27 05:07:57'),(210,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:09:52','2024-10-27 05:09:52'),(211,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:09:52','2024-10-27 05:09:52'),(212,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:09:52','2024-10-27 05:09:52'),(213,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:13:37','2024-10-27 05:13:37'),(214,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:13:37','2024-10-27 05:13:37'),(215,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:13:37','2024-10-27 05:13:37'),(216,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:16:24','2024-10-27 05:16:24'),(217,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:16:24','2024-10-27 05:16:24'),(218,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:16:24','2024-10-27 05:16:24'),(219,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 05:16:54','2024-10-27 05:16:54'),(220,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 05:16:54','2024-10-27 05:16:54'),(221,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 05:16:54','2024-10-27 05:16:54'),(222,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 06:46:46','2024-10-27 06:46:46'),(223,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 06:46:46','2024-10-27 06:46:46'),(224,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 06:46:46','2024-10-27 06:46:46'),(225,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 06:55:37','2024-10-27 06:55:37'),(226,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 06:55:37','2024-10-27 06:55:37'),(227,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 06:55:37','2024-10-27 06:55:37'),(228,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 06:58:07','2024-10-27 06:58:07'),(229,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 06:58:07','2024-10-27 06:58:07'),(230,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 06:58:07','2024-10-27 06:58:07'),(231,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 06:58:33','2024-10-27 06:58:33'),(232,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 06:58:33','2024-10-27 06:58:33'),(233,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 06:58:33','2024-10-27 06:58:33'),(234,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 07:27:36','2024-10-27 07:27:36'),(235,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 07:27:36','2024-10-27 07:27:36'),(236,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 07:27:36','2024-10-27 07:27:36'),(237,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 07:28:51','2024-10-27 07:28:51'),(238,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 07:28:51','2024-10-27 07:28:51'),(239,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 07:28:51','2024-10-27 07:28:51'),(240,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 07:30:09','2024-10-27 07:30:09'),(241,NULL,7,1,'ayat','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 07:30:09','2024-10-27 07:30:09'),(242,NULL,7,1,'alaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 07:30:09','2024-10-27 07:30:09'),(243,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-27 12:20:05','2024-10-27 12:20:05'),(244,NULL,7,1,'ayatt','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 12:20:05','2024-10-27 12:20:05'),(245,NULL,7,1,'alaaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 12:20:05','2024-10-27 12:20:05'),(246,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,7,'2024-10-24','2024-10-26','2024-10-27 12:33:29','2024-10-27 12:33:29'),(247,NULL,7,1,'ayatt','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 12:33:29','2024-10-27 12:33:29'),(248,NULL,7,1,'alaaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 12:33:29','2024-10-27 12:33:29'),(249,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,7,'2024-10-24','2024-10-26','2024-10-27 12:33:31','2024-10-27 12:33:31'),(250,NULL,7,1,'ayatt','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-27 12:33:31','2024-10-27 12:33:31'),(251,NULL,7,1,'alaaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-27 12:33:31','2024-10-27 12:33:31'),(252,1,NULL,1,'amero','American','1234567890','0987654321',0,1,5,5,'2024-10-08','2024-10-31','2024-10-27 12:39:18','2024-10-27 12:39:18'),(253,NULL,1,1,'ayat','albanian','9627879999','9626697594',1,1,4,4,'2024-10-28','2024-12-12','2024-10-27 12:39:18','2024-10-27 12:39:18'),(254,1,NULL,1,'amero','American','1234567890','0987654321',0,1,5,5,'2024-10-08','2024-10-31','2024-10-27 12:40:16','2024-10-27 12:40:16'),(255,NULL,1,1,'ayat','albanian','9627879999','9626697594',1,1,4,4,'2024-10-28','2024-12-12','2024-10-27 12:40:16','2024-10-27 12:40:16'),(256,7,NULL,1,'John Doe','jordanian','321','123',0,1,5,3,'2024-10-24','2024-10-26','2024-10-30 08:32:01','2024-10-30 08:32:01'),(257,NULL,7,1,'ayatt','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-30 08:32:01','2024-10-30 08:32:01'),(258,NULL,7,1,'alaaa','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-30 08:32:01','2024-10-30 08:32:01'),(259,2,NULL,1,'amero','American','1234567890','0987654321',0,1,2,9,'2024-10-24','2024-10-26','2024-10-30 08:58:25','2024-10-30 09:04:41'),(260,NULL,2,1,'lamaamamaama','afghan','9624555','96245',1,1,5,450,'2024-10-25','2024-11-01','2024-10-30 08:58:25','2024-10-30 09:04:41'),(261,NULL,2,1,'meeeeeeeeeeen','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-30 08:58:25','2024-10-30 09:04:41'),(262,2,NULL,1,'amero','American','1234567890','0987654321',0,1,5,3,'2024-10-24','2024-10-26','2024-10-30 08:59:53','2024-10-30 08:59:53'),(263,NULL,2,1,'yosef','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-30 08:59:53','2024-10-30 08:59:53'),(264,NULL,2,1,'asma','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-30 08:59:53','2024-10-30 08:59:53'),(265,2,NULL,1,'amero','American','1234567890','0987654321',0,1,5,3,'2024-10-24','2024-10-26','2024-10-30 09:00:22','2024-10-30 09:00:22'),(266,NULL,2,1,'yosef','afghan','9624555','96245',1,1,5,45,'2024-10-25','2024-11-01','2024-10-30 09:00:22','2024-10-30 09:00:22'),(267,NULL,2,1,'asma','jordanian','96254444','96245555',1,1,5,5,'2024-10-25','2024-10-26','2024-10-30 09:00:22','2024-10-30 09:00:22');
/*!40000 ALTER TABLE `trip_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trips` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trip_type` enum('private','group') COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `additional_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_5` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_per_person` decimal(10,2) DEFAULT NULL,
  `price_for_two` decimal(10,2) DEFAULT NULL,
  `price_for_three_or_more` decimal(10,2) DEFAULT NULL,
  `available_dates` json DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `inclusions` text COLLATE utf8mb4_unicode_ci,
  `group_price_per_person` decimal(10,2) DEFAULT NULL,
  `group_price_per_speaker` decimal(10,2) DEFAULT NULL,
  `trip_details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trips`
--

LOCK TABLES `trips` WRITE;
/*!40000 ALTER TABLE `trips` DISABLE KEYS */;
INSERT INTO `trips` VALUES (1,'private','My Amazing Trip','This is an amazing trip description.','Additional info about the trip','trip_images/JNoL2N10HV3to3OzYefbna6PFJ2sIqPl0JeEkZsR.jpg','trip_images/ZoFgXXlsjvJU7tgCQ0Uq9jqhFvHpuIefB5WNJazS.jpg','trip_images/molGxNkkbRreRcToJ8soY50UyampYupoRNjihzlA.jpg','trip_images/tqcGXbln9JmwEtLqWLiYpWNMFTu2MjLYjAbJwRCl.jpg','trip_images/matAxRKtfbcyOaA6BdOWprnSP8tYNHqbQIaqX9bJ.jpg',100.00,180.00,250.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-10-26 11:00:23','2024-10-26 11:00:23');
/*!40000 ALTER TABLE `trips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_final_prices`
--

DROP TABLE IF EXISTS `user_final_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_final_prices` (
  `trip_participant_id` bigint unsigned NOT NULL,
  `trip_id` bigint unsigned NOT NULL,
  `final_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`trip_participant_id`,`trip_id`),
  KEY `user_final_prices_trip_id_foreign` (`trip_id`),
  CONSTRAINT `user_final_prices_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_final_prices_trip_participant_id_foreign` FOREIGN KEY (`trip_participant_id`) REFERENCES `trip_participants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_final_prices`
--

LOCK TABLES `user_final_prices` WRITE;
/*!40000 ALTER TABLE `user_final_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_final_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `biography` text COLLATE utf8mb4_unicode_ci,
  `registration_type` enum('speaker','attendance','sponsor','group_registration') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specialization` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_of_residence` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'amero','ayat@gmail.com',NULL,'$2y$12$uMv5GqObtNzSUF4/EVpQzOcqgvp7YOJN0di9lxZxU5tw7bDt3KSpC',0,NULL,'2024-10-21 09:23:15','2024-10-21 09:23:15','images/i2mcP2VAf655O3zqLqPDgCbSjcxpWvv4H9pYMsdT.png','This is a biography','speaker','1234567890','0987654321','Software Developer','American','USA','approved'),(2,'amero','admin@gmail.com',NULL,'$2y$12$IAEhAmGFHg4gUw9avhsGo.u4udz.08k5XmemrzAGgOT9TVS1JceQC',1,NULL,'2024-10-21 09:25:15','2024-10-21 09:25:15','images/bxNZi8ASb4TQAz3O1hn6GIQ8bxuRIwKnG4hfAt3M.png','This is a biography','speaker','1234567890','0987654321','Software Developer','American','USA','approved'),(3,'John Doe','johndoe@example.com',NULL,'$2y$12$UmimXaOA57wFe4DA/6HeReIeXMjVQXrSS/d1bcu96NbHqFNAAQg1u',0,NULL,'2024-10-21 10:15:36','2024-11-03 03:15:25',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved'),(4,'John Doe','m@example.com',NULL,'$2y$12$Lt6RKZRqj/dN.ifg2oohW.I82Ic.TlPAsu3ABlB7Re7g4WcMEbqFq',0,NULL,'2024-10-21 11:09:26','2024-10-21 11:09:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pending'),(5,'John Doe','mf@example.com',NULL,'$2y$12$nyL15Wkz8pjXmgYEBpe61OC.cy7u./u2CjKj2f4TaxpSZ0FAFO5RG',0,NULL,'2024-10-21 12:04:00','2024-10-21 12:04:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pending'),(6,'ayaaa','aya@gmail.com',NULL,'$2y$12$pwLtn1BDisClq9asE9VlieKKXgpHQEbw0IFU9LC0fzISqiavBAcDm',0,NULL,'2024-10-22 10:28:37','2024-10-22 10:28:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pending'),(7,'John Doe','ma@example.com',NULL,'$2y$12$6fHOvFJhBjUMlnMSLeysZOkcVl3qYiAHsSeJdxWSh4/wXD72uYmV.',0,NULL,'2024-10-22 12:48:50','2024-10-22 12:48:50',NULL,NULL,NULL,'321','123','engineer','jordanian',NULL,'pending'),(8,'╪º╪º╪º╪º╪º╪º╪º','jor@GMAIL.COM',NULL,'$2y$12$OXKF1lslTQk3Ibb/GQgliumuJcBaw0YQfCcmzVHpBEcQCvLNWWDdS',0,NULL,'2024-10-22 14:40:33','2024-10-22 14:40:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pending'),(9,'alaa','alaa@alaa.com',NULL,'$2y$12$dVNwKVwkSfkc33Xc9BJCLu8ryztWmqA.Jsps6HKaBUepEKuwwNzI6',0,NULL,'2024-10-28 07:24:45','2024-10-28 07:24:45','images/f3KFEPALjJfWeFj2AF6E7gfWovX5Q03zvibCRRj7.jpg','wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww','speaker','9623333','962444444','engineer','jordanian','jordan','pending'),(10,'mm','m@m.com',NULL,'$2y$12$5aSrBdiSnN.3QbtQkHhcKex9B8uE86kaeXAOAasZtAyi4Sgv5COL2',0,NULL,'2024-10-28 07:42:06','2024-10-28 07:42:06','images/gi7OeGOYLnorETtQKghgmfu1LIXQJYf9LCDCu5qw.jpg','yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy','speaker','962999999','962888888','engineer','jordanian','jordan','approved'),(11,'jjj','hedaya@gmail.com',NULL,'$2y$12$/nUsFTqP8qsiWT51GaJUm.lO.X0Z71oxqH9.7SESTCDltpTGNqw6K',0,NULL,'2024-10-28 07:43:39','2024-10-28 07:43:39','images/pebNrsCxfwaTqtXCCF0ZT6pMvT2IX19nRV8OSXd2.jpg','yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy','speaker','9628888888','9620000000','engineer','jordanian','jordan','approved'),(12,'╪┤╪║','a@gmail.com',NULL,'$2y$12$PD0Ci2T4hlrsob.B.o74auSEzewBPWDDsx.x40vQBTeTGdV4IMona',0,NULL,'2024-10-28 08:28:14','2024-10-28 08:28:14',NULL,NULL,NULL,'9629999999','962999999','engineer','jordanian','jordan','pending'),(13,'ahmad','ahmad@gmail.com',NULL,'$2y$12$uRnoJVxvyS4Grq3BmhxCT.HVfklyPeJfbLS36uH/E2J.6HspfuxI6',0,NULL,'2024-10-28 08:34:46','2024-10-28 08:34:46','images/Ta8ra6lgrQxZdssqBAVpj79JlkD7haVIcm10zFqm.jpg','Passionate Full-Stack Developer and Mechatronics Engineer with expertise in JavaScript, React, and the MERN stack.','speaker','96299999','96299999','engineer','jordanian','jordan','approved'),(14,'ayat','soso@gmail.com',NULL,'$2y$12$cKGAPl8cF/U8whYZ.Jy5UucW5xvP..dN4M2AnYOCh5RYwG4dUwCAy',0,NULL,'2024-10-31 01:39:31','2024-10-31 01:39:31',NULL,NULL,NULL,'962555555','962666666','engineer','albanian','algeria','approved'),(15,'┘ä┘ä┘ä┘ä┘ä┘ä┘ä','ALAA@gmail.com',NULL,'$2y$12$XShfkFo2NCXPvmNJ95aRdOeI9hXAi8pZF2m7lv8ByAA9N7mtB/1wa',0,NULL,'2024-11-01 12:31:12','2024-11-01 13:04:34','images/10XM4EloaydXxRW8CMzxHAp7fAryiTO3mQxEehuf.jpg','yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy','speaker','962666666','962777777','engineer','jordanian','jordan','approved'),(16,'┘ä┘ä┘ä┘ä┘ä┘ä┘ä','ALAAa@gmail.com',NULL,'$2y$12$J2I4AaF7Ac29S0WiTy/2R./RYdb2hmC10FZefOVPgVikocgO9Zg7.',0,NULL,'2024-11-01 12:39:09','2024-11-01 13:03:22','images/Q4Sf1K2ngP2Hr8nwz6pWTbb98E8slCfyjcsqfpbo.jpg','yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy','speaker','962666666','962777777','engineer','jordanian','jordan','approved'),(17,'aaa','alala@gmail.com',NULL,'$2y$12$BEacvPJUyXfS8P8miFtE0eeF4/P0IRtV4FNop70fn4ShmSCN/yk1q',0,NULL,'2024-11-03 02:29:15','2024-11-03 02:29:15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pending'),(18,'aaa','alalaa@gmail.com',NULL,'$2y$12$aDIO2jiGTMz/6iW1MSgHCOPcINOXsDCUUBZTGtBR4wfgvzi1iI9ZO',0,NULL,'2024-11-03 02:31:20','2024-11-03 02:31:20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pending'),(19,'gggg','sabahalmomani7@gmail.com',NULL,'$2y$12$VCxMhkKg/SLWs1HuW6SrKOgaA3LkTniDb/sPa.zsEMNuCMGzuwrMy',0,NULL,'2024-11-03 02:47:25','2024-11-03 06:10:15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved'),(20,'hhhh','toto@gmail.com',NULL,'$2y$12$uCPmbiZEJUTK2jtcRvCj0exZdKNTjp.ZRLSy2kRuad0wSb.VpMDvu',0,NULL,'2024-11-03 08:34:38','2024-11-03 08:34:38',NULL,NULL,'group_registration',NULL,NULL,NULL,NULL,NULL,'pending'),(21,'ayat','ameer@gmail.com',NULL,'$2y$12$J/4HOoVhBn0YAkFvULge4u6ZCvFmMIcQ.LtSdBJ/c9Q6pyyqDM5HK',0,NULL,'2024-11-03 10:52:16','2024-11-03 10:52:16',NULL,NULL,'speaker',NULL,NULL,NULL,NULL,NULL,'approved'),(22,'gg','yy@gmail.com',NULL,'$2y$12$weaskX1KydM5HL1yqZPoUeX9EK2AvRW9/Cx7J0Vr7SN7qHHfXwKUC',0,NULL,'2024-11-03 11:56:40','2024-11-03 12:17:04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved'),(23,'aaa','ll@gmail.com',NULL,'$2y$12$gRvkGOlQ11D6j/3t5BrBtu0vYn3WtQPSdXwgQsPOw.iC8.2XCJjwe',0,NULL,'2024-11-03 13:23:19','2024-11-03 13:24:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved'),(24,'gggg','kk@gmail.com',NULL,'$2y$12$xdY59YoBY9AAbX/ZhgN8ZuXjf5cknXQGI4SmoVfe/Nay0SlJKaqQi',0,NULL,'2024-11-03 13:29:00','2024-11-03 13:29:33',NULL,NULL,'speaker',NULL,NULL,NULL,NULL,NULL,'approved'),(25,'aa','al@gmail.com',NULL,'$2y$12$kQnN2GegqL/SybIUp.7DAOVoFf.UkUfH9NQaxl.YRVByOLT4ju0IW',0,NULL,'2024-11-07 03:54:28','2024-11-07 03:54:28','images/QWwZaNuIzH45wMORQ8GoGyNvaMIKW3byAWngGZs1.jpg','hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii','speaker','962999999','96288888','eng','jordanian','jordan','pending'),(26,'aa','alo@gmail.com',NULL,'$2y$12$j9t2SOmIkvxAInNw8hLTO.7TsP1.lhn1/6QNaSZstAvQMVKY1fCWS',0,NULL,'2024-11-07 03:55:28','2024-11-07 05:27:53','images/wpZRRd3luQjArz6XgKeZUmLPmaAMlQ0ZCwWVr6M6.jpg','hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii','speaker','962999999','96288888','eng','jordanian','jordan','approved'),(27,'aa','alhh@gmail.com',NULL,'$2y$12$FCzxeVyy3y3SzZfqgSVdhO6P4TzqE4HNyP6kdXafIO6zRI9tnkkvW',0,NULL,'2024-11-07 03:56:00','2024-11-07 03:56:00','images/N9jszp9V9fmpOdOsKoDnPfHPK5h22Jy5ij5K4HuT.jpg','hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii','speaker','962999999','96288888','eng','jordanian','jordan','pending'),(28,'ayat','am@gmail.com',NULL,'$2y$12$0vKYtjER2RhsoZMYhBkfJ.nu2hC8.CKRz6B1NID2M5PUh4v5u0W62',0,NULL,'2024-11-07 03:59:22','2024-11-07 03:59:22','images/sSDCjUgZK6NUyqy7qoUOuVCqQpxlDQ2pWtt2Adpq.jpg','ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg','speaker','962777777','962999999','jjjjjj','jordanian','jordan','pending'),(29,'ayat','ampp@gmail.com',NULL,'$2y$12$.Sr85ybjp5pDu9VOxJABnO1MoquVfhsT/j2ancR6U.zvKp4yOLQiq',0,NULL,'2024-11-07 04:17:35','2024-11-07 04:18:23','images/ZHPPvLQ34eYYk7gnYvVh6O1lJleBgjVFp8MSA8r4.jpg','ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg','speaker','962777777','962999999','jjjjjj','jordanian','jordan','approved');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visas`
--

DROP TABLE IF EXISTS `visas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `passport_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `visa_cost` decimal(8,2) NOT NULL DEFAULT '0.00',
  `payment_required` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `visa_updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_at_by_admin` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `visas_user_id_foreign` (`user_id`),
  CONSTRAINT `visas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visas`
--

LOCK TABLES `visas` WRITE;
/*!40000 ALTER TABLE `visas` DISABLE KEYS */;
INSERT INTO `visas` VALUES (20,14,'images/BP7i0fFCtb68c78JFmQCcELE8NtuJPogo52R4sfJ.png','2024-10-23','2024-10-14',0.00,0,'pending',NULL,'2024-10-31 07:39:27','2024-10-31 07:39:27',NULL),(21,11,'images/TgKnqiU78VsxESVTMaIg4K9u7yhfedKatK6n55Om.jpg','2024-10-17','2024-10-08',0.00,0,'pending',NULL,'2024-10-31 07:41:48','2024-10-31 07:41:48',NULL),(22,16,'images/QUaDTUD8kBnLobUVyk5BRjCh20hygtIbvApAW6Vk.png','2024-11-21','2024-11-23',0.00,0,'pending',NULL,'2024-11-01 16:36:12','2024-11-01 16:36:12',NULL),(40,13,'images/NbWhxmoiVVABHUTNsNmtS79gKT1VNJuBgOZAaGwo.jpg','2024-11-02','2024-11-29',555.00,1,'approved','2024-11-02 17:58:12','2024-11-02 14:57:43','2024-11-02 14:58:12','2024-11-02 17:58:12'),(42,24,'images/SCxc4thoD2ywt2NK5tnx91K2WR9jq5OFy9Z4s4jH.jpg','2024-11-13','2024-11-26',0.00,0,'approved','2024-11-07 06:24:20','2024-11-04 13:26:06','2024-11-07 03:24:20','2024-11-07 06:24:20'),(43,1,'images/t3GqQbOSlBvDt420MUuEMUO1lscvYZF6ARrhFmYZ.jpg','2024-11-23','2024-11-21',33.00,1,'pending',NULL,'2024-11-07 03:48:05','2024-11-07 03:48:05',NULL),(44,29,'images/e0Yd9iuprbLRpMFE7hVmDoG9iApozvPmYJSq3Lca.jpg','2024-11-20','2024-11-18',666.00,1,'approved','2024-11-07 08:29:12','2024-11-07 04:40:23','2024-11-07 05:29:12','2024-11-07 08:29:12');
/*!40000 ALTER TABLE `visas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-07 18:08:05
