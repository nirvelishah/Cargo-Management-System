-- Adminer 4.8.1 MySQL 5.5.5-10.4.11-MariaDB dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `cargo_items`;
CREATE TABLE `cargo_items` (
  `cargo_id` int(30) NOT NULL,
  `cargo_type_id` int(30) NOT NULL,
  `price` double NOT NULL DEFAULT 0,
  `weight` double NOT NULL DEFAULT 0,
  `total` double NOT NULL DEFAULT 0,
  KEY `cargo_id` (`cargo_id`),
  KEY `cargo_type_list` (`cargo_type_id`),
  CONSTRAINT `cargo_id_FK` FOREIGN KEY (`cargo_id`) REFERENCES `cargo_list` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `cargo_type_id_FK` FOREIGN KEY (`cargo_type_id`) REFERENCES `cargo_type_list` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `cargo_items` (`cargo_id`, `cargo_type_id`, `price`, `weight`, `total`) VALUES
(1,	1,	550,	3,	1650),
(1,	2,	450,	10,	4500),
(1,	3,	800,	5,	4000);

DROP TABLE IF EXISTS `cargo_list`;
CREATE TABLE `cargo_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `ref_code` varchar(100) NOT NULL,
  `shipping_type` int(1) NOT NULL DEFAULT 1 COMMENT '1 = city to city,\r\n2 = state to state,\r\n3 = country to country',
  `total_amount` double NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = pending,\r\n1 = In-Transit,\r\n2 = Arrived at Station,\r\n3 = Out for Delivery,\r\n4 = Delivered',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `cargo_list` (`id`, `ref_code`, `shipping_type`, `total_amount`, `status`, `date_created`, `date_updated`) VALUES
(1,	'20220200001',	3,	10150,	2,	'2024-02-22 13:12:50',	'2024-03-08 11:14:42');

DROP TABLE IF EXISTS `cargo_meta`;
CREATE TABLE `cargo_meta` (
  `cargo_id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text DEFAULT NULL,
  KEY `cargo_id` (`cargo_id`),
  CONSTRAINT `cargo_meta_id_FK` FOREIGN KEY (`cargo_id`) REFERENCES `cargo_list` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `cargo_meta` (`cargo_id`, `meta_field`, `meta_value`) VALUES
(1,	'sender_name',	'Alam Khan'),
(1,	'sender_contact',	'9970444968'),
(1,	'sender_address',	'Sample Address Only'),
(1,	'sender_provided_id_type',	'TIN'),
(1,	'sender_provided_id',	'456789954'),
(1,	'receiver_name',	'mark kiro'),
(1,	'receiver_contact',	'9970444987'),
(1,	'receiver_address',	'This a sample address only'),
(1,	'from_location',	'This is a sample From Location'),
(1,	'to_location',	'This is a sample of Cargo\'s Destination.');

DROP TABLE IF EXISTS `cargo_type_list`;
CREATE TABLE `cargo_type_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `city_price` double NOT NULL DEFAULT 0,
  `state_price` double NOT NULL DEFAULT 0,
  `country_price` double NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinytext NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `cargo_type_list` (`id`, `name`, `description`, `city_price`, `state_price`, `country_price`, `status`, `delete_flag`, `date_created`, `date_updated`) VALUES
(1,	'Electronic Devices',	'Mobile/Smartphones, Tv, Computer/Laptop, etc.',	150,	250,	550,	1,	'0',	'2024-02-22 10:15:41',	NULL),
(2,	'Dry Foods',	'Dry Foods',	100,	200,	450,	1,	'0',	'2024-02-22 10:16:17',	NULL),
(3,	'Fragile',	'Easy to break such as glasses.',	200,	400,	800,	1,	'0',	'2024-02-22 10:18:55',	NULL),
(4,	'test',	'test',	1,	2,	3,	0,	'1',	'2024-02-22 10:19:07',	'2024-02-22 10:19:11');

DROP TABLE IF EXISTS `system_info`;
CREATE TABLE `system_info` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1,	'name',	'Cargo Management System'),
(6,	'short_name',	'CMS'),
(11,	'logo',	'uploads/logo-1709874210.png?v=1709874210'),
(13,	'user_avatar',	'uploads/user_avatar.jpg'),
(14,	'cover',	'uploads/cover-1709873986.jpg?v=1709873987');

DROP TABLE IF EXISTS `tracking_list`;
CREATE TABLE `tracking_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `cargo_id` int(30) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `cargo_id` (`cargo_id`),
  CONSTRAINT `cargo_id_FK2` FOREIGN KEY (`cargo_id`) REFERENCES `cargo_list` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `tracking_list` (`id`, `cargo_id`, `title`, `description`, `date_added`) VALUES
(1,	1,	'Pending',	' Shipment created.',	'2024-02-22 14:39:09'),
(2,	1,	'In-Transit',	'Cargo has been departed.',	'2024-02-22 14:42:18'),
(3,	1,	'Arrive at Station',	'Cargo has arrived at the station',	'2024-02-22 14:54:43');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1,	'Adminstrator',	'Admin',	'admin',	'0192023a7bbd73250516f069df18b500',	'uploads/avatars/1.png?v=1645064505',	NULL,	1,	'2024-01-20 14:02:37',	'2024-02-17 10:21:45'),
(5,	'Alam',	'khan',	'alam',	'1254737c076cf867dc53d60a0364f38e',	'uploads/avatars/5.png?v=1645514943',	NULL,	2,	'2024-02-22 15:29:03',	'2024-02-22 15:34:01');

-- 2024-03-09 07:01:10
