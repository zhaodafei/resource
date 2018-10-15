/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-10-14 10:48:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for m
-- ----------------------------
DROP TABLE IF EXISTS `m`;
CREATE TABLE `m` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hid` int(11) DEFAULT NULL COMMENT '主队ID',
  `gid` int(11) DEFAULT NULL COMMENT '客队ID',
  `mres` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '比赛结果',
  `matime` date DEFAULT NULL COMMENT '比赛开始时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of m
-- ----------------------------
INSERT INTO `m` VALUES ('1', '1', '2', '2:0', '2006-05-21');
INSERT INTO `m` VALUES ('2', '2', '3', '1:2', '2006-06-21');
INSERT INTO `m` VALUES ('3', '3', '1', '2:5', '2006-06-25');
INSERT INTO `m` VALUES ('4', '2', '1', '3:2', '2006-07-21');
