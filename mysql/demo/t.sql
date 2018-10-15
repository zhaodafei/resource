/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-10-14 10:49:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t
-- ----------------------------
DROP TABLE IF EXISTS `t`;
CREATE TABLE `t` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `tname` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '队伍名称',
  PRIMARY KEY (`tid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t
-- ----------------------------
INSERT INTO `t` VALUES ('1', '国安');
INSERT INTO `t` VALUES ('2', '申花');
INSERT INTO `t` VALUES ('3', '布尔联队');
