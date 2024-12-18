-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: laravel11
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
  `accepted_flight_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flight_id` bigint(20) unsigned NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `admin_set_deadline` timestamp NULL DEFAULT NULL,
  `ticket_number` varchar(255) DEFAULT NULL,
  `ticket_image` varchar(255) DEFAULT NULL,
  `issued_at` timestamp NULL DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `isOther` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `is_free` tinyint(1) NOT NULL DEFAULT 0,
  `departure_time` time DEFAULT NULL,
  PRIMARY KEY (`accepted_flight_id`),
  KEY `accepted_flights_flight_id_foreign` (`flight_id`),
  CONSTRAINT `accepted_flights_flight_id_foreign` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accepted_flights`
--

LOCK TABLES `accepted_flights` WRITE;
/*!40000 ALTER TABLE `accepted_flights` DISABLE KEYS */;
/*!40000 ALTER TABLE `accepted_flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `additional_options`
--

DROP TABLE IF EXISTS `additional_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_options` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trip_id` bigint(20) unsigned NOT NULL,
  `option_name` varchar(255) NOT NULL,
  `option_description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `additional_options_trip_id_foreign` (`trip_id`),
  CONSTRAINT `additional_options_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_options`
--

LOCK TABLES `additional_options` WRITE;
/*!40000 ALTER TABLE `additional_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `additional_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport_transfer_bookings`
--

DROP TABLE IF EXISTS `airport_transfer_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport_transfer_bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trip_type` enum('One-way trip from the airport to the hotel','One-way trip from the hotel to the airport','Round trip') NOT NULL DEFAULT 'One-way trip from the airport to the hotel',
  `arrival_date` date NOT NULL,
  `arrival_time` time NOT NULL,
  `departure_date` date DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `flight_number` varchar(255) NOT NULL,
  `companion_name` varchar(255) DEFAULT NULL,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `airport_transfer_bookings_conference_id_foreign` (`conference_id`),
  KEY `airport_transfer_bookings_user_id_foreign` (`user_id`),
  CONSTRAINT `airport_transfer_bookings_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `airport_transfer_bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport_transfer_bookings`
--

LOCK TABLES `airport_transfer_bookings` WRITE;
/*!40000 ALTER TABLE `airport_transfer_bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport_transfer_bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport_transfer_prices`
--

DROP TABLE IF EXISTS `airport_transfer_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport_transfer_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  `from_airport_price` decimal(8,2) DEFAULT NULL,
  `to_airport_price` decimal(8,2) DEFAULT NULL,
  `round_trip_price` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `airport_transfer_prices_conference_id_foreign` (`conference_id`),
  CONSTRAINT `airport_transfer_prices_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport_transfer_prices`
--

LOCK TABLES `airport_transfer_prices` WRITE;
/*!40000 ALTER TABLE `airport_transfer_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport_transfer_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport_transfers_invoices`
--

DROP TABLE IF EXISTS `airport_transfers_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport_transfers_invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `airport_transfer_booking_id` bigint(20) unsigned NOT NULL,
  `total_price` decimal(8,2) NOT NULL,
  `status` enum('pending','paid','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `airport_transfers_invoices_airport_transfer_booking_id_foreign` (`airport_transfer_booking_id`),
  CONSTRAINT `airport_transfers_invoices_airport_transfer_booking_id_foreign` FOREIGN KEY (`airport_transfer_booking_id`) REFERENCES `airport_transfer_bookings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport_transfers_invoices`
--

LOCK TABLES `airport_transfers_invoices` WRITE;
/*!40000 ALTER TABLE `airport_transfers_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport_transfers_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applicant_job`
--

DROP TABLE IF EXISTS `applicant_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applicant_job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `applicant_id` bigint(20) unsigned NOT NULL,
  `job_id` bigint(20) unsigned NOT NULL,
  `status` enum('Pending','Reviewed','Rejected') NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `applicant_job_applicant_id_foreign` (`applicant_id`),
  KEY `applicant_job_job_id_foreign` (`job_id`),
  CONSTRAINT `applicant_job_applicant_id_foreign` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `applicant_job_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `available_jobs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applicant_job`
--

LOCK TABLES `applicant_job` WRITE;
/*!40000 ALTER TABLE `applicant_job` DISABLE KEYS */;
INSERT INTO `applicant_job` VALUES (1,1,1,'Pending','2024-12-08 17:59:28','2024-12-08 17:59:28');
/*!40000 ALTER TABLE `applicant_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applicants`
--

DROP TABLE IF EXISTS `applicants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applicants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `whatsapp_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `home_address` varchar(255) DEFAULT NULL,
  `position_applied_for` varchar(255) NOT NULL,
  `educational_qualification` varchar(255) DEFAULT NULL,
  `resume` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `applicants_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applicants`
--

LOCK TABLES `applicants` WRITE;
/*!40000 ALTER TABLE `applicants` DISABLE KEYS */;
INSERT INTO `applicants` VALUES (1,'Ameer','Ahmad','124556667','078700222','amer2@gmail.com','Jordanian','Amman','Engineer','Engineer','resumes/KEoHLv61w3gd16DaMPpPhbmiBm3M8xkGnINZubCI.pdf','2024-12-08 17:59:27','2024-12-08 17:59:27');
/*!40000 ALTER TABLE `applicants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `conference_id` bigint(20) unsigned NOT NULL,
  `registration_fee` decimal(8,2) DEFAULT NULL,
  `includes_conference_bag` tinyint(1) DEFAULT 1,
  `includes_conference_badge` tinyint(1) DEFAULT 1,
  `includes_conference_book` tinyint(1) DEFAULT 1,
  `includes_certificate` tinyint(1) DEFAULT 1,
  `includes_lecture_attendance` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_user_id_foreign` (`user_id`),
  KEY `attendance_conference_id_foreign` (`conference_id`),
  CONSTRAINT `attendance_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendance_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `available_flights`
--

DROP TABLE IF EXISTS `available_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available_flights` (
  `available_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flight_id` bigint(20) unsigned NOT NULL,
  `departure_date` date NOT NULL,
  `is_free` tinyint(1) NOT NULL DEFAULT 0,
  `departure_time` time NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`available_id`),
  KEY `available_flights_flight_id_foreign` (`flight_id`),
  CONSTRAINT `available_flights_flight_id_foreign` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_flights`
--

LOCK TABLES `available_flights` WRITE;
/*!40000 ALTER TABLE `available_flights` DISABLE KEYS */;
/*!40000 ALTER TABLE `available_flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `available_jobs`
--

DROP TABLE IF EXISTS `available_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `events_coordinator` varchar(255) NOT NULL,
  `responsibilities` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_jobs`
--

LOCK TABLES `available_jobs` WRITE;
/*!40000 ALTER TABLE `available_jobs` DISABLE KEYS */;
INSERT INTO `available_jobs` VALUES (1,'Engineer','The Marketing Manager will be responsible for planning, implementing, and overseeing marketing strategies and campaigns to promote the companyΓÇÖs products or services. This role will involve working closely with cross-functional teams, managing marketing budgets, and analyzing campaign effectiveness to increase brand awareness and customer engagement.','Develop and Execute Marketing Strategies: Create comprehensive marketing strategies to achieve the companyΓÇÖs business objectives, including brand awareness, lead generation, and customer retention.','2024-12-08 17:56:30','2024-12-08 17:56:30');
/*!40000 ALTER TABLE `available_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booth_costs`
--

DROP TABLE IF EXISTS `booth_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booth_costs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  `size` varchar(10) NOT NULL,
  `cost` int(11) NOT NULL,
  `lunch_invitations` int(11) NOT NULL,
  `name_tags` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booth_costs_conference_id_foreign` (`conference_id`),
  CONSTRAINT `booth_costs_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booth_costs`
--

LOCK TABLES `booth_costs` WRITE;
/*!40000 ALTER TABLE `booth_costs` DISABLE KEYS */;
/*!40000 ALTER TABLE `booth_costs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
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
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `committee_image` varchar(255) DEFAULT NULL,
  `conference_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `committee_members_conference_id_foreign` (`conference_id`),
  CONSTRAINT `committee_members_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `committee_members`
--

LOCK TABLES `committee_members` WRITE;
/*!40000 ALTER TABLE `committee_members` DISABLE KEYS */;
INSERT INTO `committee_members` VALUES (2,'test2','committee_images/ZjIM33zKDeTMZPI5L4DpgfIOyXFu9jIsXcu0tMpX.jpg',4,'2024-12-14 23:03:27','2024-12-14 23:03:27'),(3,'test2','committee_images/dXnfTD1IUilJA6BVJwTtLFLUBhi8nzkbH6Op7Trb.jpg',5,'2024-12-14 23:08:22','2024-12-14 23:08:22'),(4,'test3','committee_images/8AxDlKhfgBz9YDLcgLXkf0TMfnFRf2lQQtGNnTUJ.jpg',6,'2024-12-14 23:10:07','2024-12-14 23:10:07');
/*!40000 ALTER TABLE `committee_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference_image`
--

DROP TABLE IF EXISTS `conference_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conference_image` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned NOT NULL,
  `conference_img` varchar(255) DEFAULT NULL,
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned NOT NULL,
  `price_type` varchar(255) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_prices_conference_id_foreign` (`conference_id`),
  CONSTRAINT `conference_prices_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference_prices`
--

LOCK TABLES `conference_prices` WRITE;
/*!40000 ALTER TABLE `conference_prices` DISABLE KEYS */;
INSERT INTO `conference_prices` VALUES (2,5,'test2',770.00,'test2','2024-12-14 23:08:21','2024-12-14 23:08:21'),(3,6,'test3',666.00,'test3','2024-12-14 23:10:07','2024-12-14 23:10:07');
/*!40000 ALTER TABLE `conference_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference_trip`
--

DROP TABLE IF EXISTS `conference_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conference_trip` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned NOT NULL,
  `trip_id` bigint(20) unsigned NOT NULL,
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `conference_id` bigint(20) unsigned NOT NULL,
  `is_visa_payment_required` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_user_user_id_foreign` (`user_id`),
  KEY `conference_user_conference_id_foreign` (`conference_id`),
  CONSTRAINT `conference_user_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conference_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference_user`
--

LOCK TABLES `conference_user` WRITE;
/*!40000 ALTER TABLE `conference_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `conference_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conferences`
--

DROP TABLE IF EXISTS `conferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conferences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `status` enum('upcoming','past') NOT NULL,
  `image` longtext DEFAULT NULL,
  `first_announcement_pdf` varchar(255) DEFAULT NULL,
  `second_announcement_pdf` varchar(255) DEFAULT NULL,
  `conference_brochure_pdf` varchar(255) DEFAULT NULL,
  `conference_scientific_program_pdf` varchar(255) DEFAULT NULL,
  `companion_dinner_price` decimal(8,2) DEFAULT NULL COMMENT 'Price for companion dinner',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `visa_price` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conferences`
--

LOCK TABLES `conferences` WRITE;
/*!40000 ALTER TABLE `conferences` DISABLE KEYS */;
INSERT INTO `conferences` VALUES (4,'test1','test1','2024-12-28','2025-01-09','test1','upcoming','conference_images/I6mVJ13U9plzibpxWChOEQxKcqbZO2l7tdLWoy0i.jpg','conference_announcements/DZNyDEetJbje03j7CVwmCXWbvd22joFho0aN3MGr.pdf','conference_announcements/hWcYNbTdbNa5QSqxbBnSMsJBa8bZNCS5rfGru5q3.pdf','conference_brochures/1hZ3ZieJXpHqIrrs3O4Un2RuIkW9qPAAwGiBIZ9B.pdf','conference_programs/biYalsu5f173PSjxVgq2DHjVMKmmvWDbcrqfswnC.pdf',444.00,'2024-12-15 02:03:27','2024-12-15 02:03:27',555.00),(5,'test2','test2','2024-12-26','2025-01-07','test2','upcoming','conference_images/gaCV2Qbi1Cpbp9ht86k7tTbmXbidZ3uFsz87qu8k.jpg','conference_announcements/TmDKEOgLsk11PBDxaVnYd4laKJd02DtPXcBmYJ3q.pdf','conference_announcements/z3xNHxwmjsxXRhZHvtBUFySBnEX2u5gbpwEXEyvU.pdf','conference_brochures/HVTGldX5Hyvr2YsyOa1Tu0f5fLXp8qPtltrLPGSw.pdf','conference_programs/qAYSCwxcOaJBnL3avNlkNIvPpyNYtbjyvkfRGzLM.pdf',50.00,'2024-12-15 02:08:21','2024-12-15 02:08:21',333.00),(6,'test3','test3','2024-12-24','2025-01-04','test3','upcoming','conference_images/A2fPynoCIWjNtVCcbrF2ck7ZkSd2XAf9nyEmpv7Z.jpg','conference_announcements/plVWNoC3aAULHP9MVMo6xYAJoJEGyMlODkHcyE7u.pdf','conference_announcements/Ld0c8GFxjEHq2HKWNK1wAqOpZVLzkw0pyxPRzZu3.pdf','conference_brochures/b1swaMNmVrl5Uv4QcwzIqpAiSsybaV8xVL7p95Oc.pdf','conference_programs/nCjCFsBLwrtFDlSoCzRI3Y6OvEJQn2KwWXwBBpZp.pdf',60.00,'2024-12-15 02:10:07','2024-12-15 02:10:07',899.00);
/*!40000 ALTER TABLE `conferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dinner_attendees`
--

DROP TABLE IF EXISTS `dinner_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dinner_attendees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `speaker_id` bigint(20) unsigned NOT NULL,
  `companion_name` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT 1,
  `is_companion_fee_applicable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `companion_price` decimal(8,2) DEFAULT NULL,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dinner_attendees_speaker_id_foreign` (`speaker_id`),
  CONSTRAINT `dinner_attendees_speaker_id_foreign` FOREIGN KEY (`speaker_id`) REFERENCES `speakers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dinner_attendees`
--

LOCK TABLES `dinner_attendees` WRITE;
/*!40000 ALTER TABLE `dinner_attendees` DISABLE KEYS */;
/*!40000 ALTER TABLE `dinner_attendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dinner_attendees_invoice`
--

DROP TABLE IF EXISTS `dinner_attendees_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dinner_attendees_invoice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `status` varchar(255) NOT NULL,
  `dinner_attendees_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dinner_attendees_invoice_dinner_attendees_id_foreign` (`dinner_attendees_id`),
  CONSTRAINT `dinner_attendees_invoice_dinner_attendees_id_foreign` FOREIGN KEY (`dinner_attendees_id`) REFERENCES `dinner_attendees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dinner_attendees_invoice`
--

LOCK TABLES `dinner_attendees_invoice` WRITE;
/*!40000 ALTER TABLE `dinner_attendees_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `dinner_attendees_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dinner_details`
--

DROP TABLE IF EXISTS `dinner_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dinner_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned NOT NULL,
  `dinner_date` datetime DEFAULT NULL,
  `restaurant_name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `gathering_place` varchar(255) DEFAULT NULL,
  `transportation_method` varchar(255) DEFAULT NULL,
  `gathering_time` time DEFAULT NULL,
  `dinner_time` time DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `dress_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dinner_details_conference_id_foreign` (`conference_id`),
  CONSTRAINT `dinner_details_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dinner_details`
--

LOCK TABLES `dinner_details` WRITE;
/*!40000 ALTER TABLE `dinner_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `dinner_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dinner_speaker_companion_fees`
--

DROP TABLE IF EXISTS `dinner_speaker_companion_fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dinner_speaker_companion_fees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dinner_id` bigint(20) unsigned NOT NULL,
  `speaker_id` bigint(20) unsigned NOT NULL,
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `trip_id` bigint(20) unsigned NOT NULL,
  `option_id` bigint(20) unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `show_price` tinyint(1) NOT NULL DEFAULT 0,
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `exhibition_id` bigint(20) unsigned NOT NULL,
  `image` varchar(255) NOT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exhibition_images_exhibition_id_foreign` (`exhibition_id`),
  CONSTRAINT `exhibition_images_exhibition_id_foreign` FOREIGN KEY (`exhibition_id`) REFERENCES `exhibitions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibition_images`
--

LOCK TABLES `exhibition_images` WRITE;
/*!40000 ALTER TABLE `exhibition_images` DISABLE KEYS */;
INSERT INTO `exhibition_images` VALUES (6,3,'exhibition_images/wAfRRe0dxuLH2Dzla71dMNSOn4vUmqauOmIXxksM.jpg','default alt text','2024-12-14 23:13:19','2024-12-14 23:13:19','2024-12-14 23:13:19'),(7,3,'exhibition_images/iY9uzT6WbZnmZnjpBxb8AmVDZ5P5PgQzqOe9Kfhg.jpg','default alt text','2024-12-14 23:13:19','2024-12-14 23:13:19','2024-12-14 23:13:19');
/*!40000 ALTER TABLE `exhibition_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exhibitions`
--

DROP TABLE IF EXISTS `exhibitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exhibitions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `status` enum('upcoming','past') NOT NULL DEFAULT 'upcoming',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exhibitions_conference_id_foreign` (`conference_id`),
  CONSTRAINT `exhibitions_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibitions`
--

LOCK TABLES `exhibitions` WRITE;
/*!40000 ALTER TABLE `exhibitions` DISABLE KEYS */;
INSERT INTO `exhibitions` VALUES (2,'International Art Expo','An international exhibition showcasing contemporary art from various artists across the globe. The event features paintings, sculptures, digital art, and more, offering a diverse collection of creative expressions.','Amman','2024-12-01','2024-12-02','exhibition_images/1734187779_exhibitions.jpeg','upcoming','2024-12-10 14:31:23','2024-12-14 22:49:39',NULL),(3,'test3','test3','test3','2024-12-26','2025-01-01','exhibitions/YvmEPR2QCRrVAkhGBeV13sEkkBJvr4FqMWsHJjkP.jpg','upcoming','2024-12-14 23:13:19','2024-12-14 23:13:19',4);
/*!40000 ALTER TABLE `exhibitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
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
  `flight_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `is_companion` tinyint(1) NOT NULL DEFAULT 0,
  `main_user_id` bigint(20) unsigned DEFAULT NULL,
  `passport_image` varchar(255) DEFAULT NULL,
  `departure_airport` varchar(100) NOT NULL,
  `arrival_airport` varchar(100) NOT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date NOT NULL,
  `flight_number` text DEFAULT NULL,
  `seat_preference` varchar(50) DEFAULT NULL,
  `upgrade_class` tinyint(1) NOT NULL DEFAULT 0,
  `ticket_count` int(11) DEFAULT 1,
  `additional_requests` text DEFAULT NULL,
  `passenger_name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `last_speaker_update_at` timestamp NULL DEFAULT NULL,
  `last_admin_update_at` timestamp NULL DEFAULT NULL,
  `business_class_upgrade_cost` decimal(8,2) DEFAULT 0.00,
  `reserved_seat_cost` decimal(8,2) DEFAULT 0.00,
  `additional_baggage_cost` decimal(8,2) DEFAULT 0.00,
  `other_additional_costs` decimal(8,2) DEFAULT 0.00,
  `admin_update_deadline` datetime DEFAULT NULL,
  `is_free` tinyint(1) NOT NULL DEFAULT 0,
  `ticket_number` varchar(255) DEFAULT NULL,
  `is_available_for_download` tinyint(1) NOT NULL DEFAULT 0,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `download_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `specific_flight_time` time DEFAULT NULL,
  `base_ticket_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`flight_id`),
  KEY `flights_user_id_foreign` (`user_id`),
  CONSTRAINT `flights_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,8,0,NULL,NULL,'kk','kkkk','2024-12-14','2024-12-12',NULL,'22',1,1,'kkkkk','ayat',0,NULL,NULL,0.00,0.00,0.00,0.00,NULL,0,NULL,0,NULL,NULL,NULL,'2024-12-11 19:04:38','2024-12-11 16:04:38',NULL,NULL),(2,NULL,1,1,NULL,'kkkkk','jjjj','2024-12-19','2024-12-17',NULL,'66',0,1,'kkkkk','jj',0,NULL,NULL,0.00,0.00,0.00,0.00,NULL,0,NULL,0,NULL,NULL,NULL,'2024-12-11 19:04:41','2024-12-11 16:04:41',NULL,NULL);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_registrations`
--

DROP TABLE IF EXISTS `group_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_registrations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `number_of_doctors` int(11) DEFAULT NULL,
  `excel_file` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `update_deadline` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_registrations_user_id_foreign` (`user_id`),
  KEY `group_registrations_conference_id_foreign` (`conference_id`),
  CONSTRAINT `group_registrations_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE SET NULL,
  CONSTRAINT `group_registrations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_registrations`
--

LOCK TABLES `group_registrations` WRITE;
/*!40000 ALTER TABLE `group_registrations` DISABLE KEYS */;
INSERT INTO `group_registrations` VALUES (1,6,'ayat',22,'excel_files/nw6mbMWKLcCpMIJysEZSgXCFUA80F3EWsqksEY6W.xlsx',1,'2024-12-07 08:00:00','2024-12-08 15:48:54','2024-12-08 15:51:09',NULL,NULL),(2,29,',kkkkkkk',88,NULL,0,NULL,'2024-12-11 19:29:40','2024-12-11 19:29:40',NULL,NULL),(3,34,'┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä',7,NULL,0,NULL,'2024-12-12 00:53:34','2024-12-12 00:53:34',NULL,NULL),(4,35,'ggg',55,NULL,0,NULL,'2024-12-12 01:03:55','2024-12-12 01:03:55',NULL,NULL);
/*!40000 ALTER TABLE `group_registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_trip_participants`
--

DROP TABLE IF EXISTS `group_trip_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_trip_participants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `trip_id` bigint(20) unsigned NOT NULL,
  `selected_date` date NOT NULL,
  `companions_count` int(11) NOT NULL DEFAULT 0,
  `total_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
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
-- Table structure for table `invoice_flights`
--

DROP TABLE IF EXISTS `invoice_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_flights` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_flights`
--

LOCK TABLES `invoice_flights` WRITE;
/*!40000 ALTER TABLE `invoice_flights` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (1,'default','{\"uuid\":\"33a8a729-0ddb-40f1-b8b7-a9a9c1906b48\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733395374,1733395374),(2,'default','{\"uuid\":\"edff8f51-7d6b-420f-9737-7258d700f1d6\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733395374,1733395374),(3,'default','{\"uuid\":\"22a27b6d-f3c1-4503-9533-0719ca90f8f8\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733573307,1733573307),(4,'default','{\"uuid\":\"b2817862-fc49-4e92-a1f8-c94e8bf37e16\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733573307,1733573307),(5,'default','{\"uuid\":\"a165508f-0ea4-4695-acba-c854a4ed982e\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733573307,1733573307),(6,'default','{\"uuid\":\"e6469fb6-8890-4a50-b8d8-7801eec43a47\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733573347,1733573347),(7,'default','{\"uuid\":\"3be9c2c1-9de7-409f-85d2-3e640ea3feb4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733574148,1733574148),(8,'default','{\"uuid\":\"79793083-3f44-488f-aa46-599614ac4583\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733574241,1733574241),(9,'default','{\"uuid\":\"030c3627-af03-4a4e-aa27-b5cdfd3cc9fd\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:9;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733574546,1733574546),(10,'default','{\"uuid\":\"3d0dc94c-6621-4116-adfb-983cf03b42ef\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733574729,1733574729),(11,'default','{\"uuid\":\"20cbef01-28db-4688-aa0f-8632adb3661c\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575023,1733575023),(12,'default','{\"uuid\":\"5beb8ea5-1790-4f4c-8d72-630538e938c2\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575058,1733575058),(13,'default','{\"uuid\":\"d55a9176-1fa1-445d-8690-adc525d27df1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:13;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575131,1733575131),(14,'default','{\"uuid\":\"7e5ce3e0-321d-4aa5-bd2a-1236ea10b5d4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:14;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575228,1733575228),(15,'default','{\"uuid\":\"912ef6aa-73e9-4905-b441-1bd45ecc4ce1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:15;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575230,1733575230),(16,'default','{\"uuid\":\"3eea8981-f625-4e46-af57-73518ff0d550\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:16;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575391,1733575391),(17,'default','{\"uuid\":\"601d5049-fd2b-4912-bd66-66b26d0d79fc\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:17;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575510,1733575510),(18,'default','{\"uuid\":\"2154f0a8-21a3-44e0-a8d8-7a5b985f5716\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:18;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575631,1733575631),(19,'default','{\"uuid\":\"50c27dc7-525d-4f96-9949-ffbe3e303e0f\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:19;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575632,1733575632),(20,'default','{\"uuid\":\"4cd1dc14-be58-4343-b4e8-01a461be29aa\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733575687,1733575687),(21,'default','{\"uuid\":\"2e0d8f01-7d44-4ddb-8b5f-b6f1313ae884\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:21;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733576412,1733576412),(22,'default','{\"uuid\":\"13b6c063-4092-4553-8466-04d97fc63217\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:22;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733576412,1733576412),(23,'default','{\"uuid\":\"a5b68489-3250-4d02-ad47-3bd59c5371b2\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:23;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733576412,1733576412),(24,'default','{\"uuid\":\"18906602-dfac-4683-b202-c71fbb1f8541\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:24;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733636460,1733636460),(25,'default','{\"uuid\":\"1937855e-5e6b-410d-b9bb-ad23432ebaba\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:25;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733636460,1733636460),(26,'default','{\"uuid\":\"eeea5344-a162-4890-aee5-138a50b5fc6d\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:26;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733636460,1733636460),(27,'default','{\"uuid\":\"e4a81fb4-a1f4-48bc-81b1-a31c639e1c76\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:27;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733636531,1733636532),(28,'default','{\"uuid\":\"3ab370d3-f5e5-466c-ac16-9de0d6d5d4d9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:28;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733636546,1733636546),(29,'default','{\"uuid\":\"d8ac212c-e9d7-4840-83c6-c4437a676e3c\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:29;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733636546,1733636546),(30,'default','{\"uuid\":\"272e94c9-b72c-4095-9dd9-415a7159336a\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:30;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733644134,1733644134),(31,'default','{\"uuid\":\"c1dbd16f-0c4d-4627-8fef-3a7defc2d757\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:31;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733644134,1733644134),(32,'default','{\"uuid\":\"b738f622-65f8-4f4d-9467-2e3477f6891b\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:32;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733644134,1733644134),(33,'default','{\"uuid\":\"560b0f96-4bd0-4089-bd72-f586fd7bebb3\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:34;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733644447,1733644447),(34,'default','{\"uuid\":\"2a583fcd-b17f-4974-af28-1f793047ac13\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:35;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733644447,1733644447),(35,'default','{\"uuid\":\"39d27761-75d2-4bfe-8dd2-d85f5113e05c\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:36;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733644447,1733644447),(36,'default','{\"uuid\":\"16fca468-9889-4831-a025-0e3a15b7b7d4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:37;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733644526,1733644526),(37,'default','{\"uuid\":\"cc45d1d9-8b38-4850-999a-5eec24d654df\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:38;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733644757,1733644757),(38,'default','{\"uuid\":\"c5d9ece7-953b-42ee-b41c-2617b5bf9980\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:39;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733645448,1733645448),(39,'default','{\"uuid\":\"2677a0d8-0771-43f8-9a42-d97db7ce20f9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:40;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733645466,1733645466),(40,'default','{\"uuid\":\"f7420a30-64fe-4046-8436-d921ac37912d\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:41;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733645982,1733645982),(41,'default','{\"uuid\":\"a560a996-882a-4e8c-bb49-8dad37862415\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:42;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733645982,1733645982),(42,'default','{\"uuid\":\"d6914408-b158-438c-8c00-c14d5f087ce6\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:43;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733646012,1733646012),(43,'default','{\"uuid\":\"5c986b02-6f34-44e0-9b8b-63f0f0a13caa\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:44;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733646683,1733646683),(44,'default','{\"uuid\":\"3f556621-06b7-43ff-84e7-e66a0a6fb545\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:45;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733646683,1733646683),(45,'default','{\"uuid\":\"c8ef1c69-fbcf-43fb-bffd-50dd67557bca\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:46;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733646723,1733646723),(46,'default','{\"uuid\":\"f5cc3314-3a7a-4e60-aa4d-30fb5cfd5822\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:47;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733647620,1733647620),(47,'default','{\"uuid\":\"44cb1c3f-08e2-46db-8840-0a5ae948663b\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:48;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733647960,1733647960),(48,'default','{\"uuid\":\"64392b92-11c6-4646-bcc3-97c49b50a867\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:49;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733647960,1733647960),(49,'default','{\"uuid\":\"9333dd33-cad5-4995-9259-93644ced32e9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:50;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733648108,1733648108),(50,'default','{\"uuid\":\"3c7a68ab-70dd-4237-9299-da6bd53ad463\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:51;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733648108,1733648108),(51,'default','{\"uuid\":\"04781e41-cee6-44a0-8e78-cf2cf6f08194\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:52;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733648340,1733648340),(52,'default','{\"uuid\":\"14e70724-7f0c-47d8-a9c6-cbc7cd69fbcc\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:53;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733648358,1733648358),(53,'default','{\"uuid\":\"ace2bfb5-d817-4e45-be7b-4412781b02ce\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:54;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733648390,1733648390),(54,'default','{\"uuid\":\"38c4b08b-abcc-4d18-b19c-ecf147429232\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:55;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733648868,1733648868),(55,'default','{\"uuid\":\"8b5df297-28a8-4dcf-96e0-2754d13ab636\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:56;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733666621,1733666621),(56,'default','{\"uuid\":\"0164f149-099f-40f0-888a-e4b6d3142a09\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:57;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733722860,1733722860),(57,'default','{\"uuid\":\"8a54ab0b-b48e-4d48-827a-cbfa0b1b4d8a\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:58;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733722860,1733722860),(58,'default','{\"uuid\":\"f0aa4e9d-b24d-49e4-a034-941620385e27\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:59;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733732877,1733732877),(59,'default','{\"uuid\":\"53a41087-a148-4112-87a9-3bb0347830a9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:60;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733732877,1733732877),(60,'default','{\"uuid\":\"6d54cd46-7aad-4ce4-8595-89941e913399\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:61;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733733027,1733733027),(61,'default','{\"uuid\":\"88c7e601-6603-4fe7-be88-a7f0b2c5e0ee\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:62;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733735068,1733735068),(62,'default','{\"uuid\":\"fcc05132-21b8-4f65-8898-3aefde671aeb\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:63;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733737473,1733737473),(63,'default','{\"uuid\":\"1e051217-3438-4aaf-8643-70a058876491\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:64;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733737473,1733737473),(64,'default','{\"uuid\":\"e1029486-1c95-4e21-94f2-6ea9f2b1535d\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742188,1733742188),(65,'default','{\"uuid\":\"43af626f-21ca-4f9a-992b-ddbac9701311\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:66;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742190,1733742190),(66,'default','{\"uuid\":\"578b1b15-334a-402b-a20b-51d0d43a11bb\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:67;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742192,1733742192),(67,'default','{\"uuid\":\"18c1cc4c-294b-483c-9041-65b05077cebe\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:68;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742199,1733742199),(68,'default','{\"uuid\":\"26eb1256-4790-4072-a53b-06329f9c7c8f\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:69;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742246,1733742246),(69,'default','{\"uuid\":\"02c570b0-bd64-4839-938f-e415611fc69d\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:70;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742246,1733742246),(70,'default','{\"uuid\":\"c1992911-ac6a-4c4b-8e13-f5fe91d1b063\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:71;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742346,1733742346),(71,'default','{\"uuid\":\"c8c9a2ce-63cf-490a-895b-17181b5e08a1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:72;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742346,1733742346),(72,'default','{\"uuid\":\"505de514-6cbf-44c7-b7e4-21ff52c0cb67\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:73;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742881,1733742881),(73,'default','{\"uuid\":\"1554f98c-1899-47a7-82ad-48fd3dd28be9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:74;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742881,1733742881),(74,'default','{\"uuid\":\"635b636e-bd61-4ca9-9fb9-1a8d04839e45\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:75;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733742913,1733742913),(75,'default','{\"uuid\":\"5d9e95af-23fc-47c9-86a4-81dcfcc6400c\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:76;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743073,1733743073),(76,'default','{\"uuid\":\"4319c3dc-2a28-4f91-897e-84ef4569b3d6\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:77;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743073,1733743073),(77,'default','{\"uuid\":\"82028233-4e62-4543-8f7f-17dc453c1ac0\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:78;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743135,1733743135),(78,'default','{\"uuid\":\"3509afa7-b763-4c6c-9593-6b5f0b50ef4b\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:79;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743135,1733743135),(79,'default','{\"uuid\":\"1bd58200-3e5d-47f0-8047-13b9eff3f268\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:80;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743202,1733743202),(80,'default','{\"uuid\":\"ab2c7180-0d85-4ba6-a3d4-cdf9a2b151c1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:81;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743202,1733743202),(81,'default','{\"uuid\":\"c950753d-7d88-45e9-8f1c-ac3b0100def1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:82;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743203,1733743203),(82,'default','{\"uuid\":\"a63b65fb-a36c-48ea-a4c6-98ff11d3ace0\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:83;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743203,1733743203),(83,'default','{\"uuid\":\"3a08b975-3765-4398-b880-9938813f0bf6\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:84;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743528,1733743528),(84,'default','{\"uuid\":\"9acb89ef-b60a-4543-8edf-a0a46f5b22b0\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:85;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743528,1733743528),(85,'default','{\"uuid\":\"5218addd-150c-424f-bb0b-fda0e4359689\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:86;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743578,1733743578),(86,'default','{\"uuid\":\"4126b194-72ad-4c54-b472-952dbef5c393\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:87;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733743578,1733743578),(87,'default','{\"uuid\":\"f406f81f-9558-4543-ab20-bfb3e1ce18a1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:88;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733745936,1733745936),(88,'default','{\"uuid\":\"57061671-2cb5-4c9c-a9c9-91ea6acdc365\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:89;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733745936,1733745936),(89,'default','{\"uuid\":\"d89aef3e-e2dd-4ac4-9f8a-c7be2c2402f1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:90;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733749058,1733749058),(90,'default','{\"uuid\":\"40e29ec0-1a11-4411-8a47-3dc06015a2ec\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:91;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733749435,1733749435),(91,'default','{\"uuid\":\"9c3dbfb4-b75a-4bf2-b076-0196d5541bae\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:92;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733749512,1733749512),(92,'default','{\"uuid\":\"a5911cfd-0be0-40c3-b669-980ef8787d29\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:93;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733749724,1733749724),(93,'default','{\"uuid\":\"50cec241-a663-4d40-81b6-9c571c82e910\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:94;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733813168,1733813168),(94,'default','{\"uuid\":\"51ee1ca4-9590-4bb0-9715-465978075546\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:95;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733813168,1733813168),(95,'default','{\"uuid\":\"3ffe5af6-94fb-4f01-a4a9-e70789c34d8d\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:96;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733813197,1733813197),(96,'default','{\"uuid\":\"04994b56-78f3-4337-9dce-7d2b8eddd645\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:97;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733824694,1733824694),(97,'default','{\"uuid\":\"bf6bfaea-966c-4633-9501-1ac4c05ec3f3\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:98;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733824694,1733824694),(98,'default','{\"uuid\":\"e09ff008-c081-46c2-9705-be0e1927d603\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:99;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733824734,1733824734),(99,'default','{\"uuid\":\"37a97b1b-93f7-46b9-a9b6-7643e2bb30a9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:100;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733824734,1733824734),(100,'default','{\"uuid\":\"f474e55c-7f12-4b9a-a15d-5fc974d2d030\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:101;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733824827,1733824827),(101,'default','{\"uuid\":\"07325c75-8357-4870-a973-7ac42dc7d884\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:102;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733824827,1733824827),(102,'default','{\"uuid\":\"8daad857-ecb6-447c-81a5-448a3a3ab8fe\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:103;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733824894,1733824894),(103,'default','{\"uuid\":\"fc8059ad-b3e8-47ba-a5bd-a230839cd3ab\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:104;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733824894,1733824894),(104,'default','{\"uuid\":\"e51cf713-db28-4f8f-a6b0-9fb0ed5c97a4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:105;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733825069,1733825069),(105,'default','{\"uuid\":\"5ea9edc6-5b97-4dd7-baca-ad2a8f107311\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:106;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733825069,1733825069),(106,'default','{\"uuid\":\"f5523913-31b7-4d3a-ae8a-8a712eb7a6f6\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:107;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733825978,1733825978),(107,'default','{\"uuid\":\"4d2e3046-8b0e-4844-ba5a-0276007bfa00\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:108;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733825978,1733825978),(108,'default','{\"uuid\":\"2b866785-85ed-43f2-9217-5ca64f81e19b\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:109;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733825991,1733825991),(109,'default','{\"uuid\":\"765276cb-4006-44d7-979b-5acf81aa14fb\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:110;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733825991,1733825991),(110,'default','{\"uuid\":\"50830d46-9fe9-46b1-a971-01ef1d00c9cd\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:111;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733826017,1733826017),(111,'default','{\"uuid\":\"bc226b62-d582-42e4-81d5-8828b29ee409\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:112;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733826017,1733826017),(112,'default','{\"uuid\":\"cd0f8bc7-e004-40d6-ad28-87bf68be66a4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:113;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827287,1733827287),(113,'default','{\"uuid\":\"2ca9b343-4c08-4eaf-92df-d22ad9dd89e2\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:114;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827287,1733827287),(114,'default','{\"uuid\":\"9020574f-72e3-4bd2-b82e-647925a547a4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:115;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827325,1733827325),(115,'default','{\"uuid\":\"29e1a907-cbfa-4941-8d04-ba60f60d48b6\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:116;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827325,1733827325),(116,'default','{\"uuid\":\"2156083e-ef97-4fe7-8fb4-ca6abf91b896\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:117;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827395,1733827395),(117,'default','{\"uuid\":\"697e1af1-642f-4769-ac75-23e96c322247\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:118;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827395,1733827395),(118,'default','{\"uuid\":\"848aaeac-7b10-4d03-abfd-2fb9b01c9dac\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:119;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827495,1733827495),(119,'default','{\"uuid\":\"af64dc4e-fd45-41b8-b1d4-b502e8f381f3\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:120;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827495,1733827495),(120,'default','{\"uuid\":\"e1b9d050-44e6-4dba-9e54-4fc288313d76\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:121;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827566,1733827566),(121,'default','{\"uuid\":\"b2b2d524-3e2c-429c-b18a-880405655bc7\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:122;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827566,1733827566),(122,'default','{\"uuid\":\"d11ee3a9-6a34-4868-b4d1-323cb09d2b3a\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:123;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827590,1733827590),(123,'default','{\"uuid\":\"0030fc6b-bc6d-4fab-b205-5fd83d62fdc4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:124;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733827590,1733827590),(124,'default','{\"uuid\":\"4a1665e9-1391-4e86-b83a-a093909bc884\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:125;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828390,1733828390),(125,'default','{\"uuid\":\"ec674bfe-60ce-4c2f-9922-e2186bd382d9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:126;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828390,1733828390),(126,'default','{\"uuid\":\"606e69d8-1d08-452f-afca-193f73098048\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:127;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828508,1733828508),(127,'default','{\"uuid\":\"6bd35bbc-0f23-43be-8bc3-dfc86551c434\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:128;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828589,1733828589),(128,'default','{\"uuid\":\"06704aee-26a6-4241-b398-7dfa1075c754\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:129;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828589,1733828589),(129,'default','{\"uuid\":\"6f316c7a-bd80-475d-a57a-16e2f84ef2c1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:130;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828618,1733828618),(130,'default','{\"uuid\":\"a73570c5-46c9-41c9-941e-aab73c215c57\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:131;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828672,1733828672),(131,'default','{\"uuid\":\"1f7038e5-b23d-4180-b5ce-f9302092269a\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:132;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828672,1733828672),(132,'default','{\"uuid\":\"9280559f-782e-4327-afcd-86151af0ca9f\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:133;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733828917,1733828917),(133,'default','{\"uuid\":\"5914ddbd-fe0e-4a6f-a4ac-846bae25a4d2\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:134;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733829138,1733829138),(134,'default','{\"uuid\":\"8445200e-4574-447b-9342-8ea67af8afe1\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:135;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733829140,1733829140),(135,'default','{\"uuid\":\"e072a155-db54-4b94-af6b-12aa0050d215\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:136;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733829169,1733829169),(136,'default','{\"uuid\":\"7c784196-17f0-4041-95b7-7613573fd180\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:137;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733829169,1733829169),(137,'default','{\"uuid\":\"41b06611-fe67-44b9-b109-87bcc02d7c82\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:138;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733829374,1733829374),(138,'default','{\"uuid\":\"d487b7ed-23b6-4533-b868-4f912f489634\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:139;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733829374,1733829374),(139,'default','{\"uuid\":\"cde7b0bc-ea53-4761-8e35-6b3d5df2b6b0\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:140;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733829455,1733829455),(140,'default','{\"uuid\":\"dfa28caf-261c-4ffa-ac98-97a63cd98bd8\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:141;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733829455,1733829455),(141,'default','{\"uuid\":\"d0971ead-fd2d-4649-ba0e-d957fb03443e\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:142;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733832259,1733832259),(142,'default','{\"uuid\":\"43b0a183-8c04-45d9-975a-072d4d158d90\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:143;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733832259,1733832259),(143,'default','{\"uuid\":\"f50f8001-7aea-4fbe-9b59-eded82dce018\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:144;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733832992,1733832992),(144,'default','{\"uuid\":\"a49a03d8-94df-40cd-ad73-9c30e3c8c384\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:145;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733832992,1733832992),(145,'default','{\"uuid\":\"77ed1686-2d71-4dbd-a5fb-9cb88a7e2cc7\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:146;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733833230,1733833230),(146,'default','{\"uuid\":\"79cf37d9-2366-455d-9e6a-6478fd16bc90\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:147;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733833230,1733833230),(147,'default','{\"uuid\":\"46796436-d48e-4b84-af6e-d175ba0fa779\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:148;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733834207,1733834207),(148,'default','{\"uuid\":\"bd0b7a14-077e-4070-9b35-26eec5721bb4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:149;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733834207,1733834207),(149,'default','{\"uuid\":\"6ce5f161-d3ba-4452-9645-ace259c2ad91\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:150;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733835264,1733835264),(150,'default','{\"uuid\":\"88086f43-c09e-4c23-8e10-e1f6dcc68b12\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:151;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733835264,1733835264),(151,'default','{\"uuid\":\"a168954b-362c-430e-aa1a-250e45ace672\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:152;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733835312,1733835312),(152,'default','{\"uuid\":\"21ba8d8f-8754-4de2-b7aa-813cc78139f9\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:153;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733835312,1733835312),(153,'default','{\"uuid\":\"c732d234-eb2d-40b3-9455-3cb973e41d6e\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:154;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733835400,1733835400),(154,'default','{\"uuid\":\"3753f36b-4dbc-42f5-bcf3-7bff869ef0cb\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:155;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733835400,1733835400),(155,'default','{\"uuid\":\"dafe1f2e-dcbc-4e77-a3e3-97f83690e270\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:156;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733835443,1733835443),(156,'default','{\"uuid\":\"4d112d24-5eed-426d-b7d8-dd873be70f7f\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:157;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733835443,1733835443),(157,'default','{\"uuid\":\"9396d398-1946-431e-a9b0-70a038f7c6a0\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:158;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733848390,1733848390),(158,'default','{\"uuid\":\"57b79ce5-7655-4cfb-afa6-45d0451c4e62\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:159;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733848390,1733848390),(159,'default','{\"uuid\":\"6e97fec6-ed22-4a29-bf19-30c82d73b748\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:160;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733848455,1733848455),(160,'default','{\"uuid\":\"d61cd572-5700-4b9f-89e6-1140f190ab58\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:162;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733904281,1733904281),(161,'default','{\"uuid\":\"1d05ff5d-4616-454a-a970-d2d4e92f8f52\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:164;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733904281,1733904281),(162,'default','{\"uuid\":\"5db0d980-cea8-4484-aac3-3c54d5c24bef\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:165;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733906769,1733906769),(163,'default','{\"uuid\":\"88ee3968-4680-43bb-8637-5602efcbf514\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:166;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733906797,1733906797),(164,'default','{\"uuid\":\"6103f320-a3db-48c0-a1b5-981e0985ddc4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:184;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733917371,1733917371),(165,'default','{\"uuid\":\"7d62bb49-4dde-4040-8d93-4ebb69b46607\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:185;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733917371,1733917371),(166,'default','{\"uuid\":\"cca9599e-c000-4f78-bd96-492c8a7d3b06\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:186;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733917404,1733917404),(167,'default','{\"uuid\":\"522fe97e-e416-4f79-b2d1-03024eda2ea4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:187;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733917418,1733917418),(168,'default','{\"uuid\":\"4e37f4ba-2978-40db-8e5b-635cef70ee32\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:188;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733922604,1733922604),(169,'default','{\"uuid\":\"758c126c-f628-4fa5-8501-486c9c791685\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:189;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733922604,1733922604),(170,'default','{\"uuid\":\"2f653852-595d-40b5-b1d6-ec0daa57efde\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:190;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733922825,1733922825),(171,'default','{\"uuid\":\"c8c9a704-b378-4f30-930a-449519aaa924\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:191;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733922825,1733922825),(172,'default','{\"uuid\":\"09861b4e-b510-462c-a56b-bb7bec0043a0\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:192;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733924596,1733924596),(173,'default','{\"uuid\":\"44fcc996-eceb-4f36-ac39-c1ddc80ca430\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:193;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733924596,1733924596),(174,'default','{\"uuid\":\"82f2846e-ba3a-4547-819e-e071339e1e55\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:194;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733924640,1733924640),(175,'default','{\"uuid\":\"e65b306c-c833-4be8-92ab-d8ad35d83e71\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:195;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733927456,1733927456),(176,'default','{\"uuid\":\"4bb5dd01-33bb-42de-8280-3757cb17385d\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:196;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733927473,1733927473),(177,'default','{\"uuid\":\"c3d68694-f3b6-4e10-9ac4-729129c9fbe8\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:197;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733936014,1733936014),(178,'default','{\"uuid\":\"28e98fb0-bf5d-4208-b5b9-3cced74e73b4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:198;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733936014,1733936014),(179,'default','{\"uuid\":\"5857557b-94a8-479b-9df9-77a3a9e70993\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:199;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733936635,1733936635),(180,'default','{\"uuid\":\"4c20a966-d9d3-4992-9274-0362bb6ac866\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:200;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733936635,1733936635),(181,'default','{\"uuid\":\"e1e4e468-6208-411b-b111-6678151a5e2f\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:201;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1733988936,1733988936),(182,'default','{\"uuid\":\"95f6fed6-8e72-4a8e-8f46-eb11d2756bae\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:202;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734090960,1734090960),(183,'default','{\"uuid\":\"3c3e7441-c7b4-4902-98c4-0d6e93bf22cd\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:203;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734090960,1734090960),(184,'default','{\"uuid\":\"759049d6-49bb-482b-ab6e-82f859a2a8f4\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:204;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734091027,1734091027),(185,'default','{\"uuid\":\"ae3fdcac-acd7-44d1-ae2c-f0bd96c91bbc\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:205;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734091027,1734091027),(186,'default','{\"uuid\":\"057e263e-0416-402e-85fa-0be63ac83264\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:206;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734091169,1734091169),(187,'default','{\"uuid\":\"b4d14f7b-92c9-48cf-b8c5-7d06be720460\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:207;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734091169,1734091169),(188,'default','{\"uuid\":\"c2888172-811a-47be-bd09-46d0c0bcba16\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:208;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734091969,1734091969),(189,'default','{\"uuid\":\"398100e7-b47c-412d-988a-015c73540c22\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:209;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734091969,1734091969),(190,'default','{\"uuid\":\"bbe8b8d1-5989-44f6-b565-07d5dca9b460\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:210;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734093197,1734093197),(191,'default','{\"uuid\":\"65ecff40-e41e-4cc9-b3a2-74350805a143\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:211;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734093197,1734093197),(192,'default','{\"uuid\":\"8e2b6189-1ad8-4085-83d5-5fb2a6ba495b\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:212;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734093581,1734093581),(193,'default','{\"uuid\":\"2aeb9db0-390f-4d74-b96d-e2f108596182\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:213;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734093581,1734093581),(194,'default','{\"uuid\":\"be1393cc-dc06-4ca6-b95e-4d420a7ea17f\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:214;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734094083,1734094083),(195,'default','{\"uuid\":\"fcbb26e6-0abe-46f4-a08f-9b6f3be8ef30\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:215;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734094083,1734094083),(196,'default','{\"uuid\":\"9c0c691a-37c5-47fa-a91c-229b17ed615c\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:216;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734171547,1734171547),(197,'default','{\"uuid\":\"9a59e075-352b-45ce-8ee3-4adee342fa0d\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:217;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734171689,1734171689),(198,'default','{\"uuid\":\"aa44dc10-9112-4192-9c64-0d63463eef0e\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:218;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734171771,1734171771),(199,'default','{\"uuid\":\"0f668625-bf71-4774-bce1-0d8e519a7d7d\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:219;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734171832,1734171832),(200,'default','{\"uuid\":\"a5706132-9732-4a44-b9c8-7744731a0b64\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:220;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734171878,1734171878),(201,'default','{\"uuid\":\"260e3da6-e1f9-4af3-9bd2-b6b120ec808e\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:221;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734171894,1734171894),(202,'default','{\"uuid\":\"cefaa078-c6a2-4edd-8b4f-74623f631596\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:222;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734176289,1734176289),(203,'default','{\"uuid\":\"adc986c5-a137-4ba7-9f31-22423385457f\",\"displayName\":\"App\\\\Events\\\\NotificationSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:27:\\\"App\\\\Events\\\\NotificationSent\\\":1:{s:12:\\\"notification\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\Notification\\\";s:2:\\\"id\\\";i:223;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}',0,NULL,1734189229,1734189229);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'Maria','ma@g.com','msg','Hello, I would like to inquire about the speaker\'s visa payment status for the upcoming conference. Please let me know if the payment is required.','2024-12-08 17:42:58','2024-12-08 17:42:58'),(2,'Ameer','Ameer@gmail.com','Message','Hello, I would like to inquire about the speaker\'s visa payment status for the upcoming conference. Please let me know if the payment is required.','2024-12-08 17:47:01','2024-12-08 17:47:01'),(3,'Ameer','Ameer@gmail.com','Message','Hello, I would like to inquire about the speaker\'s visa payment status for the upcoming conference. Please let me know if the payment is required.','2024-12-08 17:47:06','2024-12-08 17:47:06'),(4,'Ayat','ay@mail.com','msg','You have received a new message','2024-12-08 17:50:13','2024-12-08 17:50:13'),(5,'Ayat','ay@mail.com','msg','You have received a new message','2024-12-08 17:50:16','2024-12-08 17:50:16'),(6,'Leen','leen@gmail.com','Message','Hello, I would like to inquire about the speaker\'s visa payment status for the upcoming conference. Please let me know if the payment is required.','2024-12-08 17:54:58','2024-12-08 17:54:58');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2024_09_03_062848_create_conferences_table',1),(5,'2024_09_03_065551_create_conference_image_table',1),(6,'2024_09_03_073118_create_committee_members_table',1),(7,'2024_09_03_082314_create_scientific_topics_table',1),(8,'2024_09_03_082802_create_conference_prices_table',1),(9,'2024_09_03_093540_create_scientific_papers_table',1),(10,'2024_09_03_115452_create_exhibitions_table',1),(11,'2024_09_03_122725_create_tourist_sites_table',1),(12,'2024_09_04_061903_update_users_table',1),(13,'2024_09_04_065553_update_conferences_table',1),(14,'2024_09_05_120747_modify_name_column_in_users_table',1),(15,'2024_09_05_160656_make_conference_img_nullable',1),(16,'2024_09_05_160846_update_conference_img_column',1),(17,'2024_09_05_162332_change_committee_image_column_in_committee_members_table',1),(18,'2024_09_10_220245_create_personal_access_tokens_table',1),(19,'2024_09_12_143405_create_speakers_table',1),(20,'2024_09_12_155012_create_attendance_table',1),(21,'2024_09_12_155327_create_sponsors_table',1),(22,'2024_09_12_161020_create_group_registrations_table',1),(23,'2024_09_12_212631_add_status_to_users_table',1),(24,'2024_09_14_103631_create_exhibition_images_table',1),(25,'2024_09_16_095352_create_notifications_table',2),(26,'2024_09_16_223522_add_column_to_notifications_table',2),(27,'2024_09_17_132654_create_visas_table',2),(28,'2024_09_17_145154_update_visas_table',2),(29,'2024_09_19_162524_create_flights_table',2),(30,'2024_09_19_162757_create_available_flights_table',2),(31,'2024_09_22_102500_modify_admin_update_deadline_column_in_flights_table',2),(32,'2024_09_22_142132_create_accepted_flights_table',2),(33,'2024_09_22_160324_add_departure_details_to_accepted_flights_table',2),(34,'2024_09_25_141323_update_ticket_count_default_in_flights_table',2),(35,'2024_09_27_180053_create_conference_user_table',2),(36,'2024_09_27_192519_add_specific_flight_time_to_flights_table',2),(37,'2024_09_28_022942_make_user_id_nullable_in_flights_table',2),(38,'2024_09_28_062022_add_conference_id_to_exhibitions_table',2),(39,'2024_10_01_050157_create_reservations_table',2),(40,'2024_10_01_050246_create_rooms_table',2),(41,'2024_10_03_053130_add_update_deadline_to_reservations_table',2),(42,'2024_10_03_093606_create_trips_table',2),(43,'2024_10_03_100913_create_trip_participants_table',2),(44,'2024_10_04_121859_create_group_trip_participants_table',2),(45,'2024_10_06_143350_create_conference_trip_table',2),(46,'2024_10_06_154441_create_additional_options_table',2),(47,'2024_10_06_155127_create_user_final_prices_table',2),(48,'2024_10_09_112106_create_dinner_details_table',3),(49,'2024_10_09_112107_create_dinner_attendees_table',3),(50,'2024_10_09_123210_create_airport_transfer_bookings_table',4),(51,'2024_10_09_140643_create_dinner_speaker_companion_fees_table',4),(52,'2024_10_10_070827_add_trip_costs_to_speakers_table',4),(53,'2024_10_10_152424_modify_foreign_key_on_dinner_attendees',4),(54,'2024_10_11_100200_create_discount_option_table',4),(55,'2024_10_12_092152_create_trip_options_participants_table',4),(56,'2024_10_12_130532_modify_trip_participants_nullable_columns',4),(57,'2024_10_13_062851_create_airport_transfer_prices_table',5),(58,'2024_10_16_100356_add_conference_id_to_notifications_table',6),(59,'2024_10_19_110657_make_password_nullable_in_users_table',6),(60,'2024_10_20_084001_add_updated_at_by_admin_to_visas_table',6),(61,'2024_10_21_051547_add_visa_price_to_conferences_table',6),(62,'2024_10_21_122214_add_is_admin_to_users_table',7),(63,'2024_10_21_130937_add_password_to_group_registrations_table',8),(64,'2024_10_21_145828_add_conference_id_to_group_registrations_table',9),(65,'2024_10_22_234531_add_base_ticket_price_to_flights_table',10),(66,'2024_10_25_124630_create_room_prices_table',11),(67,'2024_10_25_133459_add_room_type_and_nights_covered_to_speakers_table',12),(68,'2024_10_26_140006_make_columns_nullable_in_trips_table',13),(69,'2024_10_29_081049_create_ourclients_table',14),(70,'2024_11_01_094355_rename_visa_price_in_conferences_table',15),(71,'2024_11_01_153250_add_is_visa_payment_required_to_conference_user_table',16),(73,'2024_11_04_102722_add_companion_dinner_price_to_conferences_table',17),(74,'2024_11_04_103759_add_companion_dinner_price_to_conferences_table',18),(75,'2024_11_04_151523_add_companion_price_to_dinner_attendees_table',19),(77,'2024_11_05_051427_add_conference_id_to_dinner_attendees_table',20),(79,'2024_11_05_112318_create_jobs_applicants_and_job_applications_tables',21),(80,'2024_11_05_133759_rename_events_coordinator_column_in_available_jobs_table',22),(81,'2024_11_06_080507_create_messages_table',23),(82,'2024_11_06_105517_create_sponsorship_options_table',24),(83,'2024_11_06_145221_create_conference_sponsorship_options_table',25),(84,'2024_11_06_151147_rename_conference_sponsorship_options_to_sponsorships',26),(85,'2024_11_09_054249_add_is_other_to_accepted_flights_table',27),(86,'2024_11_09_225329_create_papers_table',27),(87,'2024_11_17_152104_create_booth_costs_table',27),(88,'2024_11_19_131348_create_sponsor_invoices_table',27),(89,'2024_11_19_152220_change_price_column_in_sponsorship_options_table',27),(90,'2024_11_20_055604_add_status_to_sponsors_table',27),(91,'2024_11_20_062242_add_company_details_to_users_table',27),(92,'2024_11_20_065837_add_conference_id_to_users_table',27),(93,'2024_11_20_120257_create_private_invoice_trips_table',27),(94,'2024_11_20_123029_create_tourism_trips_table',27),(95,'2024_11_20_124154_add_status_to_private_invoice_trips_table',27),(96,'2024_11_20_161823_create_transportation_requests_table',27),(97,'2024_11_20_170442_create_ticket_bookings_table',27),(98,'2024_11_20_180755_create_travel_form_table',27),(99,'2024_11_21_104655_create_available_flights_table',28),(100,'2024_11_23_131928_create_reservation_invoices_table',28),(101,'2024_11_23_165208_add_late_check_out_price_and_early_check_in_price_and_status_to_reservation_invoices_table',28),(102,'2024_11_24_133309_add_unique_constraint_to_exhibit_number_in_sponsor_invoices_table',28),(103,'2024_11_24_133311_create_standard_booth_packages_table',28),(104,'2024_12_07_095329_create_airport_transfers_invoices_table',29),(105,'2024_12_07_110726_create_invoice_flights_table',30),(106,'2024_12_08_084420_add_is_visa_payment_required_to_speakers_table',31),(107,'2024_12_07_170630_create_dinner_attendees_invoice_table',32),(108,'2024_12_03_064756_add_conference_id_to_trips_table',33),(109,'2024_12_03_082133_add_group_accompanying_price_to_trips_table',33),(110,'2024_12_12_061018_add_status_to_group_trip_participants_table',34),(111,'2024_12_12_065213_add_arrival_and_departure_dates_to_speakers_table',35),(112,'2024_12_14_134412_add_video_column_to_speakers_table',36);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `register_id` bigint(20) unsigned DEFAULT NULL,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (2,2,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',1,'2024-12-05 18:42:54','2024-12-11 19:23:51',2,1),(4,2,'New speaker registration: ayat',1,'2024-12-07 20:08:27','2024-12-11 19:22:10',3,1),(5,3,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-07 20:08:27','2024-12-07 20:08:27',3,1),(6,3,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-07 20:09:07','2024-12-07 20:09:07',NULL,1),(7,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:22:28','2024-12-07 20:22:28',3,NULL),(8,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:24:01','2024-12-07 20:24:01',3,NULL),(9,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:29:06','2024-12-07 20:29:06',3,NULL),(10,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:32:09','2024-12-07 20:32:09',3,NULL),(11,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:37:03','2024-12-07 20:37:03',3,NULL),(12,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:37:38','2024-12-07 20:37:38',3,NULL),(13,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:38:51','2024-12-07 20:38:51',3,NULL),(14,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:40:28','2024-12-07 20:40:28',3,NULL),(15,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:40:30','2024-12-07 20:40:30',3,NULL),(16,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:43:11','2024-12-07 20:43:11',3,NULL),(17,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:45:10','2024-12-07 20:45:10',3,NULL),(18,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:47:11','2024-12-07 20:47:11',3,NULL),(19,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:47:12','2024-12-07 20:47:12',3,NULL),(20,3,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-07 20:48:07','2024-12-07 20:48:07',3,NULL),(22,2,'New speaker registration: ggg',1,'2024-12-07 21:00:12','2024-12-11 19:22:40',4,1),(23,4,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',1,'2024-12-07 21:00:12','2024-12-14 22:31:00',4,1),(24,5,'You will be contacted directly by the organizing company via email.',1,'2024-12-08 13:40:57','2024-12-14 20:10:06',NULL,NULL),(26,2,'New sponsor registration: m@m.com',1,'2024-12-08 13:41:00','2024-12-11 19:22:12',5,NULL),(27,5,'Your sponsorship has been approved. Thank you for becoming a sponsor for our conference. We look forward to your valuable contribution.',1,'2024-12-08 13:42:09','2024-12-14 20:06:23',NULL,NULL),(29,2,'Sponsor approved: m@m.com',1,'2024-12-08 13:42:26','2024-12-11 19:33:28',5,NULL),(30,6,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-12-08 15:48:54','2024-12-08 15:48:54',NULL,1),(32,2,'New group registration: aya@gmail.com',1,'2024-12-08 15:48:54','2024-12-11 19:27:34',6,NULL),(33,6,'Now you can access the activated file and download the registered names.',0,'2024-12-08 15:49:48','2024-12-08 15:49:48',NULL,NULL),(35,2,'New speaker registration: nn',1,'2024-12-08 15:54:07','2024-12-11 19:22:15',7,1),(36,7,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-08 15:54:07','2024-12-08 15:54:07',7,1),(37,7,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-08 15:55:26','2024-12-08 15:55:26',NULL,1),(38,7,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-08 15:59:17','2024-12-08 15:59:17',NULL,1),(39,7,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-08 16:10:47','2024-12-08 16:10:47',NULL,1),(40,7,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-08 16:11:06','2024-12-08 16:11:06',NULL,1),(41,7,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-08 16:19:42','2024-12-08 16:19:42',7,1),(42,2,'New visa request from user: nn for conference: fff',1,'2024-12-08 16:19:42','2024-12-11 19:33:29',7,1),(43,7,'Your visa has been approved.',0,'2024-12-08 16:20:11','2024-12-08 16:20:11',7,NULL),(44,2,'New speaker registration: ayat',1,'2024-12-08 16:31:23','2024-12-11 19:33:30',8,1),(45,8,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-08 16:31:23','2024-12-08 16:31:23',8,1),(46,8,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-08 16:32:03','2024-12-08 16:32:03',NULL,1),(47,8,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-08 16:47:00','2024-12-08 16:47:00',NULL,1),(48,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-08 16:52:40','2024-12-08 16:52:40',8,1),(49,2,'New visa request from user: ayat for conference: fff',1,'2024-12-08 16:52:40','2024-12-11 19:27:26',8,1),(50,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-08 16:55:08','2024-12-08 16:55:08',8,1),(51,2,'New visa request from user: ayat for conference: fff',1,'2024-12-08 16:55:08','2024-12-11 19:33:32',8,1),(52,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-08 16:59:00','2024-12-08 16:59:00',8,NULL),(53,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-08 16:59:18','2024-12-08 16:59:18',8,NULL),(54,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-08 16:59:50','2024-12-08 16:59:50',8,NULL),(55,8,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-12-08 17:07:48','2024-12-08 17:07:48',8,NULL),(56,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-08 22:03:39','2024-12-08 22:03:39',8,NULL),(57,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-09 13:41:00','2024-12-09 13:41:00',8,1),(58,2,'New visa request from user: ayat for conference: fff',1,'2024-12-09 13:41:00','2024-12-11 19:33:26',8,1),(59,8,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-12-09 16:27:54','2024-12-09 16:27:54',8,NULL),(60,8,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-12-09 16:27:57','2024-12-09 16:27:57',8,NULL),(61,8,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-12-09 16:30:27','2024-12-09 16:30:27',8,NULL),(62,8,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-12-09 17:04:28','2024-12-09 17:04:28',8,NULL),(63,2,'New speaker registration: AS',1,'2024-12-09 17:44:33','2024-12-11 16:46:07',9,1),(64,9,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-09 17:44:33','2024-12-09 17:44:33',9,1),(65,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-09 19:03:08','2024-12-09 19:03:08',8,1),(66,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-09 19:03:10','2024-12-09 19:03:10',8,1),(67,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:03:12','2024-12-13 19:54:05',8,1),(68,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-09 19:03:19','2024-12-09 19:03:19',8,1),(69,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:04:06','2024-12-12 17:44:04',8,1),(70,2,'New visa request from user: ayat for conference: fff',1,'2024-12-09 19:04:06','2024-12-11 19:21:55',8,1),(71,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:05:46','2024-12-13 19:54:03',8,1),(72,2,'New visa request from user: ayat for conference: fff',1,'2024-12-09 19:05:46','2024-12-11 19:31:20',8,1),(73,2,'New speaker registration: aa',1,'2024-12-09 19:14:41','2024-12-11 19:29:11',10,2),(74,10,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',1,'2024-12-09 19:14:41','2024-12-11 19:14:06',10,2),(75,10,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',1,'2024-12-09 19:15:13','2024-12-11 19:14:05',NULL,2),(76,10,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:17:53','2024-12-11 19:14:08',10,2),(77,2,'New visa request from user: aa for conference: ',1,'2024-12-09 19:17:53','2024-12-11 19:21:53',10,2),(78,10,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:18:55','2024-12-11 19:14:13',10,2),(79,2,'New visa request from user: aa for conference: ',1,'2024-12-09 19:18:55','2024-12-11 19:27:12',10,2),(80,10,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:20:02','2024-12-11 19:14:02',10,2),(81,2,'New visa request from user: aa for conference: ',1,'2024-12-09 19:20:02','2024-12-11 19:29:08',10,2),(82,10,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:20:03','2024-12-11 19:14:09',10,2),(83,2,'New visa request from user: aa for conference: ',1,'2024-12-09 19:20:03','2024-12-11 16:22:24',10,2),(84,10,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:25:28','2024-12-11 19:14:00',10,2),(85,2,'New visa request from user: aa for conference: ',1,'2024-12-09 19:25:28','2024-12-11 19:27:11',10,2),(86,10,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 19:26:18','2024-12-11 19:14:10',10,2),(87,2,'New visa request from user: aa for conference: ',1,'2024-12-09 19:26:18','2024-12-11 00:36:15',10,2),(88,10,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-09 20:05:36','2024-12-11 19:13:59',10,2),(89,2,'New visa request from user: aa for conference: ',1,'2024-12-09 20:05:36','2024-12-11 00:36:16',10,2),(90,10,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',1,'2024-12-09 20:57:38','2024-12-11 19:14:12',10,NULL),(91,10,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',1,'2024-12-09 21:03:55','2024-12-11 19:13:57',10,NULL),(92,10,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',1,'2024-12-09 21:05:12','2024-12-11 16:23:37',10,NULL),(93,10,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',1,'2024-12-09 21:08:43','2024-12-11 16:23:35',10,NULL),(94,2,'New speaker registration: Ameer',1,'2024-12-10 14:46:05','2024-12-11 00:36:17',11,3),(95,11,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 14:46:08','2024-12-10 14:46:08',11,3),(96,11,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-10 14:46:37','2024-12-10 14:46:37',NULL,3),(97,2,'New speaker registration: aa',1,'2024-12-10 17:58:12','2024-12-11 00:36:19',12,3),(98,12,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 17:58:14','2024-12-10 17:58:14',12,3),(99,2,'New speaker registration: aa',1,'2024-12-10 17:58:54','2024-12-11 00:36:05',13,3),(100,13,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 17:58:54','2024-12-10 17:58:54',13,3),(101,2,'New speaker registration: aa',1,'2024-12-10 18:00:27','2024-12-11 00:36:01',14,3),(102,14,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:00:27','2024-12-10 18:00:27',14,3),(103,2,'New speaker registration: aa',1,'2024-12-10 18:01:34','2024-12-11 00:35:58',15,3),(104,15,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:01:34','2024-12-10 18:01:34',15,3),(105,2,'New speaker registration: aa',1,'2024-12-10 18:04:29','2024-12-11 00:36:19',16,3),(107,2,'New speaker registration: aa',1,'2024-12-10 18:19:38','2024-12-11 00:35:50',17,3),(108,17,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:19:38','2024-12-10 18:19:38',17,3),(109,2,'New speaker registration: aa',1,'2024-12-10 18:19:51','2024-12-12 00:51:19',18,3),(110,18,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:19:51','2024-12-10 18:19:51',18,3),(111,2,'New speaker registration: aa',1,'2024-12-10 18:20:17','2024-12-11 16:12:36',19,3),(112,19,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:20:17','2024-12-10 18:20:17',19,3),(113,2,'New speaker registration: John Doe',1,'2024-12-10 18:41:27','2024-12-11 19:21:26',20,3),(114,20,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:41:27','2024-12-10 18:41:27',20,3),(115,2,'New speaker registration: John Doe',1,'2024-12-10 18:42:05','2024-12-11 00:35:49',21,3),(116,21,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:42:05','2024-12-10 18:42:05',21,3),(117,2,'New speaker registration: aa',1,'2024-12-10 18:43:15','2024-12-11 19:27:09',22,3),(118,22,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:43:15','2024-12-10 18:43:15',22,3),(119,2,'New speaker registration: John Doe',1,'2024-12-10 18:44:55','2024-12-11 00:34:09',23,3),(120,23,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:44:55','2024-12-10 18:44:55',23,3),(121,2,'New speaker registration: John Doe',1,'2024-12-10 18:46:06','2024-12-11 00:34:08',24,3),(122,24,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:46:06','2024-12-10 18:46:06',24,3),(123,2,'New speaker registration: John Doe',1,'2024-12-10 18:46:30','2024-12-11 00:35:49',25,3),(124,25,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-10 18:46:30','2024-12-10 18:46:30',25,3),(125,2,'New speaker registration: aa',1,'2024-12-10 18:59:50','2024-12-11 00:34:11',26,3),(126,26,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',1,'2024-12-10 18:59:50','2024-12-11 21:52:55',26,3),(127,26,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',1,'2024-12-10 19:01:48','2024-12-11 21:52:59',NULL,3),(128,2,'New speaker registration: fff',1,'2024-12-10 19:03:09','2024-12-11 00:35:56',27,3),(129,27,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',1,'2024-12-10 19:03:09','2024-12-11 19:24:29',27,3),(130,27,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',1,'2024-12-10 19:03:38','2024-12-11 19:24:26',NULL,3),(131,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 19:04:32','2024-12-11 21:53:02',26,3),(132,2,'New visa request from user: aa for conference: International',1,'2024-12-10 19:04:32','2024-12-11 00:34:07',26,3),(133,26,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',1,'2024-12-10 19:08:37','2024-12-11 21:53:09',26,NULL),(134,26,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',1,'2024-12-10 19:12:18','2024-12-11 21:53:02',26,NULL),(135,26,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',1,'2024-12-10 19:12:20','2024-12-11 21:53:13',26,NULL),(136,26,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',1,'2024-12-10 19:12:49','2024-12-11 21:53:08',26,NULL),(137,26,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',1,'2024-12-10 19:12:49','2024-12-11 21:52:52',26,NULL),(138,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 19:16:14','2024-12-11 21:53:11',26,3),(139,2,'New visa request from user: aa for conference: International',1,'2024-12-10 19:16:14','2024-12-11 00:34:03',26,3),(140,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 19:17:35','2024-12-11 21:52:52',26,3),(141,2,'New visa request from user: aa for conference: International',1,'2024-12-10 19:17:35','2024-12-11 00:35:55',26,3),(142,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 20:04:19','2024-12-11 21:52:50',26,3),(143,2,'New visa request from user: aa for conference: International',1,'2024-12-10 20:04:19','2024-12-11 00:34:01',26,3),(144,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 20:16:31','2024-12-11 20:22:35',26,3),(145,2,'New visa request from user: aa for conference: International',1,'2024-12-10 20:16:32','2024-12-11 00:34:05',26,3),(146,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 20:20:30','2024-12-11 21:52:49',26,3),(147,2,'New visa request from user: aa for conference: International',1,'2024-12-10 20:20:30','2024-12-11 00:34:00',26,3),(148,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 20:36:47','2024-12-11 21:45:07',26,3),(149,2,'New visa request from user: aa for conference: International',1,'2024-12-10 20:36:47','2024-12-11 00:34:12',26,3),(150,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 20:54:23','2024-12-11 20:21:43',26,3),(151,2,'New visa request from user: aa for conference: International',1,'2024-12-10 20:54:24','2024-12-11 00:33:56',26,3),(152,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 20:55:12','2024-12-11 20:22:34',26,3),(153,2,'New visa request from user: aa for conference: International',1,'2024-12-10 20:55:12','2024-12-11 00:33:57',26,3),(154,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 20:56:40','2024-12-11 20:21:41',26,3),(155,2,'New visa request from user: aa for conference: International',1,'2024-12-10 20:56:40','2024-12-11 00:33:58',26,3),(156,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-10 20:57:23','2024-12-11 00:31:50',26,3),(157,2,'New visa request from user: aa for conference: International',1,'2024-12-10 20:57:23','2024-12-11 00:34:04',26,3),(158,2,'New speaker registration: ╪¿╪¿╪¿╪¿╪¿╪¿╪¿╪¿',1,'2024-12-11 00:33:10','2024-12-11 00:33:50',28,3),(159,28,'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',0,'2024-12-11 00:33:10','2024-12-11 00:33:10',28,3),(160,26,'Your visa has been approved.',1,'2024-12-11 00:34:15','2024-12-11 20:21:40',26,NULL),(161,8,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',1,'2024-12-11 16:04:38','2024-12-12 16:18:02',NULL,NULL),(162,2,'New flight registered by ayat. Log in to adjust the price.',1,'2024-12-11 16:04:38','2024-12-11 16:19:57',8,NULL),(163,8,'The ticket will be available shortly, and you will be notified on the website once it becomes available.',1,'2024-12-11 16:04:41','2024-12-12 16:18:01',NULL,NULL),(164,2,'New flight registered by ayat. Log in to adjust the price.',1,'2024-12-11 16:04:41','2024-12-11 16:12:30',8,NULL),(165,9,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-11 16:46:09','2024-12-11 16:46:09',NULL,1),(166,28,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-11 16:46:37','2024-12-11 16:46:37',NULL,3),(167,20,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-11 19:21:27','2024-12-11 19:21:27',NULL,3),(168,8,'Your visa has been approved.',1,'2024-12-11 19:22:00','2024-12-12 13:24:39',8,NULL),(169,4,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',1,'2024-12-11 19:22:43','2024-12-14 22:30:58',NULL,1),(170,23,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-11 19:23:18','2024-12-11 19:23:18',NULL,3),(171,27,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-11 19:24:51','2024-12-11 19:24:51',27,3),(172,27,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-11 19:25:04','2024-12-11 19:25:04',27,3),(173,27,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-11 19:25:10','2024-12-11 19:25:10',27,3),(174,27,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-11 19:25:23','2024-12-11 19:25:23',27,3),(175,27,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-11 19:25:24','2024-12-11 19:25:24',27,3),(176,27,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-11 19:25:28','2024-12-11 19:26:21',27,3),(177,27,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-11 19:26:01','2024-12-11 19:26:01',27,NULL),(178,27,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',1,'2024-12-11 19:26:07','2024-12-11 19:26:20',27,NULL),(179,29,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-12-11 19:29:40','2024-12-11 19:29:40',NULL,3),(180,8,'Your visa has been approved.',1,'2024-12-11 19:31:24','2024-12-12 13:24:38',8,NULL),(181,22,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-11 19:34:19','2024-12-11 19:34:19',NULL,3),(182,24,'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',0,'2024-12-11 19:34:36','2024-12-11 19:34:36',NULL,3),(183,30,'You will be contacted directly by the organizing company via email.',0,'2024-12-11 19:35:31','2024-12-11 19:35:31',NULL,NULL),(184,31,'You will be contacted directly by the organizing company via email.',1,'2024-12-11 19:42:49','2024-12-11 20:08:53',NULL,NULL),(185,2,'New sponsor registration: n@gmail.com',1,'2024-12-11 19:42:51','2024-12-11 19:43:14',31,NULL),(186,31,'Your sponsorship has been approved. Thank you for becoming a sponsor for our conference. We look forward to your valuable contribution.',1,'2024-12-11 19:43:24','2024-12-11 20:08:50',NULL,NULL),(187,2,'Sponsor approved: n@gmail.com',1,'2024-12-11 19:43:38','2024-12-11 20:09:06',31,NULL),(188,32,'You will be contacted directly by the organizing company via email.',0,'2024-12-11 21:10:03','2024-12-11 21:10:03',NULL,NULL),(189,2,'New sponsor registration: mm@gmail.com',1,'2024-12-11 21:10:04','2024-12-11 22:30:41',32,NULL),(190,33,'You will be contacted directly by the organizing company via email.',0,'2024-12-11 21:13:45','2024-12-11 21:13:45',NULL,NULL),(191,2,'New sponsor registration: klkl@gmail.com',1,'2024-12-11 21:13:45','2024-12-11 22:31:15',33,NULL),(192,26,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',1,'2024-12-11 21:43:16','2024-12-11 21:44:44',26,3),(193,2,'New visa request from user: aa for conference: International',1,'2024-12-11 21:43:16','2024-12-11 21:43:56',26,3),(194,26,'Your visa has been approved.',1,'2024-12-11 21:44:00','2024-12-11 21:44:35',26,NULL),(195,33,'Your sponsorship has been approved. Thank you for becoming a sponsor for our conference. We look forward to your valuable contribution.',0,'2024-12-11 22:30:53','2024-12-11 22:30:53',NULL,NULL),(196,2,'Sponsor approved: klkl@gmail.com',1,'2024-12-11 22:31:13','2024-12-12 00:49:23',33,NULL),(197,34,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-12-12 00:53:34','2024-12-12 00:53:34',NULL,3),(198,2,'New group registration: yu@gmail.com',0,'2024-12-12 00:53:34','2024-12-12 00:53:34',34,NULL),(199,35,'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',0,'2024-12-12 01:03:55','2024-12-12 01:03:55',NULL,3),(200,2,'New group registration: adm┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘äin@gmail.com',1,'2024-12-12 01:03:55','2024-12-12 13:13:35',35,NULL),(201,8,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',1,'2024-12-12 15:35:34','2024-12-12 17:44:02',8,NULL),(202,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-13 19:55:57','2024-12-13 19:55:57',8,1),(203,2,'New visa request from user: ayat for conference: fff',0,'2024-12-13 19:56:00','2024-12-13 19:56:00',8,1),(204,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-13 19:57:07','2024-12-13 19:57:07',8,1),(205,2,'New visa request from user: ayat for conference: fff',0,'2024-12-13 19:57:07','2024-12-13 19:57:07',8,1),(206,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-13 19:59:29','2024-12-13 19:59:29',8,1),(207,2,'New visa request from user: ayat for conference: fff',1,'2024-12-13 19:59:29','2024-12-14 23:13:47',8,1),(208,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-13 20:12:49','2024-12-13 20:12:49',8,1),(209,2,'New visa request from user: ayat for conference: fff',1,'2024-12-13 20:12:49','2024-12-14 19:43:36',8,1),(210,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-13 20:33:17','2024-12-13 20:33:17',8,1),(211,2,'New visa request from user: ayat for conference: fff',1,'2024-12-13 20:33:17','2024-12-14 19:39:28',8,1),(212,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-13 20:39:41','2024-12-13 20:39:41',8,1),(213,2,'New visa request from user: ayat for conference: fff',1,'2024-12-13 20:39:41','2024-12-14 19:38:26',8,1),(214,8,'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',0,'2024-12-13 20:48:03','2024-12-13 20:48:03',8,1),(215,2,'New visa request from user: ayat for conference: fff',1,'2024-12-13 20:48:03','2024-12-14 19:36:16',8,1),(216,8,'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.',0,'2024-12-14 18:19:05','2024-12-14 18:19:05',8,NULL),(217,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-14 18:21:29','2024-12-14 18:21:29',8,NULL),(218,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-14 18:22:51','2024-12-14 18:22:51',8,NULL),(219,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-14 18:23:52','2024-12-14 18:23:52',8,NULL),(220,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-14 18:24:38','2024-12-14 18:24:38',8,NULL),(221,8,'It will be confirmed through a message sent to his WhatsApp, containing the driver\'s name and phone number.',0,'2024-12-14 18:24:54','2024-12-14 18:24:54',8,NULL),(222,8,'Your visa has been approved.',0,'2024-12-14 19:38:07','2024-12-14 19:38:07',8,NULL),(223,8,'Your visa has been approved.',0,'2024-12-14 23:13:49','2024-12-14 23:13:49',8,NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ourclients`
--

DROP TABLE IF EXISTS `ourclients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ourclients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ourclients`
--

LOCK TABLES `ourclients` WRITE;
/*!40000 ALTER TABLE `ourclients` DISABLE KEYS */;
INSERT INTO `ourclients` VALUES (13,'images/oqVBOI6CiOJKeURGC8ioGnfituOYSldr5dBSq3a6.jpg',NULL,'2024-12-11 14:40:09','2024-12-11 14:40:09'),(14,'images/mWmNuthWefBrccuK6BugR3naF9r5BA4MH6kybhzX.jpg',NULL,'2024-12-11 14:43:10','2024-12-11 14:43:10'),(15,'images/DItAkBdpXVD5WVasvDCHaY4QbfhCb5EYCyMoozBZ.jpg',NULL,'2024-12-11 14:44:17','2024-12-11 14:44:17'),(21,'images/AF5PegxKk7S2B4hHP1ZB1CSkY5ITJMHi7eoLFNDY.jpg',NULL,'2024-12-14 19:22:41','2024-12-14 19:22:41'),(22,'images/nRzO9eka9g4q7U4T40fUihES6S8bPH5ueXUtyZGo.jpg',NULL,'2024-12-14 19:23:15','2024-12-14 19:23:15'),(23,'images/MfSnos4DnvlfB85LofPmL2ZWaTlrxdDxkDnaql1Q.jpg',NULL,'2024-12-14 19:23:30','2024-12-14 19:23:30'),(24,'images/BUuQMVff7UQ5AIZ0QnkEk00rGKhC28whbxQBaKdr.jpg',NULL,'2024-12-14 19:23:59','2024-12-14 19:23:59'),(25,'images/5egEXcAQPK9mB7Fj7MfWFHCZqyBxUQyCkA7wscYr.jpg',NULL,'2024-12-14 19:24:13','2024-12-14 19:24:13'),(26,'images/8B1yvSEhKRxNBccI13gD9xjmiqopuSdLSA0V0LcW.jpg',NULL,'2024-12-14 19:24:29','2024-12-14 19:24:29'),(29,'images/KIzqoie6uX1huZ9fYgCP7KloM2cvkThdtnv9rpwr.png',NULL,'2024-12-14 19:27:43','2024-12-14 19:27:43');
/*!40000 ALTER TABLE `ourclients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `papers`
--

DROP TABLE IF EXISTS `papers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `papers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `abstract` varchar(500) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `status` enum('under review','accepted','rejected') NOT NULL DEFAULT 'under review',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `papers_user_id_foreign` (`user_id`),
  KEY `papers_conference_id_foreign` (`conference_id`),
  CONSTRAINT `papers_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `papers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `papers`
--

LOCK TABLES `papers` WRITE;
/*!40000 ALTER TABLE `papers` DISABLE KEYS */;
/*!40000 ALTER TABLE `papers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',2,'laravel','12a8cfb478ae203115cc76ca1499b339eac37cd44e5b1a1d62d2ba1c8697f50e','[\"*\"]','2024-12-05 18:44:13',NULL,'2024-12-05 18:44:01','2024-12-05 18:44:13'),(2,'App\\Models\\User',2,'laravel','6abd6c78f3d9b2c6fc6522e147ecdb1dbf9483466145a9fad530b9f4d74871e4','[\"*\"]','2024-12-07 17:11:54',NULL,'2024-12-05 18:44:07','2024-12-07 17:11:54'),(3,'App\\Models\\User',2,'laravel','1ac38fc0779116f4e779068647a3bc15799ff369d544d06fde6addb7f776b067','[\"*\"]','2024-12-07 20:07:25',NULL,'2024-12-07 20:04:50','2024-12-07 20:07:25'),(4,'App\\Models\\User',2,'laravel','8bc7ec78baabf330e3b83e13d6b890037cd38135394411163346874dd096223b','[\"*\"]','2024-12-07 20:09:06',NULL,'2024-12-07 20:08:59','2024-12-07 20:09:06'),(5,'App\\Models\\User',3,'laravel','a8e36ad22896fbfd746dde6d4751da0c77bd1ffa88f92399e98a96081ef317cd','[\"*\"]','2024-12-07 20:48:07',NULL,'2024-12-07 20:09:33','2024-12-07 20:48:07'),(6,'App\\Models\\User',3,'laravel','f40fd8d8188b29a19c37d98a27f895d9976774d722fd801d8615506a3c9b5c99','[\"*\"]','2024-12-07 20:37:38',NULL,'2024-12-07 20:36:10','2024-12-07 20:37:38'),(7,'App\\Models\\User',2,'laravel','2c754d59892cdfab6eb136a85d354bab27517c34993cc742c4b5e24c866594c4','[\"*\"]','2024-12-07 21:00:50',NULL,'2024-12-07 21:00:48','2024-12-07 21:00:50'),(8,'App\\Models\\User',2,'laravel','d8c8112fb391802b5e5f02903c584c61e8f71a82fbffb6243593da1142b01853','[\"*\"]','2024-12-08 13:42:09',NULL,'2024-12-08 13:41:51','2024-12-08 13:42:09'),(9,'App\\Models\\User',5,'laravel','d42c68f8b9353fa2e40ededc6c86198b25f725441c89853c0a6068c67564c5c3','[\"*\"]','2024-12-08 13:51:53',NULL,'2024-12-08 13:42:27','2024-12-08 13:51:53'),(10,'App\\Models\\User',5,'laravel','697daca530e50be3022c5d758e875635805b2313b634b3d239f2997dd5612784','[\"*\"]','2024-12-08 14:02:14',NULL,'2024-12-08 13:52:27','2024-12-08 14:02:14'),(11,'App\\Models\\User',5,'laravel','0621cb97221c66701f03bf8efd8e840bcd1b2fe044128557b7030e2da82a3869','[\"*\"]','2024-12-08 14:26:30',NULL,'2024-12-08 14:02:34','2024-12-08 14:26:30'),(12,'App\\Models\\User',5,'laravel','7554c6cbdeafd9290e56bee4296034a127edecc3a4255dd2142a2eec67b79f09','[\"*\"]','2024-12-08 15:30:33',NULL,'2024-12-08 15:10:05','2024-12-08 15:30:33'),(13,'App\\Models\\User',5,'laravel','2333ba8d09b5e17198668483ee4b92d894248756766f51d376680cd38d61a7a1','[\"*\"]','2024-12-08 15:31:08',NULL,'2024-12-08 15:30:51','2024-12-08 15:31:08'),(14,'App\\Models\\User',5,'laravel','1ca84344fb154b79bac0a5cb565166b79ab711821f164dd7e64e4e82a2801dff','[\"*\"]','2024-12-08 15:31:28',NULL,'2024-12-08 15:31:25','2024-12-08 15:31:28'),(15,'App\\Models\\User',2,'laravel','b979f712dba341aabccbea0d0b14a123f0ec288dfd6890b7e0f3febb974792a9','[\"*\"]','2024-12-08 15:38:38',NULL,'2024-12-08 15:31:46','2024-12-08 15:38:38'),(16,'App\\Models\\User',5,'laravel','51a1563da39ef18b03781800a122d7ea49c11c907650f7288af69a6511b7b6c9','[\"*\"]','2024-12-08 15:40:19',NULL,'2024-12-08 15:38:54','2024-12-08 15:40:19'),(17,'App\\Models\\User',5,'laravel','9091fb22e6559d45732334cc0bc13b75e07a4a1ed60a40b53bba641f95df95fb','[\"*\"]','2024-12-08 15:45:56',NULL,'2024-12-08 15:40:37','2024-12-08 15:45:56'),(18,'App\\Models\\User',5,'laravel','dd44833712cda9a7be8d1cc72df475da876983ed22af704de9bd4e09814118e8','[\"*\"]','2024-12-08 15:49:08',NULL,'2024-12-08 15:46:12','2024-12-08 15:49:08'),(19,'App\\Models\\User',6,'laravel','b18541209db3e1081643ec8e3140303474bd271850fdbd2096f7c9a627bf999e','[\"*\"]',NULL,NULL,'2024-12-08 15:48:54','2024-12-08 15:48:54'),(20,'App\\Models\\User',2,'laravel','d463137d39265f102050de351134f3c8c4a58fdfee1f775667ebd3772bd965a4','[\"*\"]','2024-12-08 15:49:48',NULL,'2024-12-08 15:49:31','2024-12-08 15:49:48'),(21,'App\\Models\\User',6,'laravel','0e82728b72c9e4a574f80ddf453811373f3c26feb248048cad4c89fd0d1a07a9','[\"*\"]','2024-12-08 15:51:49',NULL,'2024-12-08 15:50:08','2024-12-08 15:51:49'),(22,'App\\Models\\User',2,'laravel','c5436e871fcccc218210921b3f911873d036de8529b434f6e93f0788825bba4b','[\"*\"]','2024-12-08 15:55:41',NULL,'2024-12-08 15:55:15','2024-12-08 15:55:41'),(23,'App\\Models\\User',7,'laravel','ceb6f71e15bc4f852cd5f835d9ec674e9df2ab843041d05d9407035fb567fb4c','[\"*\"]','2024-12-08 15:58:01',NULL,'2024-12-08 15:56:06','2024-12-08 15:58:01'),(24,'App\\Models\\User',2,'laravel','fb20d8a5afc0af0f493dcf100e9eacf02ac23a0802c3ff42ff40e6252a1be4ff','[\"*\"]','2024-12-08 15:59:16',NULL,'2024-12-08 15:58:37','2024-12-08 15:59:16'),(25,'App\\Models\\User',7,'laravel','8dc6a852e7640eb3a5e5ac2a037450e24493ede0ae22abc92d2a9907c1ab36f0','[\"*\"]','2024-12-08 16:10:10',NULL,'2024-12-08 15:59:33','2024-12-08 16:10:10'),(26,'App\\Models\\User',2,'laravel','2fc7dcf613dd644885bb262689d855d9f6abdc4af20778123dabeceaa1231c61','[\"*\"]','2024-12-08 16:11:06',NULL,'2024-12-08 16:10:28','2024-12-08 16:11:06'),(27,'App\\Models\\User',7,'laravel','469ac9235294ee5f72604f5ae5a3c4c23de4e15b8bcab7659a2888f5b12fd07b','[\"*\"]','2024-12-08 16:19:43',NULL,'2024-12-08 16:11:20','2024-12-08 16:19:43'),(28,'App\\Models\\User',2,'laravel','607cda08fdc1a0ee8533495a471ca55cf9c383154240c002b1e76a6e437e019f','[\"*\"]','2024-12-08 16:20:11',NULL,'2024-12-08 16:20:04','2024-12-08 16:20:11'),(29,'App\\Models\\User',7,'laravel','1db0d7d7a5816f79c8eacb65fede4168095023b28eecf87d5c664204d27c0b01','[\"*\"]','2024-12-08 16:20:44',NULL,'2024-12-08 16:20:30','2024-12-08 16:20:44'),(30,'App\\Models\\User',5,'laravel','d4f4b503e7dd1f300518d0f4f299c2733447a69ef708f586484df18e0af0939f','[\"*\"]','2024-12-08 16:29:39',NULL,'2024-12-08 16:29:31','2024-12-08 16:29:39'),(31,'App\\Models\\User',5,'laravel','d1d1681974dd9b4b16647544fb1f27cbf909a0ed0aa3eb8b0408046023d52e20','[\"*\"]','2024-12-08 16:30:10',NULL,'2024-12-08 16:30:03','2024-12-08 16:30:10'),(32,'App\\Models\\User',2,'laravel','745241003f44056409d7a6037bed0bf4fa4149f8edbb4e4928ef9f7c04229bc8','[\"*\"]','2024-12-08 16:32:03',NULL,'2024-12-08 16:31:52','2024-12-08 16:32:03'),(33,'App\\Models\\User',8,'laravel','19cc30de928ac6eaeba6370d706a703af6b2b8e058efb942ac43b9a9ea021644','[\"*\"]','2024-12-08 16:38:21',NULL,'2024-12-08 16:32:16','2024-12-08 16:38:21'),(34,'App\\Models\\User',2,'laravel','ac49d62a7225c66b8b2947a2ae0e44b10e705270efafed7dc52ca27e91339df6','[\"*\"]','2024-12-08 16:47:00',NULL,'2024-12-08 16:41:59','2024-12-08 16:47:00'),(35,'App\\Models\\User',7,'laravel','e80581db9cff65928c4a55405dc77a79f4e1a9bf017d51f94d0ce0c009da1ad9','[\"*\"]','2024-12-08 16:49:07',NULL,'2024-12-08 16:47:17','2024-12-08 16:49:07'),(36,'App\\Models\\User',8,'laravel','0d2cf98bf6cb9311e2c20fa8ff308741e3076e9580ce82b3b0fc1eb4b14d8dde','[\"*\"]','2024-12-08 16:52:59',NULL,'2024-12-08 16:50:19','2024-12-08 16:52:59'),(37,'App\\Models\\User',8,'laravel','6e1909bf574c90b0658883dd96a810d7494de7dddf828a8d0c7d2113614ddc1e','[\"*\"]','2024-12-08 16:55:46',NULL,'2024-12-08 16:53:21','2024-12-08 16:55:46'),(38,'App\\Models\\User',8,'laravel','28f8f71b4548e1e06691e2b4e205dc2fa88acbc5822bf07a563f83036d56d71c','[\"*\"]','2024-12-08 17:08:20',NULL,'2024-12-08 16:56:23','2024-12-08 17:08:20'),(39,'App\\Models\\User',2,'laravel','5024ef7b8a8aaac3f5c1685be969afe246270af7cd393797ea2febd8fc7d0ac2','[\"*\"]','2024-12-08 17:30:15',NULL,'2024-12-08 17:12:19','2024-12-08 17:30:15'),(40,'App\\Models\\User',2,'laravel','7bc9a73a51c4a78b39a50a12aabbfa8a091896647fc3edcd29213b8f076685bc','[\"*\"]','2024-12-08 17:43:26',NULL,'2024-12-08 17:43:16','2024-12-08 17:43:26'),(41,'App\\Models\\User',2,'laravel','dfe32e98a16cd5218f0c44d4a50e59a9399e1c0f4c8bba7f7421b0485f608507','[\"*\"]','2024-12-08 21:41:57',NULL,'2024-12-08 17:47:22','2024-12-08 21:41:57'),(42,'App\\Models\\User',8,'laravel','4e79033754d28c2e818558d25e220714f144126602eea1e0af459437876b6901','[\"*\"]','2024-12-08 21:45:04',NULL,'2024-12-08 21:45:02','2024-12-08 21:45:04'),(43,'App\\Models\\User',8,'laravel','a66d003fee6b9b461fff88b5915cd65a77aa8093df9147ff2e991f84720b4230','[\"*\"]','2024-12-11 16:29:37',NULL,'2024-12-08 21:53:38','2024-12-11 16:29:37'),(44,'App\\Models\\User',8,'laravel','ad6b993fca52abf580722e76ec54c5d6095e76f7d0caead2ebd5711787bdedd9','[\"*\"]','2024-12-09 13:43:34',NULL,'2024-12-09 13:43:24','2024-12-09 13:43:34'),(45,'App\\Models\\User',8,'laravel','18c50841df8f0437621e7f7ab5255cdff1e4de0529b5739a20c1a476aa85ecd0','[\"*\"]','2024-12-09 15:33:43',NULL,'2024-12-09 15:33:39','2024-12-09 15:33:43'),(46,'App\\Models\\User',8,'laravel','d5b03bb3b53b1a0242679d6d5341a316c1ad874798644d36f2e2c9a42580ae8f','[\"*\"]','2024-12-09 15:33:53',NULL,'2024-12-09 15:33:40','2024-12-09 15:33:53'),(47,'App\\Models\\User',8,'laravel','5c476a9f730392288b8687fc49851a6adc2a93c0f23725fd5522af42b787b567','[\"*\"]','2024-12-09 16:04:20',NULL,'2024-12-09 16:04:15','2024-12-09 16:04:20'),(48,'App\\Models\\User',8,'laravel','5e51a59524a3f15475223ff221bc78bd0b64952e2ac87d2634285a69122eeb63','[\"*\"]','2024-12-09 16:59:45',NULL,'2024-12-09 16:04:28','2024-12-09 16:59:45'),(49,'App\\Models\\User',8,'laravel','ab60d2d03420a73512ad66a8131348272459463e27ebbc864c951757d6f9103c','[\"*\"]','2024-12-09 17:42:52',NULL,'2024-12-09 16:59:50','2024-12-09 17:42:52'),(50,'App\\Models\\User',2,'laravel','5f54d4bdc602a7dec3c43a1b2aaa9336bf94172ccc660813371b1e663a754b1e','[\"*\"]','2024-12-09 17:45:21',NULL,'2024-12-09 17:45:19','2024-12-09 17:45:21'),(51,'App\\Models\\User',8,'laravel','44b78670da4512ea5577135db50766316ea93ee380f2d144abb920e11e4ac703','[\"*\"]','2024-12-09 19:02:38',NULL,'2024-12-09 18:39:25','2024-12-09 19:02:38'),(52,'App\\Models\\User',8,'laravel','7c954a1cf281841ac7bf8d95b53d67c28cc53b9f9146068f3af72106c4391c9c','[\"*\"]','2024-12-09 19:11:04',NULL,'2024-12-09 19:02:49','2024-12-09 19:11:04'),(53,'App\\Models\\User',8,'laravel','f1254cddabe5d22957beccfa366547bd66eca4ab15cc6f4b02a8c589eeda12e7','[\"*\"]','2024-12-09 19:12:16',NULL,'2024-12-09 19:11:12','2024-12-09 19:12:16'),(54,'App\\Models\\User',8,'laravel','c937ec250cc6e2915cea64210ae63143fc7dab809994b6a5a3bc92044342fea1','[\"*\"]','2024-12-09 19:13:26',NULL,'2024-12-09 19:12:20','2024-12-09 19:13:26'),(55,'App\\Models\\User',2,'laravel','d341bab4f29dcf9c382ab653276b285c3354491d942e138d329b3360837688c1','[\"*\"]','2024-12-09 19:15:13',NULL,'2024-12-09 19:15:00','2024-12-09 19:15:13'),(56,'App\\Models\\User',10,'laravel','e62c6a501176b21f325e02d9aa5e4c784590df6c40f786ddcd3c22d8d154559f','[\"*\"]','2024-12-09 19:37:20',NULL,'2024-12-09 19:15:25','2024-12-09 19:37:20'),(57,'App\\Models\\User',8,'laravel','479dcdb2a53a17ae15fd5b216fcaeefa6d34679627f1af9cc5287210a4c5d7d2','[\"*\"]','2024-12-09 19:37:34',NULL,'2024-12-09 19:37:27','2024-12-09 19:37:34'),(58,'App\\Models\\User',10,'laravel','48e0043b15db6679df54e7502f3c3ac1714e33c249a685bf9892daf5eff782dd','[\"*\"]','2024-12-09 20:00:10',NULL,'2024-12-09 19:37:48','2024-12-09 20:00:10'),(59,'App\\Models\\User',10,'laravel','fc6eb17a8a635e6191ad9489553f9e69910296dfab714d64659758b928089179','[\"*\"]','2024-12-09 20:41:55',NULL,'2024-12-09 20:02:22','2024-12-09 20:41:55'),(60,'App\\Models\\User',2,'laravel','ab4bd947f209439c946267aec5d98b97d9b98bc3ff2a3396bb74ce2255c5e07a','[\"*\"]','2024-12-09 20:43:52',NULL,'2024-12-09 20:42:23','2024-12-09 20:43:52'),(61,'App\\Models\\User',10,'laravel','ca65eaec890a3d0cdcbb316d512f29fd17537396646e9a89ffb8780c0345806a','[\"*\"]','2024-12-09 20:51:01',NULL,'2024-12-09 20:44:24','2024-12-09 20:51:01'),(62,'App\\Models\\User',8,'laravel','e3799ab9d403a8057ad64c355d083fe2c7caf5514b86d32da2085c2d242ae425','[\"*\"]','2024-12-09 20:52:36',NULL,'2024-12-09 20:52:28','2024-12-09 20:52:36'),(63,'App\\Models\\User',10,'laravel','1293529f078d0cd151df2336cb5096f51b151ab49844ff5e8acb0d01df5e0b71','[\"*\"]','2024-12-09 21:01:20',NULL,'2024-12-09 20:53:02','2024-12-09 21:01:20'),(64,'App\\Models\\User',10,'laravel','5408e28dc81f13d7d499ba4190eda8d66822a94f9b344aa0c15051549d97e005','[\"*\"]','2024-12-10 13:11:25',NULL,'2024-12-09 21:01:46','2024-12-10 13:11:25'),(65,'App\\Models\\User',8,'laravel','9e51fdad78fa1d7b289ebaa39c2e9042e504e400b96d03cd69ca0183cf99f8fd','[\"*\"]','2024-12-10 12:53:06',NULL,'2024-12-10 12:53:03','2024-12-10 12:53:06'),(66,'App\\Models\\User',2,'laravel','773965bb560faaa2908bc4585a65cada3d9e5a39080f58a9dc3aebec37f66229','[\"*\"]','2024-12-10 12:53:20',NULL,'2024-12-10 12:53:18','2024-12-10 12:53:20'),(67,'App\\Models\\User',2,'laravel','83aa717cd4dbfb0ac937126dee0086dff5624a182cbf1cc088d9c15745dab0f2','[\"*\"]','2024-12-10 12:53:53',NULL,'2024-12-10 12:53:51','2024-12-10 12:53:53'),(68,'App\\Models\\User',2,'laravel','77fe8ada9b2906c1682bc57e944303f01f0db6e3b044842fc3fe4259dd148f61','[\"*\"]','2024-12-10 12:57:06',NULL,'2024-12-10 12:55:26','2024-12-10 12:57:06'),(69,'App\\Models\\User',8,'laravel','4ea6e663d78dba1e94625c6b5aab8d9e224b7ab8fe470725ae05c01d625d9670','[\"*\"]','2024-12-10 13:19:43',NULL,'2024-12-10 13:19:40','2024-12-10 13:19:43'),(70,'App\\Models\\User',2,'laravel','bd01327aa96d6f075b3a232b23ea8a0f6bf9fc51f75a676259d9a7640584a69f','[\"*\"]','2024-12-10 13:29:59',NULL,'2024-12-10 13:25:12','2024-12-10 13:29:59'),(71,'App\\Models\\User',10,'laravel','4f8f63ed96c4e4e032d1f2c70f3f46298065f719158efd8671e7d672f3209926','[\"*\"]','2024-12-10 13:34:27',NULL,'2024-12-10 13:30:15','2024-12-10 13:34:27'),(72,'App\\Models\\User',2,'laravel','93d81ed48b924d796760b8b70f978d5af844b425fdcbb85767e80ad42ec8ac6a','[\"*\"]','2024-12-10 13:35:36',NULL,'2024-12-10 13:34:39','2024-12-10 13:35:36'),(73,'App\\Models\\User',2,'laravel','0ef05fc56b62984894a2dab6d61ca6525d15abeaa48f5a56ab7296e8810fffb7','[\"*\"]','2024-12-10 14:26:57',NULL,'2024-12-10 14:22:16','2024-12-10 14:26:57'),(74,'App\\Models\\User',8,'laravel','d79d3a3a08f60a51eafdc66c885532caa5271460742e62c14be249e5518990eb','[\"*\"]','2024-12-10 14:27:20',NULL,'2024-12-10 14:27:18','2024-12-10 14:27:20'),(75,'App\\Models\\User',8,'laravel','cd5c427a9d4797f8e0a964a3c297de8c0a3cba9fcf294bf310d4c2c18e2071bf','[\"*\"]','2024-12-10 14:29:51',NULL,'2024-12-10 14:29:40','2024-12-10 14:29:51'),(76,'App\\Models\\User',2,'laravel','37fd82b80b3e06c8a3058f39a339eb6b8b269ac02f04240505053f2cbb624704','[\"*\"]','2024-12-10 14:31:23',NULL,'2024-12-10 14:30:15','2024-12-10 14:31:23'),(77,'App\\Models\\User',8,'laravel','49391981f4015238cc16b1e483ce2d8244e6775dcaaa0b6060ecc24aa5ddb6ee','[\"*\"]','2024-12-10 14:32:14',NULL,'2024-12-10 14:31:36','2024-12-10 14:32:14'),(78,'App\\Models\\User',2,'laravel','53072e4b34d15fa55f3aefa7bb4e987d689a2e66b68b5c6e6ebaf90ff9c4e05f','[\"*\"]','2024-12-10 14:33:53',NULL,'2024-12-10 14:32:33','2024-12-10 14:33:53'),(79,'App\\Models\\User',3,'laravel','7c19818631d4648811e6172eafaece9f7c22315b57c9d061f1e183e19701d321','[\"*\"]','2024-12-10 14:34:31',NULL,'2024-12-10 14:34:00','2024-12-10 14:34:31'),(80,'App\\Models\\User',2,'laravel','aacb70624bc64282f35e70b5102a169fd508ef83865b4ddad55fe2a3edf521ea','[\"*\"]','2024-12-10 14:35:06',NULL,'2024-12-10 14:34:37','2024-12-10 14:35:06'),(81,'App\\Models\\User',2,'laravel','0e9dab98ce15359b376e8adce02cc1c48e6b46da7cdf8dd4af627ba506e4e378','[\"*\"]','2024-12-10 14:46:37',NULL,'2024-12-10 14:46:28','2024-12-10 14:46:37'),(82,'App\\Models\\User',11,'laravel','aad28a466ec5dcadedd10cfc597e22a5a28be306db49a14ce3e1f0a9ce0b4af2','[\"*\"]','2024-12-10 15:32:37',NULL,'2024-12-10 14:46:52','2024-12-10 15:32:37'),(83,'App\\Models\\User',2,'laravel','c73c59d67e1500c6ae9621f050040769f5e492c225c0ed2deb8774ac1a5b666b','[\"*\"]','2024-12-10 15:39:24',NULL,'2024-12-10 15:34:06','2024-12-10 15:39:24'),(84,'App\\Models\\User',2,'laravel','ad97df4ddb6cf8d93bb6b9d8af22402de676962001ef03c235686363ff7f3533','[\"*\"]','2024-12-10 17:35:40',NULL,'2024-12-10 17:33:32','2024-12-10 17:35:40'),(85,'App\\Models\\User',2,'laravel','2704766f97edc9f240029acc6a5aeed6f9fe5b6c71a7576ad1afb2e8a5c7757d','[\"*\"]','2024-12-10 17:44:00',NULL,'2024-12-10 17:43:57','2024-12-10 17:44:00'),(86,'App\\Models\\User',2,'laravel','806d6046b79b77097cf5d8471cfd458d126757f652ba14e18295aae26366776c','[\"*\"]','2024-12-11 16:30:59',NULL,'2024-12-10 17:45:59','2024-12-11 16:30:59'),(87,'App\\Models\\User',2,'laravel','c7e5f8c31acc971a975c71a75b457fc6ebd67248e9be00e7d7649d928d2ac128','[\"*\"]','2024-12-10 17:56:43',NULL,'2024-12-10 17:56:41','2024-12-10 17:56:43'),(88,'App\\Models\\User',2,'laravel','27b362ffdb5054c796f2ade362d1cc2350cee08f4a4618f5afff31816dfa9686','[\"*\"]','2024-12-10 19:01:48',NULL,'2024-12-10 19:01:36','2024-12-10 19:01:48'),(89,'App\\Models\\User',2,'laravel','095ac60977a357d9a876cddd113262f7a280145d8f44a5a074f6f919cdd77ab3','[\"*\"]','2024-12-10 19:02:00',NULL,'2024-12-10 19:01:57','2024-12-10 19:02:00'),(90,'App\\Models\\User',26,'laravel','703916c0927cfcea0320a52ab671e7fa14009637b88365934386953e121693c3','[\"*\"]','2024-12-10 19:02:18',NULL,'2024-12-10 19:02:14','2024-12-10 19:02:18'),(91,'App\\Models\\User',2,'laravel','2031b2e3f98c7491a16509fc8266961a243e686376c6a61564f5a4cefce474c2','[\"*\"]','2024-12-10 19:03:38',NULL,'2024-12-10 19:03:28','2024-12-10 19:03:38'),(92,'App\\Models\\User',27,'laravel','63c021c40f3201fff4cec2dbd6c9e70dc4dfef82f6a8f03a5e4cfbab8c6f0229','[\"*\"]','2024-12-10 19:03:56',NULL,'2024-12-10 19:03:52','2024-12-10 19:03:56'),(93,'App\\Models\\User',26,'laravel','c8f264844240f410f11612fdfdedd037de2ec0acb1c90593a418d9081c437e0d','[\"*\"]','2024-12-10 19:04:33',NULL,'2024-12-10 19:04:12','2024-12-10 19:04:33'),(94,'App\\Models\\User',27,'laravel','514c8e03d4043ddca8ba667210628a4663b6942f92677707c7815d7b03dfd478','[\"*\"]','2024-12-10 19:05:33',NULL,'2024-12-10 19:05:26','2024-12-10 19:05:33'),(95,'App\\Models\\User',27,'laravel','523a7e019ba3e8fa6da018b8f2d2f94939694dbe833fcaf4b35e28065e8a7582','[\"*\"]','2024-12-10 19:05:34',NULL,'2024-12-10 19:05:29','2024-12-10 19:05:34'),(96,'App\\Models\\User',26,'laravel','f2ebd4511f649b12cad7288b51784fce97c051190193c03fa9671bbfd6a2b04d','[\"*\"]','2024-12-10 19:06:54',NULL,'2024-12-10 19:05:45','2024-12-10 19:06:54'),(97,'App\\Models\\User',2,'laravel','326f9c53320471b33c496f83b6a0edf294a8f5d7b60b1d89b01f83f7fd8fd4ee','[\"*\"]','2024-12-10 19:07:57',NULL,'2024-12-10 19:07:01','2024-12-10 19:07:57'),(98,'App\\Models\\User',26,'laravel','ea54ca1815242857f6a46f3503c10a06b148a47faf763249c85a3742966c4689','[\"*\"]','2024-12-10 19:08:53',NULL,'2024-12-10 19:08:08','2024-12-10 19:08:53'),(99,'App\\Models\\User',2,'laravel','216efe5c5aa666784bc4aac24416a22feeb32cbff1b4485aa65ae3a020cecb0b','[\"*\"]','2024-12-10 19:11:28',NULL,'2024-12-10 19:08:58','2024-12-10 19:11:28'),(100,'App\\Models\\User',26,'laravel','6d33221a5063010391ef193edd2ab5f3f7b3ddcde319c3a21252ab044a96ab02','[\"*\"]','2024-12-10 19:16:15',NULL,'2024-12-10 19:11:41','2024-12-10 19:16:15'),(101,'App\\Models\\User',26,'laravel','5e005de4a56ca99d2bbd776fa1e751a0a41ac9a23f8da9827fb8fad3fc42ff3a','[\"*\"]','2024-12-10 22:15:49',NULL,'2024-12-10 19:17:16','2024-12-10 22:15:49'),(102,'App\\Models\\User',26,'laravel','39cf940993c1f6b40fee8b8a6a19408d71727fd7487725d78e0e32b3edd42325','[\"*\"]','2024-12-11 00:31:51',NULL,'2024-12-10 22:15:58','2024-12-11 00:31:51'),(103,'App\\Models\\User',26,'laravel','f5131368ed0e8aee040acf9e66eb49a4010735928119a7001a48f6d82dce2d5b','[\"*\"]','2024-12-11 00:32:22',NULL,'2024-12-11 00:31:57','2024-12-11 00:32:22'),(104,'App\\Models\\User',2,'laravel','33caaa9df788296ba17c3fc19e80148f3b05736ef109879ea741ccdb3d861c8c','[\"*\"]','2024-12-11 14:06:21',NULL,'2024-12-11 00:33:33','2024-12-11 14:06:21'),(105,'App\\Models\\User',2,'laravel','d6d4a4d82561db897d8275bd35fa1f4dc80de1faabf4901df6663421c7c059af','[\"*\"]','2024-12-11 14:31:06',NULL,'2024-12-11 14:29:57','2024-12-11 14:31:06'),(106,'App\\Models\\User',2,'laravel','75d2a7b4428f4cb86f8d196564aaa0f4ee9613a94ddf78a8eb9caa445a23d56a','[\"*\"]','2024-12-11 14:59:53',NULL,'2024-12-11 14:39:42','2024-12-11 14:59:53'),(107,'App\\Models\\User',2,'laravel','2ceb6a703715afec215a3af4027717c2eb51df6b7d44a92c3a0a7a01b0855937','[\"*\"]','2024-12-11 16:03:01',NULL,'2024-12-11 15:41:24','2024-12-11 16:03:01'),(108,'App\\Models\\User',8,'laravel','addb1678621bb3faa28e51ace00074a15a936eace83bf99b4ffb0dfe2e910c5e','[\"*\"]','2024-12-11 16:04:57',NULL,'2024-12-11 16:03:19','2024-12-11 16:04:57'),(109,'App\\Models\\User',2,'laravel','bbc07b2eefb8c822aaae98c928d8319d9a7a361277e3506c7e5eafe53d76d6e9','[\"*\"]','2024-12-11 16:15:35',NULL,'2024-12-11 16:05:01','2024-12-11 16:15:35'),(110,'App\\Models\\User',2,'laravel','0a29bc154af664b4dd7e90b82d8231cd744837aea158342b10c664d50445d144','[\"*\"]','2024-12-11 16:17:04',NULL,'2024-12-11 16:15:38','2024-12-11 16:17:04'),(111,'App\\Models\\User',2,'laravel','dfae9e3fd2bc2edb5f616b9b448ddf5cf05b3f7daa0bc522af8a789f7004472a','[\"*\"]','2024-12-11 16:19:40',NULL,'2024-12-11 16:17:10','2024-12-11 16:19:40'),(112,'App\\Models\\User',2,'laravel','5dbcf98544beac1254f167f98797d593ede883fb0cfc2f682f976fb96de5ff87','[\"*\"]','2024-12-11 16:22:28',NULL,'2024-12-11 16:19:48','2024-12-11 16:22:28'),(113,'App\\Models\\User',10,'laravel','ed28bc86abbfa6e64b219f5e80229223b18d9c0f5f720f0513aa592a85e67ba0','[\"*\"]','2024-12-11 16:22:46',NULL,'2024-12-11 16:22:41','2024-12-11 16:22:46'),(114,'App\\Models\\User',10,'laravel','d3fbdd0c947346d4d8646bb5863e572c22179c129e0cd924f20849ce8a8214fd','[\"*\"]','2024-12-11 16:23:37',NULL,'2024-12-11 16:22:43','2024-12-11 16:23:37'),(115,'App\\Models\\User',2,'laravel','14df447bea24b600a824cac891235b9e059def239d316a1a5eea012694bc8379','[\"*\"]','2024-12-11 16:30:02',NULL,'2024-12-11 16:23:45','2024-12-11 16:30:02'),(116,'App\\Models\\User',2,'laravel','db6df2c1f8a7fa3a442863d49c196ee6cfcbc2a3cf0c0fa1adc8be6533891099','[\"*\"]','2024-12-11 16:39:01',NULL,'2024-12-11 16:30:07','2024-12-11 16:39:01'),(117,'App\\Models\\User',2,'laravel','f60c9243674b975d712a760bd4fdfc441ffd40ec37df2d6e8c1a79a2eff571f9','[\"*\"]','2024-12-11 17:55:01',NULL,'2024-12-11 16:31:02','2024-12-11 17:55:01'),(118,'App\\Models\\User',2,'laravel','921bce625935dc5da135a732b239f4421817b2932f20d2c84d0926eabfd953d4','[\"*\"]','2024-12-11 16:43:28',NULL,'2024-12-11 16:39:04','2024-12-11 16:43:28'),(119,'App\\Models\\User',2,'laravel','e6b88162370b32159d607b5abdd25e3e88e03eb0663a53e711e8092173f42ad6','[\"*\"]','2024-12-11 16:46:54',NULL,'2024-12-11 16:45:34','2024-12-11 16:46:54'),(120,'App\\Models\\User',2,'laravel','ae69a360857a9a0ee13d04dba381406c0dc75c51a9f7b3b370f82097721cc256','[\"*\"]','2024-12-11 16:48:52',NULL,'2024-12-11 16:47:00','2024-12-11 16:48:52'),(121,'App\\Models\\User',2,'laravel','4612561bf164e18e2b20e38b29885c63ec200eba79eaf8be9b369d84c6e97756','[\"*\"]','2024-12-11 16:56:48',NULL,'2024-12-11 16:49:05','2024-12-11 16:56:48'),(122,'App\\Models\\User',2,'laravel','00232542da9258f1ac23cbfa2ca03a60095f09aa6454cba9a48678aac9ba9d81','[\"*\"]','2024-12-11 16:57:01',NULL,'2024-12-11 16:56:56','2024-12-11 16:57:01'),(123,'App\\Models\\User',10,'laravel','41741e4b4906652beff71e31d5a5ead5c2c1c5b8f97f11a8710f734aa85dadf8','[\"*\"]','2024-12-11 17:09:44',NULL,'2024-12-11 16:57:07','2024-12-11 17:09:44'),(124,'App\\Models\\User',10,'laravel','2825bdbf3a85986dca9d8b9c4b2e1a316768207df53bc1f4093e0101d7142fc2','[\"*\"]','2024-12-11 18:25:20',NULL,'2024-12-11 17:09:48','2024-12-11 18:25:20'),(125,'App\\Models\\User',2,'laravel','34687281e071a455840d9d21d43cd8b48ef4c6670491144ae002f7af44333aed','[\"*\"]','2024-12-11 18:02:57',NULL,'2024-12-11 17:55:04','2024-12-11 18:02:57'),(126,'App\\Models\\User',2,'laravel','643866d8fff8ce55e6db202bc7510b23237fdad334f79c4ce6dbc7f663ea36cb','[\"*\"]','2024-12-11 18:07:42',NULL,'2024-12-11 18:03:03','2024-12-11 18:07:42'),(127,'App\\Models\\User',2,'laravel','d09e1ef5b4e19c28ba2a0097cba3a665abff772726c6ef8ea42183217ab2795a','[\"*\"]','2024-12-11 18:14:18',NULL,'2024-12-11 18:13:47','2024-12-11 18:14:18'),(128,'App\\Models\\User',2,'laravel','dd73d0e767b93578bc9438bcbcc86e9082d4df426e6da64ee9f032948b9d476f','[\"*\"]','2024-12-12 00:51:19',NULL,'2024-12-11 18:24:42','2024-12-12 00:51:19'),(129,'App\\Models\\User',10,'laravel','4b6e92153621709c209a980877dbff14a5949dcbd006edbf272e2995ed549352','[\"*\"]','2024-12-11 18:27:54',NULL,'2024-12-11 18:25:23','2024-12-11 18:27:54'),(130,'App\\Models\\User',10,'laravel','c86795038ee44e306822dd0bd522b0cb0bb13c749ca15ef4569c981e941ea04c','[\"*\"]','2024-12-11 18:28:25',NULL,'2024-12-11 18:27:57','2024-12-11 18:28:25'),(131,'App\\Models\\User',10,'laravel','451e8825961b488e9d58c62a85e67abd35dcb114ccab10e7ef3489ec2e75630b','[\"*\"]','2024-12-11 18:29:52',NULL,'2024-12-11 18:28:29','2024-12-11 18:29:52'),(132,'App\\Models\\User',10,'laravel','f01aeb8c5aac6ed7e97fac0523538f5dbfeca7d94751058b68710184819b3914','[\"*\"]','2024-12-11 18:37:14',NULL,'2024-12-11 18:29:54','2024-12-11 18:37:14'),(133,'App\\Models\\User',10,'laravel','264cd0a28dbe44ca94c5aa17b456dfe62b1076a3d3ad2f72c221f3a13fe6d4be','[\"*\"]','2024-12-11 18:38:12',NULL,'2024-12-11 18:37:19','2024-12-11 18:38:12'),(134,'App\\Models\\User',10,'laravel','08674d1ced231a32738f43ad1c6ca664437fcf5694129be84416098d24553b83','[\"*\"]','2024-12-11 18:40:36',NULL,'2024-12-11 18:38:14','2024-12-11 18:40:36'),(135,'App\\Models\\User',10,'laravel','c54de3d00932cad4cdde7a6a04b3c77ad274a294613cff3bfa2663ff7e05d0e2','[\"*\"]','2024-12-11 18:41:09',NULL,'2024-12-11 18:40:41','2024-12-11 18:41:09'),(136,'App\\Models\\User',10,'laravel','9204cb5c7b61f0d90636c95901b3952efc6fcc8ad085fe8b9581300de961374e','[\"*\"]','2024-12-11 18:43:09',NULL,'2024-12-11 18:41:13','2024-12-11 18:43:09'),(137,'App\\Models\\User',10,'laravel','06f42b34b07a2fb10d0e51aa2433569d5b2d9f9e00b75d4c8eb98f75bff014a7','[\"*\"]','2024-12-11 18:52:32',NULL,'2024-12-11 18:43:13','2024-12-11 18:52:32'),(138,'App\\Models\\User',10,'laravel','ffaf0904b02f4ac8144b0e1b66604f0637514f181d46b30d90877e823c23270d','[\"*\"]','2024-12-11 18:54:46',NULL,'2024-12-11 18:52:36','2024-12-11 18:54:46'),(139,'App\\Models\\User',10,'laravel','c8c1440215b6f7b71d277af6636099ca335542e3a3ac3fc16eb04e242fb5f9ba','[\"*\"]','2024-12-11 18:54:52',NULL,'2024-12-11 18:54:49','2024-12-11 18:54:52'),(140,'App\\Models\\User',10,'laravel','222678ced352e3596d010c520bc3f5e8ad30f20ecf324a284d8524445a9f959b','[\"*\"]','2024-12-11 18:57:27',NULL,'2024-12-11 18:57:24','2024-12-11 18:57:27'),(141,'App\\Models\\User',10,'laravel','19c2448bf772b79eb20372fa3c37c022fa20e4fdebbb0174d208ed3d7dd5033f','[\"*\"]','2024-12-11 19:02:03',NULL,'2024-12-11 18:57:37','2024-12-11 19:02:03'),(142,'App\\Models\\User',10,'laravel','3917c7dd8503c76296c86ff5033e6cf21fbd3e10da68d421081b62c4e7fad361','[\"*\"]','2024-12-11 19:05:03',NULL,'2024-12-11 19:02:07','2024-12-11 19:05:03'),(143,'App\\Models\\User',10,'laravel','f1704006c11d43041d72e7c18d708f329eb758ffc7e8565a3d658771ba25998e','[\"*\"]','2024-12-11 19:12:18',NULL,'2024-12-11 19:07:39','2024-12-11 19:12:18'),(144,'App\\Models\\User',10,'laravel','06db6f7343f685849c762f1fb48157bbdd46c13ce2f39821a370b1d7b3ff28b6','[\"*\"]','2024-12-11 19:13:39',NULL,'2024-12-11 19:12:23','2024-12-11 19:13:39'),(145,'App\\Models\\User',10,'laravel','d910c14fbe404de24bea8ff11879d24530f418ed28e3944c8b30105a2953a885','[\"*\"]','2024-12-11 19:18:28',NULL,'2024-12-11 19:13:42','2024-12-11 19:18:28'),(146,'App\\Models\\User',2,'laravel','5b81ecdc9fa006e0f52be714918ee256d9fe89a76fec7c3d7e8ed157a4bff11a','[\"*\"]','2024-12-11 19:23:51',NULL,'2024-12-11 19:21:21','2024-12-11 19:23:51'),(147,'App\\Models\\User',27,'laravel','984a2434daf484608e98ed47158dd7769edcd67dca47ba8ab43b3f30dc979c66','[\"*\"]','2024-12-11 19:26:27',NULL,'2024-12-11 19:24:19','2024-12-11 19:26:27'),(148,'App\\Models\\User',27,'laravel','7a128cb007019f78b8f89e374b6ef0ecd438d8e1ceefe2a5f444e2b8d7a2b289','[\"*\"]','2024-12-11 19:26:53',NULL,'2024-12-11 19:26:36','2024-12-11 19:26:53'),(149,'App\\Models\\User',2,'laravel','81ffb2fc16090c6223462038a29bfc08b2e207d253dbbdc187c0dfa555be8418','[\"*\"]','2024-12-11 19:27:34',NULL,'2024-12-11 19:26:56','2024-12-11 19:27:34'),(150,'App\\Models\\User',2,'laravel','5afed2682da98869f4f03639275c33ba712ac2b4c5cf1e20f18911dd41aa5c2a','[\"*\"]','2024-12-11 19:28:54',NULL,'2024-12-11 19:28:51','2024-12-11 19:28:54'),(151,'App\\Models\\User',2,'laravel','a4146f232e02990556fb43e6153d81ccd2ad0dfcc4d7479f6813cb7369f4347a','[\"*\"]','2024-12-11 19:29:11',NULL,'2024-12-11 19:29:03','2024-12-11 19:29:11'),(152,'App\\Models\\User',29,'laravel','442bf60222d11fd2c5221c3fd9b5c6b96863b3bb357aa71ecd418252b62513d4','[\"*\"]',NULL,NULL,'2024-12-11 19:29:40','2024-12-11 19:29:40'),(153,'App\\Models\\User',2,'laravel','eeb05505fab350080b06050518acde4b876d35efa7baca00ff2bb044d7a3f59f','[\"*\"]','2024-12-11 19:33:32',NULL,'2024-12-11 19:31:09','2024-12-11 19:33:32'),(154,'App\\Models\\User',2,'laravel','fa9717b02d23efad8523ca37ed00366300a12571ce16a6191f61cc19a59b6cc9','[\"*\"]','2024-12-11 19:43:05',NULL,'2024-12-11 19:33:37','2024-12-11 19:43:05'),(155,'App\\Models\\User',2,'laravel','d67b09a91378bdfef05fec175f2d0803e45ee99d341c3d1544f5637c1180c999','[\"*\"]','2024-12-11 20:07:52',NULL,'2024-12-11 19:43:10','2024-12-11 20:07:52'),(156,'App\\Models\\User',2,'laravel','599d073b4b771234729fa01d6de2224738b5b6baeb37a5d6b3bb5bd93f3d7e73','[\"*\"]','2024-12-11 20:08:06',NULL,'2024-12-11 20:07:56','2024-12-11 20:08:06'),(157,'App\\Models\\User',31,'laravel','70069d46f8bfe4bbb525fa7d93cf1d7c7db4e3704391c201c048f9ef258cda5c','[\"*\"]','2024-12-11 20:08:53',NULL,'2024-12-11 20:08:36','2024-12-11 20:08:53'),(158,'App\\Models\\User',2,'laravel','880c2116e8a91670b0e6dc81eb74f962569eb929cff1540467884b19772da26b','[\"*\"]','2024-12-11 20:09:07',NULL,'2024-12-11 20:08:57','2024-12-11 20:09:07'),(159,'App\\Models\\User',27,'laravel','da2ceeb57ebee9036bbfcdcf97a907c23bec3c35c8b4405dfc0df4c88cdbd274','[\"*\"]','2024-12-11 20:17:06',NULL,'2024-12-11 20:09:50','2024-12-11 20:17:06'),(160,'App\\Models\\User',2,'laravel','dc09e4b8be766471b9a120fb3b8929cca917642b7f060025eb2bbe531c406f94','[\"*\"]','2024-12-11 20:17:40',NULL,'2024-12-11 20:17:09','2024-12-11 20:17:40'),(161,'App\\Models\\User',31,'laravel','7bc2550a96c31fdf8e07dff1fbf0422ab1f8bfc2f2fbab345a3fae08fc99ec63','[\"*\"]','2024-12-11 20:17:52',NULL,'2024-12-11 20:17:46','2024-12-11 20:17:52'),(162,'App\\Models\\User',26,'laravel','d86c108f6959120a5901b254df72712a6601328982d2bc4502755477c3f92bb9','[\"*\"]','2024-12-11 20:18:18',NULL,'2024-12-11 20:18:14','2024-12-11 20:18:18'),(163,'App\\Models\\User',26,'laravel','c2fc4dbaaf0c827f9afbdb27f67ad3a094b5522978f21f0adc122d1a0e45a8f0','[\"*\"]','2024-12-11 20:22:36',NULL,'2024-12-11 20:21:35','2024-12-11 20:22:36'),(164,'App\\Models\\User',26,'laravel','08c8d78fe8a07f79376317fc501653c179212aae7774c9a3195317fb991e8833','[\"*\"]','2024-12-11 20:34:31',NULL,'2024-12-11 20:23:22','2024-12-11 20:34:31'),(165,'App\\Models\\User',26,'laravel','6a8aca63fbebdfbd82f334a1587af0dbb0bebadf022033c6a222721110952af7','[\"*\"]','2024-12-11 20:35:05',NULL,'2024-12-11 20:34:57','2024-12-11 20:35:05'),(166,'App\\Models\\User',2,'laravel','3cd0d73c24839c014f924767c91486dd016577256852308058292435b5d88a85','[\"*\"]','2024-12-11 20:36:10',NULL,'2024-12-11 20:35:17','2024-12-11 20:36:10'),(167,'App\\Models\\User',2,'laravel','b38b787b989479b02336c441e5c2eeb1d74b934f72ec8c20ecf77c7452850593','[\"*\"]','2024-12-11 20:36:28',NULL,'2024-12-11 20:36:24','2024-12-11 20:36:28'),(168,'App\\Models\\User',10,'laravel','bafd0eb818774a2b01027728075d85c91a21230b6155fd538e2f8c65cb7d96ff','[\"*\"]','2024-12-11 20:36:40',NULL,'2024-12-11 20:36:35','2024-12-11 20:36:40'),(169,'App\\Models\\User',27,'laravel','2f039b92f727d05f9c10c10a4f1904484e8488a8fd617b9847d20b4315952120','[\"*\"]','2024-12-11 21:07:11',NULL,'2024-12-11 20:37:10','2024-12-11 21:07:11'),(170,'App\\Models\\User',10,'laravel','1259b2644d2822f2c31205df376910c7f694fbb1f512a36c85cf92aed7b8058b','[\"*\"]','2024-12-11 21:07:51',NULL,'2024-12-11 21:07:20','2024-12-11 21:07:51'),(171,'App\\Models\\User',2,'laravel','04d9cc1906934a3dd24962ecfd8b110afb3fad4f75cfcc3a9c0529e706cab5b0','[\"*\"]','2024-12-11 21:09:38',NULL,'2024-12-11 21:08:33','2024-12-11 21:09:38'),(172,'App\\Models\\User',2,'laravel','35bc651448588176ba0656a252b3003e5380abbb66331bfd6cde0c31100aa3e4','[\"*\"]','2024-12-11 21:11:22',NULL,'2024-12-11 21:10:15','2024-12-11 21:11:22'),(173,'App\\Models\\User',2,'laravel','3c6cab8cf4223f98bac8802f671d769db10a6389577cf44865f1210995d62c3e','[\"*\"]','2024-12-11 21:13:05',NULL,'2024-12-11 21:13:04','2024-12-11 21:13:05'),(174,'App\\Models\\User',2,'laravel','5f58e276e4829eb820df9ef036a7284ed9f92e077b5c96fb3b5d72541a983f17','[\"*\"]','2024-12-11 21:29:57',NULL,'2024-12-11 21:13:57','2024-12-11 21:29:57'),(175,'App\\Models\\User',2,'laravel','393823b61151f8a1312d878adb01e56a6d239e5d83452972f856158410d627a7','[\"*\"]','2024-12-11 21:30:33',NULL,'2024-12-11 21:30:06','2024-12-11 21:30:33'),(176,'App\\Models\\User',2,'laravel','60e6b2c609016974ec8b45384336a574ad6d8c4aca33940ae24dcaf8840e7381','[\"*\"]','2024-12-11 21:31:24',NULL,'2024-12-11 21:30:42','2024-12-11 21:31:24'),(177,'App\\Models\\User',2,'laravel','d485b2bc4d9f7bc208766a0ae093754a37bb956c42bc7af6247cafd37add0cae','[\"*\"]','2024-12-11 21:31:30',NULL,'2024-12-11 21:31:28','2024-12-11 21:31:30'),(178,'App\\Models\\User',2,'laravel','b9c4718d39415b45e52e51cc3b991d63a6d6a1e83648f60eb93046821626c96f','[\"*\"]','2024-12-11 21:31:43',NULL,'2024-12-11 21:31:40','2024-12-11 21:31:43'),(179,'App\\Models\\User',2,'laravel','dfddc60968df7b98d68580bb4b5670c341c72f720413a9e09c5802ac17bbe7e3','[\"*\"]','2024-12-11 21:32:00',NULL,'2024-12-11 21:31:58','2024-12-11 21:32:00'),(180,'App\\Models\\User',2,'laravel','e4efd2e2969da7d0b175dde143ae2799627e807657db11a90835037aa8b60856','[\"*\"]','2024-12-11 21:33:57',NULL,'2024-12-11 21:33:53','2024-12-11 21:33:57'),(181,'App\\Models\\User',2,'laravel','1c4f4e39e792a932cfe8f3fc07f63665065b029376e04d249dbd1c3afe700c47','[\"*\"]','2024-12-11 21:34:44',NULL,'2024-12-11 21:34:29','2024-12-11 21:34:44'),(182,'App\\Models\\User',2,'laravel','cf9efb7f13699944d6d7240276c74f7fc1a54007bf079f12f22d52c692b918fa','[\"*\"]','2024-12-11 21:41:11',NULL,'2024-12-11 21:39:29','2024-12-11 21:41:11'),(183,'App\\Models\\User',26,'laravel','996320a77c660ebbb75f8fc565fbad411759c11cab7e91cf88378e06a7880312','[\"*\"]','2024-12-11 21:43:38',NULL,'2024-12-11 21:41:24','2024-12-11 21:43:38'),(184,'App\\Models\\User',2,'laravel','eba49f83b5140c7d31bd618b88a0b494067c6d7209eaf436fd30fb762cbd47c7','[\"*\"]','2024-12-11 21:44:15',NULL,'2024-12-11 21:43:50','2024-12-11 21:44:15'),(185,'App\\Models\\User',2,'laravel','1c502171fbd8d8029c81b362573f5e466ffc99c382bae65072a2587ba4953f81','[\"*\"]','2024-12-11 21:44:22',NULL,'2024-12-11 21:44:18','2024-12-11 21:44:22'),(186,'App\\Models\\User',26,'laravel','dfe7cd8ed64b238efca62379ff9cc6971be7aa29755219f0c52bb9c5ab39941f','[\"*\"]','2024-12-11 21:53:16',NULL,'2024-12-11 21:44:27','2024-12-11 21:53:16'),(187,'App\\Models\\User',26,'laravel','c2e90d8c3994315ebf378ec6d7f02f230270eae0c8c55c507a974df0622df49f','[\"*\"]','2024-12-11 22:06:19',NULL,'2024-12-11 22:06:15','2024-12-11 22:06:19'),(188,'App\\Models\\User',2,'laravel','672a5f5525ab2ee0e5e136a5c83a50da8e431b96b92e75b31cf3b08a7373d416','[\"*\"]','2024-12-11 22:10:10',NULL,'2024-12-11 22:06:38','2024-12-11 22:10:10'),(189,'App\\Models\\User',2,'laravel','46f723d6350989ca7a60b27d6854d4bb3a5cab2ac2bd00f9131c80695466ba14','[\"*\"]','2024-12-11 22:11:03',NULL,'2024-12-11 22:10:19','2024-12-11 22:11:03'),(190,'App\\Models\\User',2,'laravel','616804dcea07bc0ec45858d546e796ffad68a439af3e1162b10fefb1419cf41d','[\"*\"]','2024-12-11 22:12:05',NULL,'2024-12-11 22:11:15','2024-12-11 22:12:05'),(191,'App\\Models\\User',10,'laravel','68bbde86665bd3de14b126ae8c148f4a7097fd6175b5212b2730fc04224d2ad8','[\"*\"]','2024-12-11 22:23:31',NULL,'2024-12-11 22:20:49','2024-12-11 22:23:31'),(192,'App\\Models\\User',10,'laravel','f810e52e1465b6f295958e98bb4092750c2c10a86d9dec16fd17e1a815a4c313','[\"*\"]','2024-12-11 22:23:40',NULL,'2024-12-11 22:23:35','2024-12-11 22:23:40'),(193,'App\\Models\\User',10,'laravel','04b66ec43d46759939dde6d7501380c0ccb3f2d9c3c2362886ba693fb5bcecf4','[\"*\"]','2024-12-11 22:29:48',NULL,'2024-12-11 22:23:48','2024-12-11 22:29:48'),(194,'App\\Models\\User',2,'laravel','8b9772de93ff30a06c109b229d09b0817e993d2ef8653b915a257dc3284398c7','[\"*\"]','2024-12-11 22:30:16',NULL,'2024-12-11 22:30:14','2024-12-11 22:30:16'),(195,'App\\Models\\User',2,'laravel','c802c1579f4eeec2c4369580608c2e0ceced7795d446c99343d0df744be6f732','[\"*\"]','2024-12-12 00:49:24',NULL,'2024-12-11 22:30:38','2024-12-12 00:49:24'),(196,'App\\Models\\User',2,'laravel','a74b3374aa1ac18d625a3a8de6b208ce674a68813dc571f5de20f58a213ad57e','[\"*\"]','2024-12-12 17:32:42',NULL,'2024-12-12 00:51:28','2024-12-12 17:32:42'),(197,'App\\Models\\User',2,'laravel','5ae3c9a188e6886a10fac7f07162fb6032abbf3cbff424b6ef18d7203daadb70','[\"*\"]','2024-12-12 00:52:43',NULL,'2024-12-12 00:52:42','2024-12-12 00:52:43'),(198,'App\\Models\\User',8,'laravel','b21dfc0e79b133e83074c40055d7850625fd5f44f282b95e8030c72aad033a2a','[\"*\"]','2024-12-12 00:53:10',NULL,'2024-12-12 00:52:55','2024-12-12 00:53:10'),(199,'App\\Models\\User',34,'laravel','65fa5897db75d00755c908d5bdeb754ebc61492335662647a3b8850fa33142a6','[\"*\"]',NULL,NULL,'2024-12-12 00:53:34','2024-12-12 00:53:34'),(200,'App\\Models\\User',2,'laravel','17e3137c49a20f73f0057d87b502678b32ae83c40bf5450ed8672d16542a6cac','[\"*\"]','2024-12-12 00:54:23',NULL,'2024-12-12 00:54:22','2024-12-12 00:54:23'),(201,'App\\Models\\User',2,'laravel','9f8ad9e7a67a874f8a129554965ee732968b15940ea7076af3de740fc5538434','[\"*\"]','2024-12-12 00:55:40',NULL,'2024-12-12 00:54:29','2024-12-12 00:55:40'),(202,'App\\Models\\User',35,'laravel','1788ed4faed21f3b16bbd09e7a653fd22c81b754b6640d1fb29dc68cf1cdadd3','[\"*\"]',NULL,NULL,'2024-12-12 01:03:55','2024-12-12 01:03:55'),(203,'App\\Models\\User',2,'laravel','582f0c6a908d4c0aa5cb3fae49a2f87a8d6122005b7ec1bf9e3ad50df7d2f3d7','[\"*\"]','2024-12-12 01:04:16',NULL,'2024-12-12 01:04:14','2024-12-12 01:04:16'),(204,'App\\Models\\User',2,'laravel','319e70d32d8babcc3dc1a8feeae0a7b98e43e0ff584ec6ba167a78f909467a7a','[\"*\"]','2024-12-12 13:15:52',NULL,'2024-12-12 01:30:43','2024-12-12 13:15:52'),(205,'App\\Models\\User',8,'laravel','81f12a5f9799e5b8655bfcf591027f773a5419d0b77bb31278bbf2319f63c7a7','[\"*\"]','2024-12-12 13:20:19',NULL,'2024-12-12 13:20:13','2024-12-12 13:20:19'),(206,'App\\Models\\User',8,'laravel','a211f29de2f08e627bdceaf8c4d4bf43e6afa230cc78cb46e44235766f89fc97','[\"*\"]','2024-12-12 13:20:20',NULL,'2024-12-12 13:20:15','2024-12-12 13:20:20'),(207,'App\\Models\\User',8,'laravel','bb4d1730bcfcba3e70142228ed07538102a8e66fd7e70d9a627c65860120cb68','[\"*\"]','2024-12-12 13:24:40',NULL,'2024-12-12 13:20:16','2024-12-12 13:24:40'),(208,'App\\Models\\User',2,'laravel','ed7d1cd24c1e44c7735ca7d024ee4e3f6b79a4c4205dbf372a1ec27374ebf999','[\"*\"]','2024-12-12 13:28:00',NULL,'2024-12-12 13:27:50','2024-12-12 13:28:00'),(209,'App\\Models\\User',8,'laravel','cacb871a03717c87e012db81cc7f3b4465f80350eba83c02d5c9a686526ee77b','[\"*\"]','2024-12-13 19:51:10',NULL,'2024-12-12 14:49:35','2024-12-13 19:51:10'),(210,'App\\Models\\User',2,'laravel','0dbc43c292cb754bca80832168c9068e4b094fe59de1badfc04d102b700936e9','[\"*\"]','2024-12-12 17:35:56',NULL,'2024-12-12 17:33:12','2024-12-12 17:35:56'),(211,'App\\Models\\User',2,'laravel','7975cfd913c57f3c5950447f4cbb3cb804c7b2e5a56dd89ed5f080d5027e3e1f','[\"*\"]','2024-12-12 17:38:11',NULL,'2024-12-12 17:38:06','2024-12-12 17:38:11'),(212,'App\\Models\\User',8,'laravel','ddbe8feff9c55b6d1103ea308857bf3feb3134b4f77d67b3316c734ded1cfb8e','[\"*\"]','2024-12-12 17:44:04',NULL,'2024-12-12 17:38:15','2024-12-12 17:44:04'),(213,'App\\Models\\User',8,'laravel','612f19590f5659a19ae09752d665b2e75e4e8b28889d0f563615ea7ffe4b3b6f','[\"*\"]','2024-12-13 19:51:31',NULL,'2024-12-13 19:51:24','2024-12-13 19:51:31'),(214,'App\\Models\\User',8,'laravel','fbb3958af887d58df1f4a23855a7093ac494d3291b501bbfcd5f0a9806fd0df6','[\"*\"]','2024-12-13 19:54:22',NULL,'2024-12-13 19:51:27','2024-12-13 19:54:22'),(215,'App\\Models\\User',2,'laravel','7978c84c9309df32c7747e1558217e500d73de470d442a6c4b7a2936f34b4fb1','[\"*\"]','2024-12-13 20:40:47',NULL,'2024-12-13 19:54:47','2024-12-13 20:40:47'),(216,'App\\Models\\User',8,'laravel','99d66c6687fb00b0e6aed7c915fadf5b4bd12302c1c9a76114833bb78da27573','[\"*\"]','2024-12-13 20:39:41',NULL,'2024-12-13 19:54:55','2024-12-13 20:39:41'),(217,'App\\Models\\User',2,'laravel','e18c2e269c8b0551615912747517569b38a6ecdaff7909a61b924aa7d8c515f7','[\"*\"]','2024-12-13 20:46:53',NULL,'2024-12-13 20:46:49','2024-12-13 20:46:53'),(218,'App\\Models\\User',8,'laravel','687573cbaae0b3f8bfae14bef3346a6933cecf7cab9790f164da962666614688','[\"*\"]','2024-12-13 20:48:04',NULL,'2024-12-13 20:47:07','2024-12-13 20:48:04'),(219,'App\\Models\\User',2,'laravel','eb0d198334dcae32098b5645326656c882a4cc7f0ab052a1b90f39943f8803ee','[\"*\"]','2024-12-14 16:59:47',NULL,'2024-12-14 16:59:44','2024-12-14 16:59:47'),(220,'App\\Models\\User',2,'laravel','7e86d3ea5e07d2d3b493325f03432308fa1e6ca643eb6fc109ea68b7b6485b1c','[\"*\"]','2024-12-14 17:27:51',NULL,'2024-12-14 16:59:46','2024-12-14 17:27:51'),(221,'App\\Models\\User',8,'laravel','c9309e732db0138d5f647e5f64535cd41e0d29caa7cd302c562a9cd0f180d654','[\"*\"]','2024-12-14 17:27:59',NULL,'2024-12-14 17:27:56','2024-12-14 17:27:59'),(222,'App\\Models\\User',2,'laravel','86b23b3e9e48996c22b3899407548ceaca69a416ba02397acf1fbd5d10b61856','[\"*\"]','2024-12-14 17:28:37',NULL,'2024-12-14 17:28:22','2024-12-14 17:28:37'),(223,'App\\Models\\User',8,'laravel','a1da529e36f9f8dbb971c9ae705a8706c116a586346064947d8486dfeb1e54ae','[\"*\"]','2024-12-14 18:24:54',NULL,'2024-12-14 18:17:45','2024-12-14 18:24:54'),(224,'App\\Models\\User',8,'laravel','59e9a58285290c49381a09ef3a428cdd40944227b971bbb9a09412dbcbb8d7ac','[\"*\"]','2024-12-14 19:16:23',NULL,'2024-12-14 18:43:29','2024-12-14 19:16:23'),(225,'App\\Models\\User',2,'laravel','cbbfe2e30bb0eeb292f17a918dfe8a342acc5fd4ac5b5e9598791357ad1354a8','[\"*\"]','2024-12-14 19:43:37',NULL,'2024-12-14 19:21:46','2024-12-14 19:43:37'),(226,'App\\Models\\User',5,'laravel','21ae97d2072e15cd0bce6ce363a04447c8419a613143aaa5260e2a661a7dc063','[\"*\"]','2024-12-14 20:30:41',NULL,'2024-12-14 19:44:39','2024-12-14 20:30:41'),(227,'App\\Models\\User',8,'laravel','cfb98919c8c07d78ed1630e9c3c5a286bb0956adf051b51c765d9e98985f25c0','[\"*\"]','2024-12-14 21:10:24',NULL,'2024-12-14 20:41:15','2024-12-14 21:10:24'),(228,'App\\Models\\User',8,'laravel','cd56451272c30ca3acf7a9a5d9c512dde2b6b4430d8c084ad10c56a47ec3d02f','[\"*\"]','2024-12-14 21:15:55',NULL,'2024-12-14 21:15:50','2024-12-14 21:15:55'),(229,'App\\Models\\User',8,'laravel','8920c719050bc9c821546e9c4c2af42f86e4b5a44a323ef92c21a62d08baed70','[\"*\"]','2024-12-14 22:18:40',NULL,'2024-12-14 22:04:44','2024-12-14 22:18:40'),(230,'App\\Models\\User',4,'laravel','79c6ce1da5b9852251a2bdeb3b409cb8e4168d72796882c6d2d658751787a111','[\"*\"]','2024-12-14 22:31:05',NULL,'2024-12-14 22:19:29','2024-12-14 22:31:05'),(231,'App\\Models\\User',2,'laravel','9fc8e64dc0fe001ab4af6a05aad3b4a2d6fa516ac2681f6f0e7763a2e5432e4a','[\"*\"]','2024-12-14 23:15:37',NULL,'2024-12-14 22:48:54','2024-12-14 23:15:37');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_invoice_trips`
--

DROP TABLE IF EXISTS `private_invoice_trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `private_invoice_trips` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `participant_id` bigint(20) unsigned NOT NULL,
  `base_price` decimal(8,2) NOT NULL,
  `options_price` decimal(8,2) NOT NULL,
  `total_price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `private_invoice_trips_participant_id_foreign` (`participant_id`),
  CONSTRAINT `private_invoice_trips_participant_id_foreign` FOREIGN KEY (`participant_id`) REFERENCES `trip_participants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_invoice_trips`
--

LOCK TABLES `private_invoice_trips` WRITE;
/*!40000 ALTER TABLE `private_invoice_trips` DISABLE KEYS */;
/*!40000 ALTER TABLE `private_invoice_trips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_invoices`
--

DROP TABLE IF EXISTS `reservation_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `additional_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `late_check_out_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `early_check_in_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('approved','pending') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `reservation_invoices_room_id_foreign` (`room_id`),
  CONSTRAINT `reservation_invoices_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_invoices`
--

LOCK TABLES `reservation_invoices` WRITE;
/*!40000 ALTER TABLE `reservation_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `room_count` int(11) DEFAULT 1,
  `companions_count` int(11) NOT NULL DEFAULT 0,
  `companions_names` text DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `update_deadline` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservations_user_id_foreign` (`user_id`),
  CONSTRAINT `reservations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_prices`
--

DROP TABLE IF EXISTS `room_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_type` enum('Single','Double','Triple') NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `companion_price` decimal(10,2) NOT NULL,
  `early_check_in_price` decimal(10,2) NOT NULL,
  `late_check_out_price` decimal(10,2) NOT NULL,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_prices_conference_id_foreign` (`conference_id`),
  CONSTRAINT `room_prices_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_prices`
--

LOCK TABLES `room_prices` WRITE;
/*!40000 ALTER TABLE `room_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint(20) unsigned NOT NULL,
  `room_type` enum('Single','Double','Triple') NOT NULL,
  `occupant_name` varchar(255) DEFAULT NULL,
  `special_requests` text DEFAULT NULL,
  `check_in_date` datetime NOT NULL,
  `check_out_date` datetime NOT NULL,
  `late_check_out` tinyint(1) NOT NULL DEFAULT 0,
  `early_check_in` tinyint(1) NOT NULL DEFAULT 0,
  `total_nights` int(11) NOT NULL,
  `user_type` enum('main','companion') NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `cost` decimal(10,2) DEFAULT NULL,
  `additional_cost` decimal(10,2) DEFAULT 0.00,
  `update_deadline` datetime DEFAULT NULL,
  `is_confirmed` tinyint(1) DEFAULT 0,
  `confirmation_message_pdf` text DEFAULT NULL,
  `last_user_update_at` timestamp NULL DEFAULT NULL,
  `last_admin_update_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rooms_reservation_id_foreign` (`reservation_id`),
  CONSTRAINT `rooms_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scientific_papers`
--

DROP TABLE IF EXISTS `scientific_papers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scientific_papers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `author_title` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `whatsapp` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `status` enum('under_review','accepted','rejected') NOT NULL DEFAULT 'under_review',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scientific_papers_conference_id_foreign` (`conference_id`),
  CONSTRAINT `scientific_papers_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scientific_papers`
--

LOCK TABLES `scientific_papers` WRITE;
/*!40000 ALTER TABLE `scientific_papers` DISABLE KEYS */;
/*!40000 ALTER TABLE `scientific_papers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scientific_topics`
--

DROP TABLE IF EXISTS `scientific_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scientific_topics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `speaker_names` varchar(255) DEFAULT NULL,
  `goal` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scientific_topics_conference_id_foreign` (`conference_id`),
  CONSTRAINT `scientific_topics_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scientific_topics`
--

LOCK TABLES `scientific_topics` WRITE;
/*!40000 ALTER TABLE `scientific_topics` DISABLE KEYS */;
INSERT INTO `scientific_topics` VALUES (4,4,'test1',NULL,NULL,NULL,'2024-12-14 23:03:27','2024-12-14 23:03:27'),(5,5,'test2',NULL,NULL,NULL,'2024-12-14 23:08:21','2024-12-14 23:08:21'),(6,6,'test3',NULL,NULL,NULL,'2024-12-14 23:10:07','2024-12-14 23:10:07');
/*!40000 ALTER TABLE `scientific_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
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
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speakers`
--

DROP TABLE IF EXISTS `speakers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `speakers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `conference_id` bigint(20) unsigned NOT NULL,
  `abstract` varchar(255) DEFAULT NULL,
  `topics` text DEFAULT NULL,
  `presentation_file` varchar(255) DEFAULT NULL,
  `online_participation` tinyint(1) NOT NULL DEFAULT 0,
  `is_online_approved` tinyint(1) NOT NULL DEFAULT 0,
  `accommodation_status` tinyint(1) NOT NULL DEFAULT 0,
  `ticket_status` tinyint(1) NOT NULL DEFAULT 0,
  `dinner_invitation` tinyint(1) NOT NULL DEFAULT 0,
  `airport_pickup` tinyint(1) NOT NULL DEFAULT 0,
  `free_trip` tinyint(1) NOT NULL DEFAULT 0,
  `certificate_file` varchar(255) DEFAULT NULL,
  `is_certificate_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cost_airport_to_hotel` decimal(10,2) DEFAULT NULL,
  `cost_hotel_to_airport` decimal(10,2) DEFAULT NULL,
  `cost_round_trip` decimal(10,2) DEFAULT NULL,
  `room_type` varchar(255) DEFAULT NULL,
  `nights_covered` int(11) DEFAULT NULL,
  `is_visa_payment_required` tinyint(1) NOT NULL DEFAULT 1,
  `arrival_date` date DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `speakers_user_id_foreign` (`user_id`),
  KEY `speakers_conference_id_foreign` (`conference_id`),
  CONSTRAINT `speakers_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `speakers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speakers`
--

LOCK TABLES `speakers` WRITE;
/*!40000 ALTER TABLE `speakers` DISABLE KEYS */;
/*!40000 ALTER TABLE `speakers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor_invoices`
--

DROP TABLE IF EXISTS `sponsor_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsor_invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `conference_sponsorship_option_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conference_sponsorship_option_ids`)),
  `booth_cost_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`booth_cost_ids`)),
  `sponsorship_option_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`sponsorship_option_ids`)),
  `additional_cost_for_shell_scheme_booth` tinyint(1) DEFAULT 0,
  `conference_id` bigint(20) unsigned NOT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `exhibit_number` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sponsor_invoices_exhibit_number_unique` (`exhibit_number`),
  KEY `sponsor_invoices_user_id_foreign` (`user_id`),
  KEY `sponsor_invoices_conference_id_foreign` (`conference_id`),
  CONSTRAINT `sponsor_invoices_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sponsor_invoices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor_invoices`
--

LOCK TABLES `sponsor_invoices` WRITE;
/*!40000 ALTER TABLE `sponsor_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsor_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsors`
--

DROP TABLE IF EXISTS `sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `contact_person` varchar(255) NOT NULL,
  `company_address` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sponsors_user_id_foreign` (`user_id`),
  CONSTRAINT `sponsors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsors`
--

LOCK TABLES `sponsors` WRITE;
/*!40000 ALTER TABLE `sponsors` DISABLE KEYS */;
INSERT INTO `sponsors` VALUES (1,5,'au','au','dfkls','active','2024-12-08 13:42:09','2024-12-08 13:42:09'),(2,31,';;;;kkk','llll','kkkkkkkkkkk','active','2024-12-11 19:43:24','2024-12-11 19:43:24'),(3,33,'╪¬╪¬╪¬╪¬╪¬╪¬','╪º╪º╪º╪º╪º╪º╪º','uuuuuuu','active','2024-12-11 22:30:53','2024-12-11 22:30:53');
/*!40000 ALTER TABLE `sponsors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsorship_options`
--

DROP TABLE IF EXISTS `sponsorship_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsorship_options` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sponsorship_options_conference_id_foreign` (`conference_id`),
  CONSTRAINT `sponsorship_options_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsorship_options`
--

LOCK TABLES `sponsorship_options` WRITE;
/*!40000 ALTER TABLE `sponsorship_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsorship_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsorships`
--

DROP TABLE IF EXISTS `sponsorships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsorships` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `max_sponsors` int(11) NOT NULL,
  `booth_size` varchar(255) NOT NULL,
  `booklet_ad` varchar(255) DEFAULT NULL,
  `website_ad` varchar(255) DEFAULT NULL,
  `bags_inserts` varchar(255) DEFAULT NULL,
  `backdrop_logo` varchar(255) DEFAULT NULL,
  `non_residential_reg` int(11) NOT NULL,
  `residential_reg` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_sponsorship_options_conference_id_foreign` (`conference_id`),
  CONSTRAINT `conference_sponsorship_options_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsorships`
--

LOCK TABLES `sponsorships` WRITE;
/*!40000 ALTER TABLE `sponsorships` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsorships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standard_booth_packages`
--

DROP TABLE IF EXISTS `standard_booth_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `standard_booth_packages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  `floor_plan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `standard_booth_packages_conference_id_foreign` (`conference_id`),
  CONSTRAINT `standard_booth_packages_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standard_booth_packages`
--

LOCK TABLES `standard_booth_packages` WRITE;
/*!40000 ALTER TABLE `standard_booth_packages` DISABLE KEYS */;
/*!40000 ALTER TABLE `standard_booth_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_bookings`
--

DROP TABLE IF EXISTS `ticket_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `cellular` varchar(255) NOT NULL,
  `whatsapp` varchar(255) NOT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date NOT NULL,
  `arrival_time` time NOT NULL,
  `departure_time` time NOT NULL,
  `preferred_airline` varchar(255) NOT NULL,
  `departure_from` varchar(255) NOT NULL,
  `passport_copy` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_bookings_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_bookings`
--

LOCK TABLES `ticket_bookings` WRITE;
/*!40000 ALTER TABLE `ticket_bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourist_sites`
--

DROP TABLE IF EXISTS `tourist_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourist_sites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` longtext NOT NULL,
  `additional_info` varchar(255) DEFAULT NULL,
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
-- Table structure for table `transportation_requests`
--

DROP TABLE IF EXISTS `transportation_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportation_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `whatsapp` varchar(255) NOT NULL,
  `passengers` int(11) NOT NULL,
  `pickup_option` enum('pickup','drop_off','both') NOT NULL DEFAULT 'pickup',
  `flight_code` varchar(255) NOT NULL,
  `flight_time` varchar(255) NOT NULL,
  `additional_info` text DEFAULT NULL,
  `total_usd` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportation_requests`
--

LOCK TABLES `transportation_requests` WRITE;
/*!40000 ALTER TABLE `transportation_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `transportation_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `travel_forms`
--

DROP TABLE IF EXISTS `travel_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `travel_forms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `cellular` varchar(255) NOT NULL,
  `whatsapp` varchar(255) NOT NULL,
  `arrivalDate` date NOT NULL,
  `departureDate` date NOT NULL,
  `hotelCategory` varchar(255) NOT NULL,
  `hotelName` varchar(255) NOT NULL,
  `accompanyingPersons` int(11) NOT NULL DEFAULT 0,
  `totalUSD` decimal(10,2) NOT NULL DEFAULT 0.00,
  `roomType` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `travel_forms`
--

LOCK TABLES `travel_forms` WRITE;
/*!40000 ALTER TABLE `travel_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `travel_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip_options_participants`
--

DROP TABLE IF EXISTS `trip_options_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip_options_participants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trip_id` bigint(20) unsigned NOT NULL,
  `option_id` bigint(20) unsigned NOT NULL,
  `participant_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_options_participants_trip_id_foreign` (`trip_id`),
  KEY `trip_options_participants_option_id_foreign` (`option_id`),
  KEY `trip_options_participants_participant_id_foreign` (`participant_id`),
  CONSTRAINT `trip_options_participants_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `additional_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_options_participants_participant_id_foreign` FOREIGN KEY (`participant_id`) REFERENCES `trip_participants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_options_participants_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip_options_participants`
--

LOCK TABLES `trip_options_participants` WRITE;
/*!40000 ALTER TABLE `trip_options_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `trip_options_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip_participants`
--

DROP TABLE IF EXISTS `trip_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip_participants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `main_user_id` bigint(20) unsigned DEFAULT NULL,
  `trip_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `whatsapp_number` varchar(255) DEFAULT NULL,
  `is_companion` tinyint(1) NOT NULL DEFAULT 0,
  `include_accommodation` tinyint(1) NOT NULL DEFAULT 0,
  `accommodation_stars` int(11) DEFAULT NULL,
  `nights_count` int(11) DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_participants_user_id_foreign` (`user_id`),
  KEY `trip_participants_trip_id_foreign` (`trip_id`),
  CONSTRAINT `trip_participants_trip_id_foreign` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip_participants`
--

LOCK TABLES `trip_participants` WRITE;
/*!40000 ALTER TABLE `trip_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `trip_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trips` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  `trip_type` enum('private','group') NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `additional_info` varchar(255) DEFAULT NULL,
  `image_1` varchar(255) DEFAULT NULL,
  `image_2` varchar(255) DEFAULT NULL,
  `image_3` varchar(255) DEFAULT NULL,
  `image_4` varchar(255) DEFAULT NULL,
  `image_5` varchar(255) DEFAULT NULL,
  `price_per_person` decimal(10,2) DEFAULT NULL,
  `price_for_two` decimal(10,2) DEFAULT NULL,
  `price_for_three_or_more` decimal(10,2) DEFAULT NULL,
  `available_dates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`available_dates`)),
  `location` varchar(255) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `inclusions` text DEFAULT NULL,
  `group_price_per_person` decimal(10,2) DEFAULT NULL,
  `group_price_per_speaker` decimal(10,2) DEFAULT NULL,
  `trip_details` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `group_accompanying_price` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','approved','cancelled') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `trips_conference_id_foreign` (`conference_id`),
  CONSTRAINT `trips_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trips`
--

LOCK TABLES `trips` WRITE;
/*!40000 ALTER TABLE `trips` DISABLE KEYS */;
/*!40000 ALTER TABLE `trips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_final_prices`
--

DROP TABLE IF EXISTS `user_final_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_final_prices` (
  `trip_participant_id` bigint(20) unsigned NOT NULL,
  `trip_id` bigint(20) unsigned NOT NULL,
  `final_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `biography` text DEFAULT NULL,
  `registration_type` enum('speaker','attendance','sponsor','group_registration') DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `whatsapp_number` varchar(255) DEFAULT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `country_of_residence` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `company_name` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `company_address` text DEFAULT NULL,
  `conference_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_conference_id_foreign` (`conference_id`),
  CONSTRAINT `users_conference_id_foreign` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'hh','admin@gmail.com',NULL,'$2y$12$WyuTfZWkaORJju2v0hEL5uq3kcGm6VzD/FFnAlQ7IZGzKR3/w8.jC',1,NULL,'2024-12-05 18:42:51','2024-12-05 18:42:51','images/rJRuQgfLPS1ZbunmqvYhMfmwnLJeNqr69KT4CBZG.jpg','hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh','','96255555555','96266666','end','algerian','albania','approved',NULL,NULL,NULL,NULL),(3,'ayat','ayat@gmail.com',NULL,'$2y$12$kqPKLkkxcdqqKkdfp61p/epFcX95MD94cjsCm7LHkjfUQaqqRhLfm',0,NULL,'2024-12-07 20:08:26','2024-12-07 20:09:07','images/thsnFuM0mKXDU0Z8XngGuqkXg0gEHBob0t2MwKRq.jpg','ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg','speaker','962555555','962666666','ggg','albanian','albania','approved',NULL,NULL,NULL,NULL),(4,'ggg','d@d.com',NULL,'$2y$12$GudDULZGaxSmjRku7yDGMuJaLG9/pzR7J.AJSmn/ct3IacBr8oE9G',0,NULL,'2024-12-07 21:00:12','2024-12-11 19:22:43','images/MQMpk0GLRZaLY2gTuyQ22lgpS8GTzTPYsgqrc6dq.jpg','ggggggggggggggghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh','speaker','9625555','9624444','eng','afghan','albania','approved',NULL,NULL,NULL,NULL),(5,NULL,'m@ml.com',NULL,'$2y$12$BJ2kwU6t6AAY3HgzueAzCOtTRkUQPRaO.vIUmbvL9oPrYPk8HabWG',0,NULL,'2024-12-08 13:40:57','2024-12-08 13:42:09',NULL,NULL,'sponsor','77777','9626666',NULL,NULL,NULL,'approved','au','au','dfkls',NULL),(6,'hhh','aya@gmail.com',NULL,'$2y$12$e63KfmjWjTeaYssH6GtJZ.n6Jbi.Mm2i9graskcPhosvSJGmPLOt2',0,NULL,'2024-12-08 15:48:54','2024-12-08 15:49:48',NULL,NULL,'group_registration','962787770047',NULL,NULL,NULL,NULL,'approved',NULL,NULL,NULL,NULL),(7,'nn','n@n.com',NULL,'$2y$12$vchms.kVImb5hDNkCPA7G.OMre5bsYzaufJgA7.oOxtXIXBCD10o6',0,NULL,'2024-12-08 15:54:07','2024-12-08 15:55:26','images/hBgR1c6w045tIc2ugYyXFdD1rHymae2HfVzlTW6B.jpg','ggggggggggggggghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh','speaker','962666666','962444444','ff','algerian','albania','approved',NULL,NULL,NULL,NULL),(8,'ayat','ayat2@gmail.com',NULL,'$2y$12$tyZMUjWn3O3SBl4/URPAuew7WAhOKajYfPtzWtI1hzirjt3jgZInK',0,NULL,'2024-12-08 16:31:23','2024-12-08 16:32:03','images/blClRTUpHgCCbymkuZ9EvceRCwGG1oevsNxVKJj7.jpg','wwwwwwwww2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222','speaker','962444444','96233333','eng','albanian','albania','approved',NULL,NULL,NULL,NULL),(9,'AS','SA@A.COM',NULL,'$2y$12$Wluiy8fEXY7NgBO/Fyja5eNr2RXhOw8XOoe.pp3/PoxvnWrtIhdyi',0,NULL,'2024-12-09 17:44:33','2024-12-11 16:46:09',NULL,NULL,'attendance','962555555','96255555','kik','albanian','albania','approved',NULL,NULL,NULL,NULL),(10,'aa','a@A.com',NULL,'$2y$12$R7m/puy6xQ29o4RvIMUl6OJFV.jyi04gTB0Z.9TodaKUF82VmzWwq',0,NULL,'2024-12-09 19:14:41','2024-12-09 19:15:13','images/BWErma7vELw2FDiUyPPkIcuTTjtw8XdHauPK4v99.jpg','rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr','speaker','962333','96233333','333ss','albanian','afghanistan','approved',NULL,NULL,NULL,NULL),(11,'Ameer','Amer@gmail.com',NULL,'$2y$12$u8jj4tRhK/I5XFg48F3t3.FprMxRifr.lhKMmFDeQH7D.O2DpbMfG',0,NULL,'2024-12-10 14:46:05','2024-12-10 14:46:37','images/shNBSDAQhXz9j5qyxgys8FD02MdktAO4b8ocBI5E.jpg','Experienced [Your Job Title] with [X] years of expertise in [Field or Industry]. Skilled in [Key Skills/Technologies], with a proven track record in [specific achievement or task]. Adept at problem-solving, teamwork, and delivering high-quality solutions.','speaker','962787878','962454545','Engineer','albanian','jordan','approved',NULL,NULL,NULL,NULL),(12,'aa','annn@a.com',NULL,'$2y$12$NsGz3jFkquwPMt9Z1XNxNOSXitTv8xNjA6Fnbb5xsbTc2mvcBz3u2',0,NULL,'2024-12-10 17:58:11','2024-12-10 17:58:11','images/7IlSTMC1tE89zvVdC7FHzhQC0FzKbyH8vg15jedq.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','pending',NULL,NULL,NULL,NULL),(13,'aa','annvfgfdvxsddn@a.com',NULL,'$2y$12$vSz7I7bq9Q/CRFInXleAyuOA7kMoE5DpZzSE7lqFUYuIoGodIS.ri',0,NULL,'2024-12-10 17:58:54','2024-12-10 17:58:54','images/DdGyfbWaBPS3TgLJQG0RZc7IGE72ZiXCCcjWLuuy.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','pending',NULL,NULL,NULL,NULL),(14,'aa','annvfg┘å┘å┘å┘å┘å┘å┘åfdvxsddn@a.com',NULL,'$2y$12$1uLUjMvFYyIs2YV2mc.kA.AklPSqN52zFCll/dtKKpRZ3nP9anXsi',0,NULL,'2024-12-10 18:00:27','2024-12-10 18:00:27','images/sXR5rJq0hGJgM99maAms5Bqw1qud8UmBAJ2XJLbS.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','pending',NULL,NULL,NULL,NULL),(15,'aa','annvfg┘å┘å┘å┘à┘à┘à┘å┘å┘å┘åfdvxsddn@a.com',NULL,'$2y$12$nh0odnD02W9R0Spf8HvJ9OYdZjSus1boaq5hKYgHk1T4NOI3Y6enq',0,NULL,'2024-12-10 18:01:34','2024-12-10 18:01:34','images/qby6TjTMFeAcgmTVRLIOHUBtUAGAMyg8Oc73olmi.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','pending',NULL,NULL,NULL,NULL),(17,'aa','ayatal989890momani655@gmail.com',NULL,'$2y$12$W7HmBfS1Jb9SDJX.IXp9g.rS03PwcJCeZWDyRrl7d6tUNxvWZyzKa',0,NULL,'2024-12-10 18:19:38','2024-12-10 18:19:38','images/7dVv3oAer0ZJIy3fVLH9XfuH15Oh82bDli1XRBeg.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','pending',NULL,NULL,NULL,NULL),(18,'aa','ayJJJJJatal989890momani655@gmail.com',NULL,'$2y$12$cFEmyn.2HVfTR7z3Bsmt1ezdtrB0JnQgezH3IHzItfT0hKDoAiLRq',0,NULL,'2024-12-10 18:19:51','2024-12-10 18:19:51','images/BMtg9ZeeflJi2JJL097fwFIpKJj7UY2TCG6CEvDP.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','pending',NULL,NULL,NULL,NULL),(19,'aa','ayJJJJJatal98989@0momani655gmail.com',NULL,'$2y$12$TrL905Ga34oS4JSm6zmfS.pO1cOtzTO8SMJrjA2Zf38syHf0OC0L2',0,NULL,'2024-12-10 18:20:17','2024-12-10 18:20:17','images/F5R1mjYY5hqbj4695j1QUxhXTXdlHjV4nuqqgEXT.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','pending',NULL,NULL,NULL,NULL),(20,'John Doe','johndolllllllllllle@example.com','2024-12-10 18:41:27','$2y$12$/.Si421/Ocg6G7Wf4HPNo.F/HRTlGUTbB7srF4maqBXE/Yg2ZH1Kq',0,NULL,'2024-12-10 18:41:27','2024-12-11 19:21:27',NULL,'This is the biography of John Doe.','speaker','+1234567890','+0987654321','Software Development','American','USA','approved','Tech Solutions','John Doe','123 Tech St, Silicon Valley',NULL),(21,'John Doe','jke@3.com','2024-12-10 18:42:05','$2y$12$6jC9bbICwzt.02gXVTqSSOBuUHuUYJKkrHtthAU2oaKoKJBqEUhyO',0,NULL,'2024-12-10 18:42:05','2024-12-10 18:42:05',NULL,'This is the biography of John Doe.','speaker','+1234567890','+0987654321','Software Development','American','USA','pending','Tech Solutions','John Doe','123 Tech St, Silicon Valley',NULL),(22,'aa','aya33t@gmail.com','2024-12-10 18:43:15','$2y$12$8AhU6a2z.yVDVJVgA8qWwu4IgZwomPvj3z9uD0nuwg34sjpPg35a.',0,NULL,'2024-12-10 18:43:15','2024-12-11 19:34:19','images/hDJW8Jtjrspv8ZbGVsCaRWceb13tmEqRPlPQfaQw.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','approved',NULL,NULL,NULL,NULL),(23,'John Doe','jjjke@3.com','2024-12-10 18:44:55','$2y$12$N08NoDX/WXEB21CwsV5kIeOy5XERSsmD30qmxOr.OMjYlstKC9edK',0,NULL,'2024-12-10 18:44:55','2024-12-11 19:23:18',NULL,'This is the biography of John Doe.','speaker','+1234567890','+0987654321','Software Development','American','USA','approved','Tech Solutions','John Doe','123 Tech St, Silicon Valley',NULL),(24,'John Doe','jjjke@jjj3.com','2024-12-10 18:46:06','$2y$12$G/UYOYenQotDWrGGuN/l5OnkUE6ZCgA4/jcMdj3KV/Vum1WENa0Ti',0,NULL,'2024-12-10 18:46:06','2024-12-11 19:34:36',NULL,'This is the biography of John Doe.','speaker','+1234567890','+0987654321','Software Development','American','USA','approved','Tech Solutions','John Doe','123 Tech St, Silicon Valley',NULL),(25,'John Doe','jjjkkkkkkkkkkkkkkkkkkkjke@jjj3.com','2024-12-10 18:46:30','$2y$12$0xvo4QJDEvRQBqvDMuagmO7VSeM4NJPoYfosFdCSljPJoE/F3RrPa',0,NULL,'2024-12-10 18:46:30','2024-12-10 18:46:30',NULL,'This is the biography of John Doe.','speaker','+1234567890','+0987654321','Software Development','American','USA','pending','Tech Solutions','John Doe','123 Tech St, Silicon Valley',NULL),(26,'aa','ayatalmomani655@gmail.com','2024-12-10 18:59:50','$2y$12$XM1.9YTmlhW6iE2suZNJd.Gnd75ujFWMGokj4UQVmYRcYy9cRLh8.',0,NULL,'2024-12-10 18:59:50','2024-12-10 19:01:48','images/0DtMPM8Sz8H3cDJn3DAW7USOc7KCHP2Wb3VuXclK.jpg','ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd','speaker','962444','9623333334','ddd','albanian','algeria','approved',NULL,NULL,NULL,NULL),(27,'fff','sonjl@mm.com','2024-12-10 19:03:09','$2y$12$Ro4Iw6yPvVfanpGIwkHBCeKN5.uLnvz7.vM67CS8rBvtUmNNcoAO.',0,NULL,'2024-12-10 19:03:09','2024-12-10 19:03:38','images/N5APbuj3uB0KLHwDciP2Y5oLd84FhB29XiIxCUnh.png','ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg','speaker','962555','9625555','rrr','albanian','albania','approved',NULL,NULL,NULL,NULL),(28,'╪¿╪¿╪¿╪¿╪¿╪¿╪¿╪¿','s@s.com','2024-12-11 00:33:10','$2y$12$7cAKR0zT1awynVpfmpYfAuUnUnaSagjTJr7sBOy4hRLehNdj/iu.a',0,NULL,'2024-12-11 00:33:10','2024-12-11 16:46:37','images/9KCYZFqSRnCVXT0bk4tTPKiDAoVBY6ertnfZtSw2.jpg','rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr','speaker','9626666666','9625555555','enf','afghan','algeria','approved',NULL,NULL,NULL,NULL),(29,'llllll','jk@gmail.com',NULL,'$2y$12$QA0umREAoSPZK4NPVRveoO2ht.LPlibnTrcl0NLK3/kHdzRS9WMX6',0,NULL,'2024-12-11 19:29:40','2024-12-11 19:29:40',NULL,NULL,'group_registration','96200000000',NULL,NULL,NULL,NULL,'pending',NULL,NULL,NULL,NULL),(30,NULL,'lll@gmail.com',NULL,'$2y$12$o6fzEHD264e6je/8eNReYOU47gIp4DVSMwPIRjuG4Xg2V6QmKKRd2',0,NULL,'2024-12-11 19:35:31','2024-12-11 19:35:31',NULL,NULL,'sponsor','962777777','96277777',NULL,NULL,NULL,'pending','hhh','vgggh','gggggggg',NULL),(31,NULL,'n@gmail.com',NULL,'$2y$12$d3DCgDZvFK8SMZU877MXt.yT3GfsmSXf6l68MHrTJ4q.VcgZhJps.',0,NULL,'2024-12-11 19:42:49','2024-12-11 19:43:24',NULL,NULL,'sponsor','962999','96200',NULL,NULL,NULL,'approved',';;;;kkk','llll','kkkkkkkkkkk',NULL),(32,NULL,'mm@gmail.com',NULL,'$2y$12$wdT5LzY.gAptrmC13z3CmeDfCcaV5mlacmwvKRNIDp8mxq7ZpOVH6',0,NULL,'2024-12-11 21:10:03','2024-12-11 21:10:03',NULL,NULL,'sponsor','962333','962555555',NULL,NULL,NULL,'pending','ffffffff','df','ffffffff',NULL),(33,NULL,'klkl@gmail.com',NULL,'$2y$12$PeZohy5.jO9Nu/jPvF8uEukDN4b0WpPyTxDHqeCXzEfH6CUHRSn4K',0,NULL,'2024-12-11 21:13:45','2024-12-11 22:30:53',NULL,NULL,'sponsor','962888888','9629999',NULL,NULL,NULL,'approved','╪¬╪¬╪¬╪¬╪¬╪¬','╪º╪º╪º╪º╪º╪º╪º','uuuuuuu',NULL),(34,'╪º╪º╪º╪º╪º╪º╪º╪º╪º','yu@gmail.com',NULL,'$2y$12$7/o5ItUKJTIzjwTMVXZ9pOENedTqUbAdlqFu9tig9Ev8VkaD7XDLa',0,NULL,'2024-12-12 00:53:34','2024-12-12 00:53:34',NULL,NULL,'group_registration','962888',NULL,NULL,NULL,NULL,'pending',NULL,NULL,NULL,NULL),(35,'hhhh','adm┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘ä┘äin@gmail.com',NULL,'$2y$12$mu9j.u4a78DiTQICy8wTQeCqs16RGqOC4jdKZe8SdTVeha04qf3r2',0,NULL,'2024-12-12 01:03:55','2024-12-12 01:03:55',NULL,NULL,'group_registration','962555599',NULL,NULL,NULL,NULL,'pending',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visas`
--

DROP TABLE IF EXISTS `visas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `passport_image` varchar(255) DEFAULT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `visa_cost` decimal(8,2) NOT NULL DEFAULT 0.00,
  `payment_required` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `visa_updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_at_by_admin` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `visas_user_id_foreign` (`user_id`),
  CONSTRAINT `visas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visas`
--

LOCK TABLES `visas` WRITE;
/*!40000 ALTER TABLE `visas` DISABLE KEYS */;
INSERT INTO `visas` VALUES (42,8,'images/wdY80e5AC7toDkr8Izz2wdJyyF4lZOck15JaaI4s.jpg','2024-12-26','2025-01-10',0.00,0,'approved','2024-12-15 02:13:49','2024-12-13 20:48:03','2024-12-14 23:13:49','2024-12-15 02:13:49');
/*!40000 ALTER TABLE `visas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `╪º┘ä╪▒╪¡┘ä╪º╪¬_╪º┘ä╪│┘è╪º╪¡┘è╪⌐`
--

DROP TABLE IF EXISTS `╪º┘ä╪▒╪¡┘ä╪º╪¬_╪º┘ä╪│┘è╪º╪¡┘è╪⌐`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `╪º┘ä╪▒╪¡┘ä╪º╪¬_╪º┘ä╪│┘è╪º╪¡┘è╪⌐` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `emailaddress` varchar(255) NOT NULL,
  `phonenumber` varchar(255) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `arrivalPoint` varchar(255) NOT NULL,
  `departurePoint` varchar(255) NOT NULL,
  `arrivalDate` date NOT NULL,
  `departureDate` date NOT NULL,
  `arrivalTime` time NOT NULL,
  `departureTime` time NOT NULL,
  `preferredHotel` varchar(255) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `adults` int(11) NOT NULL,
  `children` int(11) NOT NULL,
  `preferredDestination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`preferredDestination`)),
  `activities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`activities`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `╪º┘ä╪▒╪¡┘ä╪º╪¬_╪º┘ä╪│┘è╪º╪¡┘è╪⌐`
--

LOCK TABLES `╪º┘ä╪▒╪¡┘ä╪º╪¬_╪º┘ä╪│┘è╪º╪¡┘è╪⌐` WRITE;
/*!40000 ALTER TABLE `╪º┘ä╪▒╪¡┘ä╪º╪¬_╪º┘ä╪│┘è╪º╪¡┘è╪⌐` DISABLE KEYS */;
/*!40000 ALTER TABLE `╪º┘ä╪▒╪¡┘ä╪º╪¬_╪º┘ä╪│┘è╪º╪¡┘è╪⌐` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-14 13:00:21
