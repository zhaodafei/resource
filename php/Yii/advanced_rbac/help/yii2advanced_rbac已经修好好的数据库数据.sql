/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : yii2advanced

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-12-13 17:35:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_assignment
-- ----------------------------
DROP TABLE IF EXISTS `auth_assignment`;
CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  KEY `auth_assignment_user_id_idx` (`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_assignment
-- ----------------------------
INSERT INTO `auth_assignment` VALUES ('一般用户', '2', '1513155706');
INSERT INTO `auth_assignment` VALUES ('管理员', '1', '1513155601');

-- ----------------------------
-- Table structure for auth_item
-- ----------------------------
DROP TABLE IF EXISTS `auth_item`;
CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_item
-- ----------------------------
INSERT INTO `auth_item` VALUES ('/book/*', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/book/create', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/book/delete', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/book/index', '2', null, null, null, '1513151354', '1513151354');
INSERT INTO `auth_item` VALUES ('/book/update', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/book/view', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('一般用户', '1', '一般用户能访问index，view，create三个节点', null, null, '1513153840', '1513153840');
INSERT INTO `auth_item` VALUES ('图书修改权限', '2', 'book表数据修改权限', null, null, '1513152180', '1513152180');
INSERT INTO `auth_item` VALUES ('图书删除权限', '2', 'book表数据的删除权限', null, null, '1513153009', '1513153182');
INSERT INTO `auth_item` VALUES ('图书所有权限', '2', 'book表数据的所有权限', null, null, '1513153049', '1513153049');
INSERT INTO `auth_item` VALUES ('图书新增权限', '2', 'book表数据的新增权限', null, null, '1513153091', '1513153091');
INSERT INTO `auth_item` VALUES ('图书查看权限', '2', 'book 表的数据查看权限', null, null, '1513153142', '1513153142');
INSERT INTO `auth_item` VALUES ('未登录用户', '1', '未登录用户仅能访问index节点', null, null, '1513154093', '1513154093');
INSERT INTO `auth_item` VALUES ('管理员', '1', '系统管理员，拥有系统一起权限，管理员能访问所有节点', null, null, '1513153696', '1513153696');

-- ----------------------------
-- Table structure for auth_item_child
-- ----------------------------
DROP TABLE IF EXISTS `auth_item_child`;
CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_item_child
-- ----------------------------
INSERT INTO `auth_item_child` VALUES ('图书所有权限', '/book/*');
INSERT INTO `auth_item_child` VALUES ('图书所有权限', '/book/create');
INSERT INTO `auth_item_child` VALUES ('图书新增权限', '/book/create');
INSERT INTO `auth_item_child` VALUES ('图书删除权限', '/book/delete');
INSERT INTO `auth_item_child` VALUES ('图书所有权限', '/book/delete');
INSERT INTO `auth_item_child` VALUES ('图书所有权限', '/book/index');
INSERT INTO `auth_item_child` VALUES ('图书查看权限', '/book/index');
INSERT INTO `auth_item_child` VALUES ('图书修改权限', '/book/update');
INSERT INTO `auth_item_child` VALUES ('图书所有权限', '/book/update');
INSERT INTO `auth_item_child` VALUES ('图书所有权限', '/book/view');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书修改权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书删除权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书所有权限');
INSERT INTO `auth_item_child` VALUES ('一般用户', '图书新增权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书新增权限');
INSERT INTO `auth_item_child` VALUES ('一般用户', '图书查看权限');
INSERT INTO `auth_item_child` VALUES ('未登录用户', '图书查看权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书查看权限');

-- ----------------------------
-- Table structure for auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_rule
-- ----------------------------

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `data` blob,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `menu` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------

-- ----------------------------
-- Table structure for migration
-- ----------------------------
DROP TABLE IF EXISTS `migration`;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migration
-- ----------------------------
INSERT INTO `migration` VALUES ('m000000_000000_base', '1513147369');
INSERT INTO `migration` VALUES ('m140602_111327_create_menu_table', '1513147371');
INSERT INTO `migration` VALUES ('m160312_050000_create_user', '1513147371');
INSERT INTO `migration` VALUES ('m140506_102106_rbac_init', '1513147410');
INSERT INTO `migration` VALUES ('m170907_052038_rbac_add_index_on_auth_assignment_user_id', '1513147410');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'djYuafk7O_9ZdnYDnZcxMM7d-69I5nvi', '$2y$13$1mWWJZG6eDyLWWXms8grkul8clZqr5F4oEmDcZYA.OhLNP2ddXo8i', null, 'admin@qq.ocm', '10', '1513154376', '1513154376');
INSERT INTO `user` VALUES ('2', 'test', 'dlzrNZwqOZwv9R33K8iriERYzpWdz02U', '$2y$13$Vtj0oTp4iMNuz3r1bBC8guB9n920WCAI/jT/GWf9CDCRrcheV1YAa', null, 'test@qq.com', '10', '1513154409', '1513154409');
