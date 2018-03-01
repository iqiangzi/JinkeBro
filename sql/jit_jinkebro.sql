/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : jit_jinkebro

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2018-03-01 20:34:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jit_customer
-- ----------------------------
DROP TABLE IF EXISTS `jit_customer`;
CREATE TABLE `jit_customer` (
  `CustomerID` int(11) NOT NULL AUTO_INCREMENT,
  `WechatUserCode` varchar(100) NOT NULL,
  `Phone` varchar(11) DEFAULT NULL,
  `CustomerAccount` varchar(50) DEFAULT NULL,
  `CustomerUserName` varchar(45) DEFAULT NULL,
  `AreaID` int(11) DEFAULT NULL COMMENT '宿舍区域，比如南区、北区、xx区\n',
  `DormID` int(11) DEFAULT NULL COMMENT '哪一栋宿舍楼',
  `HouseNum` varchar(50) DEFAULT NULL,
  `BalanceNum` int(11) DEFAULT '0',
  `CreditPoint` int(11) DEFAULT '0' COMMENT '信用积分，一元等于1积分',
  `Sex` smallint(1) NOT NULL COMMENT '男女',
  `NickName` varchar(50) NOT NULL COMMENT '昵称',
  `MemberLevelID` int(11) DEFAULT '1' COMMENT '会员等级ID',
  `Country` varchar(50) DEFAULT NULL,
  `IsActive` smallint(1) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Memo` varchar(200) DEFAULT NULL,
  `Province` varchar(50) DEFAULT NULL,
  `Lon` double DEFAULT NULL COMMENT '经度',
  `Lat` double DEFAULT NULL COMMENT '纬度',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `CustomerID_UNIQUE` (`CustomerID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='客户表';

-- ----------------------------
-- Records of jit_customer
-- ----------------------------
INSERT INTO `jit_customer` VALUES ('1', 'oW6zYvw_cY7LxF-2RP2oFX9V2jXI', '', null, '', '1', '1', '', '0', '0', '1', '我是sun', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '118.893852', '31.90885', '2017-05-13 18:40:06');
INSERT INTO `jit_customer` VALUES ('2', 'oW6zYv5_5ZWBZkc87jIF9NUQTAC0', null, null, null, null, null, null, '0', '0', '1', '桑春铨', '1', null, '1', '2017-01-07 09:18:08', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('3', 'oW6zYv_xgJu0MbJrmM70X7blPpYo', null, null, null, null, null, null, '0', '0', '2', 'Megan', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '116.796143', '34.530331', null);
INSERT INTO `jit_customer` VALUES ('4', 'oW6zYv_Mrv33RXKKo8jagUzS44BE', null, null, null, null, null, null, '0', '0', '0', 'up_snail', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '121.33358', '31.394548', '2017-01-15 19:35:17');
INSERT INTO `jit_customer` VALUES ('5', 'oW6zYv6OvrhBMTRlG0E9etWYpEKk', null, null, null, null, null, null, '0', '0', '2', 'Lee豆豆', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '118.689705', '32.184914', '2017-03-24 16:28:48');
INSERT INTO `jit_customer` VALUES ('6', 'oW6zYv3-khozSXVIL9u2gx2DaNY8', null, null, null, null, null, null, '0', '0', '1', '小浩浩', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '118.895432', '31.910192', '2017-03-15 22:30:12');
INSERT INTO `jit_customer` VALUES ('7', 'oW6zYv8c1ENEBW6tRvCFq3VkLShM', null, null, null, null, null, null, '0', '0', '1', 'bitzo', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '118.893936', '31.908764', '2017-05-18 19:28:18');
INSERT INTO `jit_customer` VALUES ('8', 'oW6zYv_cbO7s1R5h45IjC7EUMLy8', '18621983356', null, 'snail', '1', '1', '402', '0', '0', '1', '大蜗牛', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '121.598495', '31.203045', '2017-03-17 17:18:14');
INSERT INTO `jit_customer` VALUES ('9', 'oW6zYv4SQMzjk1-Ygj6eVTqXSxaM', '13260905960', null, null, null, null, null, '0', '0', '1', 'Cecurio', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '120.590546', '32.363499', '2017-05-19 22:57:51');
INSERT INTO `jit_customer` VALUES ('10', 'oW6zYv1nk5qjGdgjRheX4Xg_njpc', null, null, null, null, null, null, '0', '0', '0', '丶给你微笑', '1', null, '1', '2017-01-07 09:18:08', null, null, null, '118.893852', '31.908649', null);
INSERT INTO `jit_customer` VALUES ('11', 'oW6zYv3F-uF_V-ZmqOQKugafboNE', null, null, null, null, null, null, '0', '0', '1', 'Oneday', '1', null, '1', '2017-01-07 14:25:52', null, null, null, '116.799187', '33.940372', null);
INSERT INTO `jit_customer` VALUES ('12', 'oW6zYv0NR7gLxAQam4cx97EYaaaE', null, null, null, null, null, null, '0', '0', '1', '杨GG', '1', null, '1', '2017-01-07 14:25:52', null, null, null, '118.893402', '31.908705', null);
INSERT INTO `jit_customer` VALUES ('13', 'oW6zYvxRg68-9EsHFryBlnACo6-Q', null, null, null, null, null, null, '0', '0', '1', 'Kaiux', '1', null, '1', '2017-01-07 14:25:52', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('14', 'oW6zYv-SGji5tmGSLSvjHbzyFXB8', null, null, null, null, null, null, '0', '0', '2', '- 刘潇洒    ', '1', null, '1', '2017-01-07 14:25:52', null, null, null, '118.893829', '31.90885', null);
INSERT INTO `jit_customer` VALUES ('15', 'oW6zYv0Gd37BPIP3iWiywfJF7KyU', null, null, null, null, null, null, '0', '0', '1', '必过425。', '1', null, '1', '2017-01-07 14:25:52', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('16', 'oW6zYv01eQgRubpjp3gCZqWYnBLU', null, null, null, null, null, null, '0', '0', '1', '阿邦', '1', null, '1', '2017-01-07 14:25:52', null, null, null, '118.882065', '32.08905', null);
INSERT INTO `jit_customer` VALUES ('17', 'oW6zYvz3MqvBCG3omsYHbAx2SpqE', null, null, null, null, null, null, '0', '0', '2', '鹿鹿', '1', null, '1', '2017-01-07 14:25:52', null, null, null, '118.893547', '31.908689', null);
INSERT INTO `jit_customer` VALUES ('18', 'oW6zYv9Qtb0WRozFxGf5BSBIg6cA', '13256865935', null, '吴彦祖', '1', '1', '256556', '0', '0', '1', '爱豆晖', '1', null, '1', '2017-01-07 14:25:52', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('19', 'oW6zYv5jr5l8DoOB2F376fqBoV2w', null, null, null, null, null, null, '0', '0', '1', '、i如莫', '1', null, '1', '2017-01-07 14:25:52', null, null, null, '118.894768', '31.91427', null);
INSERT INTO `jit_customer` VALUES ('20', 'oW6zYv4gfMpJ9IQ8Ug3SwJG8ULmo', null, null, null, null, null, null, '0', '0', '1', 'JustKiddingBaby', '1', null, '1', '2017-01-07 14:25:52', null, null, null, '118.893829', '31.908833', null);
INSERT INTO `jit_customer` VALUES ('21', 'oW6zYv4ixHhmqyVikpy8lx2XVf20', null, null, null, null, null, null, '0', '0', '1', 'Jason', '1', null, '1', '2017-01-07 14:43:20', null, null, null, '118.68969', '32.184925', '2017-03-24 16:16:24');
INSERT INTO `jit_customer` VALUES ('22', 'oW6zYvw4LkrWnZkxcTYcwfotc848', null, null, null, null, null, null, '0', '0', '1', 'Anx', '1', null, '1', '2017-01-07 14:45:21', null, null, null, '118.791672', '32.042122', null);
INSERT INTO `jit_customer` VALUES ('23', 'oW6zYv1MkGwmfn9VbPSNFIW7ewTk', null, null, null, null, null, null, '0', '0', '1', '张福臣', '1', null, '1', '2017-01-09 16:49:31', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('24', 'oW6zYv0VXkumAXscge4guoULPN2I', null, null, null, null, null, null, '0', '0', '0', '十七年蝉', '1', null, '1', '2017-01-09 16:49:31', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('25', 'oW6zYvwajhzwRPxrOGe5UJD_9XRs', null, null, null, null, null, null, '0', '0', '2', 'Doc_Hong', '1', null, '1', '2017-01-15 12:18:50', null, null, null, '121.333633', '31.394499', '2017-01-15 12:31:11');
INSERT INTO `jit_customer` VALUES ('27', 'oW6zYv0JuOi0-FG4bKVz-teB8KgA', null, null, null, null, null, null, '0', '0', '0', '初音未来', '1', null, '1', '2017-01-16 18:28:40', null, null, null, '120.114365', '31.547377', '2017-01-16 22:05:30');
INSERT INTO `jit_customer` VALUES ('28', 'oW6zYv6qW911Vq2DpOZPAbQSkM6w', null, null, null, null, null, null, '0', '0', '0', '光之百合华', '1', null, '1', '2017-01-17 12:44:42', null, null, null, '120.114464', '31.547337', '2017-01-19 20:21:14');
INSERT INTO `jit_customer` VALUES ('50', 'oW6zYvyyStq4kjHJfjLHGd6kYQdE', null, null, null, null, null, null, '0', '0', '1', '皮皮虾 ', '1', null, '1', '2017-03-04 11:40:39', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('51', 'oW6zYv3XVIk1pGfo7L4zkO4OCeEM', null, null, null, null, null, null, '0', '0', '1', '此昵称已被保护￡', '1', null, '1', '2017-05-02 19:51:01', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('52', 'oW6zYv0N6O3H63RwTrKkAEpf_RC4', null, null, null, null, null, null, '0', '0', '2', '王瑞', '1', null, '1', '2017-05-02 19:51:01', null, null, null, null, null, null);
INSERT INTO `jit_customer` VALUES ('53', 'oW6zYv_6ep2HC6FKUISsFNp6olnQ', null, null, null, null, null, null, '0', '0', '1', 'XS', '1', null, '1', '2017-05-02 19:51:01', null, null, null, '118.894897', '31.914148', '2017-05-02 20:31:40');
INSERT INTO `jit_customer` VALUES ('54', 'oW6zYvzf82_c6kC3mx5ueQfe4tPw', null, null, null, null, null, null, '0', '0', '1', 'WELL Tai', '1', null, '1', '2017-05-12 21:13:21', null, null, null, '118.897865', '31.903465', '2017-05-18 22:44:58');
INSERT INTO `jit_customer` VALUES ('55', 'oW6zYvzs-kMpARQEl7tjHaeOVUEk', null, null, null, null, null, null, '0', '0', '2', 'western·C', '1', null, '1', '2017-05-18 11:44:05', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for jit_message
-- ----------------------------
DROP TABLE IF EXISTS `jit_message`;
CREATE TABLE `jit_message` (
  `MessageID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MessageCommand` varchar(30) DEFAULT NULL,
  `MessageDesc` varchar(50) DEFAULT NULL,
  `MessageContent` varchar(1024) DEFAULT NULL,
  `IsActive` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`MessageID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jit_message
-- ----------------------------
INSERT INTO `jit_message` VALUES ('1', '帮助', '帮助', '点击[我要下单]，进入商城。点击[我]->[历史订单]查看历史订单。', '1');
INSERT INTO `jit_message` VALUES ('2', 'welcome', '欢迎关注', '欢迎来到金科小哥。回复[帮助]，查看内容。', '1');
INSERT INTO `jit_message` VALUES ('3', '看剧', '看电视剧', '那就看《人民的名义》吧！', '1');

-- ----------------------------
-- Table structure for jit_order
-- ----------------------------
DROP TABLE IF EXISTS `jit_order`;
CREATE TABLE `jit_order` (
  `OrderID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderTime` datetime NOT NULL COMMENT '下订单时间',
  `PayTime` datetime DEFAULT NULL COMMENT '付款时间',
  `DeliveryTime` datetime DEFAULT NULL COMMENT '配送时间',
  `PayMethod` tinyint(2) NOT NULL DEFAULT '1' COMMENT '付款方式，1:现金 2:微信支付',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1',
  `IsActive` tinyint(1) NOT NULL DEFAULT '1',
  `DeliveryUserID` int(11) DEFAULT NULL COMMENT '配送员id\n',
  `IsCancel` tinyint(1) DEFAULT NULL COMMENT '是否取消订单',
  `CancelTime` datetime DEFAULT NULL COMMENT '订单取消时间',
  `DiscountMoney` decimal(18,2) DEFAULT NULL COMMENT '打折金额',
  `DiscountType` tinyint(2) DEFAULT NULL COMMENT '打折类型',
  `BizID` int(11) DEFAULT NULL COMMENT '业务ID，预留的',
  `Memo` varchar(100) DEFAULT NULL COMMENT '订单备注',
  `IsCheck` tinyint(1) DEFAULT NULL COMMENT '是否审核',
  `PDate` datetime DEFAULT NULL COMMENT '分区索引',
  `OrderStatus` int(11) NOT NULL,
  PRIMARY KEY (`OrderID`)
) ENGINE=InnoDB AUTO_INCREMENT=556 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of jit_order
-- ----------------------------
INSERT INTO `jit_order` VALUES ('500', '2017-03-16 09:47:44', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('501', '2017-03-17 14:09:01', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('503', '2017-03-17 16:07:22', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('504', '2017-03-30 18:43:56', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('505', '2017-04-02 22:08:49', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('506', '2017-04-02 22:13:05', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('507', '2017-04-02 22:14:32', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('508', '2017-04-02 22:17:43', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('509', '2017-04-02 22:20:19', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('510', '2017-04-02 22:41:52', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('511', '2017-04-05 20:01:26', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('512', '2017-04-09 16:40:32', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('513', '2017-04-09 16:48:35', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('514', '2017-04-09 23:31:11', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('515', '2017-04-10 18:46:33', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('516', '2017-04-20 15:52:12', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('517', '2017-04-20 19:26:01', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('518', '2017-04-20 20:40:21', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('519', '2017-04-21 15:40:46', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('520', '2017-04-21 18:20:34', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('521', '2017-04-23 10:04:15', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('522', '2017-04-23 10:22:18', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('523', '2017-04-23 10:28:12', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('524', '2017-04-23 10:38:22', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('525', '2017-04-23 11:15:32', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('527', '2017-05-02 20:08:49', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('528', '2017-05-02 20:14:51', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('531', '2017-05-02 20:21:36', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('532', '2017-05-02 20:21:48', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('533', '2017-05-02 20:24:01', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('534', '2017-05-02 20:25:05', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('535', '2017-05-02 20:26:50', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('536', '2017-05-10 22:02:56', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('538', '2017-05-13 13:50:23', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('539', '2017-05-13 14:52:04', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('540', '2017-05-13 17:23:51', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('541', '2017-05-13 17:35:14', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('542', '2017-05-13 17:35:15', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('543', '2017-05-13 17:36:11', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('544', '2017-05-13 17:39:16', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '2');
INSERT INTO `jit_order` VALUES ('545', '2017-05-13 18:35:28', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('546', '2017-05-13 21:49:49', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('550', '2017-05-16 21:02:35', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('551', '2017-05-17 16:35:34', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('552', '2017-05-18 11:52:15', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '3');
INSERT INTO `jit_order` VALUES ('553', '2017-05-18 12:25:31', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('554', '2017-05-18 19:27:41', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');
INSERT INTO `jit_order` VALUES ('555', '2017-05-19 10:25:35', null, null, '1', '1', '1', null, null, null, null, null, null, null, null, null, '1');

-- ----------------------------
-- Table structure for jit_ordercustomer
-- ----------------------------
DROP TABLE IF EXISTS `jit_ordercustomer`;
CREATE TABLE `jit_ordercustomer` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `IsActive` tinyint(4) NOT NULL,
  `CreateTime` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jit_ordercustomer
-- ----------------------------
INSERT INTO `jit_ordercustomer` VALUES ('484', '8', '500', '1', '2017-03-16 09:47:44');
INSERT INTO `jit_ordercustomer` VALUES ('485', '21', '501', '1', '2017-03-17 14:09:01');
INSERT INTO `jit_ordercustomer` VALUES ('487', '1', '503', '1', '2017-03-17 16:07:23');
INSERT INTO `jit_ordercustomer` VALUES ('488', '2', '504', '1', '2017-03-30 18:43:56');
INSERT INTO `jit_ordercustomer` VALUES ('489', '2', '505', '1', '2017-04-02 22:08:49');
INSERT INTO `jit_ordercustomer` VALUES ('490', '2', '506', '1', '2017-04-02 22:13:05');
INSERT INTO `jit_ordercustomer` VALUES ('491', '2', '507', '1', '2017-04-02 22:14:32');
INSERT INTO `jit_ordercustomer` VALUES ('492', '2', '508', '1', '2017-04-02 22:17:43');
INSERT INTO `jit_ordercustomer` VALUES ('493', '2', '509', '1', '2017-04-02 22:20:20');
INSERT INTO `jit_ordercustomer` VALUES ('494', '2', '510', '1', '2017-04-02 22:41:52');
INSERT INTO `jit_ordercustomer` VALUES ('495', '2', '511', '1', '2017-04-05 20:01:26');
INSERT INTO `jit_ordercustomer` VALUES ('496', '2', '512', '1', '2017-04-09 16:40:32');
INSERT INTO `jit_ordercustomer` VALUES ('497', '2', '513', '1', '2017-04-09 16:48:35');
INSERT INTO `jit_ordercustomer` VALUES ('498', '2', '514', '1', '2017-04-09 23:31:11');
INSERT INTO `jit_ordercustomer` VALUES ('499', '2', '515', '1', '2017-04-10 18:46:33');
INSERT INTO `jit_ordercustomer` VALUES ('500', '7', '516', '1', '2017-04-20 15:52:12');
INSERT INTO `jit_ordercustomer` VALUES ('501', '2', '517', '1', '2017-04-20 19:26:01');
INSERT INTO `jit_ordercustomer` VALUES ('502', '1', '518', '1', '2017-04-20 20:40:21');
INSERT INTO `jit_ordercustomer` VALUES ('503', '2', '519', '1', '2017-04-21 15:40:46');
INSERT INTO `jit_ordercustomer` VALUES ('504', '2', '520', '1', '2017-04-21 18:20:34');
INSERT INTO `jit_ordercustomer` VALUES ('505', '2', '521', '1', '2017-04-23 10:04:15');
INSERT INTO `jit_ordercustomer` VALUES ('506', '2', '522', '1', '2017-04-23 10:22:18');
INSERT INTO `jit_ordercustomer` VALUES ('507', '2', '523', '1', '2017-04-23 10:28:12');
INSERT INTO `jit_ordercustomer` VALUES ('508', '2', '524', '1', '2017-04-23 10:38:22');
INSERT INTO `jit_ordercustomer` VALUES ('509', '2', '525', '1', '2017-04-23 11:15:32');
INSERT INTO `jit_ordercustomer` VALUES ('511', '1', '527', '1', '2017-05-02 20:08:49');
INSERT INTO `jit_ordercustomer` VALUES ('512', '1', '528', '1', '2017-05-02 20:14:51');
INSERT INTO `jit_ordercustomer` VALUES ('515', '2', '531', '1', '2017-05-02 20:21:36');
INSERT INTO `jit_ordercustomer` VALUES ('516', '53', '532', '1', '2017-05-02 20:21:48');
INSERT INTO `jit_ordercustomer` VALUES ('517', '53', '533', '1', '2017-05-02 20:24:01');
INSERT INTO `jit_ordercustomer` VALUES ('518', '53', '534', '1', '2017-05-02 20:25:05');
INSERT INTO `jit_ordercustomer` VALUES ('519', '53', '535', '1', '2017-05-02 20:26:50');
INSERT INTO `jit_ordercustomer` VALUES ('520', '2', '536', '1', '2017-05-10 22:02:56');
INSERT INTO `jit_ordercustomer` VALUES ('522', '2', '538', '1', '2017-05-13 13:50:24');
INSERT INTO `jit_ordercustomer` VALUES ('523', '2', '539', '1', '2017-05-13 14:52:04');
INSERT INTO `jit_ordercustomer` VALUES ('524', '1', '540', '1', '2017-05-13 17:23:51');
INSERT INTO `jit_ordercustomer` VALUES ('525', '1', '541', '1', '2017-05-13 17:35:14');
INSERT INTO `jit_ordercustomer` VALUES ('526', '1', '542', '1', '2017-05-13 17:35:15');
INSERT INTO `jit_ordercustomer` VALUES ('527', '2', '543', '1', '2017-05-13 17:36:11');
INSERT INTO `jit_ordercustomer` VALUES ('528', '1', '544', '1', '2017-05-13 17:39:17');
INSERT INTO `jit_ordercustomer` VALUES ('529', '1', '545', '1', '2017-05-13 18:35:28');
INSERT INTO `jit_ordercustomer` VALUES ('530', '54', '546', '1', '2017-05-13 21:49:49');
INSERT INTO `jit_ordercustomer` VALUES ('534', '9', '550', '1', '2017-05-16 21:02:35');
INSERT INTO `jit_ordercustomer` VALUES ('535', '9', '551', '1', '2017-05-17 16:35:34');
INSERT INTO `jit_ordercustomer` VALUES ('536', '9', '552', '1', '2017-05-18 11:52:15');
INSERT INTO `jit_ordercustomer` VALUES ('537', '9', '553', '1', '2017-05-18 12:25:31');
INSERT INTO `jit_ordercustomer` VALUES ('538', '9', '554', '1', '2017-05-18 19:27:41');
INSERT INTO `jit_ordercustomer` VALUES ('539', '9', '555', '1', '2017-05-19 10:25:35');

-- ----------------------------
-- Table structure for jit_orderdelivery
-- ----------------------------
DROP TABLE IF EXISTS `jit_orderdelivery`;
CREATE TABLE `jit_orderdelivery` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderID` int(11) NOT NULL COMMENT '订单ID',
  `DeliveryUserID` int(11) NOT NULL COMMENT '配送员ID',
  `DeliveryBeginTime` datetime DEFAULT NULL COMMENT '配送开始时间',
  `DeliveryEndTime` datetime DEFAULT NULL COMMENT '配送结束时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='订单对应的配送表';

-- ----------------------------
-- Records of jit_orderdelivery
-- ----------------------------
INSERT INTO `jit_orderdelivery` VALUES ('1', '1', '3', '2017-02-24 00:00:00', '2017-02-25 00:00:00');
INSERT INTO `jit_orderdelivery` VALUES ('2', '2', '44', '2017-02-23 09:56:42', '2017-02-23 19:17:38');
INSERT INTO `jit_orderdelivery` VALUES ('3', '3', '40', '2017-02-23 19:16:33', '2017-02-23 19:16:36');
INSERT INTO `jit_orderdelivery` VALUES ('4', '4', '44', '2017-02-23 18:07:43', '2017-02-23 18:10:41');
INSERT INTO `jit_orderdelivery` VALUES ('5', '6', '44', '2017-02-24 00:00:00', '2017-02-26 00:00:00');
INSERT INTO `jit_orderdelivery` VALUES ('6', '11', '45', '2017-02-24 00:00:00', '2017-02-26 00:00:00');
INSERT INTO `jit_orderdelivery` VALUES ('7', '10', '40', '2017-02-24 00:00:00', '2017-02-25 00:00:00');
INSERT INTO `jit_orderdelivery` VALUES ('8', '17', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('9', '16', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('10', '8', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('11', '9', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('12', '5', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('13', '19', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('14', '18', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('15', '15', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('16', '14', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('17', '13', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('18', '12', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('19', '25', '45', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('20', '24', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('21', '23', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('22', '22', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('23', '21', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('24', '20', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('25', '26', '45', '2017-03-22 20:22:58', '2017-03-22 20:23:02');
INSERT INTO `jit_orderdelivery` VALUES ('26', '27', '45', '2017-03-22 20:24:05', '2017-03-19 17:53:04');
INSERT INTO `jit_orderdelivery` VALUES ('27', '28', '45', '2017-03-22 20:24:14', '2017-03-22 20:24:23');
INSERT INTO `jit_orderdelivery` VALUES ('28', '29', '44', '2017-03-13 12:24:33', null);
INSERT INTO `jit_orderdelivery` VALUES ('29', '31', '44', '2017-03-13 12:23:20', '2017-02-25 15:03:33');
INSERT INTO `jit_orderdelivery` VALUES ('30', '30', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('31', '33', '40', '2017-03-13 12:09:30', '2017-02-25 14:56:00');
INSERT INTO `jit_orderdelivery` VALUES ('32', '41', '30', '2017-03-13 12:09:26', '2017-03-13 12:29:59');
INSERT INTO `jit_orderdelivery` VALUES ('33', '42', '45', '2017-03-13 12:06:38', null);
INSERT INTO `jit_orderdelivery` VALUES ('34', '516', '45', '2017-04-20 16:02:35', '2017-04-20 16:02:38');
INSERT INTO `jit_orderdelivery` VALUES ('35', '518', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('36', '521', '54', '2017-04-23 10:11:05', '2017-04-23 10:11:09');
INSERT INTO `jit_orderdelivery` VALUES ('37', '524', '54', '2017-04-23 10:39:50', '2017-04-23 10:39:55');
INSERT INTO `jit_orderdelivery` VALUES ('38', '525', '54', '2017-04-23 11:18:48', '2017-04-23 11:18:51');
INSERT INTO `jit_orderdelivery` VALUES ('39', '523', '45', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('40', '522', '44', null, null);
INSERT INTO `jit_orderdelivery` VALUES ('41', '527', '54', '2017-05-02 20:14:33', '2017-05-02 20:14:35');
INSERT INTO `jit_orderdelivery` VALUES ('42', '532', '45', '2017-05-02 20:23:36', '2017-05-02 20:23:38');
INSERT INTO `jit_orderdelivery` VALUES ('43', '531', '54', '2017-05-02 20:23:40', '2017-05-02 20:23:42');
INSERT INTO `jit_orderdelivery` VALUES ('44', '528', '54', '2017-05-02 20:23:44', '2017-05-02 20:23:45');
INSERT INTO `jit_orderdelivery` VALUES ('45', '533', '54', '2017-05-02 20:24:47', '2017-05-02 20:24:49');
INSERT INTO `jit_orderdelivery` VALUES ('46', '534', '45', '2017-05-02 20:25:47', '2017-05-02 20:25:49');
INSERT INTO `jit_orderdelivery` VALUES ('47', '535', '54', '2017-05-02 20:27:44', '2017-05-02 20:27:46');
INSERT INTO `jit_orderdelivery` VALUES ('48', '551', '54', '2017-05-18 00:00:00', '2017-05-18 00:00:00');
INSERT INTO `jit_orderdelivery` VALUES ('49', '552', '45', '2017-05-18 11:55:01', '2017-05-18 11:55:04');

-- ----------------------------
-- Table structure for jit_orderproduct
-- ----------------------------
DROP TABLE IF EXISTS `jit_orderproduct`;
CREATE TABLE `jit_orderproduct` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderID` int(11) NOT NULL COMMENT '订单ID',
  `ProductID` int(11) NOT NULL COMMENT '商品ID',
  `ProductName` varchar(50) DEFAULT NULL COMMENT '考虑到商品名称不会变化，所以冗余在这',
  `ProductCount` int(11) NOT NULL COMMENT '订购商品的数量',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=557 DEFAULT CHARSET=utf8 COMMENT='订单对应的商品关系表';

-- ----------------------------
-- Records of jit_orderproduct
-- ----------------------------
INSERT INTO `jit_orderproduct` VALUES ('1', '1', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('2', '1', '2', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('3', '1', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('4', '2', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('5', '2', '2', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('6', '2', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('7', '3', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('8', '3', '2', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('9', '3', '3', null, '9');
INSERT INTO `jit_orderproduct` VALUES ('10', '4', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('11', '4', '2', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('12', '4', '3', null, '9');
INSERT INTO `jit_orderproduct` VALUES ('13', '5', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('14', '6', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('15', '8', '8', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('16', '9', '8', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('17', '10', '8', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('18', '11', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('19', '12', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('20', '13', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('21', '14', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('22', '15', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('23', '16', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('24', '17', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('25', '18', '1', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('26', '19', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('27', '20', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('28', '21', '8', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('29', '22', '2', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('30', '23', '2', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('31', '24', '2', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('32', '25', '2', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('33', '26', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('34', '27', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('35', '28', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('36', '29', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('37', '30', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('38', '31', '6', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('39', '32', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('40', '32', '6', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('41', '33', '9', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('42', '34', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('43', '35', '4', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('44', '36', '4', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('45', '37', '4', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('46', '38', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('47', '39', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('48', '40', '4', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('49', '41', '1', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('50', '42', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('51', '43', '3', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('52', '44', '1', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('53', '45', '1', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('54', '49', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('96', '104', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('97', '105', '2', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('98', '106', '1', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('105', '112', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('106', '113', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('107', '114', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('108', '115', '5', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('109', '116', '5', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('110', '117', '5', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('111', '118', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('112', '119', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('113', '120', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('114', '121', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('115', '122', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('116', '123', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('117', '124', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('118', '125', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('119', '126', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('120', '127', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('121', '128', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('122', '129', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('123', '130', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('124', '131', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('125', '132', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('126', '133', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('127', '134', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('128', '135', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('129', '136', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('130', '137', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('131', '138', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('132', '139', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('133', '140', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('134', '141', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('135', '142', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('136', '143', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('137', '144', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('138', '145', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('139', '146', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('140', '147', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('141', '148', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('142', '149', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('143', '150', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('144', '151', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('145', '152', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('146', '153', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('147', '154', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('148', '155', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('149', '156', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('150', '157', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('151', '158', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('152', '159', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('153', '160', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('154', '161', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('155', '162', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('156', '163', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('157', '164', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('158', '165', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('159', '166', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('160', '167', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('161', '168', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('162', '169', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('163', '170', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('164', '171', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('165', '172', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('166', '173', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('167', '174', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('168', '175', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('169', '176', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('170', '177', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('171', '178', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('172', '179', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('173', '180', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('174', '181', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('175', '182', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('176', '183', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('177', '184', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('178', '185', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('179', '186', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('180', '187', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('181', '189', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('182', '188', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('183', '190', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('184', '191', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('185', '192', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('186', '193', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('187', '194', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('188', '195', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('189', '196', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('190', '197', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('191', '198', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('192', '200', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('193', '199', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('194', '201', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('195', '202', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('196', '203', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('197', '204', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('198', '205', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('199', '206', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('200', '207', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('201', '208', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('202', '209', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('203', '210', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('204', '211', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('205', '212', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('206', '213', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('207', '214', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('208', '215', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('209', '216', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('210', '217', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('211', '218', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('212', '219', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('213', '220', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('214', '221', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('215', '222', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('216', '223', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('217', '224', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('218', '225', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('219', '226', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('220', '227', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('221', '228', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('222', '229', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('223', '230', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('224', '231', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('225', '232', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('226', '233', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('227', '234', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('228', '235', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('229', '236', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('230', '237', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('231', '238', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('232', '239', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('233', '240', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('234', '241', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('235', '242', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('236', '243', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('237', '244', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('238', '245', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('239', '246', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('240', '247', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('241', '248', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('242', '249', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('243', '250', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('244', '251', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('245', '252', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('246', '253', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('247', '254', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('248', '255', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('249', '256', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('250', '257', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('251', '258', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('252', '259', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('253', '260', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('254', '261', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('255', '262', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('256', '263', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('257', '264', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('258', '265', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('259', '266', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('260', '267', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('261', '268', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('262', '269', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('263', '270', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('264', '271', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('265', '272', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('266', '273', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('267', '274', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('268', '275', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('269', '276', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('270', '277', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('271', '278', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('272', '279', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('273', '280', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('274', '281', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('275', '282', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('276', '283', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('277', '284', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('278', '285', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('279', '286', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('280', '287', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('281', '288', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('282', '289', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('283', '290', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('284', '291', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('285', '292', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('286', '293', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('287', '294', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('288', '295', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('289', '296', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('290', '297', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('291', '298', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('292', '299', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('293', '300', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('294', '301', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('295', '302', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('296', '303', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('297', '304', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('298', '305', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('299', '306', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('300', '307', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('301', '308', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('302', '309', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('303', '310', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('304', '311', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('305', '312', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('306', '313', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('307', '314', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('308', '315', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('309', '316', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('310', '317', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('311', '318', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('312', '319', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('313', '320', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('314', '321', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('315', '322', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('316', '323', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('317', '324', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('318', '325', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('319', '326', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('320', '327', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('321', '328', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('322', '329', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('323', '330', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('324', '331', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('325', '332', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('326', '333', '5', null, '5');
INSERT INTO `jit_orderproduct` VALUES ('327', '334', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('328', '335', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('329', '336', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('330', '337', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('331', '338', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('332', '339', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('333', '340', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('334', '341', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('335', '342', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('336', '343', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('337', '344', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('338', '345', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('339', '346', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('340', '347', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('341', '348', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('342', '349', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('343', '350', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('344', '351', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('345', '352', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('346', '353', '4', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('347', '354', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('348', '355', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('349', '356', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('350', '357', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('351', '358', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('352', '359', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('353', '360', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('354', '361', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('355', '362', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('356', '363', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('357', '364', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('358', '365', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('359', '366', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('360', '367', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('361', '368', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('362', '369', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('363', '370', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('364', '371', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('365', '372', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('366', '373', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('367', '374', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('368', '375', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('369', '376', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('370', '377', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('371', '378', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('372', '379', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('373', '380', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('374', '381', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('375', '382', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('376', '383', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('377', '384', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('378', '385', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('379', '386', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('380', '387', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('381', '388', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('382', '389', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('383', '390', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('384', '391', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('385', '392', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('386', '393', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('387', '394', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('388', '395', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('389', '396', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('390', '397', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('391', '398', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('392', '399', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('393', '400', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('394', '401', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('395', '402', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('396', '403', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('397', '404', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('398', '405', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('399', '406', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('400', '407', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('401', '408', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('402', '409', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('403', '410', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('404', '411', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('405', '412', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('406', '413', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('407', '414', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('408', '415', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('409', '416', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('410', '417', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('411', '418', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('412', '419', '3', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('413', '420', '7', null, '7');
INSERT INTO `jit_orderproduct` VALUES ('414', '421', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('415', '422', '7', null, '7');
INSERT INTO `jit_orderproduct` VALUES ('416', '423', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('417', '424', '3', null, '4');
INSERT INTO `jit_orderproduct` VALUES ('418', '425', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('419', '426', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('420', '427', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('421', '428', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('422', '429', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('423', '430', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('424', '431', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('425', '432', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('426', '433', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('427', '434', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('428', '435', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('429', '436', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('430', '437', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('431', '438', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('432', '439', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('433', '440', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('434', '441', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('435', '442', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('436', '443', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('437', '444', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('438', '445', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('441', '448', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('442', '449', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('444', '451', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('445', '452', '3', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('447', '454', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('450', '457', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('451', '458', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('452', '459', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('453', '460', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('454', '461', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('470', '477', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('471', '478', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('472', '479', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('473', '480', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('474', '481', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('475', '482', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('476', '483', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('477', '484', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('478', '485', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('479', '486', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('480', '487', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('481', '488', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('482', '489', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('483', '490', '9', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('484', '491', '4', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('486', '493', '4', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('487', '494', '4', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('488', '495', '5', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('490', '497', '5', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('491', '498', '10', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('492', '498', '5', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('493', '499', '10', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('494', '500', '10', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('495', '501', '10', null, '10');
INSERT INTO `jit_orderproduct` VALUES ('497', '503', '6', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('498', '504', '12', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('499', '505', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('500', '506', '2', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('501', '507', '6', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('502', '508', '7', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('503', '509', '12', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('504', '510', '12', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('505', '510', '11', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('506', '511', '1', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('507', '512', '7', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('508', '512', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('509', '513', '8', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('510', '513', '7', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('511', '513', '2', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('512', '513', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('513', '514', '1', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('514', '515', '7', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('515', '516', '16', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('516', '516', '17', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('517', '517', '16', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('518', '517', '17', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('519', '518', '15', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('520', '519', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('521', '520', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('522', '521', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('523', '522', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('524', '523', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('525', '524', '16', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('526', '525', '15', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('528', '527', '24', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('529', '528', '25', null, '12');
INSERT INTO `jit_orderproduct` VALUES ('532', '531', '24', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('533', '532', '15', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('534', '533', '19', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('535', '534', '15', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('536', '535', '20', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('537', '536', '24', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('539', '538', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('540', '539', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('541', '540', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('542', '541', '15', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('543', '542', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('544', '543', '15', null, '2');
INSERT INTO `jit_orderproduct` VALUES ('545', '544', '18', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('546', '545', '15', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('547', '546', '15', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('551', '550', '24', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('552', '551', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('553', '552', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('554', '553', '15', null, '1');
INSERT INTO `jit_orderproduct` VALUES ('555', '554', '15', null, '3');
INSERT INTO `jit_orderproduct` VALUES ('556', '555', '15', null, '1');

-- ----------------------------
-- Table structure for jit_product
-- ----------------------------
DROP TABLE IF EXISTS `jit_product`;
CREATE TABLE `jit_product` (
  `ProductID` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `SKU` varchar(50) NOT NULL,
  `ProductName` varchar(50) NOT NULL COMMENT '商品名称',
  `ProductDesc` varchar(200) DEFAULT NULL COMMENT '商品描述',
  `ProductImgPath` varchar(200) DEFAULT NULL COMMENT '商品图片路径',
  `ExpireTime` datetime NOT NULL COMMENT '有效期',
  `ProducTime` datetime NOT NULL COMMENT '生产日期',
  `SupplierID` int(11) NOT NULL COMMENT '供应商ID',
  `ProductTypeID` int(11) NOT NULL COMMENT '商品类型：饮料，水果等',
  `ProductPrice` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `OnSale` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE KEY `ProductID_UNIQUE` (`ProductID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='商品表';

-- ----------------------------
-- Records of jit_product
-- ----------------------------
INSERT INTO `jit_product` VALUES ('15', 'JK1320025220015', '老坛酸菜', null, 'imgs/uploads/JK1320025220003.jpg', '2017-05-28 00:00:00', '2017-04-01 00:00:00', '21', '23', '4.50', '1');
INSERT INTO `jit_product` VALUES ('16', 'JK1320025220016', '优乐美', null, 'imgs/uploads/JK1320025220009.jpg', '2017-05-28 00:00:00', '2017-03-17 00:00:00', '46', '24', '1.80', '0');
INSERT INTO `jit_product` VALUES ('18', 'JK1320025220018', '红烧牛肉面', null, 'imgs/uploads/JK1320025220002.jpg', '2017-06-09 00:00:00', '2017-03-17 00:00:00', '46', '26', '3.50', '0');
INSERT INTO `jit_product` VALUES ('24', 'JK1320025220024', '卫龙', null, 'imgs/uploads/JK1320025220001.jpg', '2017-05-31 00:00:00', '2017-03-17 00:00:00', '46', '32', '0.50', '0');
INSERT INTO `jit_product` VALUES ('25', 'JK1320025220025', '可口可乐330ml', null, 'imgs/uploads/JK1320025220025.jpg', '2017-05-31 00:00:00', '2017-04-14 00:00:00', '48', '33', '3.00', '1');
INSERT INTO `jit_product` VALUES ('26', 'JK1320025220026', '猪肉铺', null, 'imgs/uploads/JK1320025220026.jpg', '2017-05-28 00:00:00', '2017-05-04 00:00:00', '53', '34', '12.18', '0');

-- ----------------------------
-- Table structure for jit_productstock
-- ----------------------------
DROP TABLE IF EXISTS `jit_productstock`;
CREATE TABLE `jit_productstock` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductID` int(11) NOT NULL COMMENT '商品ID',
  `TotalNum` int(11) NOT NULL DEFAULT '0' COMMENT '总量',
  `StockAreaID` int(11) NOT NULL COMMENT '货位，对应的是这笔库存存放的位置',
  `CreateUserID` int(11) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `EditUserID` int(11) DEFAULT NULL,
  `EditTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_productid` (`ProductID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='商品库存表';

-- ----------------------------
-- Records of jit_productstock
-- ----------------------------
INSERT INTO `jit_productstock` VALUES ('15', '15', '34', '95', '1', '2017-04-20 10:10:51', '1970117', '2017-04-21 14:56:15');
INSERT INTO `jit_productstock` VALUES ('16', '16', '14', '95', '1', '2017-04-20 15:39:13', '1970117', '2017-04-23 10:10:09');
INSERT INTO `jit_productstock` VALUES ('18', '18', '132', '94', '1', '2017-04-20 15:44:48', '1970140', '2017-05-17 23:10:26');
INSERT INTO `jit_productstock` VALUES ('24', '24', '43', '95', '1', '2017-04-20 15:49:14', '1970136', '2017-05-18 11:54:16');
INSERT INTO `jit_productstock` VALUES ('25', '25', '188', '94', '1970117', '2017-04-21 15:45:39', null, null);

-- ----------------------------
-- Table structure for jit_productype
-- ----------------------------
DROP TABLE IF EXISTS `jit_productype`;
CREATE TABLE `jit_productype` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductTypeName` varchar(50) DEFAULT NULL COMMENT '商品类别名称',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='商品类型表';

-- ----------------------------
-- Records of jit_productype
-- ----------------------------
INSERT INTO `jit_productype` VALUES ('23', '500g桶装');
INSERT INTO `jit_productype` VALUES ('24', '225ml杯装');
INSERT INTO `jit_productype` VALUES ('26', '106克桶装');
INSERT INTO `jit_productype` VALUES ('32', '10g袋装');
INSERT INTO `jit_productype` VALUES ('33', '330ml罐装');
INSERT INTO `jit_productype` VALUES ('34', '20小袋装');

-- ----------------------------
-- Table structure for jit_staff
-- ----------------------------
DROP TABLE IF EXISTS `jit_staff`;
CREATE TABLE `jit_staff` (
  `StaffID` int(11) NOT NULL AUTO_INCREMENT,
  `StaffName` varchar(50) NOT NULL COMMENT '真实姓名',
  `StaffType` int(2) unsigned NOT NULL COMMENT '1、供货商 2、配送者3、管理者',
  `Phone` varchar(11) NOT NULL COMMENT '员工电话',
  `Sex` smallint(1) NOT NULL,
  `Position` varchar(50) DEFAULT NULL COMMENT '职位',
  `CreateTime` datetime NOT NULL,
  `LeaveTime` datetime DEFAULT NULL,
  `IsActive` smallint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`StaffID`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jit_staff
-- ----------------------------
INSERT INTO `jit_staff` VALUES ('1', '供货小哥1', '1', '13260905960', '1', '经理', '2017-02-18 09:42:55', null, '1');
INSERT INTO `jit_staff` VALUES ('2', '供货小哥2', '1', '13260905960', '2', '普通员工', '2017-02-18 09:43:58', null, '1');
INSERT INTO `jit_staff` VALUES ('39', '配送小哥19', '2', '13260905935', '1', '普通员工', '2017-02-18 01:42:55', '2017-02-22 14:57:13', '0');
INSERT INTO `jit_staff` VALUES ('40', '配送小哥20', '2', '13260905936', '1', '普通员工', '2017-02-18 01:42:55', null, '0');
INSERT INTO `jit_staff` VALUES ('41', '仓库管理员1', '3', '13260905569', '2', '普通员工', '2017-02-20 00:13:52', '2017-02-22 20:21:16', '1');
INSERT INTO `jit_staff` VALUES ('42', '单凯', '3', '13260905960', '1', '普通员工', '2017-02-21 00:00:00', null, '1');
INSERT INTO `jit_staff` VALUES ('43', '奶茶妹妹', '1', '1237823812', '1', '经理', '2017-02-22 00:02:55', null, '1');
INSERT INTO `jit_staff` VALUES ('44', '刘强东', '2', '2134234545', '2', '普通员工', '2017-02-22 00:04:15', null, '1');
INSERT INTO `jit_staff` VALUES ('45', '王卫', '2', '13260905520', '1', '经理', '2017-02-22 00:00:00', null, '1');
INSERT INTO `jit_staff` VALUES ('46', 'Trump', '1', '13260905960', '1', '经理', '2017-02-22 00:00:00', null, '1');
INSERT INTO `jit_staff` VALUES ('47', '希拉里', '1', '13260905960', '2', '经理', '2017-02-22 00:00:00', null, '1');
INSERT INTO `jit_staff` VALUES ('48', '埃隆马斯克', '3', '13260905960', '1', '经理', '2017-02-22 00:00:00', null, '1');
INSERT INTO `jit_staff` VALUES ('49', '孙茂昀', '3', '13260906602', '1', '普通员工', '2017-03-03 00:00:00', '2017-03-03 00:00:00', '1');
INSERT INTO `jit_staff` VALUES ('50', 'shankai1996', '1', '13260905960', '1', '经理', '2017-03-09 17:03:33', '2017-03-09 17:03:33', '0');
INSERT INTO `jit_staff` VALUES ('51', '王小六', '1', '13260905960', '1', '经理', '2017-03-13 00:00:00', null, '1');
INSERT INTO `jit_staff` VALUES ('52', '尤小右', '1', '13260905960', '1', '经理', '2017-03-13 00:00:00', null, '1');
INSERT INTO `jit_staff` VALUES ('53', '朴灵', '1', '13260905960', '1', '经理', '2017-03-22 18:35:33', null, '1');
INSERT INTO `jit_staff` VALUES ('54', '码云', '2', '13260905960', '1', '经理', '2017-04-21 15:47:09', null, '1');
INSERT INTO `jit_staff` VALUES ('55', '马化腾', '1', '13256901234', '1', '经理', '2017-04-23 10:12:25', '2017-04-23 10:12:36', '0');
INSERT INTO `jit_staff` VALUES ('56', '侯亮平', '3', '13256780987', '1', '经理', '2017-05-18 09:50:50', null, '1');
