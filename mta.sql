/*
Navicat MySQL Data Transfer

Source Server         : database
Source Server Version : 80017
Source Host           : localhost:3306
Source Database       : mta

Target Server Type    : MYSQL
Target Server Version : 80017
File Encoding         : 65001

Date: 2023-03-24 04:34:03
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `accounts`
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `password` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `money` bigint(11) NOT NULL DEFAULT '1000',
  `model` int(11) NOT NULL DEFAULT '21',
  `walking` int(11) NOT NULL DEFAULT '125',
  `serial` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `balance` int(11) NOT NULL DEFAULT '0',
  `admin` int(3) NOT NULL DEFAULT '0',
  `death` bigint(11) NOT NULL DEFAULT '0',
  `kill` bigint(11) NOT NULL DEFAULT '0',
  `tag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accounts
-- ----------------------------

-- ----------------------------
-- Table structure for `items`
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) DEFAULT NULL,
  `ammo` bigint(11) DEFAULT NULL,
  `own` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of items
-- ----------------------------

-- ----------------------------
-- Table structure for `pets`
-- ----------------------------
DROP TABLE IF EXISTS `pets`;
CREATE TABLE `pets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `own` int(11) DEFAULT NULL,
  `model` int(11) DEFAULT NULL,
  `name` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pets
-- ----------------------------

-- ----------------------------
-- Table structure for `vips`
-- ----------------------------
DROP TABLE IF EXISTS `vips`;
CREATE TABLE `vips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `own` int(11) DEFAULT NULL,
  `remain` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vips
-- ----------------------------
