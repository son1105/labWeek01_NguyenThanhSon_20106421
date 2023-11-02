-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for mydb
CREATE DATABASE IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `mydb`;

-- Dumping structure for table mydb.account
CREATE TABLE IF NOT EXISTS `account` (
  `status` tinyint(4) DEFAULT NULL,
  `account_id` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table mydb.account: ~6 rows (approximately)
INSERT INTO `account` (`status`, `account_id`, `email`, `full_name`, `password`, `phone`) VALUES
	(1, 'cam', 'cam@gmail.com', 'Van My Cam', '123', '0249234293403'),
	(1, 'loi', 'loi@gmail.com', 'Pham Tan Loi', '123', '0985456320'),
	(1, 'met', 'met@gmail.com', 'Tran Thi Met', '123', '0904567890'),
	(1, 'phong', 'phong@gmail.com', 'Nguyen Tan Phong', '123', '0945674421'),
	(1, 'son', 'son@gmail.com', 'Nguyen Thanh Son', '123', '0387866829'),
	(1, 'sonPham', 'sonPham@gmail.com', 'Phạm Thanh Sơn', '123', '24234234324'),
	(1, 'teo', 'teo@gmail.com', 'Nguyen Van Teo', '123', '0903123456');

-- Dumping structure for table mydb.grant_access
CREATE TABLE IF NOT EXISTS `grant_access` (
  `is_grant` bit(1) DEFAULT NULL,
  `account_id` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) NOT NULL,
  PRIMARY KEY (`account_id`,`role_id`),
  KEY `FKn8vuhdmux6pxjr90wu37ppej0` (`role_id`),
  CONSTRAINT `FK6d5l1bbvt3fbq9wtn94s22hxq` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `FKn8vuhdmux6pxjr90wu37ppej0` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table mydb.grant_access: ~8 rows (approximately)
INSERT INTO `grant_access` (`is_grant`, `account_id`, `note`, `role_id`) VALUES
	(b'1', 'cam', 'a', 'delete'),
	(b'1', 'cam', 'select table', 'select'),
	(b'1', 'cam', 'rfwada', 'update'),
	(b'1', 'cam', '', 'user'),
	(b'1', 'loi', '', 'user'),
	(b'1', 'met', '', 'user'),
	(b'1', 'son', '', 'admin'),
	(b'1', 'sonPham', '', 'user'),
	(b'1', 'teo', '', 'user');

-- Dumping structure for table mydb.log
CREATE TABLE IF NOT EXISTS `log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loginTime` datetime(6) DEFAULT NULL,
  `logoutTime` datetime(6) DEFAULT NULL,
  `account_id` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK503ama154cr4d3cyc7741l4b7` (`account_id`),
  CONSTRAINT `FK503ama154cr4d3cyc7741l4b7` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table mydb.log: ~11 rows (approximately)
INSERT INTO `log` (`id`, `loginTime`, `logoutTime`, `account_id`, `notes`) VALUES
	(134, '2023-11-02 02:12:15.157249', '2023-11-02 02:12:25.381609', 'son', ''),
	(135, '2023-11-02 02:12:36.758083', '2023-11-02 02:12:38.753645', 'teo', ''),
	(136, '2023-11-02 02:12:57.290374', '2023-11-02 02:13:41.455369', 'son', ''),
	(137, '2023-11-02 02:13:44.076248', '2023-11-02 02:13:45.418840', 'loi', ''),
	(139, '2023-11-02 02:22:52.073998', '2023-11-02 02:23:55.078059', 'son', ''),
	(140, '2023-11-02 02:25:52.389823', '2023-11-02 02:25:53.627945', 'teo', ''),
	(143, '2023-11-02 02:38:27.295867', '2023-11-02 02:38:31.792897', 'teo', ''),
	(144, '2023-11-02 02:38:35.867518', '2023-11-02 02:38:39.788707', 'cam', ''),
	(145, '2023-11-02 02:42:09.958932', '2023-11-02 02:42:13.834647', 'son', ''),
	(146, '2023-11-02 02:42:20.321474', '2023-11-02 02:42:23.800083', 'cam', ''),
	(147, '2023-11-03 00:04:18.170729', '2023-11-03 00:04:33.583841', 'son', '');

-- Dumping structure for table mydb.role
CREATE TABLE IF NOT EXISTS `role` (
  `status` tinyint(4) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) NOT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table mydb.role: ~6 rows (approximately)
INSERT INTO `role` (`status`, `description`, `role_id`, `role_name`) VALUES
	(1, 'admin role', 'admin', 'administrator'),
	(1, 'delete', 'delete', 'delete'),
	(1, 'insert', 'insert', 'insert'),
	(1, 'select', 'select', 'select'),
	(1, 'update', 'update', 'update'),
	(1, 'user role', 'user', 'user');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
