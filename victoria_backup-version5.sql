/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.4-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: victoria
-- ------------------------------------------------------
-- Server version	11.4.4-MariaDB-3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `additional_cost_types`
--

DROP TABLE IF EXISTS `additional_cost_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `additional_cost_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_cost_types`
--

LOCK TABLES `additional_cost_types` WRITE;
/*!40000 ALTER TABLE `additional_cost_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `additional_cost_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `additional_costs`
--

DROP TABLE IF EXISTS `additional_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `additional_costs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `production_id` bigint(20) unsigned NOT NULL,
  `cost_type_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `notes` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `additional_costs_production_id_foreign` (`production_id`),
  KEY `additional_costs_cost_type_id_foreign` (`cost_type_id`),
  CONSTRAINT `additional_costs_cost_type_id_foreign` FOREIGN KEY (`cost_type_id`) REFERENCES `additional_cost_types` (`id`),
  CONSTRAINT `additional_costs_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_costs`
--

LOCK TABLES `additional_costs` WRITE;
/*!40000 ALTER TABLE `additional_costs` DISABLE KEYS */;
/*!40000 ALTER TABLE `additional_costs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `additional_costs_new`
--

DROP TABLE IF EXISTS `additional_costs_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `additional_costs_new` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `production_id` bigint(20) unsigned NOT NULL,
  `cost_type_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `notes` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_costs_new`
--

LOCK TABLES `additional_costs_new` WRITE;
/*!40000 ALTER TABLE `additional_costs_new` DISABLE KEYS */;
/*!40000 ALTER TABLE `additional_costs_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `category` enum('production','sales','inventory','financial','other') NOT NULL,
  `priority` enum('low','medium','high','critical') NOT NULL DEFAULT 'medium',
  `resolved_at` timestamp NULL DEFAULT NULL,
  `resolved_by` bigint(20) unsigned DEFAULT NULL,
  `resolution_notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
INSERT INTO `cache` VALUES
('admin@example.com|127.0.0.1','i:1;',1738991586),
('admin@example.com|127.0.0.1:timer','i:1738991586;',1738991586),
('admin@gmail.com|127.0.0.1','i:1;',1738991601),
('admin@gmail.com|127.0.0.1:timer','i:1738991601;',1738991601),
('joshua@gmail.com|127.0.0.1','i:1;',1738991612),
('joshua@gmail.com|127.0.0.1:timer','i:1738991612;',1738991612);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `customers_deleted_by_foreign` (`deleted_by`),
  CONSTRAINT `customers_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `daily_wage` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `factory` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `factory_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `factory_id` (`factory_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`factory_id`) REFERENCES `factory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES
(1,'cybernet','cybernet@gamil.com',230.00,1,'Admin User','2025-02-11 09:06:57','2025-02-11 09:34:18',NULL),
(2,'cybernet','cybernet1@gamil.com',200.00,1,'Admin User','2025-02-11 09:07:16','2025-02-11 09:07:16',NULL),
(3,'cybernet','cybernet2@gamil.com',200.00,1,'Admin User','2025-02-11 09:07:23','2025-02-11 09:07:23',NULL),
(4,'cybernet','cybernet4@gamil.com',200.00,1,'Admin User','2025-02-11 09:07:31','2025-02-11 09:07:31',NULL),
(5,'cybernet','cybernet6@gamil.com',200.00,1,'Admin User','2025-02-11 09:07:41','2025-02-11 09:07:41',NULL),
(7,'atila','loyd45@gmail.com',20.00,1,'joshuaiska','2025-02-11 19:59:32','2025-02-11 19:59:32',NULL),
(8,'atila','atila231@gmail.com',2020.00,1,'man','2025-02-13 00:16:20','2025-02-13 00:16:20',NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factory`
--

DROP TABLE IF EXISTS `factory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `manager` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `factory_manager_unique` (`manager`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factory`
--

LOCK TABLES `factory` WRITE;
/*!40000 ALTER TABLE `factory` DISABLE KEYS */;
INSERT INTO `factory` VALUES
(2,'Joshua','bathroom','14','2025-02-09 16:47:38','2025-02-09 16:59:32'),
(3,'Joshua','kenya','2','2025-02-11 20:09:22','2025-02-11 20:09:22'),
(4,'admin','bathroom','20','2025-02-11 20:09:42','2025-02-11 20:09:42');
/*!40000 ALTER TABLE `factory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `finished_products`
--

DROP TABLE IF EXISTS `finished_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finished_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `production_id` bigint(20) unsigned NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `finished_products_production_id_foreign` (`production_id`),
  CONSTRAINT `finished_products_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finished_products`
--

LOCK TABLES `finished_products` WRITE;
/*!40000 ALTER TABLE `finished_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `finished_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kpis`
--

DROP TABLE IF EXISTS `kpis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kpis` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `category` enum('production','sales','inventory','financial') NOT NULL,
  `value` decimal(15,2) NOT NULL,
  `target` decimal(15,2) DEFAULT NULL,
  `unit` varchar(20) NOT NULL DEFAULT 'KSh',
  `date` date NOT NULL DEFAULT curdate(),
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kpis`
--

LOCK TABLES `kpis` WRITE;
/*!40000 ALTER TABLE `kpis` DISABLE KEYS */;
/*!40000 ALTER TABLE `kpis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labor_attendance`
--

DROP TABLE IF EXISTS `labor_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labor_attendance` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `production_id` bigint(20) unsigned NOT NULL,
  `employee_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `labor_attendance_production_id_employee_id_unique` (`production_id`,`employee_id`),
  KEY `labor_attendance_employee_id_foreign` (`employee_id`),
  CONSTRAINT `labor_attendance_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `labor_attendance_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labor_attendance`
--

LOCK TABLES `labor_attendance` WRITE;
/*!40000 ALTER TABLE `labor_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `labor_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `managers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `factory_name` enum('FENCE_POST','WET_CAST','DRY_CAST') NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `managers_user_id_unique` (`user_id`),
  UNIQUE KEY `managers_email_unique` (`email`),
  KEY `managers_deleted_by_foreign` (`deleted_by`),
  CONSTRAINT `managers_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material__stock`
--

DROP TABLE IF EXISTS `material__stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material__stock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `material_name` varchar(255) NOT NULL,
  `material_quantity` int(11) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `material_price_perUnit` varchar(255) NOT NULL,
  `stock_value` int(11) NOT NULL,
  `measurement_unit` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_stock_value` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material__stock`
--

LOCK TABLES `material__stock` WRITE;
/*!40000 ALTER TABLE `material__stock` DISABLE KEYS */;
INSERT INTO `material__stock` VALUES
(3,'sasnd',3,'issaki','3',34,'34','2025-02-12 09:49:49','2025-02-12 20:50:09',9.00),
(4,'water',1,'issak','900',400,'galons','2025-02-12 09:55:34','2025-02-12 20:50:09',900.00),
(5,'sand',6,'23','23',87,'kg','2025-02-12 10:00:35','2025-02-12 19:49:32',138.00);
/*!40000 ALTER TABLE `material__stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_purchases`
--

DROP TABLE IF EXISTS `material_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material_purchases` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint(20) unsigned NOT NULL,
  `material_id` bigint(20) unsigned NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `received_date` timestamp NULL DEFAULT NULL,
  `purchase_order_number` varchar(50) NOT NULL,
  `invoice_number` varchar(50) DEFAULT NULL,
  `payment_status` enum('pending','partial','paid') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `material_purchases_purchase_order_number_unique` (`purchase_order_number`),
  KEY `material_purchases_supplier_id_foreign` (`supplier_id`),
  KEY `material_purchases_material_id_foreign` (`material_id`),
  CONSTRAINT `material_purchases_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  CONSTRAINT `material_purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_purchases`
--

LOCK TABLES `material_purchases` WRITE;
/*!40000 ALTER TABLE `material_purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `material_purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_usage`
--

DROP TABLE IF EXISTS `material_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material_usage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `production_id` bigint(20) unsigned NOT NULL,
  `material_id` bigint(20) unsigned NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `material_usage_production_id_foreign` (`production_id`),
  KEY `material_usage_material_id_foreign` (`material_id`),
  CONSTRAINT `material_usage_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  CONSTRAINT `material_usage_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_usage`
--

LOCK TABLES `material_usage` WRITE;
/*!40000 ALTER TABLE `material_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `material_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `unit_of_measure` enum('ton','kg','g','l','ml','pcs','m') NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `current_stock` decimal(10,2) NOT NULL DEFAULT 0.00,
  `reorder_level` decimal(10,2) NOT NULL DEFAULT 0.00,
  `minimum_order_quantity` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_stock_value` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=873 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(114,'2025_02_06_134841_create_suppliers_table',2),
(830,'0001_01_01_000000_create_users_table',3),
(831,'0001_01_01_000001_create_cache_table',3),
(832,'0001_01_01_000002_create_jobs_table',3),
(833,'2025_02_06_120107_create_products_table',3),
(834,'2025_02_06_121948_create_additional_cost_types_table',3),
(835,'2025_02_06_121949_create_alerts_table',3),
(837,'2025_02_06_122509_create_additional_costs_table',3),
(838,'2025_02_06_124649_create_customers_table',3),
(839,'2025_02_06_124649_create_employees_table',3),
(840,'2025_02_06_124650_create_finished_products_table',3),
(841,'2025_02_06_134830_create_materials_table',3),
(842,'2025_02_06_134842_create_kpis_table',3),
(843,'2025_02_06_134842_create_labor_attendance_table',3),
(844,'2025_02_06_134842_create_managers_table',3),
(845,'2025_02_06_134842_create_suppliers_table',3),
(846,'2025_02_06_135107_create_material_purchases_table',3),
(847,'2025_02_06_135108_create_material_usage_table',3),
(848,'2025_02_06_135108_create_materials_stock_table',3),
(849,'2025_02_06_141013_create_orders_table',3),
(850,'2025_02_06_141018_create_order_items_table',3),
(852,'2025_02_06_141022_create_planned_labor_table',3),
(853,'2025_02_06_142505_create_planned_productions_table',3),
(854,'2025_02_06_142601_create_planned_materials_table',3),
(855,'2025_02_06_142903_create_reports_table',3),
(856,'2025_02_06_142904_create_supplier_material_prices_table',3),
(857,'2025_02_06_142950_create_system_logs_table',3),
(858,'2025_02_06_143211_create_system_logs_table',3),
(859,'2025_02_06_200710_create_personal_access_tokens_table',3),
(860,'2025_02_07_131414_create_factory_table',4),
(863,'2025_02_06_122508_create_productions_table',5),
(866,'2025_02_06_141021_create_weekly_plans_table',6),
(867,'2025_02_08_202907_create_admins_table',7),
(868,'2025_02_08_203447_create_personal_access_tokens_table',8),
(869,'2024_05_26_100246_create_posts_table',9),
(870,'2025_02_09_133248_create_personal_access_tokens_table',10),
(871,'2025_02_09_180138_create_factory_table',11),
(872,'2025_02_09_204119_create_employee_table',12);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `finished_products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `order_date` date DEFAULT curdate(),
  `expected_delivery` date NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `products_ordered` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`products_ordered`)),
  `total_cost` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES
(2,2,'2025-02-25','2025-02-20','paid','\"[]\"',93.00,'2025-02-10 19:02:49','2025-02-10 19:13:18'),
(3,2,'2025-02-25','2025-02-20','paid','\"[{\\\"product_id\\\":\\\"1\\\",\\\"quantity\\\":\\\"12\\\"},{\\\"product_id\\\":\\\"1\\\",\\\"quantity\\\":\\\"1\\\"}]\"',23.00,'2025-02-10 19:03:08','2025-02-10 19:03:08'),
(4,2,'2025-02-25','2025-02-20','paid','\"[{\\\"product_id\\\":\\\"1\\\",\\\"quantity\\\":\\\"12\\\"},{\\\"product_id\\\":\\\"1\\\",\\\"quantity\\\":\\\"1\\\"}]\"',23.00,'2025-02-10 19:03:10','2025-02-10 19:03:10'),
(8,24,'2025-02-19','2025-02-27','pending','\"[{\\\"product_id\\\":\\\"1\\\",\\\"quantity\\\":1}]\"',23.00,'2025-02-13 15:26:42','2025-02-13 15:26:42'),
(9,24,'2025-02-22','2025-02-22','pending','\"[{\\\"product_name\\\":\\\"balast\\\",\\\"quantity\\\":1}]\"',23.00,'2025-02-13 16:08:32','2025-02-13 16:08:32'),
(10,24,'2025-01-29','2025-02-13','pending','\"[{\\\"product_name\\\":\\\"cast\\\",\\\"quantity\\\":1}]\"',23.00,'2025-02-13 16:12:36','2025-02-13 16:12:36');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES
(1,'App\\Models\\User',10,'auth_token','29b8e24377fe375cd4af077f17a2786d7cf04d50a678ae4a6de21a4625e85760','[\"*\"]',NULL,NULL,'2025-02-09 10:49:15','2025-02-09 10:49:15'),
(2,'App\\Models\\User',10,'auth_token','9c912ba998e0ab38126053ad60416c86322382cd585ac3b86396d66024bf87c3','[\"*\"]',NULL,NULL,'2025-02-09 10:49:16','2025-02-09 10:49:16'),
(3,'App\\Models\\User',10,'auth_token','52351b1d051a76e4dac41d6746840bd3c5e5fd84bc4abe200037e5ee665bfd2e','[\"*\"]',NULL,NULL,'2025-02-09 10:49:18','2025-02-09 10:49:18'),
(4,'App\\Models\\User',10,'auth_token','4aec7a6899bf627506dbf4740783ccb5a56915aa7c41d1d3856913b6f9a09995','[\"*\"]',NULL,NULL,'2025-02-09 11:13:32','2025-02-09 11:13:32'),
(5,'App\\Models\\User',10,'auth_token','fa352941fb08dfb290f5b96bb498c39514a9c46d44e2924708c18bcaa5be1771','[\"*\"]',NULL,NULL,'2025-02-09 11:13:33','2025-02-09 11:13:33'),
(6,'App\\Models\\User',10,'auth_token','c2ffdc3a2f7e1599bccba72cc75d2281aaa984a211b47ed960bdecb9e504ec57','[\"*\"]',NULL,NULL,'2025-02-09 11:15:37','2025-02-09 11:15:37'),
(7,'App\\Models\\User',10,'auth_token','666d7fd85fa5f2ba91a4bf1ed1c3a0ff2167a459b5943244165770994c6c64f6','[\"*\"]',NULL,NULL,'2025-02-09 11:15:38','2025-02-09 11:15:38'),
(8,'App\\Models\\User',10,'auth_token','94558af35f6ad6d610cccba2844699e907c5ca64a0410fc3d1f1efb4bd580b67','[\"*\"]',NULL,NULL,'2025-02-09 11:15:39','2025-02-09 11:15:39'),
(9,'App\\Models\\User',10,'auth_token','831a953457c3c0914aab3d6dd489f0f80157040758cbd2c37c14bfbb54d2ee18','[\"*\"]',NULL,NULL,'2025-02-09 11:17:22','2025-02-09 11:17:22'),
(10,'App\\Models\\User',10,'auth_token','eef13d5ce8869ae31c8d20ec98de873dca60db5dbf8738e89d59e761ecb86e1c','[\"*\"]',NULL,NULL,'2025-02-09 11:17:25','2025-02-09 11:17:25'),
(11,'App\\Models\\User',10,'auth_token','ea15df01e55d37f4f28dacc256be27150306b7edee15644202c2793ae09c81c0','[\"*\"]',NULL,NULL,'2025-02-09 11:21:08','2025-02-09 11:21:08'),
(12,'App\\Models\\User',9,'auth_token','ac054ffe2304e1978d87708b891029e16e78c12fe08c5c25a0433a59c489902e','[\"*\"]',NULL,NULL,'2025-02-09 11:21:14','2025-02-09 11:21:14'),
(13,'App\\Models\\User',9,'auth_token','3745ea41c8ae33e319bf9b4808669c08eff4d22227639f212961be2497aaf931','[\"*\"]',NULL,NULL,'2025-02-09 11:21:15','2025-02-09 11:21:15'),
(14,'App\\Models\\User',9,'auth_token','f4b55f2f00e20359f006ec61bab62cc7acfba4ba39cc8896d034e7726ff233b4','[\"*\"]',NULL,NULL,'2025-02-09 11:23:22','2025-02-09 11:23:22'),
(15,'App\\Models\\User',5,'auth_token','c81d1325985de4e2202c3e1afb3ac00266a7e66fce514bbb383f0365f3658660','[\"*\"]',NULL,NULL,'2025-02-09 11:23:34','2025-02-09 11:23:34'),
(16,'App\\Models\\User',10,'auth_token','8190a3b19ae58e3a6af93ee66ee7f87ca83ba2a2d5cd9752fb62b463a1556765','[\"*\"]',NULL,NULL,'2025-02-09 11:24:55','2025-02-09 11:24:55'),
(17,'App\\Models\\User',9,'auth_token','11f606a0cd551ea4bb8fb54705ee67fa415ddb2f4e2a631b6653e5d164afe90c','[\"*\"]',NULL,NULL,'2025-02-09 14:08:37','2025-02-09 14:08:37'),
(18,'App\\Models\\User',9,'auth_token','31065101543ff0b58c2a13d3ce69d93b86d52abe58aeab5815412760ccdfa6b5','[\"*\"]',NULL,NULL,'2025-02-09 14:18:34','2025-02-09 14:18:34'),
(19,'App\\Models\\User',9,'auth_token','675f09b818569216c846d81dd115e0b8c0b2cad594f2f4d62410665910a63f4b','[\"*\"]',NULL,NULL,'2025-02-09 14:18:37','2025-02-09 14:18:37'),
(20,'App\\Models\\User',9,'auth_token','5fafdf1ba4aeda9d3cca772860d2add3d4d2ed1bc641aa2922022ba88e43ceda','[\"*\"]',NULL,NULL,'2025-02-09 14:19:55','2025-02-09 14:19:55'),
(21,'App\\Models\\User',9,'auth_token','33157f5e2d0ff09bc7f197177ddd2990a6fc7e4c248cdfe1b85486a3a1e851e7','[\"*\"]',NULL,NULL,'2025-02-09 14:23:19','2025-02-09 14:23:19'),
(22,'App\\Models\\User',9,'auth_token','ff560f069082e92e81aa86cd0ce78b831548f9eb7f211997da58ba187ccd2094','[\"*\"]',NULL,NULL,'2025-02-09 14:23:29','2025-02-09 14:23:29'),
(23,'App\\Models\\User',9,'auth_token','cf830a1d079ccc80993faa7aae9593edce0517a4f983eb9829ad326508533f00','[\"*\"]',NULL,NULL,'2025-02-09 14:45:49','2025-02-09 14:45:49'),
(24,'App\\Models\\User',9,'auth_token','32b564826fc66944f36d8f5cf1082e73d025eea27893e337b0421eb825734070','[\"*\"]',NULL,NULL,'2025-02-09 14:45:54','2025-02-09 14:45:54'),
(25,'App\\Models\\User',9,'auth_token','3ad5fe14bbec6edeba420cb5662c095d307c8decc2e2f015eac5385382f4786c','[\"*\"]',NULL,NULL,'2025-02-09 14:45:59','2025-02-09 14:45:59'),
(26,'App\\Models\\User',10,'auth_token','35f327302563ac53e8bd672eb804509876c4e189bbb4f5cfbc429f2d78a503a7','[\"*\"]',NULL,NULL,'2025-02-09 14:46:05','2025-02-09 14:46:05'),
(27,'App\\Models\\User',10,'auth_token','bf2f0b321d4695da090fcdb660535c75c862f88bec38420bfb32976483f99a05','[\"*\"]',NULL,NULL,'2025-02-09 14:47:19','2025-02-09 14:47:19'),
(28,'App\\Models\\User',10,'auth_token','6515eeffa6228f932a6d78d4b32182e0c4c56a8e186f4bf6807b2cd095eaddf0','[\"*\"]',NULL,NULL,'2025-02-09 14:47:36','2025-02-09 14:47:36'),
(29,'App\\Models\\User',10,'auth_token','2315dc358eeff00d36c61ee4d4c86dab3eab05436d0451bb3d7ed0f7bf721fb3','[\"*\"]',NULL,NULL,'2025-02-09 14:48:50','2025-02-09 14:48:50'),
(30,'App\\Models\\User',10,'auth_token','9175b003c5235263354e1fd328b0eabfb2901713c1d6c2016bdfce1d741fe008','[\"*\"]',NULL,NULL,'2025-02-09 14:49:18','2025-02-09 14:49:18'),
(31,'App\\Models\\User',10,'auth_token','76a9b07ebaf19e73ac98cd27171dc5b911bb7cc7944286a0b79fcb2bfff3418e','[\"*\"]',NULL,NULL,'2025-02-09 14:51:27','2025-02-09 14:51:27'),
(32,'App\\Models\\User',10,'auth_token','b1a8898c65ed8f422ef5362321faae0a19769ff4282949f0025bff96876a4b43','[\"*\"]',NULL,NULL,'2025-02-09 14:51:57','2025-02-09 14:51:57'),
(33,'App\\Models\\User',9,'auth_token','02c0b28ee83a8b9c1e15dbd9ef3d82136c0e6e7e4ddf3c1268e8614e333f494f','[\"*\"]',NULL,NULL,'2025-02-09 15:16:26','2025-02-09 15:16:26'),
(34,'App\\Models\\User',9,'auth_token','1ac9c72cebce675ad2eb6f01ed114e692a63fcb844647efee293bf0163dbc16e','[\"*\"]',NULL,NULL,'2025-02-09 15:16:29','2025-02-09 15:16:29'),
(37,'App\\Models\\User',11,'auth_token','c76e41f075988fcc04ce0aa0a2bd2d265ff1b784907ee99b24e7c86f011a0a2f','[\"*\"]',NULL,NULL,'2025-02-09 18:22:17','2025-02-09 18:22:17'),
(38,'App\\Models\\User',10,'auth_token','4b70cf2ea8208df88274eadc81f129df911e12320ba82b5ed8933c13d58bc564','[\"*\"]',NULL,NULL,'2025-02-09 18:22:36','2025-02-09 18:22:36'),
(39,'App\\Models\\User',10,'auth_token','126a7955c73b0bd6205ce976c1e62eba82212c1fb012bd807c9c01dcd1c3359d','[\"*\"]',NULL,NULL,'2025-02-09 18:22:56','2025-02-09 18:22:56'),
(42,'App\\Models\\User',10,'auth_token','a303fb9e5645f8c39b1f9a30e35965b7ada3c59bfb969b517a996cd89624f023','[\"*\"]',NULL,NULL,'2025-02-10 03:20:27','2025-02-10 03:20:27'),
(43,'App\\Models\\User',10,'auth_token','07ca70d3e066ddb8d8eebd2b22692891adc3227aef027f0a2d60c80e66caff8c','[\"*\"]',NULL,NULL,'2025-02-10 03:21:08','2025-02-10 03:21:08'),
(44,'App\\Models\\User',10,'auth_token','86068d16a37653eb5af289b846e5fbab7b82e7e9e672659c37c9cd2acdf4f1d7','[\"*\"]',NULL,NULL,'2025-02-10 03:23:10','2025-02-10 03:23:10'),
(45,'App\\Models\\User',10,'auth_token','ac8673ee45dc7cd4ce2325f2ccbe57c00034be0ef49ded49c6c0ed37e1c39b7a','[\"*\"]',NULL,NULL,'2025-02-10 03:23:15','2025-02-10 03:23:15'),
(46,'App\\Models\\User',10,'auth_token','db71d1ea9f2e92c7d77db6135f7e2c2d1fa030203a2fc94a534a50251ff97394','[\"*\"]',NULL,NULL,'2025-02-10 03:25:30','2025-02-10 03:25:30'),
(47,'App\\Models\\User',10,'auth_token','0109b7a425817456c9d0470d20696ca8c4be41a241dc23e047d81d6f11ec8492','[\"*\"]',NULL,NULL,'2025-02-10 03:31:15','2025-02-10 03:31:15'),
(48,'App\\Models\\User',10,'auth_token','bc09b2b958fc0275490f9d1a9efd51403fe2fa92d15be8f3046719bcbda41b15','[\"*\"]',NULL,NULL,'2025-02-10 03:36:40','2025-02-10 03:36:40'),
(49,'App\\Models\\User',10,'auth_token','3183896e58cde4b33fe7eae2467e7cc1c6940fb4a565aa80b8f6c9b18c9f636a','[\"*\"]',NULL,NULL,'2025-02-10 03:39:46','2025-02-10 03:39:46'),
(50,'App\\Models\\User',10,'auth_token','e87e5961f519add1f70230262756da7a75deebc0d7224baaba551c6cd599a398','[\"*\"]',NULL,NULL,'2025-02-10 04:57:16','2025-02-10 04:57:16'),
(51,'App\\Models\\User',10,'auth_token','de2b645ae8ec886a67660f68368a6f092ea57ab5b967d978b924cab6129aed73','[\"*\"]',NULL,NULL,'2025-02-10 04:58:32','2025-02-10 04:58:32'),
(61,'App\\Models\\User',5,'auth_token','2d7f63242f04397c604bfe6e69f87a8b6fabb31b8b1f5714de2eae5fc1d685ee','[\"*\"]',NULL,NULL,'2025-02-10 16:34:44','2025-02-10 16:34:44'),
(62,'App\\Models\\User',11,'auth_token','de8ca71c3ae4b761939c64ef7195bf5740ef3ae08b9e577b7202cf7ca82953f1','[\"*\"]',NULL,NULL,'2025-02-10 17:57:16','2025-02-10 17:57:16'),
(63,'App\\Models\\User',10,'auth_token','da96a720ed5ff9ca1c68111fa89d52af2998a4255d3b9440b1b318d0c5c5b01d','[\"*\"]',NULL,NULL,'2025-02-10 19:36:04','2025-02-10 19:36:04'),
(64,'App\\Models\\User',10,'auth_token','3a27196cb64c8e4bc5b218ad82570e2ee91bf6aeda824cabdad1a97603a0b825','[\"*\"]',NULL,NULL,'2025-02-10 19:38:27','2025-02-10 19:38:27'),
(65,'App\\Models\\User',10,'auth_token','26364a87b4e9045c1e9527af688a7a2d909a6bb168b6ceef1719d800ee5e7655','[\"*\"]',NULL,NULL,'2025-02-10 19:39:34','2025-02-10 19:39:34'),
(66,'App\\Models\\User',10,'auth_token','7b1f564053ae331d910ac4f3ef0d078c70f9cb0312c5ead7c0514ba5aad554de','[\"*\"]',NULL,NULL,'2025-02-10 19:43:55','2025-02-10 19:43:55'),
(67,'App\\Models\\User',10,'auth_token','49373cd1c446131154b88bb993b1dd60d98a1e363191b356420a7cab6df143e2','[\"*\"]',NULL,NULL,'2025-02-10 19:44:15','2025-02-10 19:44:15'),
(68,'App\\Models\\User',10,'auth_token','86d51b25001f0fd22bfdc528c6720e9c1fd48b38f24087e5abaaed26bd847081','[\"*\"]',NULL,NULL,'2025-02-10 19:45:53','2025-02-10 19:45:53'),
(69,'App\\Models\\User',10,'auth_token','cdc5acedf9dbbb1032f180b57814e560fe4c89298aaf2ece4b6bc92504c8806e','[\"*\"]',NULL,NULL,'2025-02-10 19:46:36','2025-02-10 19:46:36'),
(70,'App\\Models\\User',10,'auth_token','7ac867e77c7d31117d138562c2d5eeb89a309082adf42bfd4769bd3b24daf8a9','[\"*\"]',NULL,NULL,'2025-02-10 19:48:18','2025-02-10 19:48:18'),
(71,'App\\Models\\User',10,'auth_token','e8deebcf197931df1cd2896ec81323f7da0814a4acc456dbf7328e2ade2dc0ee','[\"*\"]',NULL,NULL,'2025-02-10 19:51:35','2025-02-10 19:51:35'),
(73,'App\\Models\\User',10,'auth_token','cdb3030c4e04281cd9b14e6ed09c7eb57f4e3d00428e5c8592ff6a21d92b83e6','[\"*\"]',NULL,NULL,'2025-02-10 19:54:58','2025-02-10 19:54:58'),
(74,'App\\Models\\User',10,'auth_token','b857383efbb9e9f7d533edd928e960a0ef0313e0da412daa3069da25392bdb47','[\"*\"]',NULL,NULL,'2025-02-10 19:55:40','2025-02-10 19:55:40'),
(75,'App\\Models\\User',11,'auth_token','9cc20d1ba7b66a7029c9763b28d438de2f1551029d023d6b32106de03486fb89','[\"*\"]',NULL,NULL,'2025-02-10 19:56:33','2025-02-10 19:56:33'),
(76,'App\\Models\\User',10,'auth_token','692b5d90ea1bf6d0f3b472c2ca34f462e865a43dfd4261f8ea9d58b9754a92f1','[\"*\"]',NULL,NULL,'2025-02-10 19:56:46','2025-02-10 19:56:46'),
(77,'App\\Models\\User',10,'auth_token','98c13190182d2ae3ff6b5bcc07b4fb35aab251755379c53d1a887334c03f3e5c','[\"*\"]',NULL,NULL,'2025-02-10 19:59:54','2025-02-10 19:59:54'),
(78,'App\\Models\\User',10,'auth_token','5d078bab02c8ea39533d98c7afafd09341a36f0885dbc15b3a9b5a023286be0e','[\"*\"]',NULL,NULL,'2025-02-10 20:00:50','2025-02-10 20:00:50'),
(79,'App\\Models\\User',10,'auth_token','5c7f9e0e0f5c6d6b44309a3e110da543a31bf3d1c6eb1e9cbe35cdd04ea03175','[\"*\"]',NULL,NULL,'2025-02-10 20:01:34','2025-02-10 20:01:34'),
(80,'App\\Models\\User',10,'auth_token','ce8ef4b0e5ee931691f52c20bd6da3b2b9e3baa53fc3458e3497456298087e50','[\"*\"]',NULL,NULL,'2025-02-10 20:01:54','2025-02-10 20:01:54'),
(81,'App\\Models\\User',10,'auth_token','7147404975027e5f48494a62deee18e7fef1e62de5b4f8e1b8bdf56cc8ff201a','[\"*\"]',NULL,NULL,'2025-02-10 20:08:16','2025-02-10 20:08:16'),
(82,'App\\Models\\User',10,'auth_token','ec87dd65644b21f54e76b056ad60614ce327e4e77f8ffe78b86c71bf3c232e31','[\"*\"]',NULL,NULL,'2025-02-10 20:09:08','2025-02-10 20:09:08'),
(83,'App\\Models\\User',10,'auth_token','ed7dd3ca26bfc172de604285395e23286663247ad391a73f00ac64a7ca4d7ce5','[\"*\"]',NULL,NULL,'2025-02-10 20:10:39','2025-02-10 20:10:39'),
(84,'App\\Models\\User',10,'auth_token','0153b4f2241f619e664e44ed6d8afea99c540d9335ec918ffb21e6e83e4a5f99','[\"*\"]',NULL,NULL,'2025-02-10 20:11:09','2025-02-10 20:11:09'),
(85,'App\\Models\\User',10,'auth_token','af504b393767faabeb41ce0e81e1b093941d21024a5aaf76f213c4414ef12086','[\"*\"]',NULL,NULL,'2025-02-10 20:11:21','2025-02-10 20:11:21'),
(86,'App\\Models\\User',10,'auth_token','e0db17475ca3300e2c82d594c94f4cd5f8fabacbcfcc7995e568ee5b05595b70','[\"*\"]',NULL,NULL,'2025-02-10 20:14:50','2025-02-10 20:14:50'),
(87,'App\\Models\\User',10,'auth_token','0fbc5f506f068a96464e58588e252be86897c12af2032da56402a7f3e6d93c52','[\"*\"]',NULL,NULL,'2025-02-10 20:16:19','2025-02-10 20:16:19'),
(88,'App\\Models\\User',10,'auth_token','a8b4baef194f4dd3e7de37b2d3768f36456123c10c48271b34ca43bde9b3d268','[\"*\"]',NULL,NULL,'2025-02-10 20:17:01','2025-02-10 20:17:01'),
(91,'App\\Models\\User',10,'auth_token','c49e49bce8a803affded43cc032b04c6f642525a079876bd06797d5d3df85924','[\"*\"]',NULL,NULL,'2025-02-10 20:20:47','2025-02-10 20:20:47'),
(92,'App\\Models\\User',10,'auth_token','b38835d8bbf880563e1f6e170f6d75762a924dad92abaec52a26cf2c069f986f','[\"*\"]',NULL,NULL,'2025-02-11 08:18:19','2025-02-11 08:18:19'),
(93,'App\\Models\\User',10,'auth_token','d810b5da4b8a59a8f13b73e4ce6b9107b5979593266990011254cea7af8909a7','[\"*\"]',NULL,NULL,'2025-02-11 08:27:30','2025-02-11 08:27:30'),
(100,'App\\Models\\User',10,'auth_token','4007ee2b98b61a30c6fcbc92970b3003ca122dacf67a066352cbd77cab5023c6','[\"*\"]',NULL,NULL,'2025-02-11 09:59:13','2025-02-11 09:59:13'),
(103,'App\\Models\\User',10,'auth_token','8be18f761504ee3b48f0a5c2abb3a909bdade09b94e1f03a0bb42d3979a1d195','[\"*\"]',NULL,NULL,'2025-02-11 10:11:03','2025-02-11 10:11:03'),
(105,'App\\Models\\User',21,'auth_token','eb35c533a11cded6082292b44d175bbfb39c6068d666c3490c03208d663d2cf3','[\"*\"]',NULL,NULL,'2025-02-11 18:57:08','2025-02-11 18:57:08'),
(106,'App\\Models\\User',10,'auth_token','934ca148eec3c3d15a2b599e5e5c09a0926a04167e5f2e802ea31d403bf881e4','[\"*\"]',NULL,NULL,'2025-02-11 19:12:46','2025-02-11 19:12:46'),
(113,'App\\Models\\User',22,'auth_token','783cd766b3d2616557653bd9fe426df8f49a814eddc521fcf49bf41103ae323e','[\"*\"]',NULL,NULL,'2025-02-11 21:17:16','2025-02-11 21:17:16'),
(121,'App\\Models\\User',21,'auth_token','19cbd7a37803eb06175339bc6e695639446e59260862702e2f4eff01fbb27785','[\"*\"]',NULL,NULL,'2025-02-12 08:22:20','2025-02-12 08:22:20'),
(169,'App\\Models\\User',23,'auth_token','3b17f8daf0c535e5219ee027d8d35653473e47671b6880d3c61db26f1790e2cf','[\"*\"]',NULL,NULL,'2025-02-12 19:45:34','2025-02-12 19:45:34'),
(170,'App\\Models\\User',23,'auth_token','8506d53e66a77f6964dff400ee8f1b3fbda8d626bf3320ef5eef387a9bf18858','[\"*\"]',NULL,NULL,'2025-02-12 19:52:24','2025-02-12 19:52:24'),
(171,'App\\Models\\User',14,'auth_token','132f62d6d6900da4b34c37a4971d943e826d4b3ba6af03912a97765a2679031a','[\"*\"]',NULL,NULL,'2025-02-12 19:53:48','2025-02-12 19:53:48'),
(172,'App\\Models\\User',23,'auth_token','f6e863597fa262944476c565bc263c1b2b622491ef241eedd58724125f4d3326','[\"*\"]',NULL,NULL,'2025-02-12 20:07:54','2025-02-12 20:07:54'),
(173,'App\\Models\\User',23,'auth_token','e954c46a1535a1604c8157cdcb44736fefe3e2dd7a0e3ae2edc78acffee4a954','[\"*\"]',NULL,NULL,'2025-02-12 21:04:24','2025-02-12 21:04:24'),
(174,'App\\Models\\User',21,'auth_token','0982b4a304e2a52e318f78a3a8a4d814e9acf5bc79063bba39c24009a5d4337c','[\"*\"]',NULL,NULL,'2025-02-13 00:15:14','2025-02-13 00:15:14'),
(175,'App\\Models\\User',17,'auth_token','c4036db2589b6f2341acf9b59fc79a563dc4a2291648dd94a34cb6a3ab2d2a03','[\"*\"]',NULL,NULL,'2025-02-13 00:15:42','2025-02-13 00:15:42'),
(176,'App\\Models\\User',20,'auth_token','4a7647664ac251d8049a2ed3993f5816c26443480a0add19bc4dabac0cd6843c','[\"*\"]',NULL,NULL,'2025-02-13 10:09:15','2025-02-13 10:09:15'),
(177,'App\\Models\\User',24,'auth_token','84f052d1ed4017894b56acfab7cc8b2b0bfeda1db105f046b5b042d1a597f0ad','[\"*\"]',NULL,NULL,'2025-02-13 15:16:44','2025-02-13 15:16:44'),
(178,'App\\Models\\User',24,'auth_token','1d9f2f6aa049958b7be265aec933b38f9adc5d33c42fe37eda1b2e417928b781','[\"*\"]',NULL,NULL,'2025-02-13 15:16:44','2025-02-13 15:16:44'),
(179,'App\\Models\\User',24,'auth_token','00384eea0013a3029830592fd3af14430c996ca797988b8e414258bf6d953558','[\"*\"]',NULL,NULL,'2025-02-13 16:38:18','2025-02-13 16:38:18');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planned_labor`
--

DROP TABLE IF EXISTS `planned_labor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planned_labor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `weekly_plan_id` bigint(20) unsigned NOT NULL,
  `employee_id` bigint(20) unsigned NOT NULL,
  `planned_days` int(11) NOT NULL,
  `estimated_cost` decimal(10,2) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planned_labor_weekly_plan_id_foreign` (`weekly_plan_id`),
  KEY `planned_labor_employee_id_foreign` (`employee_id`),
  CONSTRAINT `planned_labor_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `planned_labor_weekly_plan_id_foreign` FOREIGN KEY (`weekly_plan_id`) REFERENCES `weekly_plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planned_labor`
--

LOCK TABLES `planned_labor` WRITE;
/*!40000 ALTER TABLE `planned_labor` DISABLE KEYS */;
/*!40000 ALTER TABLE `planned_labor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planned_materials`
--

DROP TABLE IF EXISTS `planned_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planned_materials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `weekly_plan_id` bigint(20) unsigned NOT NULL,
  `material_id` bigint(20) unsigned NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `estimated_cost` decimal(10,2) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planned_materials_weekly_plan_id_foreign` (`weekly_plan_id`),
  KEY `planned_materials_material_id_foreign` (`material_id`),
  CONSTRAINT `planned_materials_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  CONSTRAINT `planned_materials_weekly_plan_id_foreign` FOREIGN KEY (`weekly_plan_id`) REFERENCES `weekly_plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planned_materials`
--

LOCK TABLES `planned_materials` WRITE;
/*!40000 ALTER TABLE `planned_materials` DISABLE KEYS */;
/*!40000 ALTER TABLE `planned_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planned_productions`
--

DROP TABLE IF EXISTS `planned_productions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planned_productions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `weekly_plan_id` bigint(20) unsigned NOT NULL,
  `product_type` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `planned_date` date NOT NULL,
  `labor_count` int(11) NOT NULL,
  `status` enum('pending','started','completed','cancelled') NOT NULL DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planned_productions_weekly_plan_id_foreign` (`weekly_plan_id`),
  CONSTRAINT `planned_productions_weekly_plan_id_foreign` FOREIGN KEY (`weekly_plan_id`) REFERENCES `weekly_plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planned_productions`
--

LOCK TABLES `planned_productions` WRITE;
/*!40000 ALTER TABLE `planned_productions` DISABLE KEYS */;
/*!40000 ALTER TABLE `planned_productions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `body` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productions`
--

DROP TABLE IF EXISTS `productions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `production_date` date NOT NULL,
  `factory` varchar(255) NOT NULL,
  `material_total_cost` decimal(10,2) NOT NULL,
  `labor_cost` decimal(10,2) NOT NULL,
  `overhead_cost` decimal(10,2) NOT NULL,
  `items_produced_perday` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productions`
--

LOCK TABLES `productions` WRITE;
/*!40000 ALTER TABLE `productions` DISABLE KEYS */;
INSERT INTO `productions` VALUES
(3,'balast',3,'2025-02-13','issaki',343.00,34.00,422.00,16,'2025-02-10 05:00:23','2025-02-11 10:05:03'),
(5,'balast',5,'2025-02-13','kenya',343.00,34.00,422.00,16,'2025-02-10 05:08:14','2025-02-10 05:46:44'),
(7,'cement',97,'2025-02-20','kenya',9.00,23.00,3.00,234,'2025-02-12 19:08:25','2025-02-12 19:08:25'),
(8,'cement',8,'2025-02-20','kenya',9.00,23.00,3.00,234,'2025-02-12 19:11:07','2025-02-12 19:11:07'),
(9,'cement',82,'2025-02-20','kenya',9.00,23.00,3.00,234,'2025-02-12 19:15:24','2025-02-12 19:15:24'),
(10,'chocolate',33,'2025-02-26','kenya',3212.00,345.00,345.00,43,'2025-02-12 19:17:24','2025-02-12 19:17:24'),
(11,'ice',32,'2025-02-14','keanya',1892.00,234.00,234.00,234,'2025-02-12 19:19:12','2025-02-12 19:19:12'),
(12,'cement',23,'2025-02-11','2',2769.00,534.00,234.00,123,'2025-02-12 19:49:30','2025-02-12 19:49:30'),
(15,'cement simba',31,'2025-02-14','3',909.00,34.00,342.00,323,'2025-02-12 20:50:07','2025-02-12 20:50:07');
/*!40000 ALTER TABLE `productions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price_per_unit` decimal(8,2) NOT NULL,
  `availability_in_stock` tinyint(1) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES
(1,'balast',23.00,1,'public/products/ewnHcNNxahfBzWkxQQcxZnU8OCr8CgaGvd1GayFk.jpg','2025-02-10 13:10:31','2025-02-10 13:10:31'),
(3,'cast',23.00,1,'public/products/xflorJdAPf8t2VGHT4xhDOjd0PGiE1f4MPmVfVlD.jpg','2025-02-11 20:14:34','2025-02-11 20:14:34'),
(4,'cement',600.00,1,'public/products/9o7ddxfFFDqXH52lunbjpq7p1MgxJAna7ohjz9IW.jpg','2025-02-12 07:00:06','2025-02-12 07:00:06');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `category` enum('production','sales','inventory','financial','combined') NOT NULL,
  `date_range_start` date NOT NULL,
  `date_range_end` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `report_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_created_by_foreign` (`created_by`),
  CONSTRAINT `reports_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
INSERT INTO `sessions` VALUES
('DDv76jUyBc6qM0GvEbuNMJtLofsBAxaFg8tyyrl5',24,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiYUhkOUlhWnlSYmk4dmN4c2RsMXZheWFpY25kaWh1cXE5ekl1NDVjZiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MDoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2N1c3RvbWVyL2Rhc2hib2FyZCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvbG9naW4iO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyNDt9',1739475502),
('GGbniRBQLv41eTF4M72dgQRuBnOViV0JQzCK0979',24,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiYUhkOUlhWnlSYmk4dmN4c2RsMXZheWFpY25kaWh1cXE5ekl1NDVjZiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MDoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2N1c3RvbWVyL2Rhc2hib2FyZCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvbG9naW4iO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyNDt9',1739470604);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_material_prices`
--

DROP TABLE IF EXISTS `supplier_material_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier_material_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint(20) unsigned NOT NULL,
  `material_id` bigint(20) unsigned NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `minimum_order_quantity` int(11) NOT NULL DEFAULT 1,
  `is_current` tinyint(1) NOT NULL DEFAULT 1,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_supplier_material_price` (`supplier_id`,`material_id`,`is_current`),
  KEY `supplier_material_prices_material_id_foreign` (`material_id`),
  CONSTRAINT `supplier_material_prices_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supplier_material_prices_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_material_prices`
--

LOCK TABLES `supplier_material_prices` WRITE;
/*!40000 ALTER TABLE `supplier_material_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier_material_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `materials_supplied` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`materials_supplied`)),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES
(3,'kinoti','linoti@gmail.com','1231`3`','[\"water 60\",\"sugar,90\"]','2025-02-10 07:18:54','2025-02-10 07:18:54'),
(4,'iska','isakA@GAMIL.COM','2895189','[\"water\"]','2025-02-10 07:34:30','2025-02-10 07:34:30'),
(5,'iskahah','sahhs@gmail.com','23472683568','[\"water,98\"]','2025-02-10 07:37:12','2025-02-10 07:37:12');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_logs`
--

DROP TABLE IF EXISTS `system_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `action_type` enum('CREATE','UPDATE','DELETE','LOGIN','LOGOUT','VIEW','EXPORT','ERROR','OTHER') NOT NULL,
  `content_type` enum('PRODUCTION','MATERIAL','EMPLOYEE','ATTENDANCE','SUPPLIER','PURCHASE','PLAN','USER','SYSTEM') NOT NULL,
  `object_id` varchar(50) DEFAULT NULL,
  `object_repr` varchar(200) DEFAULT NULL,
  `action_detail` text DEFAULT NULL,
  `changes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `browser` varchar(200) DEFAULT NULL,
  `os` varchar(200) DEFAULT NULL,
  `device` varchar(200) DEFAULT NULL,
  `status` enum('SUCCESS','FAILURE','WARNING') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `system_logs_user_id_foreign` (`user_id`),
  CONSTRAINT `system_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_logs`
--

LOCK TABLES `system_logs` WRITE;
/*!40000 ALTER TABLE `system_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) unsigned DEFAULT NULL,
  `role` varchar(255) DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_deleted_by_foreign` (`deleted_by`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'admin','johndoe@realestatecare.com',NULL,'$2y$12$majKgj0NXZtH1OXbAriYEOcu2YN9h/jrIakCihROc9HXhgcJzIKvW',NULL,'2025-02-07 09:53:32','2025-02-07 09:53:32',NULL,NULL,'customer'),
(2,'admin','codyvandijk@realestatecare.com',NULL,'$2y$12$ISeNKzbHFRzcb5JtPsVYreOtdfmli8APTBTsDqB3Ny5mjhKuIOSFW',NULL,'2025-02-07 16:34:40','2025-02-09 16:20:01',NULL,NULL,'admin'),
(3,'joshuaiska','joshuaiska@gmail.com',NULL,'$2y$12$kX0nzXgM2fkLe0pGFZNZTuD.PWUuZa8YIcNMO.IJHVcC.zdfi1UWG',NULL,'2025-02-08 16:24:02','2025-02-08 16:24:02',NULL,NULL,'customer'),
(4,'admin','admin@example.com',NULL,'$2y$12$PWP0EXJ56Qd4bTQHcWSLlOGgYSiMaZKVXvAIMlyBoPCq2Qpor.5Ua',NULL,'2025-02-09 05:34:24','2025-02-09 05:34:24',NULL,NULL,'customer'),
(5,'admin','admin@admin.com',NULL,'$2y$12$S6KiDrKD.Ae/h4cjGIJ1se7bKb3c0oVYLxRbXM3ZQ3us19ASAbD5G',NULL,'2025-02-09 05:46:43','2025-02-09 05:46:43',NULL,NULL,'customer'),
(10,'Manager User','manager@example.com',NULL,'$2y$12$lbmx44z8NoQKXzDoM76dQOZxk.CxukYueZR6J7BAO3.KfMiTMNEFO',NULL,'2025-02-09 09:47:11','2025-02-11 21:02:32',NULL,NULL,'manager'),
(11,'joshuaiska','customer@example.com',NULL,'$2y$12$cwJmFxauDncmdCSBNqJTSOSbFzAx8W8j1fYcmcXMA3ZkEb8h086Mi',NULL,'2025-02-09 15:00:13','2025-02-09 15:00:13',NULL,NULL,'customer'),
(12,'uuyui','test2@example.com',NULL,'$2y$12$Nlknt9km6dstd5lPRzLp5O1Bvy7QMptyb995HY7H8dIPIsWv9cCze',NULL,'2025-02-09 15:46:56','2025-02-09 15:46:56',NULL,NULL,'manager'),
(13,'uuyui','test26@example.com',NULL,'$2y$12$QVzz6ypH5AMNxaRMv6LpPOaD0qjhc7m8mYBc8MxSctjBiuwgfftku',NULL,'2025-02-09 15:47:06','2025-02-09 15:47:06',NULL,NULL,'manager'),
(14,'Admin User','admin11@example.com',NULL,'$2y$12$QE5J5RehD6fUv2jacIq1SuiEkspL/uiii8Gh7uXbxkFMBo57BynbK',NULL,'2025-02-09 16:20:37','2025-02-09 16:20:37',NULL,NULL,'admin'),
(17,'Admin User','admin13@example.com',NULL,'$2y$12$dRfNsA0LVyxI94dnrvhTP.KD3r/NCHZqjxuaHRpfNPjT1pAC6KqEe',NULL,'2025-02-09 16:21:28','2025-02-09 16:21:28',NULL,NULL,'admin'),
(20,'custer2','customer2@example.com',NULL,'$2y$12$yDV8P2lwR2YABo5IMpHqfOir7HYXnJpUB.THhUrPpL6f/u8H2kx8W',NULL,'2025-02-11 10:17:17','2025-02-11 10:17:17',NULL,NULL,'customer'),
(21,'admin','admin12@example.com',NULL,'$2y$12$GaoHUuv0CMqNpExl3sgd7uEDu4CpN8rNjBL94d73n3d7tCZjDswRC',NULL,'2025-02-11 18:56:32','2025-02-11 18:56:32',NULL,NULL,'customer'),
(22,'manager','man12@gmail.com',NULL,'$2y$12$N9yepxDpGB4VLsjMZnFExOMWEV7Hv29PtcQBSwcc4v7ZF73C9VlYW',NULL,'2025-02-11 21:16:11','2025-02-11 21:16:11',NULL,NULL,'manager'),
(23,'man','man@gmail.com',NULL,'$2y$12$nzkSa3NBBO1KkZCmAJaVcevFONzLaHGgypI8cGqY3y2UpE4bCcz8O',NULL,'2025-02-12 17:34:02','2025-02-12 17:34:02',NULL,NULL,'manager'),
(24,'custer2','cust@gmail.com',NULL,'$2y$12$/986Wo914ioi.h5PFjw.4OzNQu5baBOJnPyvooFFfwJZQPzeJbOAS',NULL,'2025-02-13 10:12:53','2025-02-13 10:12:53',NULL,NULL,'customer');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekly_plans`
--

DROP TABLE IF EXISTS `weekly_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weekly_plans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `factory` varchar(255) NOT NULL,
  `week_start_date` date NOT NULL,
  `week_end_date` date NOT NULL,
  `status` enum('draft','pending','approved','rejected') DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `materials_needed` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`materials_needed`)),
  `total_cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekly_plans`
--

LOCK TABLES `weekly_plans` WRITE;
/*!40000 ALTER TABLE `weekly_plans` DISABLE KEYS */;
INSERT INTO `weekly_plans` VALUES
(2,'kenya','2025-02-22','2025-02-21','pending','2025-02-11 08:18:48','2025-02-11 08:27:47','sfga','[{\"product_id\":\"1\",\"quantity\":\"2\"}]',3.00),
(3,'kenya','2025-02-17','2025-02-28','approved','2025-02-12 21:18:50','2025-02-12 21:18:50','6this week','[{\"material_id\":\"3\",\"quantity\":\"2\"}]',234.00);
/*!40000 ALTER TABLE `weekly_plans` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-02-13 22:39:56
