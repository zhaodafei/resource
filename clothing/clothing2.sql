/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : clothing2

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-01-18 17:45:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_belong
-- ----------------------------
DROP TABLE IF EXISTS `t_belong`;
CREATE TABLE `t_belong` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `s_province` varchar(20) DEFAULT NULL,
  `s_city` varchar(20) DEFAULT NULL,
  `s_county` varchar(20) DEFAULT NULL,
  `school` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_code
-- ----------------------------
DROP TABLE IF EXISTS `t_code`;
CREATE TABLE `t_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mxs` int(11) DEFAULT NULL,
  `ms` int(11) DEFAULT NULL,
  `mm` int(11) DEFAULT NULL,
  `ml` int(11) DEFAULT NULL,
  `mxl` int(11) DEFAULT NULL,
  `mxxl` int(11) DEFAULT NULL,
  `mxxxl` int(11) DEFAULT NULL,
  `totalCount` int(11) DEFAULT NULL COMMENT '总数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_delivery
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery`;
CREATE TABLE `t_delivery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ss_province` varchar(25) DEFAULT NULL COMMENT '省',
  `ss_city` varchar(25) DEFAULT NULL,
  `ss_county` varchar(25) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `way` varchar(20) DEFAULT NULL,
  `personName` varchar(25) DEFAULT NULL,
  `relationPhone` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_fashion
-- ----------------------------
DROP TABLE IF EXISTS `t_fashion`;
CREATE TABLE `t_fashion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fashionName` varchar(255) DEFAULT NULL COMMENT '款式名称',
  `createTime` date DEFAULT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `orderId` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '订单Id',
  `customName` varchar(25) DEFAULT NULL COMMENT '客户姓名',
  `className` varchar(255) DEFAULT NULL COMMENT '单位(班级)',
  `phoneNumber` varchar(25) DEFAULT NULL COMMENT '电话号码',
  `qq` varchar(25) DEFAULT NULL,
  `fashionName` varchar(100) DEFAULT NULL COMMENT '款式名称',
  `color` varchar(20) DEFAULT NULL,
  `otherFashion` varchar(255) DEFAULT NULL COMMENT '其他款式',
  `codeId` int(11) DEFAULT NULL COMMENT '尺码id',
  `money` varchar(25) DEFAULT NULL COMMENT '成交金额',
  `earnest` varchar(255) DEFAULT NULL COMMENT '定金',
  `print` varchar(255) DEFAULT NULL COMMENT '印制说明',
  `getOrderDate` date DEFAULT NULL COMMENT '接单日期',
  `sendDate` date DEFAULT NULL COMMENT '发货日期',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `deliveryId` int(11) DEFAULT NULL COMMENT '配送货物Id',
  `createDate` date DEFAULT NULL COMMENT '创建时间',
  `endReason` varchar(255) DEFAULT NULL COMMENT '终止原因',
  `endDate` date DEFAULT NULL COMMENT '终止时间',
  `belongId` int(11) DEFAULT NULL COMMENT '订单归属地Id',
  `status` tinyint(4) DEFAULT NULL COMMENT '订单状态',
  `orderNumber` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`orderId`),
  KEY `fashionId` (`fashionName`),
  KEY `codeId` (`codeId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) DEFAULT NULL,
  `passWord` varchar(20) DEFAULT NULL,
  `realName` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `permission` int(11) DEFAULT NULL COMMENT '权限',
  `department` varchar(50) DEFAULT NULL COMMENT '部门',
  `enterTime` datetime DEFAULT NULL COMMENT '入职时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
