SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `building`
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq1_building` (`class_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of building
-- ----------------------------

-- ----------------------------
-- Table structure for `cust_loadout`
-- ----------------------------
DROP TABLE IF EXISTS `cust_loadout`;
CREATE TABLE `cust_loadout` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventory` varchar(2048) NOT NULL,
  `backpack` varchar(2048) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cust_loadout
-- ----------------------------

-- ----------------------------
-- Table structure for `cust_loadout_profile`
-- ----------------------------
DROP TABLE IF EXISTS `cust_loadout_profile`;
CREATE TABLE `cust_loadout_profile` (
  `cust_loadout_id` bigint(20) unsigned NOT NULL,
  `unique_id` varchar(128) NOT NULL,
  PRIMARY KEY (`cust_loadout_id`,`unique_id`),
  KEY `fk2_cust_loadout_profile` (`unique_id`),
  CONSTRAINT `cust_loadout_profile_ibfk_1` FOREIGN KEY (`cust_loadout_id`) REFERENCES `cust_loadout` (`id`),
  CONSTRAINT `cust_loadout_profile_ibfk_2` FOREIGN KEY (`unique_id`) REFERENCES `profile` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cust_loadout_profile
-- ----------------------------

-- ----------------------------
-- Table structure for `deployable`
-- ----------------------------
DROP TABLE IF EXISTS `deployable`;
CREATE TABLE `deployable` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq1_deployable` (`class_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of deployable
-- ----------------------------
INSERT INTO `deployable` VALUES ('4', 'Hedgehog_DZ');
INSERT INTO `deployable` VALUES ('5', 'Sandbag1_DZ');
INSERT INTO `deployable` VALUES ('1', 'TentStorage');
INSERT INTO `deployable` VALUES ('2', 'TrapBear');
INSERT INTO `deployable` VALUES ('3', 'Wire_cat1');

-- ----------------------------
-- Table structure for `instance`
-- ----------------------------
DROP TABLE IF EXISTS `instance`;
CREATE TABLE `instance` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `world_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `backpack` varchar(2048) NOT NULL DEFAULT '["DZ_Patrol_Pack_EP1",[[],[]],[[],[]]]',
  PRIMARY KEY (`id`),
  KEY `fk1_instance` (`world_id`),
  CONSTRAINT `instance_ibfk_1` FOREIGN KEY (`world_id`) REFERENCES `world` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance
-- ----------------------------
INSERT INTO `instance` VALUES ('1', '9', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');

-- ----------------------------
-- Table structure for `instance_building`
-- ----------------------------
DROP TABLE IF EXISTS `instance_building`;
CREATE TABLE `instance_building` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `building_id` smallint(5) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[0,[0,0,0]]',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx1_instance_building` (`building_id`),
  KEY `idx3_instance_building` (`instance_id`),
  CONSTRAINT `instance_building_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`),
  CONSTRAINT `instance_building_ibfk_2` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance_building
-- ----------------------------

-- ----------------------------
-- Table structure for `instance_deployable`
-- ----------------------------
DROP TABLE IF EXISTS `instance_deployable`;
CREATE TABLE `instance_deployable` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(60) NOT NULL,
  `deployable_id` smallint(5) unsigned NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[0,[0,0,0]]',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Hitpoints` varchar(500) NOT NULL DEFAULT '[]',
  `Fuel` double(13,0) NOT NULL DEFAULT '0',
  `Damage` double(13,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx1_instance_deployable` (`deployable_id`),
  KEY `idx2_instance_deployable` (`owner_id`),
  KEY `idx3_instance_deployable` (`instance_id`),
  CONSTRAINT `instance_deployable_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`),
  CONSTRAINT `instance_deployable_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `survivor` (`id`),
  CONSTRAINT `instance_deployable_ibfk_3` FOREIGN KEY (`deployable_id`) REFERENCES `deployable` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance_deployable
-- ----------------------------

-- ----------------------------
-- Table structure for `instance_vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `instance_vehicle`;
CREATE TABLE `instance_vehicle` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `world_vehicle_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[0,[0,0,0]]',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `parts` varchar(1024) NOT NULL DEFAULT '[]',
  `fuel` double NOT NULL DEFAULT '0',
  `damage` double NOT NULL DEFAULT '0',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx3_instance_vehicle` (`instance_id`),
  KEY `fk3_instance_vehicle` (`world_vehicle_id`),
  CONSTRAINT `fk3_instance_vehicle` FOREIGN KEY (`world_vehicle_id`) REFERENCES `world_vehicle` (`id`),
  CONSTRAINT `instance_vehicle_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance_vehicle
-- ----------------------------

-- ----------------------------
-- Table structure for `log_code`
-- ----------------------------
DROP TABLE IF EXISTS `log_code`;
CREATE TABLE `log_code` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_log_code` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_code
-- ----------------------------
INSERT INTO `log_code` VALUES ('1', 'Login', 'Player has logged in');
INSERT INTO `log_code` VALUES ('2', 'Logout', 'Player has logged out');
INSERT INTO `log_code` VALUES ('3', 'Ban', 'Player was banned');
INSERT INTO `log_code` VALUES ('4', 'Connect', 'Player has connected');
INSERT INTO `log_code` VALUES ('5', 'Disconnect', 'Player has disconnected');

-- ----------------------------
-- Table structure for `log_entry`
-- ----------------------------
DROP TABLE IF EXISTS `log_entry`;
CREATE TABLE `log_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(128) NOT NULL DEFAULT '',
  `log_code_id` int(11) unsigned NOT NULL,
  `text` varchar(1024) DEFAULT '',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `instance_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk1_log_entry` (`log_code_id`),
  CONSTRAINT `fk1_log_entry` FOREIGN KEY (`log_code_id`) REFERENCES `log_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_entry
-- ----------------------------
INSERT INTO `log_entry` VALUES ('1', '37830662', '1', '', '2013-06-19 17:23:28', '1');
INSERT INTO `log_entry` VALUES ('2', '37830662', '1', '', '2013-06-19 20:17:44', '1');
INSERT INTO `log_entry` VALUES ('3', '37830662', '1', '', '2013-06-19 20:26:32', '1');
INSERT INTO `log_entry` VALUES ('4', '37830662', '1', '', '2013-06-20 15:45:16', '1');
INSERT INTO `log_entry` VALUES ('5', '37830662', '1', '', '2013-06-20 17:12:20', '1');
INSERT INTO `log_entry` VALUES ('6', '37830662', '1', '', '2013-06-24 16:18:23', '1');
INSERT INTO `log_entry` VALUES ('7', '37830662', '1', '', '2013-06-26 19:29:40', '1');
INSERT INTO `log_entry` VALUES ('8', '37830662', '1', '', '2013-06-26 19:43:33', '1');
INSERT INTO `log_entry` VALUES ('9', '37830662', '1', '', '2013-06-26 20:05:13', '1');
INSERT INTO `log_entry` VALUES ('10', '37830662', '1', '', '2013-06-26 20:16:01', '1');
INSERT INTO `log_entry` VALUES ('11', '37830662', '1', '', '2013-06-26 20:49:52', '1');
INSERT INTO `log_entry` VALUES ('12', '37830662', '1', '', '2013-06-26 20:50:38', '1');
INSERT INTO `log_entry` VALUES ('13', '37830662', '1', '', '2013-06-26 21:03:05', '1');
INSERT INTO `log_entry` VALUES ('14', '37830662', '1', '', '2013-06-26 21:52:56', '1');
INSERT INTO `log_entry` VALUES ('15', '37830662', '1', '', '2013-06-26 22:22:46', '1');
INSERT INTO `log_entry` VALUES ('16', '37830662', '1', '', '2013-06-26 22:26:03', '1');
INSERT INTO `log_entry` VALUES ('17', '37830662', '1', '', '2013-06-26 22:50:35', '1');
INSERT INTO `log_entry` VALUES ('18', '37830662', '1', '', '2013-06-26 22:51:47', '1');
INSERT INTO `log_entry` VALUES ('19', '37830662', '1', '', '2013-06-26 23:03:28', '1');
INSERT INTO `log_entry` VALUES ('20', '37830662', '1', '', '2013-06-26 23:11:45', '1');
INSERT INTO `log_entry` VALUES ('21', '37830662', '1', '', '2013-06-26 23:13:16', '1');
INSERT INTO `log_entry` VALUES ('22', '37830662', '1', '', '2013-06-26 23:22:23', '1');
INSERT INTO `log_entry` VALUES ('23', '37830662', '1', '', '2013-06-26 23:48:11', '1');
INSERT INTO `log_entry` VALUES ('24', '37830662', '1', '', '2013-06-26 23:50:30', '1');
INSERT INTO `log_entry` VALUES ('25', '37830662', '1', '', '2013-06-26 23:54:13', '1');
INSERT INTO `log_entry` VALUES ('26', '37830662', '1', '', '2013-06-27 00:01:54', '1');
INSERT INTO `log_entry` VALUES ('27', '37830662', '1', '', '2013-06-27 00:11:51', '1');
INSERT INTO `log_entry` VALUES ('28', '37830662', '1', '', '2013-06-27 00:22:22', '1');
INSERT INTO `log_entry` VALUES ('29', '37830662', '1', '', '2013-06-27 00:35:16', '1');
INSERT INTO `log_entry` VALUES ('30', '37830662', '1', '', '2013-06-27 00:52:53', '1');
INSERT INTO `log_entry` VALUES ('31', '37830662', '1', '', '2013-06-27 01:12:14', '1');
INSERT INTO `log_entry` VALUES ('32', '37830662', '1', '', '2013-06-27 01:16:05', '1');
INSERT INTO `log_entry` VALUES ('33', '37830662', '1', '', '2013-06-27 16:50:47', '1');
INSERT INTO `log_entry` VALUES ('34', '37830662', '1', '', '2013-06-27 17:17:55', '1');
INSERT INTO `log_entry` VALUES ('35', '37830662', '1', '', '2013-06-27 17:48:23', '1');
INSERT INTO `log_entry` VALUES ('36', '37830662', '1', '', '2013-06-27 20:39:09', '1');
INSERT INTO `log_entry` VALUES ('37', '37830662', '1', '', '2013-06-27 21:06:51', '1');
INSERT INTO `log_entry` VALUES ('38', '37830662', '1', '', '2013-06-28 02:35:57', '1');
INSERT INTO `log_entry` VALUES ('39', '37830662', '1', '', '2013-06-28 02:42:21', '1');
INSERT INTO `log_entry` VALUES ('40', '37830662', '1', '', '2013-06-28 02:52:03', '1');
INSERT INTO `log_entry` VALUES ('41', '37830662', '1', '', '2013-06-28 03:05:44', '1');
INSERT INTO `log_entry` VALUES ('42', '37830662', '1', '', '2013-06-28 03:33:39', '1');
INSERT INTO `log_entry` VALUES ('43', '37830662', '1', '', '2013-06-28 03:53:04', '1');
INSERT INTO `log_entry` VALUES ('44', '37830662', '1', '', '2013-06-28 17:58:30', '1');
INSERT INTO `log_entry` VALUES ('45', '37830662', '1', '', '2013-06-28 19:01:22', '1');
INSERT INTO `log_entry` VALUES ('46', '37830662', '1', '', '2013-06-28 19:03:02', '1');
INSERT INTO `log_entry` VALUES ('47', '37830662', '1', '', '2013-06-28 19:34:05', '1');
INSERT INTO `log_entry` VALUES ('48', '37830662', '1', '', '2013-06-28 19:58:10', '1');
INSERT INTO `log_entry` VALUES ('49', '37830662', '1', '', '2013-06-29 04:41:13', '1');
INSERT INTO `log_entry` VALUES ('50', '37830662', '1', '', '2013-06-29 04:44:42', '1');
INSERT INTO `log_entry` VALUES ('51', '37830662', '1', '', '2013-06-29 22:59:36', '1');
INSERT INTO `log_entry` VALUES ('52', '37830662', '1', '', '2013-06-29 23:23:46', '1');
INSERT INTO `log_entry` VALUES ('53', '37830662', '1', '', '2013-06-30 00:06:37', '1');
INSERT INTO `log_entry` VALUES ('54', '37830662', '1', '', '2013-06-30 03:46:07', '1');
INSERT INTO `log_entry` VALUES ('55', '37830662', '1', '', '2013-06-30 03:48:09', '1');
INSERT INTO `log_entry` VALUES ('56', '37830662', '1', '', '2013-06-30 06:28:21', '1');
INSERT INTO `log_entry` VALUES ('57', '37830662', '1', '', '2013-06-30 06:29:00', '1');
INSERT INTO `log_entry` VALUES ('58', '37830662', '1', '', '2013-06-30 16:48:00', '1');
INSERT INTO `log_entry` VALUES ('59', '37830662', '1', '', '2013-06-30 16:49:39', '1');
INSERT INTO `log_entry` VALUES ('60', '37830662', '1', '', '2013-06-30 17:02:18', '1');
INSERT INTO `log_entry` VALUES ('61', '37830662', '1', '', '2013-06-30 17:04:10', '1');
INSERT INTO `log_entry` VALUES ('62', '37830662', '1', '', '2013-06-30 17:15:31', '1');
INSERT INTO `log_entry` VALUES ('63', '37830662', '1', '', '2013-06-30 17:21:26', '1');
INSERT INTO `log_entry` VALUES ('64', '37830662', '1', '', '2013-06-30 17:31:56', '1');
INSERT INTO `log_entry` VALUES ('65', '37830662', '1', '', '2013-06-30 18:00:21', '1');
INSERT INTO `log_entry` VALUES ('66', '37830662', '1', '', '2013-06-30 18:13:21', '1');
INSERT INTO `log_entry` VALUES ('67', '37830662', '1', '', '2013-06-30 18:27:02', '1');
INSERT INTO `log_entry` VALUES ('68', '37830662', '1', '', '2013-07-01 00:25:14', '1');
INSERT INTO `log_entry` VALUES ('69', '37830662', '1', '', '2013-07-01 00:27:38', '1');
INSERT INTO `log_entry` VALUES ('70', '37830662', '1', '', '2013-07-01 00:51:56', '1');
INSERT INTO `log_entry` VALUES ('71', '37830662', '1', '', '2013-07-01 12:29:50', '1');
INSERT INTO `log_entry` VALUES ('72', '37830662', '1', '', '2013-07-01 12:33:00', '1');
INSERT INTO `log_entry` VALUES ('73', '37830662', '1', '', '2013-07-01 13:16:55', '1');
INSERT INTO `log_entry` VALUES ('74', '37830662', '1', '', '2013-07-01 13:50:38', '1');
INSERT INTO `log_entry` VALUES ('75', '37830662', '1', '', '2013-07-01 14:24:54', '1');
INSERT INTO `log_entry` VALUES ('76', '37830662', '1', '', '2013-07-01 15:35:56', '1');
INSERT INTO `log_entry` VALUES ('77', '37830662', '1', '', '2013-07-01 18:10:17', '1');
INSERT INTO `log_entry` VALUES ('78', '37830662', '1', '', '2013-07-01 19:34:24', '1');
INSERT INTO `log_entry` VALUES ('79', '37830662', '1', '', '2013-07-01 19:55:30', '1');
INSERT INTO `log_entry` VALUES ('80', '37830662', '1', '', '2013-07-01 20:11:51', '1');
INSERT INTO `log_entry` VALUES ('81', '37830662', '1', '', '2013-07-01 20:33:48', '1');
INSERT INTO `log_entry` VALUES ('82', '37830662', '1', '', '2013-07-01 20:59:58', '1');
INSERT INTO `log_entry` VALUES ('83', '37830662', '1', '', '2013-07-01 21:10:04', '1');
INSERT INTO `log_entry` VALUES ('84', '37830662', '1', '', '2013-07-01 21:19:11', '1');
INSERT INTO `log_entry` VALUES ('85', '37830662', '1', '', '2013-07-01 21:43:21', '1');
INSERT INTO `log_entry` VALUES ('86', '37830662', '1', '', '2013-07-01 22:06:01', '1');
INSERT INTO `log_entry` VALUES ('87', '37830662', '1', '', '2013-07-02 00:37:30', '1');
INSERT INTO `log_entry` VALUES ('88', '37830662', '1', '', '2013-07-02 00:40:58', '1');
INSERT INTO `log_entry` VALUES ('89', '37830662', '1', '', '2013-07-02 01:42:32', '1');
INSERT INTO `log_entry` VALUES ('90', '37830662', '1', '', '2013-07-02 17:41:36', '1');
INSERT INTO `log_entry` VALUES ('91', '37830662', '1', '', '2013-07-02 17:58:29', '1');
INSERT INTO `log_entry` VALUES ('92', '37830662', '1', '', '2013-07-02 18:21:27', '1');
INSERT INTO `log_entry` VALUES ('93', '37830662', '1', '', '2013-07-02 22:29:40', '1');
INSERT INTO `log_entry` VALUES ('94', '37830662', '1', '', '2013-07-02 22:53:29', '1');
INSERT INTO `log_entry` VALUES ('95', '37830662', '1', '', '2013-07-02 23:32:29', '1');
INSERT INTO `log_entry` VALUES ('96', '37830662', '1', '', '2013-07-03 00:03:24', '1');
INSERT INTO `log_entry` VALUES ('97', '37830662', '1', '', '2013-07-03 03:19:51', '1');
INSERT INTO `log_entry` VALUES ('98', '37830662', '1', '', '2013-07-03 04:47:04', '1');
INSERT INTO `log_entry` VALUES ('99', '37830662', '1', '', '2013-07-03 05:13:41', '1');
INSERT INTO `log_entry` VALUES ('100', '37830662', '1', '', '2013-07-03 05:25:31', '1');
INSERT INTO `log_entry` VALUES ('101', '37830662', '1', '', '2013-07-03 07:40:55', '1');
INSERT INTO `log_entry` VALUES ('102', '37830662', '1', '', '2013-07-03 07:58:51', '1');
INSERT INTO `log_entry` VALUES ('103', '37830662', '1', '', '2013-07-03 08:26:04', '1');
INSERT INTO `log_entry` VALUES ('104', '37830662', '1', '', '2013-07-03 08:38:33', '1');
INSERT INTO `log_entry` VALUES ('105', '37830662', '1', '', '2013-07-03 08:48:59', '1');
INSERT INTO `log_entry` VALUES ('106', '37830662', '1', '', '2013-07-03 10:16:08', '1');
INSERT INTO `log_entry` VALUES ('107', '37830662', '1', '', '2013-07-04 20:51:13', '1');
INSERT INTO `log_entry` VALUES ('108', '37830662', '1', '', '2013-07-04 20:58:30', '1');
INSERT INTO `log_entry` VALUES ('109', '37830662', '1', '', '2013-07-04 21:23:33', '1');
INSERT INTO `log_entry` VALUES ('110', '37830662', '1', '', '2013-07-04 21:54:46', '1');
INSERT INTO `log_entry` VALUES ('111', '37830662', '1', '', '2013-07-04 22:10:30', '1');
INSERT INTO `log_entry` VALUES ('112', '37830662', '1', '', '2013-07-04 22:17:36', '1');
INSERT INTO `log_entry` VALUES ('113', '37830662', '1', '', '2013-07-04 23:11:54', '1');
INSERT INTO `log_entry` VALUES ('114', '37830662', '1', '', '2013-07-04 23:26:52', '1');
INSERT INTO `log_entry` VALUES ('115', '37830662', '1', '', '2013-07-04 23:40:17', '1');
INSERT INTO `log_entry` VALUES ('116', '37830662', '1', '', '2013-07-04 23:44:49', '1');
INSERT INTO `log_entry` VALUES ('117', '37830662', '1', '', '2013-07-04 23:46:25', '1');
INSERT INTO `log_entry` VALUES ('118', '37830662', '1', '', '2013-07-04 23:48:26', '1');
INSERT INTO `log_entry` VALUES ('119', '37830662', '1', '', '2013-07-05 00:08:24', '1');
INSERT INTO `log_entry` VALUES ('120', '37830662', '1', '', '2013-07-05 00:16:58', '1');
INSERT INTO `log_entry` VALUES ('121', '37830662', '1', '', '2013-07-05 00:26:46', '1');
INSERT INTO `log_entry` VALUES ('122', '37830662', '1', '', '2013-07-05 14:11:04', '1');
INSERT INTO `log_entry` VALUES ('123', '37830662', '1', '', '2013-07-05 14:13:09', '1');
INSERT INTO `log_entry` VALUES ('124', '37830662', '1', '', '2013-07-05 14:30:20', '1');
INSERT INTO `log_entry` VALUES ('125', '37830662', '1', '', '2013-07-05 14:52:34', '1');
INSERT INTO `log_entry` VALUES ('126', '37830662', '1', '', '2013-07-05 15:08:16', '1');
INSERT INTO `log_entry` VALUES ('127', '37830662', '1', '', '2013-07-05 15:18:34', '1');
INSERT INTO `log_entry` VALUES ('128', '37830662', '1', '', '2013-07-05 16:19:34', '1');
INSERT INTO `log_entry` VALUES ('129', '37830662', '1', '', '2013-07-05 16:45:47', '1');
INSERT INTO `log_entry` VALUES ('130', '37830662', '1', '', '2013-07-05 16:47:07', '1');
INSERT INTO `log_entry` VALUES ('131', '37830662', '1', '', '2013-07-05 17:00:51', '1');
INSERT INTO `log_entry` VALUES ('132', '37830662', '1', '', '2013-07-05 17:01:52', '1');
INSERT INTO `log_entry` VALUES ('133', '37830662', '1', '', '2013-07-05 17:21:44', '1');
INSERT INTO `log_entry` VALUES ('134', '37830662', '1', '', '2013-07-05 17:23:35', '1');
INSERT INTO `log_entry` VALUES ('135', '37830662', '1', '', '2013-07-05 18:56:49', '1');
INSERT INTO `log_entry` VALUES ('136', '37830662', '1', '', '2013-07-05 19:13:33', '1');
INSERT INTO `log_entry` VALUES ('137', '37830662', '1', '', '2013-07-05 19:23:06', '1');
INSERT INTO `log_entry` VALUES ('138', '37830662', '1', '', '2013-07-05 19:23:47', '1');
INSERT INTO `log_entry` VALUES ('139', '37830662', '1', '', '2013-07-05 19:36:43', '1');
INSERT INTO `log_entry` VALUES ('140', '37830662', '1', '', '2013-07-05 19:37:31', '1');
INSERT INTO `log_entry` VALUES ('141', '37830662', '1', '', '2013-07-05 19:49:05', '1');
INSERT INTO `log_entry` VALUES ('142', '37830662', '1', '', '2013-07-05 19:50:17', '1');
INSERT INTO `log_entry` VALUES ('143', '37830662', '1', '', '2013-07-05 20:09:11', '1');
INSERT INTO `log_entry` VALUES ('144', '37830662', '1', '', '2013-07-05 20:10:03', '1');
INSERT INTO `log_entry` VALUES ('145', '37830662', '1', '', '2013-07-05 20:19:22', '1');
INSERT INTO `log_entry` VALUES ('146', '37830662', '1', '', '2013-07-05 20:29:10', '1');
INSERT INTO `log_entry` VALUES ('147', '37830662', '1', '', '2013-07-05 20:39:10', '1');
INSERT INTO `log_entry` VALUES ('148', '37830662', '1', '', '2013-07-05 20:40:14', '1');
INSERT INTO `log_entry` VALUES ('149', '37830662', '1', '', '2013-07-05 20:54:41', '1');
INSERT INTO `log_entry` VALUES ('150', '37830662', '1', '', '2013-07-05 21:44:25', '1');
INSERT INTO `log_entry` VALUES ('151', '37830662', '1', '', '2013-07-05 21:58:47', '1');
INSERT INTO `log_entry` VALUES ('152', '37830662', '1', '', '2013-07-05 22:01:03', '1');
INSERT INTO `log_entry` VALUES ('153', '37830662', '1', '', '2013-07-05 22:57:00', '1');
INSERT INTO `log_entry` VALUES ('154', '37830662', '1', '', '2013-07-05 23:13:13', '1');
INSERT INTO `log_entry` VALUES ('155', '37830662', '1', '', '2013-07-05 23:14:05', '1');
INSERT INTO `log_entry` VALUES ('156', '37830662', '1', '', '2013-07-05 23:40:42', '1');
INSERT INTO `log_entry` VALUES ('157', '37830662', '1', '', '2013-07-05 23:41:58', '1');
INSERT INTO `log_entry` VALUES ('158', '37830662', '1', '', '2013-07-06 00:17:21', '1');
INSERT INTO `log_entry` VALUES ('159', '37830662', '1', '', '2013-07-06 00:50:47', '1');
INSERT INTO `log_entry` VALUES ('160', '37830662', '1', '', '2013-07-06 00:51:42', '1');
INSERT INTO `log_entry` VALUES ('161', '37830662', '1', '', '2013-07-06 01:37:43', '1');
INSERT INTO `log_entry` VALUES ('162', '37830662', '1', '', '2013-07-06 01:38:25', '1');
INSERT INTO `log_entry` VALUES ('163', '37830662', '1', '', '2013-07-06 01:49:45', '1');
INSERT INTO `log_entry` VALUES ('164', '37830662', '1', '', '2013-07-06 01:58:05', '1');
INSERT INTO `log_entry` VALUES ('165', '37830662', '1', '', '2013-07-06 02:12:34', '1');
INSERT INTO `log_entry` VALUES ('166', '37830662', '1', '', '2013-07-06 02:41:37', '1');
INSERT INTO `log_entry` VALUES ('167', '37830662', '1', '', '2013-07-06 03:14:04', '1');
INSERT INTO `log_entry` VALUES ('168', '37830662', '1', '', '2013-07-08 18:51:54', '1');
INSERT INTO `log_entry` VALUES ('169', '37830662', '1', '', '2013-07-08 18:55:47', '1');
INSERT INTO `log_entry` VALUES ('170', '37830662', '1', '', '2013-07-08 19:07:09', '1');
INSERT INTO `log_entry` VALUES ('171', '37830662', '1', '', '2013-07-08 19:12:34', '1');
INSERT INTO `log_entry` VALUES ('172', '37830662', '1', '', '2013-07-08 19:55:58', '1');
INSERT INTO `log_entry` VALUES ('173', '37830662', '1', '', '2013-07-08 20:20:26', '1');
INSERT INTO `log_entry` VALUES ('174', '37830662', '1', '', '2013-07-08 20:32:16', '1');
INSERT INTO `log_entry` VALUES ('175', '37830662', '1', '', '2013-07-08 20:55:15', '1');
INSERT INTO `log_entry` VALUES ('176', '37830662', '1', '', '2013-07-08 22:42:46', '1');
INSERT INTO `log_entry` VALUES ('177', '37830662', '1', '', '2013-07-10 17:19:40', '1');
INSERT INTO `log_entry` VALUES ('178', '37830662', '1', '', '2013-07-10 17:46:27', '1');
INSERT INTO `log_entry` VALUES ('179', '37830662', '1', '', '2013-07-10 17:47:22', '1');
INSERT INTO `log_entry` VALUES ('180', '37830662', '1', '', '2013-07-10 17:57:40', '1');
INSERT INTO `log_entry` VALUES ('181', '37830662', '1', '', '2013-07-10 17:58:35', '1');
INSERT INTO `log_entry` VALUES ('182', '37830662', '1', '', '2013-07-10 18:09:37', '1');
INSERT INTO `log_entry` VALUES ('183', '37830662', '1', '', '2013-07-11 18:03:00', '1');
INSERT INTO `log_entry` VALUES ('184', '37830662', '1', '', '2013-07-11 18:21:57', '1');
INSERT INTO `log_entry` VALUES ('185', '37830662', '1', '', '2013-07-11 18:26:48', '1');
INSERT INTO `log_entry` VALUES ('186', '37830662', '1', '', '2013-07-11 18:30:05', '1');
INSERT INTO `log_entry` VALUES ('187', '37830662', '1', '', '2013-07-11 20:19:26', '1');
INSERT INTO `log_entry` VALUES ('188', '37830662', '1', '', '2013-07-11 22:19:42', '1');
INSERT INTO `log_entry` VALUES ('189', '37830662', '1', '', '2013-07-11 22:29:46', '1');
INSERT INTO `log_entry` VALUES ('190', '37830662', '1', '', '2013-07-11 23:00:44', '1');
INSERT INTO `log_entry` VALUES ('191', '37830662', '1', '', '2013-07-11 23:11:06', '1');
INSERT INTO `log_entry` VALUES ('192', '37830662', '1', '', '2013-07-11 23:25:34', '1');
INSERT INTO `log_entry` VALUES ('193', '37830662', '1', '', '2013-07-11 23:40:08', '1');
INSERT INTO `log_entry` VALUES ('194', '37830662', '1', '', '2013-07-12 00:20:50', '1');
INSERT INTO `log_entry` VALUES ('195', '37830662', '1', '', '2013-07-12 15:51:20', '1');
INSERT INTO `log_entry` VALUES ('196', '37830662', '1', '', '2013-07-12 16:06:24', '1');
INSERT INTO `log_entry` VALUES ('197', '37830662', '1', '', '2013-07-12 16:20:29', '1');
INSERT INTO `log_entry` VALUES ('198', '37830662', '1', '', '2013-07-12 16:35:29', '1');
INSERT INTO `log_entry` VALUES ('199', '37830662', '1', '', '2013-07-12 16:51:00', '1');
INSERT INTO `log_entry` VALUES ('200', '37830662', '1', '', '2013-07-12 17:02:40', '1');
INSERT INTO `log_entry` VALUES ('201', '37830662', '1', '', '2013-07-13 00:19:40', '1');
INSERT INTO `log_entry` VALUES ('202', '37830662', '1', '', '2013-07-13 00:32:07', '1');
INSERT INTO `log_entry` VALUES ('203', '37830662', '1', '', '2013-07-13 00:33:00', '1');
INSERT INTO `log_entry` VALUES ('204', '37830662', '1', '', '2013-07-17 13:45:36', '1');
INSERT INTO `log_entry` VALUES ('205', '37830662', '1', '', '2013-07-17 13:46:10', '1');
INSERT INTO `log_entry` VALUES ('206', '37830662', '1', '', '2013-07-17 13:49:49', '1');
INSERT INTO `log_entry` VALUES ('207', '37830662', '1', '', '2013-07-17 13:59:42', '1');
INSERT INTO `log_entry` VALUES ('208', '37830662', '1', '', '2013-07-17 14:33:09', '1');
INSERT INTO `log_entry` VALUES ('209', '37830662', '1', '', '2013-07-17 14:50:27', '1');
INSERT INTO `log_entry` VALUES ('210', '37830662', '1', '', '2013-07-26 13:28:53', '1');
INSERT INTO `log_entry` VALUES ('211', '37830662', '1', '', '2013-07-26 13:29:41', '1');
INSERT INTO `log_entry` VALUES ('212', '37830662', '1', '', '2013-07-26 13:35:10', '1');
INSERT INTO `log_entry` VALUES ('213', '37830662', '1', '', '2013-07-26 13:57:08', '1');
INSERT INTO `log_entry` VALUES ('214', '37830662', '1', '', '2013-07-26 14:08:22', '1');
INSERT INTO `log_entry` VALUES ('215', '37830662', '1', '', '2013-07-26 14:46:28', '1');
INSERT INTO `log_entry` VALUES ('216', '37830662', '1', '', '2013-07-26 15:04:14', '1');
INSERT INTO `log_entry` VALUES ('217', '37830662', '1', '', '2013-07-26 16:04:30', '1');
INSERT INTO `log_entry` VALUES ('218', '37830662', '1', '', '2013-07-26 16:08:06', '1');
INSERT INTO `log_entry` VALUES ('219', '37830662', '1', '', '2013-07-26 16:09:28', '1');
INSERT INTO `log_entry` VALUES ('220', '37830662', '1', '', '2013-07-26 16:28:10', '1');
INSERT INTO `log_entry` VALUES ('221', '37830662', '1', '', '2013-07-26 16:51:03', '1');
INSERT INTO `log_entry` VALUES ('222', '37830662', '1', '', '2013-07-26 17:22:22', '1');
INSERT INTO `log_entry` VALUES ('223', '37830662', '1', '', '2013-07-26 17:23:55', '1');
INSERT INTO `log_entry` VALUES ('224', '37830662', '1', '', '2013-07-26 17:51:30', '1');
INSERT INTO `log_entry` VALUES ('225', '37830662', '1', '', '2013-07-26 18:06:11', '1');
INSERT INTO `log_entry` VALUES ('226', '37830662', '1', '', '2013-07-26 18:07:07', '1');
INSERT INTO `log_entry` VALUES ('227', '37830662', '1', '', '2013-07-26 18:10:15', '1');
INSERT INTO `log_entry` VALUES ('228', '37830662', '1', '', '2013-07-26 18:12:17', '1');
INSERT INTO `log_entry` VALUES ('229', '37830662', '1', '', '2013-07-26 18:27:18', '1');
INSERT INTO `log_entry` VALUES ('230', '37830662', '1', '', '2013-07-26 23:10:27', '1');
INSERT INTO `log_entry` VALUES ('231', '37830662', '1', '', '2013-07-26 23:11:09', '1');
INSERT INTO `log_entry` VALUES ('232', '37830662', '1', '', '2013-07-26 23:12:22', '1');
INSERT INTO `log_entry` VALUES ('233', '37830662', '1', '', '2013-07-26 23:13:36', '1');
INSERT INTO `log_entry` VALUES ('234', '37830662', '1', '', '2013-07-26 23:44:46', '1');
INSERT INTO `log_entry` VALUES ('235', '37830662', '1', '', '2013-07-27 00:07:05', '1');
INSERT INTO `log_entry` VALUES ('236', '37830662', '1', '', '2013-07-27 00:47:08', '1');
INSERT INTO `log_entry` VALUES ('237', '37830662', '1', '', '2013-07-29 17:35:38', '1');
INSERT INTO `log_entry` VALUES ('238', '37830662', '1', '', '2013-07-29 17:48:29', '1');
INSERT INTO `log_entry` VALUES ('239', '37830662', '1', '', '2013-07-29 18:09:18', '1');
INSERT INTO `log_entry` VALUES ('240', '37830662', '1', '', '2013-07-29 18:55:10', '1');
INSERT INTO `log_entry` VALUES ('241', '37830662', '1', '', '2013-07-29 18:56:21', '1');
INSERT INTO `log_entry` VALUES ('242', '37830662', '1', '', '2013-07-29 20:54:46', '1');
INSERT INTO `log_entry` VALUES ('243', '37830662', '1', '', '2013-07-29 21:03:35', '1');
INSERT INTO `log_entry` VALUES ('244', '37830662', '1', '', '2013-07-29 21:24:32', '1');
INSERT INTO `log_entry` VALUES ('245', '37830662', '1', '', '2013-07-29 22:43:50', '1');
INSERT INTO `log_entry` VALUES ('246', '37830662', '1', '', '2013-07-29 22:55:05', '1');
INSERT INTO `log_entry` VALUES ('247', '37830662', '1', '', '2013-07-29 23:30:45', '1');
INSERT INTO `log_entry` VALUES ('248', '37830662', '1', '', '2013-07-29 23:31:40', '1');
INSERT INTO `log_entry` VALUES ('249', '37830662', '1', '', '2013-08-04 19:10:51', '1');
INSERT INTO `log_entry` VALUES ('250', '79259206', '1', '', '2013-08-04 19:13:36', '1');
INSERT INTO `log_entry` VALUES ('251', '79259206', '1', '', '2013-08-04 19:31:07', '1');
INSERT INTO `log_entry` VALUES ('252', '37830662', '1', '', '2013-08-04 19:32:11', '1');
INSERT INTO `log_entry` VALUES ('253', '79259206', '1', '', '2013-08-04 20:43:38', '1');
INSERT INTO `log_entry` VALUES ('254', '37830662', '1', '', '2013-08-04 20:43:40', '1');
INSERT INTO `log_entry` VALUES ('255', '37830662', '1', '', '2013-08-04 20:44:33', '1');
INSERT INTO `log_entry` VALUES ('256', '79259206', '1', '', '2013-08-04 20:45:26', '1');
INSERT INTO `log_entry` VALUES ('257', '79259206', '1', '', '2013-08-04 21:00:05', '1');
INSERT INTO `log_entry` VALUES ('258', '37830662', '1', '', '2013-08-04 21:00:43', '1');
INSERT INTO `log_entry` VALUES ('259', '37830662', '1', '', '2013-08-04 21:01:34', '1');
INSERT INTO `log_entry` VALUES ('260', '37830662', '1', '', '2013-08-04 21:18:31', '1');
INSERT INTO `log_entry` VALUES ('261', '79259206', '1', '', '2013-08-04 21:18:43', '1');
INSERT INTO `log_entry` VALUES ('262', '79259206', '1', '', '2013-08-04 21:28:39', '1');
INSERT INTO `log_entry` VALUES ('263', '37830662', '1', '', '2013-08-10 21:10:16', '1');
INSERT INTO `log_entry` VALUES ('264', '37830662', '1', '', '2013-08-11 18:41:26', '1');
INSERT INTO `log_entry` VALUES ('265', '103229766', '1', '', '2013-08-11 18:50:28', '1');
INSERT INTO `log_entry` VALUES ('266', '103229766', '1', '', '2013-08-11 19:09:11', '1');
INSERT INTO `log_entry` VALUES ('267', '37830662', '1', '', '2013-08-11 19:32:15', '1');
INSERT INTO `log_entry` VALUES ('268', '37830662', '1', '', '2013-08-11 19:33:12', '1');
INSERT INTO `log_entry` VALUES ('269', '37830662', '1', '', '2013-08-11 19:49:07', '1');
INSERT INTO `log_entry` VALUES ('270', '37830662', '1', '', '2013-08-11 19:50:03', '1');
INSERT INTO `log_entry` VALUES ('271', '37830662', '1', '', '2013-08-11 20:13:27', '1');
INSERT INTO `log_entry` VALUES ('272', '37830662', '1', '', '2013-08-12 16:27:40', '1');
INSERT INTO `log_entry` VALUES ('273', '37830662', '1', '', '2013-08-12 16:28:29', '1');
INSERT INTO `log_entry` VALUES ('274', '37830662', '1', '', '2013-08-12 16:32:51', '1');
INSERT INTO `log_entry` VALUES ('275', '37830662', '1', '', '2013-08-12 16:36:05', '1');
INSERT INTO `log_entry` VALUES ('276', '37830662', '1', '', '2013-08-12 16:38:30', '1');

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `payload` varchar(1024) NOT NULL,
  `loop_interval` int(10) unsigned NOT NULL DEFAULT '0',
  `start_delay` int(10) unsigned NOT NULL DEFAULT '30',
  `instance_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1_message` (`instance_id`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for `migration_schema_log`
-- ----------------------------
DROP TABLE IF EXISTS `migration_schema_log`;
CREATE TABLE `migration_schema_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `schema_name` varchar(255) NOT NULL,
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `old_version` varchar(255) NOT NULL,
  `new_version` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migration_schema_log
-- ----------------------------
INSERT INTO `migration_schema_log` VALUES ('1', 'Reality', '2013-06-19 06:51:01', '0.000000', '0.010000');
INSERT INTO `migration_schema_log` VALUES ('2', 'Reality', '2013-06-19 06:51:02', '0.010000', '0.020000');
INSERT INTO `migration_schema_log` VALUES ('3', 'Reality', '2013-06-19 06:51:02', '0.020000', '0.030000');
INSERT INTO `migration_schema_log` VALUES ('4', 'Reality', '2013-06-19 06:51:02', '0.030000', '0.040000');
INSERT INTO `migration_schema_log` VALUES ('5', 'Reality', '2013-06-19 06:51:03', '0.040000', '0.050000');
INSERT INTO `migration_schema_log` VALUES ('6', 'Reality', '2013-06-19 06:51:03', '0.050000', '0.060000');
INSERT INTO `migration_schema_log` VALUES ('7', 'Reality', '2013-06-19 06:51:04', '0.060000', '0.070000');
INSERT INTO `migration_schema_log` VALUES ('8', 'Reality', '2013-06-19 06:51:05', '0.070000', '0.080000');
INSERT INTO `migration_schema_log` VALUES ('9', 'Reality', '2013-06-19 06:51:05', '0.080000', '0.090000');
INSERT INTO `migration_schema_log` VALUES ('10', 'Reality', '2013-06-19 06:51:05', '0.090000', '0.100000');
INSERT INTO `migration_schema_log` VALUES ('11', 'Reality', '2013-06-19 06:51:05', '0.100000', '0.110000');
INSERT INTO `migration_schema_log` VALUES ('12', 'Reality', '2013-06-19 06:51:05', '0.110000', '0.120000');
INSERT INTO `migration_schema_log` VALUES ('13', 'Reality', '2013-06-19 06:51:05', '0.120000', '0.130000');
INSERT INTO `migration_schema_log` VALUES ('14', 'Reality', '2013-06-19 06:51:05', '0.130000', '0.140000');
INSERT INTO `migration_schema_log` VALUES ('15', 'Reality', '2013-06-19 06:51:05', '0.140000', '0.150000');
INSERT INTO `migration_schema_log` VALUES ('16', 'Reality', '2013-06-19 06:51:05', '0.150000', '0.160000');
INSERT INTO `migration_schema_log` VALUES ('17', 'Reality', '2013-06-19 06:51:05', '0.160000', '0.170000');
INSERT INTO `migration_schema_log` VALUES ('18', 'Reality', '2013-06-19 06:51:05', '0.170000', '0.180000');
INSERT INTO `migration_schema_log` VALUES ('19', 'Reality', '2013-06-19 06:51:06', '0.180000', '0.190000');
INSERT INTO `migration_schema_log` VALUES ('20', 'Reality', '2013-06-19 06:51:07', '0.190000', '0.200000');
INSERT INTO `migration_schema_log` VALUES ('21', 'Reality', '2013-06-19 06:51:08', '0.200000', '0.210000');
INSERT INTO `migration_schema_log` VALUES ('22', 'Reality', '2013-06-19 06:51:08', '0.210000', '0.220000');
INSERT INTO `migration_schema_log` VALUES ('23', 'Reality', '2013-06-19 06:51:08', '0.220000', '0.230000');
INSERT INTO `migration_schema_log` VALUES ('24', 'Reality', '2013-06-19 06:51:08', '0.230000', '0.240000');
INSERT INTO `migration_schema_log` VALUES ('25', 'Reality', '2013-06-19 06:51:08', '0.240000', '0.250000');
INSERT INTO `migration_schema_log` VALUES ('26', 'Reality', '2013-06-19 06:51:08', '0.250000', '0.260000');
INSERT INTO `migration_schema_log` VALUES ('27', 'Reality', '2013-06-19 06:51:09', '0.260000', '0.270000');
INSERT INTO `migration_schema_log` VALUES ('28', 'Reality', '2013-06-19 06:51:09', '0.270000', '0.280000');
INSERT INTO `migration_schema_log` VALUES ('29', 'Reality', '2013-06-19 06:51:09', '0.280000', '0.290000');
INSERT INTO `migration_schema_log` VALUES ('30', 'Reality', '2013-06-19 06:51:09', '0.290000', '0.300000');
INSERT INTO `migration_schema_log` VALUES ('31', 'Reality', '2013-06-19 06:51:09', '0.300000', '0.310000');
INSERT INTO `migration_schema_log` VALUES ('32', 'Reality', '2013-06-19 06:51:09', '0.310000', '0.320000');
INSERT INTO `migration_schema_log` VALUES ('33', 'Reality', '2013-06-19 06:51:09', '0.320000', '0.330000');
INSERT INTO `migration_schema_log` VALUES ('34', 'Reality', '2013-06-19 06:51:09', '0.330000', '0.340000');
INSERT INTO `migration_schema_log` VALUES ('35', 'Reality', '2013-06-19 06:51:09', '0.340000', '0.350000');
INSERT INTO `migration_schema_log` VALUES ('36', 'Reality', '2013-06-19 06:51:09', '0.350000', '0.360000');
INSERT INTO `migration_schema_log` VALUES ('37', 'Reality', '2013-06-19 06:51:10', '0.360000', '0.370000');
INSERT INTO `migration_schema_log` VALUES ('38', 'Reality', '2013-06-19 06:51:10', '0.370000', '0.380000');
INSERT INTO `migration_schema_log` VALUES ('39', 'Reality', '2013-06-19 06:51:10', '0.380000', '0.390000');
INSERT INTO `migration_schema_log` VALUES ('40', 'RealityBuildings', '2013-06-19 06:52:41', '0.000000', '0.010000');
INSERT INTO `migration_schema_log` VALUES ('41', 'RealityMessaging', '2013-06-19 06:52:48', '0.000000', '0.010000');
INSERT INTO `migration_schema_log` VALUES ('42', 'RealityInvCust', '2013-06-19 06:52:52', '0.000000', '0.010000');
INSERT INTO `migration_schema_log` VALUES ('43', 'RealityInvCust', '2013-06-19 06:52:53', '0.010000', '0.020000');

-- ----------------------------
-- Table structure for `migration_schema_version`
-- ----------------------------
DROP TABLE IF EXISTS `migration_schema_version`;
CREATE TABLE `migration_schema_version` (
  `name` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migration_schema_version
-- ----------------------------
INSERT INTO `migration_schema_version` VALUES ('Reality', '0.390000');
INSERT INTO `migration_schema_version` VALUES ('RealityBuildings', '0.010000');
INSERT INTO `migration_schema_version` VALUES ('RealityInvCust', '0.020000');
INSERT INTO `migration_schema_version` VALUES ('RealityMessaging', '0.010000');

-- ----------------------------
-- Table structure for `profile`
-- ----------------------------
DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(128) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `humanity` int(6) NOT NULL DEFAULT '2500',
  `survival_attempts` int(3) unsigned NOT NULL DEFAULT '1',
  `total_survival_time` int(5) unsigned NOT NULL DEFAULT '0',
  `total_survivor_kills` int(4) unsigned NOT NULL DEFAULT '0',
  `total_bandit_kills` int(4) unsigned NOT NULL DEFAULT '0',
  `total_zombie_kills` int(5) unsigned NOT NULL DEFAULT '0',
  `total_headshots` int(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_profile` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of profile
-- ----------------------------

-- ----------------------------
-- Table structure for `survivor`
-- ----------------------------
DROP TABLE IF EXISTS `survivor`;
CREATE TABLE `survivor` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(128) NOT NULL,
  `world_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[]',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `backpack` varchar(2048) NOT NULL DEFAULT '[]',
  `medical` varchar(255) NOT NULL DEFAULT '[false,false,false,false,false,false,false,12000,[],[0,0],0]',
  `is_dead` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `model` varchar(128) NOT NULL DEFAULT 'Survivor2_DZ',
  `state` varchar(128) NOT NULL DEFAULT '["","aidlpercmstpsnonwnondnon_player_idlesteady04",36]',
  `survivor_kills` int(3) unsigned NOT NULL DEFAULT '0',
  `bandit_kills` int(3) unsigned NOT NULL DEFAULT '0',
  `zombie_kills` int(4) unsigned NOT NULL DEFAULT '0',
  `headshots` int(4) unsigned NOT NULL DEFAULT '0',
  `last_ate` int(3) unsigned NOT NULL DEFAULT '0',
  `last_drank` int(3) unsigned NOT NULL DEFAULT '0',
  `survival_time` int(3) unsigned NOT NULL DEFAULT '0',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `start_time` datetime NOT NULL,
  `DistanceFoot` int(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx1_main` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of survivor
-- ----------------------------

-- ----------------------------
-- Table structure for `vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE `vehicle` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) DEFAULT NULL,
  `damage_min` decimal(4,3) NOT NULL DEFAULT '0.100',
  `damage_max` decimal(4,3) NOT NULL DEFAULT '0.700',
  `fuel_min` decimal(4,3) NOT NULL DEFAULT '0.200',
  `fuel_max` decimal(4,3) NOT NULL DEFAULT '0.800',
  `limit_min` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `limit_max` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `parts` varchar(1024) DEFAULT NULL,
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq1_vehicle` (`class_name`),
  KEY `idx1_vehicle` (`class_name`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vehicle
-- ----------------------------
INSERT INTO `vehicle` VALUES ('188', 'SUV_PMC', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('189', 'TT650_Ins', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('190', 'Old_moto_TK_Civ_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('191', 'car_hatchback', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('192', 'Old_bike_TK_INS_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('193', 'Old_bike_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('194', 'hilux1_civil_3_open', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('195', 'ATV_US_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('196', 'M1030_US_DES_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('197', 'Lada2_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('198', 'Ikarus_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('199', 'schoolbus', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('200', 'hemicuda', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('201', 'cd71hm', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('202', 'mackr', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('203', 'oldtruck', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('204', 'challenger', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('205', 'cooter', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('206', 'oldtruc2', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('207', 'sahco', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('208', 'oltruc3', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('209', 'oldtruc2a', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('210', 'monaco', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('211', 'roadrunner', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('212', 'roadrunner2', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('213', 'Volha_1_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('214', 'civic', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('215', '440cuda', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('216', 'cuda', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('217', 'tractorOld', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('218', 'rosco', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('219', 'jailbus', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('220', 'CSJ_GyroP', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('221', 'CSJ_GyroCover', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('222', 'CSJ_GyroC', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('223', 'Tractor', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('224', 'Ikarus', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('225', 'hilux1_civil_3_open_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('226', 'MH6J_DZ', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('227', 'Mi17_DZ', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('228', 'UH1H_DZ', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('229', 'AH6X_DZ', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('230', 'AN2_DZ', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('231', 'C130J', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('232', 'hilux1_civil_2_covered', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('233', 'kyo_microlight_blue', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('234', 'kyo_microlight_military', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('235', 'kyo_microlight', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('236', 'kyo_microlight_yellow', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('248', 'Volha_2_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('249', 'UralOpen_INS', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('250', 'UralCivil2', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('251', 'Ural_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('252', 'UAZ_Unarmed_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('253', 'UAZ_Unarmed_UN_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('254', 'S1203_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('255', 'Car_sedan', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('256', 'Lada2', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('257', 'V3S_Civ', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('258', 'kyo_ultralight', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('259', 'VWGolf', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('260', 'UralCivil', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('261', 'SUV_DZ', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('262', 'Land_Destroyer', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('263', 'Land_Fregata', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('264', 'PBX', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('265', 'Smallboat_1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('266', 'Offroad_SPG9_Gue', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('267', 'Pickup_PK_GUE', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('268', 'Pickup_PK_INS', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('269', 'HMMWV_DZ', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('270', 'BTR40_MG_TK_INS_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('271', 'MV22', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('272', 'Lada1_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('273', 'hilux1_civil_1_open', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('274', 'VolhaLimo_TK_CIV_EP1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('275', 'LadaLM', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('276', 'Lada1', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('277', 'Ural_INS', '0.100', '0.700', '0.200', '0.800', '0', '100', 'motor', '[]');

-- ----------------------------
-- Table structure for `world`
-- ----------------------------
DROP TABLE IF EXISTS `world`;
CREATE TABLE `world` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `max_x` mediumint(9) DEFAULT '0',
  `max_y` mediumint(9) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_world` (`name`),
  KEY `idx1_world` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of world
-- ----------------------------
INSERT INTO `world` VALUES ('1', 'chernarus', '14700', '15360');
INSERT INTO `world` VALUES ('2', 'lingor', '10000', '10000');
INSERT INTO `world` VALUES ('3', 'utes', '5100', '5100');
INSERT INTO `world` VALUES ('4', 'takistan', '14000', '14000');
INSERT INTO `world` VALUES ('5', 'panthera2', '10200', '10200');
INSERT INTO `world` VALUES ('6', 'fallujah', '10200', '10200');
INSERT INTO `world` VALUES ('7', 'zargabad', '8000', '8000');
INSERT INTO `world` VALUES ('8', 'namalsk', '12000', '12000');
INSERT INTO `world` VALUES ('9', 'mbg_celle2', '13000', '13000');
INSERT INTO `world` VALUES ('10', 'tavi', '25600', '25600');

-- ----------------------------
-- Table structure for `world_vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `world_vehicle`;
CREATE TABLE `world_vehicle` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `world_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[]',
  `description` varchar(1024) DEFAULT NULL,
  `chance` decimal(4,3) unsigned NOT NULL DEFAULT '0.000',
  `last_modified` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx1_world_vehicle` (`vehicle_id`),
  KEY `idx2_world_vehicle` (`world_id`),
  CONSTRAINT `world_vehicle_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`),
  CONSTRAINT `world_vehicle_ibfk_2` FOREIGN KEY (`world_id`) REFERENCES `world` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of world_vehicle
-- ----------------------------
INSERT INTO `world_vehicle` VALUES ('1', '188', '9', '[2,[8912.0166,2008.9486,2.9563904e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('2', '189', '9', '[0,[8909.126,2006.5646,2.8610229e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('3', '190', '9', '[0,[8773.6924,2068.2144,-4.0054321e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('4', '191', '9', '[-89,[8925.5625,2225.6382,-1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('5', '192', '9', '[58,[9001.3896,2105.3784,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('6', '193', '9', '[0,[8734.3936,1409.9553,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('7', '194', '9', '[-17,[11951.44,2301.3293,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('8', '195', '9', '[0,[7808.6958,1492.9495,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('9', '196', '9', '[-56,[6027.5918,1308.1482,-1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('10', '197', '9', '[155,[4692.9873,508.25613,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('11', '188', '9', '[0,[2323.6497,1210.6176,1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('12', '190', '9', '[-49,[2349.1731,1278.0829,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('13', '198', '9', '[51,[1687.7589,2051.9717,-1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('14', '195', '9', '[0,[1638.8507,2063.5867,5.7220459e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('15', '199', '9', '[7,[270.31448,3791.8843,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('16', '200', '9', '[0,[334.25327,3888.8594,7.6293945e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('17', '201', '9', '[89,[385.2767,3748.6726,-6.6757202e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('18', '202', '9', '[100,[633.14893,5120.9102,-3.528595e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('19', '203', '9', '[-54,[590.30219,4999.6733,1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('20', '204', '9', '[24,[9568.3457,10060.036,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('21', '205', '9', '[-78,[5674.0527,3745.593,1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('22', '206', '9', '[39,[6251.8804,2558.7512,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('23', '207', '9', '[-40,[10613.786,10672.895,3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('24', '208', '9', '[74,[6961.2378,11295.592,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('25', '209', '9', '[0,[9010.6631,2691.125,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('26', '210', '9', '[-290,[9065.3115,8847.6475,1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('27', '211', '9', '[-67,[8817.5371,2646.8945,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('28', '212', '9', '[21,[9367.8271,3190.8191,3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('29', '213', '9', '[200,[9386.707,3187.5989,-3.0517578e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('30', '214', '9', '[0,[9757.125,842.98492,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('31', '215', '9', '[180,[4591.2739,5565.3691,7.6293945e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('32', '216', '9', '[197,[8457.3457,8220.1699,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('33', '217', '9', '[0,[8143.6978,8171.5239,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('34', '218', '9', '[0,[10516.491,11499.888,-2.1934509e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('35', '201', '9', '[55,[10464.054,10713.47,-2.8610229e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('36', '216', '9', '[163,[1706.5564,9417.2637,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('37', '219', '9', '[172,[7509.1807,1382.217,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('38', '220', '9', '[106,[8844.9531,2724.2625,-2.6702881e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('39', '221', '9', '[-65,[9348.3066,3210.6306,-5.7220459e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('40', '222', '9', '[13,[9001.6924,2732.8564,-2.3841858e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('41', '222', '9', '[177,[10832.004,866.11621,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('42', '222', '9', '[106,[2431.9075,1115.0425,7.6293945e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('43', '221', '9', '[-106,[7027.3491,6736.7969,1.1444092e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('44', '222', '9', '[0,[608.92535,8797.4219,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('45', '220', '9', '[215,[6784.0659,7977.1016,1.1444092e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('46', '223', '9', '[0,[6688.5811,8192.7334,1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('47', '223', '9', '[0,[7060.4727,7396.2212,1.5258789e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('48', '217', '9', '[0,[8372.1699,6352.8184,-3.8146973e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('49', '224', '9', '[127,[708.65997,11064.283,-1.5258789e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('50', '222', '9', '[0,[776.93341,11077.079,7.6293945e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('51', '188', '9', '[135,[3045.1929,11044.122,1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('52', '225', '9', '[134,[3001.9575,10862.737,-9.5367432e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('53', '222', '9', '[83,[2975.5847,10730.586,5.7220459e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('54', '189', '9', '[0,[2905.8489,10895.161,3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('55', '226', '9', '[0,[5735.1904,4240.1846,5.7220459e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('56', '227', '9', '[111,[8760.8828,2094.4185,3.0517578e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('57', '228', '9', '[69,[9359.7617,2953.541,-3.4332275e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('58', '228', '9', '[173,[7399.6343,1298.0328,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('59', '229', '9', '[108,[7589.2065,1375.4612,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('60', '230', '9', '[80,[7010.4341,1098.9054,1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('61', '230', '9', '[78,[7013.9678,1079.3026,-6.2942505e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('62', '231', '9', '[-91,[11862.23,11320.085,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('63', '227', '9', '[80,[3892.5403,6522.0366,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('64', '228', '9', '[0,[3606.3008,9783.3643,1.9073486e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('65', '228', '9', '[234,[11189.917,10149.401,0.00015640259]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('66', '227', '9', '[7,[4181.7339,5299.8452,-2.6702881e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('67', '232', '9', '[-47,[1956.5889,6452.9453,-1.9073486e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('68', '226', '9', '[-12,[1957.0107,6375.4521,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('69', '233', '9', '[0,[11282.924,11369.424,-3.9100647e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('70', '234', '9', '[0,[11245.813,11262.264,2.3841858e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('71', '235', '9', '[0,[10959.218,11280.307,-2.8610229e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('72', '236', '9', '[0,[10808.122,11378.532,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('73', '233', '9', '[0,[7303.5615,1082.8754,-6.6757202e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('74', '234', '9', '[0,[7147.3555,1218.2589,-9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('75', '235', '9', '[0,[7708.4888,1371.2163,4.7683716e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('76', '236', '9', '[0,[8241.8574,1312.4268,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('77', '218', '9', '[0,[1934.9142,7599.4565,3.6239624e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('78', '218', '9', '[0,[6255.7236,5788.314,-1.9073486e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('79', '218', '9', '[0,[5837.396,5489.4165,-3.4332275e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('80', '218', '9', '[90,[9189.418,4145.9756,3.0517578e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('81', '218', '9', '[51,[10125.332,3430.449,-3.8146973e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('82', '218', '9', '[-37,[7121.7612,2628.655,-5.7220459e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('83', '218', '9', '[-192,[4589.063,3061.0728,-3.528595e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('84', '218', '9', '[99,[2349.562,1103.3198,7.6293945e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('85', '218', '9', '[-99,[2882.0417,1248.4835,-2.0980835e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('86', '218', '9', '[74,[6021.2964,2738.9673,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('87', '218', '9', '[1,[6043.0859,1355.3433,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('88', '248', '9', '[52,[6004.4746,1341.9736,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('89', '249', '9', '[-140,[8783.9004,946.98566,5.9127808e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('90', '250', '9', '[0,[9248.1738,4923.0093,-3.0517578e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('91', '251', '9', '[0,[11664.828,5678.167,0.00011634827]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('92', '252', '9', '[0,[5864.7827,8089.6963,-2.8610229e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('93', '253', '9', '[-57,[9789.0156,8018.8179,-8.5830688e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('94', '248', '9', '[148,[9105.2832,2585.2058,-2.2888184e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('95', '254', '9', '[-148,[8818.2246,2539.1135,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('96', '255', '9', '[26,[9135.9678,2098.6682,4.2915344e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('97', '256', '9', '[0,[9058.8506,2064.8113,-1.2397766e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('98', '257', '9', '[-35,[6746.7798,8042.7134,-2.8610229e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('99', '258', '9', '[0,[7013.314,6698.4634,1.5258789e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('100', '218', '9', '[-9,[7050.5332,4632.0737,2.6702881e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('101', '218', '9', '[94,[5717.3413,4139.1162,8.5830688e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('102', '215', '9', '[-8,[9390.5908,3227.7803,-7.6293945e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('103', '213', '9', '[9,[5869.6157,10359.563,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('104', '259', '9', '[-3,[6954.3994,9240.9541,-5.7220459e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('105', '217', '9', '[-46,[6999.3481,7112.4043,1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('106', '254', '9', '[-148,[7312.0264,3193.3835,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('107', '248', '9', '[148,[7897.7944,2835.1545,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('108', '190', '9', '[0,[8794.6445,313.48535,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('109', '190', '9', '[0,[10915.979,374.57666,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('110', '189', '9', '[0,[8353.0801,950.80298,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('111', '188', '9', '[2,[8705.5645,67.297852,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('112', '255', '9', '[26,[6501.709,380.48071,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('113', '218', '9', '[-37,[7423.1826,480.91187,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('114', '197', '9', '[155,[3022.512,202.12573,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('115', '218', '9', '[99,[189.46143,646.29492,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('116', '198', '9', '[51,[982.71552,939.25781,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('117', '201', '9', '[89,[95.123688,2716.7754,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('118', '200', '9', '[0,[2102.3594,3073.4883,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('119', '232', '9', '[-47,[3818.064,1568.9956,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('120', '222', '9', '[0,[1624.0669,11691.529,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('121', '222', '9', '[0,[569.90576,12225.588,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('122', '225', '9', '[134,[4658.5269,10080.047,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('123', '213', '9', '[9,[5828.7383,11305.227,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('124', '218', '9', '[51,[11125.59,6949.709,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('125', '253', '9', '[-57,[8516.0098,10741.813,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('126', '201', '9', '[55,[8400.8691,11251.038,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('127', '201', '9', '[55,[7776.3818,8765.0029,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('128', '257', '9', '[-35,[6068.7573,8701.2451,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('129', '257', '9', '[-35,[4748.2031,6983.269,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('130', '257', '9', '[-35,[11819.172,4508.4229,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('131', '257', '9', '[-35,[2029.061,3793.6001,-5.7220459e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('132', '249', '9', '[0,[4478.0898,2357.9487,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('133', '249', '9', '[0,[3763.7905,3865.6831,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('134', '249', '9', '[0,[247.88184,6798.3252,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('135', '250', '9', '[0,[11534.408,1859.2888,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('136', '250', '9', '[0,[10333.947,1846.6245,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('137', '260', '9', '[0,[10912.482,1434.1165,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('138', '260', '9', '[0,[5162.5474,12001.696,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('139', '260', '9', '[0,[7155.9478,12014.27,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('140', '251', '9', '[-37,[1542.9962,8623.0381,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('141', '256', '9', '[0,[3002.4258,6021.8315,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('142', '261', '9', '[0,[2014.1011,5280.0459,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('143', '228', '9', '[0,[3387.7051,5254.8999,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('144', '228', '9', '[0,[7537.8301,3750.3757,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('145', '223', '9', '[0,[9905.4766,6290.0127,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('146', '216', '9', '[197,[10169.587,7076.918,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('147', '216', '9', '[197,[8470.873,7004.8345,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('148', '216', '9', '[197,[10967.923,3911.2764,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('149', '262', '9', '[74,[12798.793,509.66946,-2.6618516]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('150', '263', '9', '[0,[13028.676,544.69208,-3.9046974]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('151', '264', '9', '[90,[8592.626,2447.5613,-0.60196424]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('152', '265', '9', '[-63,[9198.9004,2457.3506,-1.0672363]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('153', '266', '9', '[45,[8899.7197,2129.4165,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('154', '267', '9', '[74,[8884.4014,2633.5073,4.7683716e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('155', '268', '9', '[25,[9291.5586,3081.019,-7.0571899e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('156', '269', '9', '[5,[10928.791,828.97522,-9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('157', '269', '9', '[-38,[7628.2949,1391.9696,-1.0490417e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('158', '266', '9', '[0,[6038.0293,5864.5635,1.1444092e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('159', '267', '9', '[0,[11872.488,5841.0474,-0.13554752]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('160', '268', '9', '[0,[6675.6958,7870.1187,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('161', '269', '9', '[0,[909.79852,11163.857,3.0517578e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('162', '266', '9', '[0,[10900.124,10926.537,-2.4795532e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('163', '267', '9', '[-84,[10871.183,11098.228,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('164', '228', '9', '[0,[4471.0225,5461.3423,-1.9073486e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('165', '270', '9', '[0,[4027.3071,9261.3838,1.5258789e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('166', '270', '9', '[-109,[4415.999,8003.1572,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('167', '271', '9', '[-209,[4484.9883,8840.0986,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('168', '267', '9', '[0,[6971.4707,11441.309,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('169', '268', '9', '[0,[1085.7524,3776.1104,2.8610229e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('170', '266', '9', '[0,[249.72977,1759.5632,5.7220459e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('171', '269', '9', '[0,[9768.7324,5601.5479,-5.3405762e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('172', '269', '9', '[0,[3139.5198,9535.873,-1.5258789e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('173', '269', '9', '[0,[111.3116,11871.164,-7.6293945e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('174', '200', '9', '[-188,[2303.3098,11829.702,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('175', '201', '9', '[0,[3409.3882,11689.394,9.5367432e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('176', '216', '9', '[66,[2445.0615,11005.281,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('177', '200', '9', '[0,[640.52551,9847.0645,1.9073486e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('178', '201', '9', '[0,[5204.8564,2790.054,-8.5830688e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('179', '211', '9', '[-107,[3229.5442,3397.7175,1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('180', '212', '9', '[39,[3672.7449,1119.1477,3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('181', '210', '9', '[137,[5129.3994,1012.8743,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('182', '204', '9', '[192,[9497.5703,1364.6495,2.0027161e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('183', '269', '9', '[21,[4279.396,4529.3315,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('184', '232', '9', '[0,[2607.4922,4110.8467,-3.8146973e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('185', '224', '9', '[29,[2749.7224,4013.5535,3.3378601e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('186', '198', '9', '[-22,[5769.0562,3918.5796,1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('187', '224', '9', '[-21,[5638.8511,3804.4875,3.4332275e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('188', '269', '9', '[63,[8286.6455,2476.5847,-1.0490417e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('189', '272', '9', '[-89,[8291.3496,2475.2444,7.6293945e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('190', '273', '9', '[-66,[8276.0303,2305.9524,-2.9563904e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('191', '191', '9', '[-274,[8280.9727,2305.2256,-2.2888184e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('192', '250', '9', '[62,[8927.4678,2486.7195,-1.9073486e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('193', '260', '9', '[-70,[10757.278,968.79596,-2.8610229e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('194', '224', '9', '[141,[11034.599,1210.4128,1.6689301e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('195', '274', '9', '[41,[6070.8389,1620.4963,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('196', '213', '9', '[-73,[6104.5776,2048.2759,1.335144e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('197', '269', '9', '[-31,[6983.7144,2569.7771,5.7220459e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('198', '196', '9', '[51,[7091.5005,2593.6418,1.5258789e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('199', '254', '9', '[0,[7214.0615,2598.7771,-9.5367432e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('200', '253', '9', '[51,[1280.3855,5931.9736,-2.3841858e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('201', '275', '9', '[50,[1180.0945,6527.8374,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('202', '276', '9', '[-103,[1317.4449,7330.6787,-9.5367432e-006]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('203', '249', '9', '[0,[10179.723,4058.8396,-2.2888184e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('204', '257', '9', '[-13,[11129.001,5044.8726,-2.2888184e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('205', '277', '9', '[-199,[5650.9995,7031.6646,7.6293945e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('206', '228', '9', '[0,[7372.2813,5207.3301,0]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('207', '228', '9', '[68,[883.49725,7807.5498,9.5367432e-007]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('208', '227', '9', '[0,[3981.9958,2042.9598,-1.1444092e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('209', '227', '9', '[71,[4823.6328,10984.902,-1.9073486e-005]]', null, '1.000', null);
INSERT INTO `world_vehicle` VALUES ('210', '228', '9', '[0,[10929.029,9377.7412,-7.6293945e-006]]', null, '1.000', null);

-- ----------------------------
-- View structure for `v_deployable`
-- ----------------------------
DROP VIEW IF EXISTS `v_deployable`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_deployable` AS select `id`.`id` AS `instance_deployable_id`,`d`.`id` AS `vehicle_id`,`d`.`class_name` AS `class_name`,`s`.`id` AS `owner_id`,`p`.`name` AS `owner_name`,`p`.`unique_id` AS `owner_unique_id`,`s`.`is_dead` AS `is_owner_dead`,`id`.`worldspace` AS `worldspace`,`id`.`inventory` AS `inventory` from (((`instance_deployable` `id` join `deployable` `d` on((`id`.`deployable_id` = `d`.`id`))) join `survivor` `s` on((`id`.`owner_id` = `s`.`id`))) join `profile` `p` on((`s`.`unique_id` = `p`.`unique_id`))) ;

-- ----------------------------
-- View structure for `v_player`
-- ----------------------------
DROP VIEW IF EXISTS `v_player`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_player` AS select `p`.`name` AS `player_name`,`p`.`humanity` AS `humanity`,`s`.`id` AS `alive_survivor_id`,`s`.`world_id` AS `alive_survivor_world_id` from (`profile` `p` left join `survivor` `s` on(((`p`.`unique_id` = `s`.`unique_id`) and (`s`.`is_dead` = 0)))) ;

-- ----------------------------
-- View structure for `v_vehicle`
-- ----------------------------
DROP VIEW IF EXISTS `v_vehicle`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_vehicle` AS select `iv`.`id` AS `instance_vehicle_id`,`v`.`id` AS `vehicle_id`,`iv`.`instance_id` AS `instance_id`,`i`.`world_id` AS `world_id`,`v`.`class_name` AS `class_name`,`iv`.`worldspace` AS `worldspace`,`iv`.`inventory` AS `inventory`,`iv`.`parts` AS `parts`,`iv`.`damage` AS `damage`,`iv`.`fuel` AS `fuel` from (((`instance_vehicle` `iv` join `world_vehicle` `wv` on((`iv`.`world_vehicle_id` = `wv`.`id`))) join `vehicle` `v` on((`wv`.`vehicle_id` = `v`.`id`))) join `instance` `i` on((`iv`.`instance_id` = `i`.`id`))) ;

-- ----------------------------
-- Procedure structure for `proc_getBuildingPageCount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getBuildingPageCount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getBuildingPageCount`(in `p_instanceId` int)
begin
  declare itemsPerPage int default 5; -- must match proc_getobjects
  select
    floor(count(*) / itemsPerPage) + if((count(*) mod itemsPerPage) > 0, 1, 0)
  from instance_building
  where instance_id = p_instanceId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getBuildings`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getBuildings`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getBuildings`(in `p_instanceId` int, in `p_currentPage` int)
begin
  set @instance = p_instanceId; --
  set @page = greatest(((p_currentPage - 1) * 5), 0); --
  prepare stmt from '
  select
    b.class_name, ib.worldspace
  from
    instance_building ib
    inner join building b on ib.building_id = b.id
  where
    ib.instance_id = ?
  limit ?, 5'; --
  execute stmt using @instance, @page; --
  deallocate prepare stmt; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getMessagePage`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getMessagePage`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getMessagePage`(in `p_instanceId` int, in `p_currentPage` int)
begin
  set @instance = p_instanceId; --
  set @page = greatest(((p_currentPage - 1) * 10), 0); --
  prepare stmt from 'select payload, loop_interval, start_delay  from message where instance_id = ? limit ?, 10'; --
  execute stmt using @instance, @page; -- 
  deallocate prepare stmt; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getMessagePageCount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getMessagePageCount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getMessagePageCount`(in `p_instanceId` int)
begin
  declare itemsPerPage int default 10; -- must match proc_getMessagePage
  select
    floor(count(*) / itemsPerPage) + if((count(*) mod itemsPerPage) > 0, 1, 0)
  from message
  where message.instance_id = p_instanceId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_loglogin`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_loglogin`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loglogin`(in `p_uniqueId` varchar(128), in `p_instanceId` int)
begin
  insert ignore into log_entry (unique_id, instance_id, log_code_id) values (p_uniqueId, p_instanceId, 1); --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_loglogout`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_loglogout`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loglogout`(in `p_uniqueId` varchar(128), in `p_instanceId` int)
begin
  insert into log_entry (unique_id, instance_id, log_code_id) values (p_uniqueId, p_instanceId, 5); --
end
;;
DELIMITER ;
