/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : yii2advanced

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-12-15 17:50:25
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
INSERT INTO `auth_item` VALUES ('/*', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/admin/*', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/assignment/*', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/assignment/assign', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/assignment/index', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/assignment/revoke', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/assignment/view', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/default/*', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/default/index', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/menu/*', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/menu/create', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/menu/delete', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/menu/index', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/menu/update', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/menu/view', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/permission/*', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/permission/assign', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/permission/create', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/permission/delete', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/permission/index', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/permission/remove', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/permission/update', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/permission/view', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/role/*', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/role/assign', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/role/create', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/role/delete', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/role/index', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/role/remove', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/role/update', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/role/view', '2', null, null, null, '1513222597', '1513222597');
INSERT INTO `auth_item` VALUES ('/admin/route/*', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/route/assign', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/route/create', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/route/index', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/route/refresh', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/route/remove', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/rule/*', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/rule/create', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/rule/delete', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/rule/index', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/rule/update', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/rule/view', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/*', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/activate', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/change-password', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/delete', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/index', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/login', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/logout', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/request-password-reset', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/reset-password', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/signup', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/admin/user/view', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/book/*', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/book/create', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/book/delete', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/book/index', '2', null, null, null, '1513151354', '1513151354');
INSERT INTO `auth_item` VALUES ('/book/update', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/book/view', '2', null, null, null, '1513151355', '1513151355');
INSERT INTO `auth_item` VALUES ('/debug/*', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/default/*', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/default/db-explain', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/default/download-mail', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/default/index', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/default/toolbar', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/default/view', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/user/*', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/user/reset-identity', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/debug/user/set-identity', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/gii/*', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/gii/default/*', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/gii/default/action', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/gii/default/diff', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/gii/default/index', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/gii/default/preview', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/gii/default/view', '2', null, null, null, '1513222598', '1513222598');
INSERT INTO `auth_item` VALUES ('/site/*', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/site/error', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/site/index', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/site/login', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('/site/logout', '2', null, null, null, '1513222599', '1513222599');
INSERT INTO `auth_item` VALUES ('一般用户', '1', '一般用户能访问index，view，create三个节点', null, null, '1513153840', '1513153840');
INSERT INTO `auth_item` VALUES ('分配用户到角色', '2', '管理员拥有分配用户到角色所有权限', null, null, '1513228342', '1513228342');
INSERT INTO `auth_item` VALUES ('图书修改权限', '2', 'book表数据修改权限', null, null, '1513152180', '1513152180');
INSERT INTO `auth_item` VALUES ('图书删除权限', '2', 'book表数据的删除权限', null, null, '1513153009', '1513153182');
INSERT INTO `auth_item` VALUES ('图书所有权限', '2', 'book表数据的所有权限', null, null, '1513153049', '1513153049');
INSERT INTO `auth_item` VALUES ('图书新增权限', '2', 'book表数据的新增权限', null, null, '1513153091', '1513153091');
INSERT INTO `auth_item` VALUES ('图书查看权限', '2', 'book 表的数据查看权限', null, null, '1513153142', '1513153142');
INSERT INTO `auth_item` VALUES ('未登录用户', '1', '未登录用户仅能访问index节点', null, null, '1513154093', '1513154093');
INSERT INTO `auth_item` VALUES ('权限列表所有权限', '2', '管理员拥有权限列表所有权限', null, null, '1513228215', '1513228215');
INSERT INTO `auth_item` VALUES ('用户列表所欲权限', '2', '管理员拥有用户列表所有权限', null, null, '1513228415', '1513228415');
INSERT INTO `auth_item` VALUES ('管理员', '1', '系统管理员，拥有系统一起权限，管理员能访问所有节点', null, null, '1513153696', '1513153696');
INSERT INTO `auth_item` VALUES ('菜单列表所有权限', '2', '管理员拥有菜单列表所有权限', null, null, '1513228380', '1513228380');
INSERT INTO `auth_item` VALUES ('规则管理所有权限', '2', '管理员拥有规则管理所有权限', null, null, '1513228302', '1513228302');
INSERT INTO `auth_item` VALUES ('角色所有权限', '2', '管理员拥有角色管理所有权限', null, null, '1513228143', '1513228143');
INSERT INTO `auth_item` VALUES ('路由列表权限', '2', '管理员拥有路由列表所有权限', null, null, '1513228257', '1513228257');

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
INSERT INTO `auth_item_child` VALUES ('分配用户到角色', '/admin/assignment/*');
INSERT INTO `auth_item_child` VALUES ('分配用户到角色', '/admin/assignment/assign');
INSERT INTO `auth_item_child` VALUES ('分配用户到角色', '/admin/assignment/index');
INSERT INTO `auth_item_child` VALUES ('分配用户到角色', '/admin/assignment/revoke');
INSERT INTO `auth_item_child` VALUES ('分配用户到角色', '/admin/assignment/view');
INSERT INTO `auth_item_child` VALUES ('菜单列表所有权限', '/admin/menu/*');
INSERT INTO `auth_item_child` VALUES ('菜单列表所有权限', '/admin/menu/create');
INSERT INTO `auth_item_child` VALUES ('菜单列表所有权限', '/admin/menu/delete');
INSERT INTO `auth_item_child` VALUES ('菜单列表所有权限', '/admin/menu/index');
INSERT INTO `auth_item_child` VALUES ('菜单列表所有权限', '/admin/menu/update');
INSERT INTO `auth_item_child` VALUES ('菜单列表所有权限', '/admin/menu/view');
INSERT INTO `auth_item_child` VALUES ('权限列表所有权限', '/admin/permission/*');
INSERT INTO `auth_item_child` VALUES ('权限列表所有权限', '/admin/permission/assign');
INSERT INTO `auth_item_child` VALUES ('权限列表所有权限', '/admin/permission/create');
INSERT INTO `auth_item_child` VALUES ('权限列表所有权限', '/admin/permission/delete');
INSERT INTO `auth_item_child` VALUES ('权限列表所有权限', '/admin/permission/index');
INSERT INTO `auth_item_child` VALUES ('权限列表所有权限', '/admin/permission/remove');
INSERT INTO `auth_item_child` VALUES ('权限列表所有权限', '/admin/permission/update');
INSERT INTO `auth_item_child` VALUES ('权限列表所有权限', '/admin/permission/view');
INSERT INTO `auth_item_child` VALUES ('角色所有权限', '/admin/role/*');
INSERT INTO `auth_item_child` VALUES ('角色所有权限', '/admin/role/assign');
INSERT INTO `auth_item_child` VALUES ('角色所有权限', '/admin/role/create');
INSERT INTO `auth_item_child` VALUES ('角色所有权限', '/admin/role/delete');
INSERT INTO `auth_item_child` VALUES ('角色所有权限', '/admin/role/index');
INSERT INTO `auth_item_child` VALUES ('角色所有权限', '/admin/role/remove');
INSERT INTO `auth_item_child` VALUES ('角色所有权限', '/admin/role/update');
INSERT INTO `auth_item_child` VALUES ('角色所有权限', '/admin/role/view');
INSERT INTO `auth_item_child` VALUES ('路由列表权限', '/admin/route/*');
INSERT INTO `auth_item_child` VALUES ('路由列表权限', '/admin/route/assign');
INSERT INTO `auth_item_child` VALUES ('路由列表权限', '/admin/route/create');
INSERT INTO `auth_item_child` VALUES ('路由列表权限', '/admin/route/index');
INSERT INTO `auth_item_child` VALUES ('路由列表权限', '/admin/route/refresh');
INSERT INTO `auth_item_child` VALUES ('路由列表权限', '/admin/route/remove');
INSERT INTO `auth_item_child` VALUES ('规则管理所有权限', '/admin/rule/*');
INSERT INTO `auth_item_child` VALUES ('规则管理所有权限', '/admin/rule/create');
INSERT INTO `auth_item_child` VALUES ('规则管理所有权限', '/admin/rule/delete');
INSERT INTO `auth_item_child` VALUES ('规则管理所有权限', '/admin/rule/index');
INSERT INTO `auth_item_child` VALUES ('规则管理所有权限', '/admin/rule/update');
INSERT INTO `auth_item_child` VALUES ('规则管理所有权限', '/admin/rule/view');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/*');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/activate');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/change-password');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/delete');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/index');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/login');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/logout');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/request-password-reset');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/reset-password');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/signup');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/admin/user/view');
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
INSERT INTO `auth_item_child` VALUES ('图书查看权限', '/book/view');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/debug/user/*');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/debug/user/reset-identity');
INSERT INTO `auth_item_child` VALUES ('用户列表所欲权限', '/debug/user/set-identity');
INSERT INTO `auth_item_child` VALUES ('管理员', '分配用户到角色');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书修改权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书删除权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书所有权限');
INSERT INTO `auth_item_child` VALUES ('一般用户', '图书新增权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书新增权限');
INSERT INTO `auth_item_child` VALUES ('一般用户', '图书查看权限');
INSERT INTO `auth_item_child` VALUES ('未登录用户', '图书查看权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '图书查看权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '权限列表所有权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '用户列表所欲权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '菜单列表所有权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '规则管理所有权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '角色所有权限');
INSERT INTO `auth_item_child` VALUES ('管理员', '路由列表权限');

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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('1', '我是admin，现在create book，图书编号001', '1.00', 'admin');
INSERT INTO `book` VALUES ('2', '我是admin，现在create book，图书编号002', '2.00', 'admin');
INSERT INTO `book` VALUES ('3', '我是admin，现在create book，图书编号003', '3.00', 'admin');
INSERT INTO `book` VALUES ('4', '我是test，现在create book，图书编号test-001', '1.00', 'test');

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '权限管理', null, '/admin/default/index', '1', null);
INSERT INTO `menu` VALUES ('2', '角色列表', null, '/admin/role/index', '2', 0x75736572);
INSERT INTO `menu` VALUES ('3', '权限列表', null, '/admin/permission/index', '3', null);
INSERT INTO `menu` VALUES ('4', '路由列表', null, '/admin/route/index', '4', null);
INSERT INTO `menu` VALUES ('5', '规则管理', null, '/admin/rule/index', '5', null);
INSERT INTO `menu` VALUES ('6', '分配用户到角色', null, '/admin/assignment/index', '6', 0x616E64726F6964);
INSERT INTO `menu` VALUES ('7', '菜单列表', null, '/admin/menu/index', '7', 0x66696C65);
INSERT INTO `menu` VALUES ('8', '用户列表', null, '/admin/user/index', '8', 0x7573657273);
INSERT INTO `menu` VALUES ('9', '图书列表', null, '/book/index', '9', 0x636F6C756D6E73);
INSERT INTO `menu` VALUES ('30', 'aaa', '6', '/book/index', null, 0x636172);
INSERT INTO `menu` VALUES ('31', 'bbb', '6', '/book/index', null, null);
INSERT INTO `menu` VALUES ('32', 'ccc', '6', '/book/index', null, null);

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
