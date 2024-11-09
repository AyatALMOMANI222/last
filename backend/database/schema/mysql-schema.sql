/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (1,'0001_01_01_000000_create_users_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (2,'0001_01_01_000001_create_cache_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (3,'0001_01_01_000002_create_jobs_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (4,'2024_09_03_062848_create_conferences_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (5,'2024_09_03_065551_create_conference_image_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (6,'2024_09_03_073118_create_committee_members_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (7,'2024_09_03_082314_create_scientific_topics_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (8,'2024_09_03_082802_create_conference_prices_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (9,'2024_09_03_093540_create_scientific_papers_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (10,'2024_09_03_115452_create_exhibitions_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (11,'2024_09_03_122725_create_tourist_sites_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (12,'2024_09_04_061903_update_users_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (13,'2024_09_04_065553_update_conferences_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (14,'2024_09_05_120747_modify_name_column_in_users_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (15,'2024_09_05_160656_make_conference_img_nullable',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (16,'2024_09_05_160846_update_conference_img_column',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (17,'2024_09_05_162332_change_committee_image_column_in_committee_members_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (18,'2024_09_10_220245_create_personal_access_tokens_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (19,'2024_09_12_143405_create_speakers_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (20,'2024_09_12_155012_create_attendance_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (21,'2024_09_12_155327_create_sponsors_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (22,'2024_09_12_161020_create_group_registrations_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (23,'2024_09_12_212631_add_status_to_users_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (24,'2024_09_14_103631_create_exhibition_images_table',1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (25,'2024_09_16_095352_create_notifications_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (26,'2024_09_16_223522_add_column_to_notifications_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (27,'2024_09_17_132654_create_visas_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (28,'2024_09_17_145154_update_visas_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (29,'2024_09_19_162524_create_flights_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (30,'2024_09_19_162757_create_available_flights_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (31,'2024_09_22_102500_modify_admin_update_deadline_column_in_flights_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (32,'2024_09_22_142132_create_accepted_flights_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (33,'2024_09_22_160324_add_departure_details_to_accepted_flights_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (34,'2024_09_25_141323_update_ticket_count_default_in_flights_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (35,'2024_09_27_180053_create_conference_user_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (36,'2024_09_27_192519_add_specific_flight_time_to_flights_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (37,'2024_09_28_022942_make_user_id_nullable_in_flights_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (38,'2024_09_28_062022_add_conference_id_to_exhibitions_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (39,'2024_10_01_050157_create_reservations_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (40,'2024_10_01_050246_create_rooms_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (41,'2024_10_03_053130_add_update_deadline_to_reservations_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (42,'2024_10_03_093606_create_trips_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (43,'2024_10_03_100913_create_trip_participants_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (44,'2024_10_04_121859_create_group_trip_participants_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (45,'2024_10_06_143350_create_conference_trip_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (46,'2024_10_06_154441_create_additional_options_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (47,'2024_10_06_155127_create_user_final_prices_table',2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (48,'2024_10_09_112106_create_dinner_details_table',3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (49,'2024_10_09_112107_create_dinner_attendees_table',3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (50,'2024_10_09_123210_create_airport_transfer_bookings_table',4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (51,'2024_10_09_140643_create_dinner_speaker_companion_fees_table',4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (52,'2024_10_10_070827_add_trip_costs_to_speakers_table',4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (53,'2024_10_10_152424_modify_foreign_key_on_dinner_attendees',4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (54,'2024_10_11_100200_create_discount_option_table',4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (55,'2024_10_12_092152_create_trip_options_participants_table',4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (56,'2024_10_12_130532_modify_trip_participants_nullable_columns',4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (57,'2024_10_13_062851_create_airport_transfer_prices_table',5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (58,'2024_10_16_100356_add_conference_id_to_notifications_table',6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (59,'2024_10_19_110657_make_password_nullable_in_users_table',6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (60,'2024_10_20_084001_add_updated_at_by_admin_to_visas_table',6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (61,'2024_10_21_051547_add_visa_price_to_conferences_table',6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (62,'2024_10_21_122214_add_is_admin_to_users_table',7);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (63,'2024_10_21_130937_add_password_to_group_registrations_table',8);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (64,'2024_10_21_145828_add_conference_id_to_group_registrations_table',9);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (65,'2024_10_22_234531_add_base_ticket_price_to_flights_table',10);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (66,'2024_10_25_124630_create_room_prices_table',11);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (67,'2024_10_25_133459_add_room_type_and_nights_covered_to_speakers_table',12);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (68,'2024_10_26_140006_make_columns_nullable_in_trips_table',13);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (69,'2024_10_29_081049_create_ourclients_table',14);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (70,'2024_11_01_094355_rename_visa_price_in_conferences_table',15);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (71,'2024_11_01_153250_add_is_visa_payment_required_to_conference_user_table',16);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (73,'2024_11_04_102722_add_companion_dinner_price_to_conferences_table',17);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (74,'2024_11_04_103759_add_companion_dinner_price_to_conferences_table',18);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (75,'2024_11_04_151523_add_companion_price_to_dinner_attendees_table',19);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (77,'2024_11_05_051427_add_conference_id_to_dinner_attendees_table',20);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (79,'2024_11_05_112318_create_jobs_applicants_and_job_applications_tables',21);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (80,'2024_11_05_133759_rename_events_coordinator_column_in_available_jobs_table',22);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (81,'2024_11_06_080507_create_messages_table',23);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (82,'2024_11_06_105517_create_sponsorship_options_table',24);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (83,'2024_11_06_145221_create_conference_sponsorship_options_table',25);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (84,'2024_11_06_151147_rename_conference_sponsorship_options_to_sponsorships',26);
