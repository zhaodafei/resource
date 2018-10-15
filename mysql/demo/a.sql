/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-10-14 11:33:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for a
-- ----------------------------
DROP TABLE IF EXISTS `a`;
CREATE TABLE `a` (
  `id` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of a
-- ----------------------------
INSERT INTO `a` VALUES ('a', '5');
INSERT INTO `a` VALUES ('b', '10');
INSERT INTO `a` VALUES ('c', '15');
INSERT INTO `a` VALUES ('d', '10');
