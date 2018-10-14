/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-09-30 00:39:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for student2
-- ----------------------------
DROP TABLE IF EXISTS `student2`;
CREATE TABLE `student2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` double(255,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of student2
-- ----------------------------
INSERT INTO `student2` VALUES ('1', '张三', '数学', '90');
INSERT INTO `student2` VALUES ('2', '张三', '语文', '50');
INSERT INTO `student2` VALUES ('3', '张三', '地理', '40');
INSERT INTO `student2` VALUES ('4', '李四', '语文', '55');
INSERT INTO `student2` VALUES ('5', '李四', '政治', '45');
INSERT INTO `student2` VALUES ('6', '王五', '政治', '30');
INSERT INTO `student2` VALUES ('7', '马六', '地理', '80');
INSERT INTO `student2` VALUES ('8', '马六', '英语', '90');
