/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : jit_sfms

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2018-03-01 20:34:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jit_financeinfo
-- ----------------------------
DROP TABLE IF EXISTS `jit_financeinfo`;
CREATE TABLE `jit_financeinfo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FIName` varchar(45) DEFAULT NULL COMMENT '财务名称',
  `FIType` varchar(45) DEFAULT NULL COMMENT '财务类型',
  `InOutType` varchar(45) DEFAULT NULL COMMENT '收入支出类型',
  `FIPrice` varchar(45) DEFAULT NULL COMMENT '财务金额',
  `ProjectId` int(11) DEFAULT NULL COMMENT '项目ID',
  `UserId` int(11) DEFAULT NULL COMMENT '用户ID',
  `UserName` varchar(45) DEFAULT NULL COMMENT '用户名称',
  `CreateTime` varchar(45) DEFAULT NULL COMMENT '新建时间',
  `OperateUser` varchar(45) DEFAULT NULL COMMENT '操作用户',
  `CheckTime` varchar(45) DEFAULT NULL COMMENT '审核时间',
  `CheckUser` int(11) DEFAULT NULL COMMENT '审核用户',
  `FIStatu` varchar(45) DEFAULT NULL COMMENT '状态',
  `Remark` varchar(45) DEFAULT NULL COMMENT '备注',
  `IsActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 COMMENT='财务信息表';

-- ----------------------------
-- Records of jit_financeinfo
-- ----------------------------
INSERT INTO `jit_financeinfo` VALUES ('141', '图书', '12', '14', '72', '188', '1970090', '谢俊逸', '2017-04-12 21:06:05', '谢俊逸', '2017-04-13 21:15:56', '1970089', '通过', 'OS X 与iOS 内核编程', '1');
INSERT INTO `jit_financeinfo` VALUES ('142', 'Head first 设计模式', '12', '14', '55.48', '188', '1970083', '单凯', '2017-04-23 18:26:00', '单凯', '2017-05-03 07:25:48', '1', '通过', '图书购买', '1');
INSERT INTO `jit_financeinfo` VALUES ('143', '图书', '12', '14', '101', '190', '1970101', '王瑞', '2017-05-03 18:54:24', '王瑞', null, null, '待审核', '两本关于需求的书，一本需求工程，骆斌著，高等教育出版社\n另一本是UML面向对象需求分析', '1');

-- ----------------------------
-- Table structure for jit_kpiinfo
-- ----------------------------
DROP TABLE IF EXISTS `jit_kpiinfo`;
CREATE TABLE `jit_kpiinfo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KPIName` varchar(45) DEFAULT NULL COMMENT 'KPI名称',
  `KPIClass` varchar(45) DEFAULT NULL COMMENT 'KPI类型',
  `KPIScore` varchar(45) DEFAULT NULL COMMENT 'KPI值',
  `ProjectId` int(11) DEFAULT NULL COMMENT '项目',
  `UserId` int(11) DEFAULT NULL COMMENT '用户ID',
  `UserName` varchar(45) DEFAULT NULL COMMENT '用户名称',
  `CreateTime` datetime DEFAULT NULL COMMENT '新增时间',
  `OperateUser` varchar(45) DEFAULT NULL COMMENT '操作用户',
  `CheckTime` datetime DEFAULT NULL COMMENT '审核时间',
  `CheckUser` varchar(45) DEFAULT NULL COMMENT '审核用户',
  `KPIStatus` varchar(45) DEFAULT NULL COMMENT 'KPI状态',
  `Remark` varchar(45) DEFAULT NULL COMMENT '备注',
  `IsActive` tinyint(1) NOT NULL,
  `KPIType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='绩效信息表';

-- ----------------------------
-- Records of jit_kpiinfo
-- ----------------------------
INSERT INTO `jit_kpiinfo` VALUES ('1', '金科小哥项目', '10', '1', '184', '1970084', '孙茂昀', '2017-04-21 12:13:06', '1970084', '2017-05-03 07:28:07', '1', '通过', '结项', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('2', '金科小哥项目', '10', '3', '184', '1970084', '孙茂昀', '2017-04-21 12:13:24', '1970084', '2017-05-03 07:28:18', '1', '通过', '参赛', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('3', 'SFMS 绩效', '16', '1', '185', '1970087', '李静波', '2017-04-22 15:24:22', '1970087', '2017-04-23 18:14:32', '1970086', '通过', '无', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('4', 'SFMS 绩效', '16', '3', '185', '1970087', '李静波', '2017-04-22 15:24:29', '1970087', '2017-04-23 18:14:58', '1970086', '通过', '无', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('5', '绩效', '16', '1', '185', '1970094', '朱浩', '2017-04-23 18:14:03', '1970094', '2017-04-23 18:14:45', '1970086', '通过', '无', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('6', '绩效', '16', '3', '185', '1970094', '朱浩', '2017-04-23 18:14:07', '1970094', '2017-04-23 18:14:52', '1970086', '通过', '无', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('7', '绩效', '16', '1', '185', '1970090', '谢俊逸', '2017-04-23 18:16:57', '1970090', '2017-04-23 18:17:24', '1970086', '通过', '无', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('8', '绩效', '16', '3', '185', '1970090', '谢俊逸', '2017-04-23 18:17:01', '1970090', '2017-04-23 18:17:33', '1970086', '通过', '无', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('9', '绩效', '16', '3', '184', '1970083', '单凯', '2017-04-23 18:27:31', '1970083', '2017-05-03 07:29:57', '1970084', '通过', '无', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('10', '绩效', '16', '1', '184', '1970083', '单凯', '2017-04-23 18:27:45', '1970083', '2017-05-03 07:30:21', '1970084', '通过', '无', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('11', 'SFMS绩效', '10', '1', '185', '1970086', '石玉龙', '2017-04-23 20:54:49', '1970086', '2017-05-03 07:27:21', '1', '通过', '项目结项', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('12', 'SFMS绩效', '10', '3', '185', '1970086', '石玉龙', '2017-04-23 20:54:57', '1970086', '2017-05-03 07:27:36', '1', '通过', '项目参赛', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('14', '教学', '16', '1', '189', '1970083', '单凯', '2017-04-23 20:57:36', '1970083', '2017-05-03 07:29:45', '1970084', '通过', '教授后端nodejs', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('15', '后端教学', '16', '1', '189', '1970086', '石玉龙', '2017-04-23 20:58:21', '1970086', '2017-05-03 07:30:09', '1970084', '通过', '后端教学', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('16', '朱浩', '16', '1', '189', '1970094', '朱浩', '2017-04-24 21:38:18', '1970094', '2017-05-03 07:29:34', '1970084', '通过', '123', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('17', '无', '10', '1', '191', '1970093', '刘佳玮', '2017-05-03 18:54:51', '1970093', null, null, '待审核', '自行车', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('18', '奋斗的小鸟', '16', '2', '192', '1970085', '马晓晗', '2017-05-04 16:48:48', '1970085', '2017-05-08 18:07:05', '1970084', '通过', '奋斗的小鸟 结项 参赛 分', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('19', '奋斗的小鸟', '16', '1', '192', '1970099', '黄佳晴', '2017-05-04 19:21:34', '1970099', '2017-05-08 18:08:56', '1970084', '通过', '负责闹钟的功能和界面', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('20', '奋斗的小鸟', '16', '1', '192', '1970102', '徐森', '2017-05-04 19:11:11', '1970102', '2017-05-08 18:06:03', '1970084', '通过', '123', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('21', '奋斗的小鸟', '16', '1', '192', '1970102', '徐森', '2017-05-04 19:15:01', '1970102', '2017-05-08 18:08:04', '1970084', '通过', '写后端', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('22', '奋斗的小鸟', '16', '1', '192', '1970099', '黄佳晴', '2017-05-04 19:22:15', '1970099', '2017-05-08 18:05:29', '1970084', '通过', '负责闹钟', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('23', '志愿者管理系统', '16', '1', '190', '1970101', '王瑞', '2017-05-04 21:18:39', '1970101', '2017-05-08 18:08:39', '1970084', '通过', '负责ui，需求分析和uml建模', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('24', '奋斗的小鸟', '16', '1', '192', '1970101', '王瑞', '2017-05-04 22:55:37', '1970101', '2017-05-08 18:08:25', '1970084', '通过', '需求分析及uml建模，后期ppt制作', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('25', '志愿者服务系统', '16', '1', '190', '1970101', '王瑞', '2017-05-05 15:23:12', '1970101', '2017-05-08 18:04:52', '1970084', '通过', '负责uml建模', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('26', '奋斗的小鸟', '16', '1', '192', '1970101', '王瑞', '2017-05-05 15:27:21', '1970101', '2017-05-08 18:05:10', '1970084', '通过', '负责需求分析uml建模，自己后期推广的ppt.制作', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('27', '前端的方向教学', '10', '1', '189', '1970084', '孙茂昀', '2017-05-08 18:13:46', '1970084', null, null, '待审核', '前端的方向教学', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('28', '奋斗的小鸟', '16', '2', '194', '1970085', '马晓晗', '2017-05-08 20:33:56', '1970085', '2017-05-09 07:43:00', '1970084', '通过', '奋斗的小鸟 开发 参赛', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('29', '奋斗的小鸟', '16', '2', '194', '1970099', '黄佳晴', '2017-05-08 20:35:36', '1970099', '2017-05-09 07:41:32', '1970084', '通过', '奋斗的小鸟  开发  参赛', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('30', '奋斗的小鸟', '16', '1', '194', '1970101', '王瑞', '2017-05-08 20:51:13', '1970101', '2017-05-09 07:54:11', '1970084', '通过', '主要做奋斗的小鸟需求分析和uml建模，以及后期宣传用的ppt', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('31', '奋斗的小鸟', '16', '1', '194', '1970101', '王瑞', '2017-05-08 20:54:13', '1970101', '2017-05-09 07:48:26', '1970084', '通过', '负责需求分析和uml建模', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('32', '志愿者管理系统', '16', '1', '195', '1970101', '王瑞', '2017-05-08 20:55:17', '1970101', null, null, '待审核', '主要负责需求工程的分析以及uml建模，图形界面和布局', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('33', '志愿者管理系统', '16', '1', '195', '1970101', '王瑞', '2017-05-08 20:55:28', '1970101', '2017-05-09 07:48:12', '1970084', '通过', '主要负责需求工程的分析以及uml建模，图形界面和布局', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('34', '志愿者管理系统', '16', '1', '195', '1970101', '王瑞', '2017-05-08 20:56:29', '1970101', null, null, '待审核', '主要负责需求工程的分析以及uml建模，图形界面和布局', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('35', '志愿者管理系统', '16', '1', '195', '1970085', '马晓晗', '2017-05-09 08:04:57', '1970085', '2017-05-09 08:06:05', '1970084', '通过', 'ui设计', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('36', '名奋斗的小鸟v1.0', '16', '1', '194', '1970102', '徐森', '2017-05-08 22:09:50', '1970102', '2017-05-09 07:42:04', '1970084', '通过', '后端编写，结项绩效，参加计算机设计大赛', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('37', '名奋斗的小鸟v1.0', '16', '1', '194', '1970102', '徐森', '2017-05-08 22:10:56', '1970102', '2017-05-09 07:44:41', '1970084', '通过', '后端编写，结项绩效，参加计算机设计大赛', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('38', '实验室管理系统基础模块的用户后端编写', '16', '1', '185', '1970084', '孙茂昀', '2017-05-09 08:13:08', '1970084', '2017-05-09 09:25:54', '1970086', '通过', '基础模块的结项', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('39', '志愿者管理系统的需求文档', '10', '1', '195', '1970084', '孙茂昀', '2017-05-09 08:15:04', '1970084', '2017-05-09 08:16:59', '1970084', '通过', '此项目暂时以需求定稿结束算结束', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('40', '金科小哥结项', '16', '1', '184', '1970086', '石玉龙', '2017-05-09 09:29:49', '1970086', '2017-05-09 09:31:15', '1970084', '通过', '金科小哥结项', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('41', '金科小哥参赛', '16', '3', '184', '1970086', '石玉龙', '2017-05-09 09:30:06', '1970086', '2017-05-09 09:31:23', '1970084', '通过', '金科小哥参赛', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('42', 'SFMS参赛', '16', '3', '185', '1970084', '孙茂昀', '2017-05-09 09:30:48', '1970084', '2017-05-09 09:33:04', '1970086', '通过', 'SFMS参赛', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('43', 'SFMS结项', '16', '1', '185', '1970083', '单凯', '2017-05-09 09:32:07', '1970083', '2017-05-09 09:33:14', '1970086', '通过', 'SFMS结项', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('44', 'SFMS参赛', '16', '3', '185', '1970083', '单凯', '2017-05-09 09:32:34', '1970083', '2017-05-09 09:33:09', '1970086', '通过', 'SFMS参赛', '1', '107');
INSERT INTO `jit_kpiinfo` VALUES ('45', '金科小哥结项', '16', '1', '184', '1970087', '李静波', '2017-05-09 09:34:44', '1970087', '2017-05-09 09:35:31', '1970084', '通过', '金科小哥结项', '1', '106');
INSERT INTO `jit_kpiinfo` VALUES ('46', '金科小哥参赛', '16', '3', '184', '1970087', '李静波', '2017-05-09 09:35:03', '1970087', '2017-05-09 09:35:43', '1970084', '通过', '金科小哥参赛', '1', '107');

-- ----------------------------
-- Table structure for jit_message
-- ----------------------------
DROP TABLE IF EXISTS `jit_message`;
CREATE TABLE `jit_message` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MessageTitle` varchar(100) NOT NULL,
  `MessageContent` varchar(300) NOT NULL,
  `CreateUserID` int(11) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `IsActive` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jit_message
-- ----------------------------
INSERT INTO `jit_message` VALUES ('13', '有关参赛作品提交的通知', '请各位项目管理人员在这周末前完成有关各大赛的报名工作！请勿拖延！', '1970093', '刘佳玮', '2017-05-03 18:53:05', '1');

-- ----------------------------
-- Table structure for jit_projectbaseinfo
-- ----------------------------
DROP TABLE IF EXISTS `jit_projectbaseinfo`;
CREATE TABLE `jit_projectbaseinfo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProjectName` varchar(45) DEFAULT NULL COMMENT '项目名称',
  `ProjectDesc` varchar(45) DEFAULT NULL COMMENT '项目描述',
  `ProjectManageID` varchar(45) DEFAULT NULL COMMENT '项目主负责人',
  `ProjectManageName` varchar(45) DEFAULT NULL COMMENT '项目主负责人姓名',
  `ProjectEndTime` datetime DEFAULT NULL COMMENT '项目截止时间',
  `ProjectTimeLine` varchar(45) DEFAULT NULL COMMENT '项目进度',
  `CreateTime` varchar(45) DEFAULT NULL COMMENT '创建时间',
  `OperateUser` varchar(45) DEFAULT NULL COMMENT '创建用户',
  `EditTime` datetime DEFAULT NULL COMMENT '修改时间',
  `EditUser` varchar(45) DEFAULT NULL COMMENT '修改用户',
  `ProjectStatus` varchar(45) DEFAULT NULL COMMENT '项目状态',
  `ProjectPrice` varchar(45) DEFAULT NULL COMMENT '项目经费',
  `IsActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8 COMMENT='项目基础信息表';

-- ----------------------------
-- Records of jit_projectbaseinfo
-- ----------------------------
INSERT INTO `jit_projectbaseinfo` VALUES ('184', '金科小哥', '实现校园内快递等最后100米的运输', '1970084', '孙茂昀', '2017-04-20 00:00:00', '待完成', '2017-03-08 20:32:27', '孙茂昀', '2017-04-19 10:27:54', '孙茂昀', '结项', '0', '1');
INSERT INTO `jit_projectbaseinfo` VALUES ('185', '实验室管理系统', '实验室自己使用的一套管理系统', '1970086', '石玉龙', '2017-05-06 00:00:00', '完成', '2017-03-08 20:34:12', '石玉龙', '2017-05-04 16:31:19', '石玉龙', '结项', '0', '1');
INSERT INTO `jit_projectbaseinfo` VALUES ('188', '实验室基础项目', '用于基础项目，便于成员的基础绩效、与项目无关的财务申请。', '1970084', '孙茂昀', '2017-04-16 00:00:00', '完成', '2017-04-12 20:18:01', 'snail', '2017-04-15 14:25:13', 'snail', '结项', '0', '1');
INSERT INTO `jit_projectbaseinfo` VALUES ('189', '方向教学', '进行中', '1970084', '孙茂昀', '2017-06-09 00:00:00', '第一周', '2017-04-23 20:51:36', '1970084', '2017-04-23 20:51:36', '1970084', '待完成', '0', '1');
INSERT INTO `jit_projectbaseinfo` VALUES ('190', '志愿者管理系统', '无', '1970084', '孙茂昀', '2018-01-31 00:00:00', '0', '2017-04-27 16:15:11', '孙茂昀', '2017-04-27 16:16:31', '孙茂昀', '待完成', '10000', '0');
INSERT INTO `jit_projectbaseinfo` VALUES ('192', '奋斗的小鸟', '无', '1970084', '孙茂昀', '2017-05-31 00:00:00', '完成', '2017-05-04 08:59:11', '1970084', '2017-05-04 08:59:11', '1970084', '结项', '112', '0');
INSERT INTO `jit_projectbaseinfo` VALUES ('193', '服务外包大赛-课程考评系统', '第八届服务外包大赛，A类，蓝鸥IT教育课程考评系统', '1970086', '石玉龙', '2017-09-20 00:00:00', '0', '2017-05-04 16:39:22', '1970093', '2017-05-04 16:39:22', '1970093', '待完成', '0', '1');
INSERT INTO `jit_projectbaseinfo` VALUES ('194', '奋斗的小鸟v1.0', '项目的经费为伪数据', '1970084', '孙茂昀', '2017-05-09 00:00:00', '完成', '2017-05-08 18:29:34', '1970084', '2017-05-08 18:29:34', '1970084', '结项', '1', '1');
INSERT INTO `jit_projectbaseinfo` VALUES ('195', '志愿者管理系统v1.0', '正在进行中', '1970084', '孙茂昀', '2017-10-20 00:00:00', '需求阶段', '2017-05-08 18:35:26', '孙茂昀', '2017-05-08 18:59:06', '孙茂昀', '结项', '10000', '1');
INSERT INTO `jit_projectbaseinfo` VALUES ('196', '鲨鱼 is watching you', '后台可完成用户信息管理，个人作品上传管理，管理员统筹，播放下载，个人站点建立的音乐翻唱网站', '1970093', '刘佳玮', '2017-05-09 00:00:00', '完成', '2017-05-08 22:21:57', '1970093', '2017-05-08 22:21:57', '1970093', '结项', '1500', '1');

-- ----------------------------
-- Table structure for jit_projectremark
-- ----------------------------
DROP TABLE IF EXISTS `jit_projectremark`;
CREATE TABLE `jit_projectremark` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProjectID` int(11) DEFAULT NULL,
  `ProjectName` varchar(45) DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  `UserName` varchar(45) DEFAULT NULL,
  `Remark` varchar(200) DEFAULT NULL,
  `CreateTime` varchar(45) DEFAULT NULL,
  `EditTime` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目参与人员,对项目的备注信息.(每天完成什么,那一块有疑问)';

-- ----------------------------
-- Records of jit_projectremark
-- ----------------------------

-- ----------------------------
-- Table structure for jit_projectruser
-- ----------------------------
DROP TABLE IF EXISTS `jit_projectruser`;
CREATE TABLE `jit_projectruser` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProjectName` varchar(45) DEFAULT NULL COMMENT '项目名称',
  `ProjectID` int(11) DEFAULT NULL COMMENT '项目id',
  `UserID` int(11) DEFAULT NULL COMMENT '用户id\n',
  `UserName` varchar(45) DEFAULT NULL COMMENT '用户名称',
  `CreateTime` datetime DEFAULT NULL COMMENT '新增时间',
  `OperateUser` varchar(45) DEFAULT NULL COMMENT '操作用户',
  `EditName` varchar(45) DEFAULT NULL COMMENT '修改用户',
  `EditTime` datetime DEFAULT NULL COMMENT '修改时间',
  `Duty` varchar(45) DEFAULT NULL COMMENT '职责',
  `IsActive` varchar(45) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8 COMMENT='项目参与人员关系表';

-- ----------------------------
-- Records of jit_projectruser
-- ----------------------------
INSERT INTO `jit_projectruser` VALUES ('404', '金科小哥', '184', '1970083', '单凯', '2017-03-08 20:32:27', '孙茂昀', '孙茂昀', '2017-03-08 20:32:27', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('405', '金科小哥', '184', '1970084', '孙茂昀', '2017-03-08 20:32:27', '孙茂昀', '孙茂昀', '2017-03-08 20:32:27', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('406', '金科小哥', '184', '1970086', '石玉龙', '2017-03-08 20:32:27', '孙茂昀', '孙茂昀', '2017-03-08 20:32:27', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('407', '金科小哥', '184', '1970087', '李静波', '2017-03-08 20:32:27', '孙茂昀', '孙茂昀', '2017-03-08 20:32:27', '前端', '1');
INSERT INTO `jit_projectruser` VALUES ('408', '实验室管理系统', '185', '1970086', '石玉龙', '2017-03-08 20:34:12', '石玉龙', '石玉龙', '2017-03-08 20:34:12', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('409', '实验室管理系统', '185', '1970083', '单凯', '2017-03-08 20:34:12', '石玉龙', '石玉龙', '2017-03-08 20:34:12', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('410', '实验室管理系统', '185', '1970084', '孙茂昀', '2017-03-08 20:34:12', '石玉龙', '石玉龙', '2017-03-08 20:34:12', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('411', '实验室管理系统', '185', '1970087', '李静波', '2017-03-08 20:34:12', '石玉龙', '石玉龙', '2017-03-08 20:34:12', '前端', '1');
INSERT INTO `jit_projectruser` VALUES ('412', '实验室管理系统', '185', '1970097', '杨雪梅', '2017-03-08 20:34:12', '石玉龙', '石玉龙', '2017-03-08 20:34:12', '前端', '1');
INSERT INTO `jit_projectruser` VALUES ('413', '实验室管理系统', '185', '1970094', '朱浩', '2017-03-08 20:34:12', '石玉龙', '石玉龙', '2017-03-08 20:34:12', '安卓', '1');
INSERT INTO `jit_projectruser` VALUES ('414', '实验室管理系统', '185', '1970090', '谢俊逸', '2017-03-08 20:34:12', '石玉龙', '石玉龙', '2017-03-08 20:34:12', 'IOS', '1');
INSERT INTO `jit_projectruser` VALUES ('418', '实验室基础项目', '188', '1970083', '单凯', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('419', '实验室基础项目', '188', '1970084', '孙茂昀', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('420', '实验室基础项目', '188', '1970085', '马晓晗', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('421', '实验室基础项目', '188', '1970086', '石玉龙', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('422', '实验室基础项目', '188', '1970087', '李静波', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('423', '实验室基础项目', '188', '1970088', '王晨曦', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('424', '实验室基础项目', '188', '1970090', '谢俊逸', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('425', '实验室基础项目', '188', '1970091', '李云飞', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('426', '实验室基础项目', '188', '1970092', '毛晖', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('427', '实验室基础项目', '188', '1970093', '刘佳玮', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('428', '实验室基础项目', '188', '1970094', '朱浩', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('429', '实验室基础项目', '188', '1970095', '虞李凯', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('430', '实验室基础项目', '188', '1970096', '谷文军', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('431', '实验室基础项目', '188', '1970097', '杨雪梅', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('432', '实验室基础项目', '188', '1970098', '于俊', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('433', '实验室基础项目', '188', '1970099', '黄佳晴', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('434', '实验室基础项目', '188', '1970100', '付丽', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('435', '实验室基础项目', '188', '1970101', '王瑞', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('436', '实验室基础项目', '188', '1970102', '徐森', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('437', '实验室基础项目', '188', '1970104', '银鹏', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('439', '实验室基础项目', '188', '1970112', '刘启暘', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('440', '实验室基础项目', '188', '1970113', '蒋苏豪', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('441', '实验室基础项目', '188', '1970114', '刘涛', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('443', '实验室基础项目', '188', '1970116', '石俊杰', '2017-04-12 20:18:01', '洪蕾', '洪蕾', '2017-04-12 20:18:01', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('444', '实验室基础项目', '188', '1970105', '郭浩楠', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('446', '实验室基础项目', '188', '1970113', '蒋苏豪', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('449', '实验室基础项目', '188', '1970116', '石俊杰', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('450', '实验室基础项目', '188', '1970125', '张凯', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('451', '实验室基础项目', '188', '1970126', '蒋双庆', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('452', '实验室基础项目', '188', '1970127', '窦钰博', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('453', '实验室基础项目', '188', '1970128', '钱黎磊', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('454', '实验室基础项目', '188', '1970129', '陈凯', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('455', '实验室基础项目', '188', '1970130', '袁敏强', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('456', '实验室基础项目', '188', '1970131', '龚则慧', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('457', '实验室基础项目', '188', '1970132', '吴中诚', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('458', '实验室基础项目', '188', '1970133', '王力平', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('459', '实验室基础项目', '188', '1970134', '沈磊', '2017-04-15 14:25:13', 'snail', 'snail', '2017-04-15 14:25:13', '成员', '1');
INSERT INTO `jit_projectruser` VALUES ('460', '方向教学', '189', '1970084', '孙茂昀', '2017-04-23 20:51:36', '孙茂昀', '孙茂昀', '2017-04-23 20:51:36', '前端', '1');
INSERT INTO `jit_projectruser` VALUES ('461', '方向教学', '189', '1970090', '谢俊逸', '2017-04-23 20:51:36', '孙茂昀', '孙茂昀', '2017-04-23 20:51:36', 'IOS', '1');
INSERT INTO `jit_projectruser` VALUES ('462', '方向教学', '189', '1970094', '朱浩', '2017-04-23 20:51:36', '孙茂昀', '孙茂昀', '2017-04-23 20:51:36', '安卓', '1');
INSERT INTO `jit_projectruser` VALUES ('463', '方向教学', '189', '1970086', '石玉龙', '2017-04-23 20:51:36', '孙茂昀', '孙茂昀', '2017-04-23 20:51:36', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('464', '方向教学', '189', '1970083', '单凯', '2017-04-23 20:51:36', '孙茂昀', '孙茂昀', '2017-04-23 20:51:36', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('465', '志愿者管理系统', '190', '1970085', '马晓晗', '2017-04-27 16:15:11', '孙茂昀', '孙茂昀', '2017-04-27 16:15:11', 'UI', '1');
INSERT INTO `jit_projectruser` VALUES ('466', '志愿者管理系统', '190', '1970101', '王瑞', '2017-04-27 16:16:31', '孙茂昀', '孙茂昀', '2017-04-27 16:16:31', '文档', '1');
INSERT INTO `jit_projectruser` VALUES ('467', 'temp', '191', '1970093', '刘佳玮', '2017-05-03 18:54:26', '刘佳玮', '刘佳玮', '2017-05-03 18:54:26', '全栈', '1');
INSERT INTO `jit_projectruser` VALUES ('468', '奋斗的小鸟', '192', '1970085', '马晓晗', '2017-05-04 08:59:11', '孙茂昀', '孙茂昀', '2017-05-04 08:59:11', '安卓', '1');
INSERT INTO `jit_projectruser` VALUES ('469', '奋斗的小鸟', '192', '1970102', '徐森', '2017-05-04 08:59:11', '孙茂昀', '孙茂昀', '2017-05-04 08:59:11', '安卓', '1');
INSERT INTO `jit_projectruser` VALUES ('470', '奋斗的小鸟', '192', '1970099', '黄佳晴', '2017-05-04 08:59:11', '孙茂昀', '孙茂昀', '2017-05-04 08:59:11', '安卓', '1');
INSERT INTO `jit_projectruser` VALUES ('471', '奋斗的小鸟', '192', '1970101', '王瑞', '2017-05-04 08:59:11', '孙茂昀', '孙茂昀', '2017-05-04 08:59:11', '文档', '1');
INSERT INTO `jit_projectruser` VALUES ('472', '服务外包大赛-课程考评系统', '193', '1970086', '石玉龙', '2017-05-04 16:39:23', '石玉龙', '石玉龙', '2017-05-04 16:39:23', '前端+后端', '1');
INSERT INTO `jit_projectruser` VALUES ('473', '服务外包大赛-课程考评系统', '193', '1970083', '单凯', '2017-05-04 16:39:23', '石玉龙', '石玉龙', '2017-05-04 16:39:23', '前端+后端', '1');
INSERT INTO `jit_projectruser` VALUES ('474', '服务外包大赛-课程考评系统', '193', '1970112', '刘启暘', '2017-05-04 16:39:23', '石玉龙', '石玉龙', '2017-05-04 16:39:23', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('475', '服务外包大赛-课程考评系统', '193', '1970133', '王力平', '2017-05-04 16:39:23', '石玉龙', '石玉龙', '2017-05-04 16:39:23', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('476', '服务外包大赛-课程考评系统', '193', '1970134', '沈磊', '2017-05-04 16:39:23', '石玉龙', '石玉龙', '2017-05-04 16:39:23', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('477', '服务外包大赛-课程考评系统', '193', '1970135', '李莉', '2017-05-04 16:39:23', '石玉龙', '石玉龙', '2017-05-04 16:39:23', '后端', '1');
INSERT INTO `jit_projectruser` VALUES ('478', '奋斗的小鸟v1.0', '194', '1970085', '马晓晗', '2017-05-08 18:29:34', '孙茂昀', '孙茂昀', '2017-05-08 18:29:34', '安卓前端编写', '1');
INSERT INTO `jit_projectruser` VALUES ('479', '奋斗的小鸟v1.0', '194', '1970102', '徐森', '2017-05-08 18:29:34', '孙茂昀', '孙茂昀', '2017-05-08 18:29:34', '后端的编写', '1');
INSERT INTO `jit_projectruser` VALUES ('480', '奋斗的小鸟v1.0', '194', '1970099', '黄佳晴', '2017-05-08 18:29:34', '孙茂昀', '孙茂昀', '2017-05-08 18:29:34', '闹钟的响铃', '1');
INSERT INTO `jit_projectruser` VALUES ('481', '奋斗的小鸟v1.0', '194', '1970101', '王瑞', '2017-05-08 18:29:34', '孙茂昀', '孙茂昀', '2017-05-08 18:29:34', '文档的编写', '1');
INSERT INTO `jit_projectruser` VALUES ('482', '志愿者管理系统v1.0', '195', '1970101', '王瑞', '2017-05-08 18:35:27', '孙茂昀', '孙茂昀', '2017-05-08 18:35:27', '文档编写', '1');
INSERT INTO `jit_projectruser` VALUES ('483', '志愿者管理系统v1.0', '195', '1970085', '马晓晗', '2017-05-08 18:59:06', '孙茂昀', '孙茂昀', '2017-05-08 18:59:06', 'ui设计', '1');
INSERT INTO `jit_projectruser` VALUES ('484', '鲨鱼 is watching you', '196', '1970093', '刘佳玮', '2017-05-08 22:21:57', '刘佳玮', '刘佳玮', '2017-05-08 22:21:57', '后端', '1');

-- ----------------------------
-- Table structure for jit_signinfo
-- ----------------------------
DROP TABLE IF EXISTS `jit_signinfo`;
CREATE TABLE `jit_signinfo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) DEFAULT NULL,
  `UserAgent` varchar(45) DEFAULT NULL,
  `Longitude` varchar(45) DEFAULT NULL,
  `Latitude` varchar(45) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `Remark` varchar(45) DEFAULT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `MAC` varchar(50) DEFAULT NULL,
  `SignType` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=876 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jit_signinfo
-- ----------------------------
INSERT INTO `jit_signinfo` VALUES ('350', '1970084', 'Android', '118.898439', '31.906528', '2017-03-05 13:01:09', null, '192.168.50.84', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('351', '1970084', 'Android', '118.898439', '31.906528', '2017-03-05 13:01:12', null, '192.168.50.84', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('352', '1970084', 'Android', '118.89846842447916', '31.906463216145834', '2017-03-05 13:01:39', null, '192.168.50.84', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('353', '1970086', 'Android', '118.89845', '31.906499', '2017-03-05 13:02:08', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('357', '1970084', 'Android', '118.89843', '31.906529', '2017-03-05 19:37:18', null, '192.168.50.84', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('358', '1970084', 'Android', '118.89843', '31.906529', '2017-03-05 19:37:19', null, '192.168.50.84', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('359', '1970086', 'Android', '118.89843', '31.906516', '2017-03-05 19:50:17', null, '192.168.50.115', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('360', '1970092', 'Android', '118.898469', '31.906534', '2017-03-05 19:51:20', null, '192.168.50.115', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('361', '1970092', 'Android', '118.898445', '31.906544', '2017-03-05 19:51:23', null, '192.168.50.115', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('362', '1970084', 'Android', '118.898469', '31.906546', '2017-03-05 19:51:39', null, '192.168.50.84', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('363', '1970084', 'Android', '118.89847547743055', '31.906421983506945', '2017-03-05 19:52:23', null, '192.168.50.84', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('364', '1970094', 'Android', '118.898463', '31.906536', '2017-03-05 19:59:46', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('365', '1970094', 'Android', '118.898463', '31.906536', '2017-03-05 20:00:01', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('366', '1970094', 'Android', '0.0', '0.0', '2017-03-05 20:00:22', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('367', '1970094', 'Android', '0.0', '0.0', '2017-03-05 20:00:25', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('368', '1970094', 'Android', '118.898476', '31.90654', '2017-03-05 20:00:36', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('369', '1970094', 'Android', '118.898476', '31.90654', '2017-03-05 20:00:38', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('370', '1970094', 'Android', '118.898457', '31.906552', '2017-03-05 20:08:50', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('371', '1970094', 'Android', '118.898459', '31.906539', '2017-03-05 20:08:52', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('372', '1970094', 'Android', '118.898459', '31.906539', '2017-03-05 20:09:04', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('373', '1970094', 'Android', '118.89846', '31.906534', '2017-03-05 20:09:38', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('374', '1970094', 'Android', '118.89846', '31.906534', '2017-03-05 20:09:40', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('375', '1970094', 'Android', '118.898447', '31.90654', '2017-03-05 20:09:49', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('376', '1970094', 'Android', '118.89846', '31.906534', '2017-03-05 20:09:50', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('377', '1970094', 'Android', '118.898467', '31.906546', '2017-03-05 20:16:31', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('378', '1970094', 'Android', '118.898467', '31.906546', '2017-03-05 20:16:32', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('379', '1970094', 'Android', '118.898468', '31.906551', '2017-03-05 20:21:48', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('380', '1970094', 'Android', '118.898453', '31.906531', '2017-03-05 20:22:03', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('381', '1970094', 'Android', '118.898453', '31.906531', '2017-03-05 20:22:06', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('382', '1970094', 'Android', '118.898453', '31.906531', '2017-03-05 20:22:13', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('383', '1970094', 'Android', '118.898468', '31.906551', '2017-03-05 20:22:28', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('384', '1970094', 'Android', '118.898468', '31.906551', '2017-03-05 20:22:30', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('385', '1970094', 'Android', '118.898468', '31.906551', '2017-03-05 20:22:31', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('386', '1970094', 'Android', '118.898468', '31.906551', '2017-03-05 20:22:32', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('387', '1970094', 'Android', '118.898457', '31.90655', '2017-03-05 20:22:40', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('388', '1970094', 'Android', '118.898457', '31.90655', '2017-03-05 20:22:42', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('389', '1970094', 'Android', '118.898462', '31.906548', '2017-03-05 20:31:14', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('390', '1970094', 'Android', '118.898465', '31.906535', '2017-03-05 20:33:11', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('391', '1970094', 'Android', '118.898473', '31.906555', '2017-03-05 20:33:15', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('392', '1970094', 'Android', '118.898473', '31.906555', '2017-03-05 20:33:17', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('393', '1970094', 'Android', '118.898473', '31.906555', '2017-03-05 20:33:19', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('394', '1970094', 'Android', '118.898473', '31.906555', '2017-03-05 20:33:20', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('395', '1970094', 'Android', '118.898452', '31.906538', '2017-03-05 20:34:28', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('396', '1970094', 'Android', '118.898452', '31.906538', '2017-03-05 20:34:29', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('397', '1970094', 'Android', '118.89835042317708', '31.90648220486111', '2017-03-05 20:43:52', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('398', '1970094', 'Android', '118.89860080295139', '31.90655056423611', '2017-03-05 20:56:47', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('399', '1970086', 'Android', '0.0', '0.0', '2017-03-05 21:01:12', null, '192.168.199.113', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('400', '1970094', 'Android', '118.898445', '31.90655', '2017-03-05 21:01:39', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('401', '1970094', 'Android', '118.898445', '31.90655', '2017-03-05 21:01:40', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('402', '1970094', 'Android', '118.898445', '31.90655', '2017-03-05 21:01:49', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('403', '1970094', 'Android', '118.898445', '31.90655', '2017-03-05 21:01:51', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('404', '1970094', 'Android', '118.898456', '31.906544', '2017-03-05 21:01:57', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('405', '1970094', 'Android', '118.898456', '31.906544', '2017-03-05 21:01:59', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('406', '1970094', 'Android', '118.898456', '31.906544', '2017-03-05 21:02:01', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('407', '1970094', 'Android', '118.898445', '31.90655', '2017-03-05 21:02:09', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('408', '1970086', 'Android', '118.898448', '31.906521', '2017-03-05 21:02:37', null, '192.168.199.113', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('409', '1970094', 'Android', '118.89845', '31.906531', '2017-03-05 21:03:03', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('410', '1970094', 'Android', '118.89847', '31.906552', '2017-03-05 21:04:43', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('411', '1970094', 'Android', '118.89847', '31.906552', '2017-03-05 21:04:47', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('412', '1970094', 'Android', '118.898436', '31.906528', '2017-03-05 21:05:06', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('413', '1970094', 'Android', '118.898472', '31.906538', '2017-03-05 21:08:55', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('414', '1970094', 'Android', '118.898472', '31.906538', '2017-03-05 21:08:57', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('415', '1970094', 'Android', '118.898472', '31.906538', '2017-03-05 21:09:00', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('416', '1970094', 'Android', '118.898481', '31.906539', '2017-03-05 21:09:02', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('417', '1970094', 'Android', '118.898464', '31.906531', '2017-03-05 21:09:41', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('418', '1970094', 'Android', '118.898464', '31.906531', '2017-03-05 21:09:43', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('419', '1970094', 'Android', '118.898457', '31.906531', '2017-03-05 21:10:23', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('420', '1970094', 'Android', '118.898457', '31.906531', '2017-03-05 21:10:24', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('421', '1970094', 'Android', '118.898457', '31.906531', '2017-03-05 21:10:26', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('422', '1970094', 'Android', '118.898457', '31.906531', '2017-03-05 21:10:30', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('423', '1970094', 'Android', '118.898472', '31.906537', '2017-03-05 21:11:33', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('424', '1970084', 'Android', '118.898431', '31.906532', '2017-03-05 23:59:59', null, '10.71.164.195', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('425', '1970084', 'Android', '118.898431', '31.906532', '2017-03-06 18:53:06', null, '10.71.164.195', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('426', '1970084', 'Android', '118.898431', '31.906532', '2017-03-06 18:53:10', null, '10.71.164.195', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('427', '1970084', 'Android', '118.898431', '31.906532', '2017-03-06 18:53:11', null, '10.71.164.195', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('428', '1970084', 'Android', '118.898431', '31.906532', '2017-03-06 18:53:12', null, '10.71.164.195', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('429', '1970084', 'Android', '118.898431', '31.906532', '2017-03-06 18:53:15', null, '10.71.164.195', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('430', '1970086', 'Android', '118.898444', '31.906506', '2017-03-06 18:55:42', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('431', '1', 'iOS', '0.000000', '0.000000', '2017-03-06 19:05:27', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('432', '1', 'iOS', '118.898745', '31.906603', '2017-03-06 19:05:31', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('433', '1', 'iOS', '118.898745', '31.906603', '2017-03-06 19:05:33', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('434', '1', 'iOS', '118.898745', '31.906603', '2017-03-06 19:05:34', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('435', '1', 'iOS', '118.898723', '31.906614', '2017-03-06 19:05:36', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('436', '1970085', 'Android', '118.898468', '31.906545', '2017-03-06 19:07:03', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('437', '1', 'iOS', '118.898687', '31.906686', '2017-03-06 19:09:22', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('438', '1', 'iOS', '118.898687', '31.906686', '2017-03-06 19:09:24', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('439', '1', 'iOS', '118.898687', '31.906686', '2017-03-06 19:09:25', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('440', '1', 'iOS', '118.898697', '31.906657', '2017-03-06 19:09:34', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('441', '1970102', 'Android', '118.898451', '31.906532', '2017-03-06 19:09:37', null, '192.168.199.182', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('442', '1', 'iOS', '118.898696', '31.906658', '2017-03-06 19:09:40', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('443', '1', 'iOS', '118.898696', '31.906658', '2017-03-06 19:09:51', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('444', '1970099', 'Android', '118.898447', '31.906541', '2017-03-06 19:10:40', null, '192.168.199.146', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('445', '1', 'iOS', '118.898694', '31.906665', '2017-03-06 19:13:59', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('446', '1', 'iOS', '118.898694', '31.906665', '2017-03-06 19:14:01', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('447', '1', 'iOS', '118.898691', '31.906664', '2017-03-06 19:14:07', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('448', '1', 'iOS', '118.898692', '31.906666', '2017-03-06 19:14:22', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('449', '1', 'iOS', '118.898683', '31.906698', '2017-03-06 19:15:12', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('450', '1', 'iOS', '118.898681', '31.906700', '2017-03-06 19:15:15', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('451', '1', 'iOS', '118.898681', '31.906700', '2017-03-06 19:15:17', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('452', '1', 'iOS', '118.898681', '31.906700', '2017-03-06 19:15:18', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('453', '1', 'iOS', '118.898681', '31.906700', '2017-03-06 19:15:19', null, '192.168.199.236', 'Can you guess?', '1');
INSERT INTO `jit_signinfo` VALUES ('454', '1', 'iOS', '118.898681', '31.906700', '2017-03-06 19:15:21', null, '192.168.199.236', 'Can you guess?', '0');
INSERT INTO `jit_signinfo` VALUES ('455', '1970090', 'iOS', '118.898723', '31.906629', '2017-03-06 19:27:28', null, '192.168.199.236', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('456', '1970090', 'iOS', '118.898723', '31.906629', '2017-03-06 19:27:30', null, '192.168.199.236', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('457', '1970090', 'iOS', '118.898723', '31.906629', '2017-03-06 19:27:31', null, '192.168.199.236', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('458', '1970086', 'Android', '118.898445', '31.906502', '2017-03-06 20:48:16', null, '10.18.195.109', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('459', '1970084', 'Android', '118.89850016276041', '31.906553819444444', '2017-03-06 21:21:33', null, '10.71.164.195', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('460', '1970085', 'Android', '0.0', '0.0', '2017-03-06 22:00:00', null, '10.233.40.109', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('461', '1970085', 'Android', '0.0', '0.0', '2017-03-07 09:49:53', null, '10.233.40.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('462', '1970090', 'iOS', '118.898777', '31.906572', '2017-03-06 22:00:00', null, '192.168.199.236', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('463', '1970090', 'iOS', '118.898777', '31.906572', '2017-03-07 12:33:40', null, '192.168.199.236', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('464', '1970085', 'Android', '0.0', '0.0', '2017-03-07 13:07:51', null, '10.233.40.109', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('465', '1970086', 'Android', '118.898444', '31.906494', '2017-03-07 18:25:02', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('466', '1970094', 'Android', '0.0', '0.0', '2017-03-07 18:34:43', null, '10.232.170.83', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('467', '1970094', 'Android', '0.0', '0.0', '2017-03-07 18:34:49', null, '10.232.170.83', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('468', '1970094', 'Android', '0.0', '0.0', '2017-03-07 18:34:52', null, '10.232.170.83', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('469', '1970085', 'Android', '0.0', '0.0', '2017-03-07 18:46:12', null, '192.168.199.209', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('470', '1970084', 'Android', '118.898446', '31.906528', '2017-03-07 18:47:58', null, '10.165.80.183', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('471', '1970099', 'Android', '118.898435', '31.906591', '2017-03-06 22:00:00', null, '192.168.199.146', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('472', '1970099', 'Android', '118.898444', '31.906592', '2017-03-07 18:54:59', null, '192.168.199.146', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('473', '1970094', 'Android', '0.0', '0.0', '2017-03-07 18:56:48', null, '10.231.137.144', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('474', '1970094', 'Android', '0.0', '0.0', '2017-03-07 18:59:07', null, '10.231.137.144', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('475', '1970094', 'Android', '118.898447', '31.906504', '2017-03-07 19:11:20', null, '192.168.199.193', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('476', '1970094', 'Android', '118.898447', '31.906504', '2017-03-07 19:11:22', null, '192.168.199.193', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('477', '1970102', 'Android', '118.898452', '31.906539', '2017-03-06 22:00:00', null, '192.168.199.182', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('478', '1970102', 'Android', '118.898452', '31.906539', '2017-03-07 19:59:34', null, '192.168.199.182', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('479', '1970094', 'Android', '118.898443', '31.906545', '2017-03-07 20:00:12', null, '10.131.49.107', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('480', '1970094', 'Android', '118.898443', '31.906545', '2017-03-07 20:00:14', null, '192.168.199.193', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('481', '1970094', 'Android', '118.898443', '31.906545', '2017-03-07 20:00:17', null, '192.168.199.193', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('482', '1970094', 'Android', '118.898443', '31.906545', '2017-03-07 20:00:25', null, '192.168.199.193', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('483', '1970094', 'Android', '118.898457', '31.906541', '2017-03-07 20:00:34', null, '192.168.199.193', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('484', '1970086', 'Android', '118.898429', '31.906526', '2017-03-07 20:07:00', null, '10.18.195.109', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('485', '1970086', 'Android', '118.89843', '31.906527', '2017-03-07 20:07:02', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('486', '1970090', 'iOS', '118.898764', '31.906899', '2017-03-07 20:07:37', null, '192.168.199.236', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('487', '1970090', 'iOS', '118.898764', '31.906899', '2017-03-07 20:07:40', null, '192.168.199.236', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('488', '1970103', 'Android', '118.898435', '31.906526', '2017-03-07 20:07:53', null, '100.122.209.252', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('489', '1970099', 'Android', '118.898472', '31.906592', '2017-03-07 20:43:24', null, '192.168.199.146', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('490', '1970103', 'Android', '118.89846', '31.906534', '2017-03-07 21:13:54', null, '192.168.199.231', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('491', '1970105', 'Android', '118.898367', '31.906588', '2017-03-07 21:15:56', null, '192.168.199.231', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('492', '1970086', 'Android', '118.898399', '31.906549', '2017-03-07 22:00:00', null, '192.168.199.113', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('493', '1970086', 'Android', '118.898422', '31.906598', '2017-03-08 17:47:14', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('494', '1970102', 'Android', '118.898431', '31.906521', '2017-03-07 22:00:00', null, '192.168.199.182', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('495', '1970102', 'Android', '118.898431', '31.906521', '2017-03-08 18:47:36', null, '192.168.199.182', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('496', '1970084', 'Android', '118.898445', '31.906516', '2017-03-07 22:00:00', null, '10.170.58.180', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('497', '1970084', 'Android', '118.898445', '31.906516', '2017-03-08 19:21:35', null, '10.170.58.180', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('498', '1970104', 'Android', '118.898421', '31.906565', '2017-03-08 19:25:03', null, '192.168.199.148', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('499', '1970086', 'Android', '118.898399', '31.906542', '2017-03-08 22:00:00', null, '192.168.199.113', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('500', '1970086', 'Android', '118.898399', '31.906542', '2017-03-09 15:20:49', null, '192.168.199.113', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('501', '1970104', 'Android', '118.898443', '31.906564', '2017-03-08 22:00:00', null, '192.168.199.148', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('502', '1970104', 'Android', '118.898443', '31.906564', '2017-03-09 18:37:42', null, '192.168.199.148', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('503', '1970084', 'Android', '118.898453', '31.906521', '2017-03-08 22:00:00', null, '192.168.199.234', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('504', '1970084', 'Android', '118.898453', '31.906521', '2017-03-09 20:26:16', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('505', '1970086', 'Android', '118.898407', '31.906573', '2017-03-09 21:22:49', null, '192.168.199.113', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('506', '1970086', 'Android', '118.898404', '31.906541', '2017-03-10 16:20:17', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('509', '1970084', 'Android', '118.89841389973958', '31.90655544704861', '2017-03-09 22:00:00', null, '192.168.199.234', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('510', '1970084', 'Android', '118.8984144422743', '31.90655517578125', '2017-03-10 16:35:16', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('513', '1970086', 'Android', '118.898421', '31.906576', '2017-03-10 16:40:53', null, '10.18.195.109', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('523', '1970086', 'Android', '118.8984', '31.906528', '2017-03-10 16:45:45', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('534', '1970086', 'Android', '118.898404', '31.906541', '2017-03-10 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('535', '1970084', 'Android', '118.8984144422743', '31.90655517578125', '2017-03-10 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('536', '1970084', 'Android', '118.898463', '31.90652', '2017-03-11 14:53:32', null, '192.168.199.235', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('537', '1970086', 'Android', '118.898454', '31.906536', '2017-03-11 15:09:37', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('538', '1970084', 'Android', '118.898453', '31.906527', '2017-03-11 23:00:00', null, '10.165.132.110', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('539', '1970084', 'Android', '118.898453', '31.906527', '2017-03-12 15:51:00', null, '10.165.132.110', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('540', '1970094', 'Android', '118.898494', '31.906581', '2017-03-12 18:29:47', null, '192.168.199.193', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('541', '1970094', 'Android', '118.898494', '31.906581', '2017-03-12 18:29:54', null, '192.168.199.193', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('542', '1970094', 'Android', '118.89846', '31.906545', '2017-03-12 18:30:00', null, '192.168.199.193', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('543', '1970094', 'Android', '118.898494', '31.906581', '2017-03-12 18:30:02', null, '192.168.199.193', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('544', '1970094', 'Android', '118.898468', '31.906541', '2017-03-12 18:30:06', null, '192.168.199.193', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('545', '1970090', 'iOS', '118.898548', '31.906985', '2017-03-07 23:00:00', null, '192.168.199.236', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('546', '1970090', 'iOS', '118.898548', '31.906985', '2017-03-12 20:33:23', null, '192.168.199.236', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('547', '1970090', 'iOS', '118.898548', '31.906985', '2017-03-12 20:33:24', null, '192.168.199.236', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('548', '1970090', 'iOS', '118.898548', '31.906985', '2017-03-12 20:33:25', null, '192.168.199.236', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('549', '1970090', 'iOS', '118.898548', '31.906985', '2017-03-12 20:33:26', null, '192.168.199.236', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('550', '1970090', 'iOS', '118.898255', '31.906487', '2017-03-12 20:33:29', null, '192.168.199.236', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('551', '1970084', 'Android', '118.898453', '31.906527', '2017-03-12 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('552', '1970094', 'Android', '118.898494', '31.906581', '2017-03-12 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('553', '1970090', 'iOS', '118.898548', '31.906985', '2017-03-12 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('554', '1970084', 'Android', '118.898441', '31.906567', '2017-03-13 07:28:27', null, '192.168.50.84', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('555', '1970086', 'Android', '118.898496', '31.906415', '2017-03-11 23:00:00', null, '10.18.195.109', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('556', '1970086', 'Android', '118.898496', '31.906415', '2017-03-13 09:29:35', null, '10.18.195.109', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('557', '1970086', 'Android', '118.898582', '31.906402', '2017-03-13 12:01:47', null, '10.136.240.221', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('558', '1970104', 'Android', '0.0', '0.0', '2017-03-09 23:00:00', null, '192.168.199.148', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('559', '1970104', 'Android', '0.0', '0.0', '2017-03-13 19:49:00', null, '192.168.199.148', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('560', '1970105', 'Android', '118.898438', '31.90657', '2017-03-07 23:00:00', null, '192.168.199.148', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('561', '1970105', 'Android', '118.898438', '31.90657', '2017-03-13 19:49:24', null, '192.168.199.148', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('562', '1970086', 'Android', '118.898399', '31.906615', '2017-03-13 20:07:38', null, '10.136.240.221', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('563', '1970084', 'Android', '118.898453', '31.906559', '2017-03-13 21:25:40', null, '10.165.144.153', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('564', '1970084', 'Android', '118.898453', '31.906559', '2017-03-13 21:25:46', null, '10.165.144.153', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('565', '1970084', 'Android', '118.898453', '31.906559', '2017-03-13 21:25:47', null, '10.165.144.153', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('566', '1970104', 'Android', '0.0', '0.0', '2017-03-13 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('567', '1970086', 'Android', '118.898496', '31.906415', '2017-03-13 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('568', '1970105', 'Android', '118.898438', '31.90657', '2017-03-13 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('569', '1', 'iOS', '0.000000', '0.000000', '2017-03-06 23:00:00', null, '192.168.199.165', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('570', '1970090', 'iOS', '118.898578', '31.907103', '2017-03-14 10:31:39', null, '192.168.199.236', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('571', '1970086', 'Android', '118.898438', '31.906554', '2017-03-14 17:56:17', null, '10.136.240.221', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('572', '1970090', 'iOS', '118.898578', '31.907103', '2017-03-14 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('573', '1970086', 'Android', '118.898438', '31.906554', '2017-03-14 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('574', '1970086', 'Android', '118.898456', '31.906623', '2017-03-15 13:22:18', null, '10.136.240.221', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('575', '1970086', 'Android', '118.898456', '31.906623', '2017-03-15 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('576', '1970086', 'Android', '118.89847', '31.906576', '2017-03-16 16:20:19', null, '10.61.189.175', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('577', '1970084', 'Android', '118.898477', '31.906512', '2017-03-16 18:33:07', null, '192.168.50.84', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('578', '1970084', 'Android', '118.898477', '31.906512', '2017-03-16 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('579', '1970086', 'Android', '118.89847', '31.906576', '2017-03-16 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('580', '1970105', 'Android', '118.898495', '31.906562', '2017-03-17 19:34:39', null, '192.168.199.237', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('581', '1970105', 'Android', '118.898521', '31.90657', '2017-03-17 23:00:00', null, '192.168.199.237', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('582', '1970104', 'Android', '118.898495', '31.906555', '2017-03-19 13:30:49', null, '192.168.199.148', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('583', '1970084', 'Android', '118.898486', '31.906532', '2017-03-19 14:04:10', null, '192.168.50.84', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('584', '1970086', 'Android', '118.898491', '31.906473', '2017-03-20 18:19:00', null, '10.136.113.133', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('585', '1970094', 'Android', '118.898515', '31.906547', '2017-03-20 20:45:10', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('586', '1970083', 'iOS', '118.898690', '31.906565', '2017-03-20 20:59:38', null, '192.168.199.189', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('587', '1970083', 'iOS', '118.898162', '31.906352', '2017-03-20 21:25:29', null, 'error', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('588', '1970086', 'Android', '118.898491', '31.906473', '2017-03-20 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('589', '1970094', 'Android', '118.898515', '31.906547', '2017-03-20 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('590', '1970086', 'Android', '118.898499', '31.906532', '2017-03-21 17:58:50', null, '10.136.113.133', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('591', '1970084', 'Android', '118.898502', '31.906515', '2017-03-19 23:00:00', null, '192.168.199.234', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('592', '1970084', 'Android', '118.898502', '31.906515', '2017-03-21 18:17:04', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('593', '1970083', 'iOS', '0.000000', '0.000000', '2017-03-21 18:40:01', null, 'error', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('594', '1970086', 'Android', '118.898499', '31.906532', '2017-03-21 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('595', '1970083', 'iOS', '0.000000', '0.000000', '2017-03-21 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('596', '1970084', 'Android', '118.898502', '31.906515', '2017-03-21 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('597', '1970094', 'Android', '0.0', '0.0', '2017-03-22 08:46:58', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('598', '1970094', 'Android', '0.0', '0.0', '2017-03-22 08:48:19', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('599', '1970094', 'Android', '0.0', '0.0', '2017-03-22 08:48:21', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('600', '1970086', 'Android', '118.898509', '31.906667', '2017-03-22 16:03:56', null, '192.168.199.113', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('601', '1970094', 'Android', '0.0', '0.0', '2017-03-22 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('602', '1970086', 'Android', '118.898509', '31.906667', '2017-03-22 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('603', '1970086', 'Android', '118.898532', '31.906545', '2017-03-23 18:15:55', null, '192.168.50.115', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('604', '1970086', 'Android', '118.898532', '31.906545', '2017-03-23 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('605', '1970086', 'Android', '118.898503', '31.906534', '2017-03-27 17:08:03', null, '10.61.150.132', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('606', '1970083', 'iOS', '118.898751', '31.906667', '2017-03-27 20:19:55', null, '192.168.199.189', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('607', '1970086', 'Android', '118.898503', '31.906534', '2017-03-27 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('608', '1970083', 'iOS', '118.898751', '31.906667', '2017-03-27 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('609', '1970086', 'Android', '118.898521', '31.906562', '2017-03-28 18:03:03', null, '10.64.158.132', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('610', '1970086', 'Android', '118.898487', '31.906516', '2017-03-28 21:02:10', null, '10.64.158.132', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('611', '1970105', 'Android', '118.89851', '31.90656', '2017-03-31 18:33:29', null, '192.168.199.221', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('612', '1970104', 'iOS', '118.898700', '31.906628', '2017-03-19 23:00:00', null, '192.168.199.234', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('613', '1970104', 'iOS', '118.898700', '31.906628', '2017-03-31 19:05:05', null, '192.168.199.234', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('614', '1970105', 'Android', '118.89851', '31.90656', '2017-03-31 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('615', '1970104', 'iOS', '118.898700', '31.906628', '2017-03-31 23:00:00', 'Auto Sign Out', '127.0.0.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('616', '1970086', 'Android', '118.898485', '31.906578', '2017-04-05 18:10:38', null, '10.138.203.138', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('617', '1970094', 'Android', '118.898505', '31.906628', '2017-04-05 18:24:37', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('618', '1970084', 'Android', '118.898487', '31.906581', '2017-04-05 18:24:47', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('619', '1970094', 'Android', '118.898471', '31.906607', '2017-04-05 18:28:10', null, '192.168.199.192', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('620', '1970094', 'Android', '118.898471', '31.906607', '2017-04-05 18:28:12', null, '192.168.199.192', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('621', '1970086', 'Android', '118.8984263780382', '31.906470811631944', '2017-04-05 23:00:00', null, '192.168.199.113', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('622', '1970084', 'Android', '118.89879991319444', '31.906442057291667', '2017-04-05 23:00:00', null, '192.168.199.234', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('623', '1970084', 'Android', '118.89879665798611', '31.906491970486112', '2017-04-13 19:38:38', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('624', '1970086', 'Android', '118.898473', '31.906561', '2017-04-16 15:37:50', null, '192.168.199.113', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('625', '1970084', 'Android', '118.898467', '31.906619', '2017-04-13 23:00:00', null, '192.168.199.234', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('626', '1970084', 'Android', '118.898467', '31.906619', '2017-04-16 15:51:02', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('627', '1970113', 'Android', '0.0', '0.0', '2017-04-17 18:25:28', null, '10.136.22.86', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('628', '1970116', 'Android', '118.898481', '31.906578', '2017-04-17 18:31:56', null, '192.168.199.129', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('629', '1970115', 'Android', '118.898479', '31.906603', '2017-04-17 18:32:08', null, '192.168.199.166', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('630', '1970084', 'Android', '118.89835123697917', '31.9064892578125', '2017-04-16 23:00:00', null, '192.168.199.234', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('631', '1970084', 'Android', '118.89836073133681', '31.90648654513889', '2017-04-17 18:32:40', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('632', '1970084', 'Android', '118.898467', '31.906599', '2017-04-17 23:00:00', null, '192.168.199.234', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('633', '1970084', 'Android', '118.89864990234375', '31.906639539930556', '2017-04-18 20:10:04', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('634', '1970112', 'Android', '118.898488', '31.906621', '2017-04-19 18:21:13', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('635', '1970115', 'Android', '118.89846', '31.906595', '2017-04-17 23:00:00', null, '192.168.199.168', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('636', '1970115', 'Android', '118.89846', '31.906595', '2017-04-19 18:22:10', null, '192.168.199.168', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('637', '1970112', 'Android', '118.8985', '31.906551', '2017-04-19 18:22:12', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('638', '1970112', 'Android', '118.898486', '31.90656', '2017-04-19 18:22:14', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('639', '1970113', 'Android', '0.0', '0.0', '2017-04-17 23:00:00', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('640', '1970113', 'Android', '0.0', '0.0', '2017-04-19 18:35:13', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('641', '1970094', 'Android', '118.898499', '31.906594', '2017-04-05 23:00:00', null, '100.118.144.187', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('642', '1970094', 'Android', '118.898499', '31.906594', '2017-04-20 15:44:39', null, '100.118.144.187', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('643', '1970112', 'Android', '118.898469', '31.906592', '2017-04-19 23:00:00', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('644', '1970112', 'Android', '118.898469', '31.906592', '2017-04-20 18:28:18', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('645', '1970086', 'Android', '118.898504', '31.906578', '2017-04-16 23:00:00', null, '10.39.167.77', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('646', '1970115', 'Android', '118.898491', '31.906583', '2017-04-19 23:00:00', null, '192.168.199.166', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('647', '1970104', 'iOS', '118.898681', '31.906607', '2017-04-23 15:38:22', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('648', '1970131', 'Android', '118.898501', '31.906564', '2017-04-23 18:07:00', null, '10.29.202.252', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('649', '1970128', 'Android', '0.0', '0.0', '2017-04-23 18:11:22', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('650', '1970105', 'Android', '118.89841362847223', '31.90631022135417', '2017-04-23 18:14:53', null, '192.168.199.221', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('651', '1970133', 'Android', '118.898523', '31.906557', '2017-04-23 18:29:50', null, '192.168.199.212', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('652', '1970133', 'Android', '118.898523', '31.906557', '2017-04-23 18:29:55', null, '192.168.199.212', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('653', '1970133', 'Android', '118.898523', '31.906557', '2017-04-23 18:29:59', null, '10.216.0.179', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('654', '1970114', 'Android', '118.898454', '31.906545', '2017-04-23 18:31:10', null, '192.168.199.177', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('655', '1970116', 'Android', '0.0', '0.0', '2017-04-17 23:00:00', null, '192.168.199.129', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('656', '1970116', 'Android', '0.0', '0.0', '2017-04-23 18:35:00', null, '192.168.199.129', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('657', '1970113', 'Android', '0.0', '0.0', '2017-04-19 23:00:00', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('658', '1970113', 'Android', '0.0', '0.0', '2017-04-23 18:58:04', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('659', '1970104', 'iOS', '118.899779', '31.906630', '2017-04-23 18:58:08', null, 'error', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('660', '1970104', 'iOS', '118.899779', '31.906630', '2017-04-23 18:58:09', null, 'error', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('661', '1970112', 'Android', '118.898492', '31.906572', '2017-04-20 23:00:00', null, '10.250.199.210', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('662', '1970112', 'Android', '118.898494', '31.906531', '2017-04-23 19:03:42', null, '10.250.199.210', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('663', '1970114', 'Android', '118.898533', '31.906548', '2017-04-23 20:53:36', null, '192.168.199.177', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('664', '1970116', 'Android', '118.898521', '31.906541', '2017-04-23 20:56:13', null, '192.168.199.129', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('665', '1970131', 'Android', '118.898495', '31.906572', '2017-04-23 21:01:41', null, '192.168.199.175', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('666', '1970113', 'Android', '0.0', '0.0', '2017-04-23 21:02:40', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('667', '1970112', 'Android', '118.89852', '31.906559', '2017-04-23 21:13:33', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('668', '1970128', 'Android', '118.898513', '31.906534', '2017-04-23 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('669', '1970128', 'Android', '118.898513', '31.906534', '2017-04-24 18:13:02', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('670', '1970084', 'Android', '118.898522', '31.906585', '2017-04-18 23:00:00', null, '192.168.199.234', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('671', '1970084', 'Android', '118.898522', '31.906585', '2017-04-24 18:16:58', null, '192.168.199.234', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('672', '1970115', 'Android', '118.898499', '31.906529', '2017-04-24 18:27:44', null, '192.168.199.166', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('673', '1970104', 'iOS', '118.898235', '31.906499', '2017-04-23 23:00:00', null, 'error', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('674', '1970104', 'iOS', '118.898235', '31.906499', '2017-04-24 20:27:37', null, 'error', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('675', '1970115', 'Android', '118.898508', '31.90647', '2017-04-24 20:41:43', null, '192.168.199.166', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('676', '1970114', 'Android', '118.898521', '31.90655', '2017-04-25 17:45:40', null, '192.168.199.180', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('677', '1970128', 'Android', '118.898535', '31.906532', '2017-04-24 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('678', '1970128', 'Android', '118.898535', '31.906532', '2017-04-25 18:32:17', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('679', '1970114', 'Android', '118.898504', '31.906554', '2017-04-25 20:02:14', null, '192.168.199.180', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('680', '1970112', 'Android', '118.898536', '31.906534', '2017-04-26 18:09:54', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('681', '1970113', 'Android', '0.0', '0.0', '2017-04-26 18:15:24', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('682', '1970116', 'Android', '0.0', '0.0', '2017-04-26 18:16:23', null, '192.168.199.129', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('683', '1970128', 'Android', '0.0', '0.0', '2017-04-25 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('684', '1970128', 'Android', '0.0', '0.0', '2017-04-26 18:18:58', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('685', '1970115', 'Android', '118.898521', '31.906544', '2017-04-26 18:19:26', null, '192.168.199.168', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('686', '1970114', 'Android', '118.898546', '31.906578', '2017-04-26 18:20:11', null, '192.168.199.180', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('687', '1970131', 'Android', '118.898556', '31.906551', '2017-04-26 18:26:20', null, '10.29.202.252', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('688', '1970133', 'Android', '118.898556', '31.906523', '2017-04-23 23:00:00', null, '192.168.199.212', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('689', '1970133', 'Android', '118.898556', '31.906523', '2017-04-26 18:27:54', null, '192.168.199.212', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('690', '1970104', 'iOS', '118.898372', '31.906614', '2017-04-24 23:00:00', null, 'error', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('691', '1970104', 'iOS', '118.898663', '31.906631', '2017-04-26 19:17:35', null, 'error', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('692', '1970115', 'Android', '118.898513', '31.906547', '2017-04-26 20:30:25', null, '192.168.199.168', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('693', '1970128', 'Android', '0.0', '0.0', '2017-04-26 20:34:30', null, '192.168.199.213', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('694', '1970114', 'Android', '118.898505', '31.90657', '2017-04-26 20:54:49', null, '192.168.199.180', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('695', '1970112', 'Android', '118.898532', '31.906542', '2017-04-26 20:55:13', null, '26.26.26.1', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('696', '1970116', 'Android', '118.89853', '31.906585', '2017-04-26 20:55:37', null, '192.168.199.129', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('697', '1970113', 'Android', '0.0', '0.0', '2017-04-26 20:57:46', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('698', '1970131', 'Android', '0.0', '0.0', '2017-04-26 20:58:11', null, '192.168.199.175', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('699', '1970133', 'Android', '118.898544', '31.906561', '2017-04-26 20:59:24', null, '192.168.199.212', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('700', '1970101', 'Android', '0.0', '0.0', '2017-04-27 16:13:16', null, '192.168.199.225', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('701', '1970112', 'Android', '118.898542', '31.90654', '2017-04-27 18:06:17', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('702', '1970112', 'Android', '118.898547', '31.906544', '2017-04-27 20:34:36', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('703', '1970104', 'iOS', '118.898791', '31.906607', '2017-04-26 23:00:00', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('704', '1970104', 'iOS', '118.898739', '31.906647', '2017-04-28 16:15:57', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('705', '1970128', 'Android', '118.898568', '31.906484', '2017-05-01 18:39:03', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('706', '1970115', 'Android', '118.898536', '31.906537', '2017-05-01 18:39:21', null, '192.168.199.166', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('707', '1970114', 'Android', '118.898535', '31.906541', '2017-05-01 18:39:31', null, '192.168.199.177', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('708', '1970116', 'Android', '118.898559', '31.906534', '2017-05-01 18:39:50', null, '192.168.199.129', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('709', '1970133', 'Android', '118.89855', '31.906556', '2017-05-01 18:39:50', null, '192.168.199.212', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('710', '1970112', 'Android', '118.89854', '31.906546', '2017-05-01 18:39:52', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('711', '1970084', 'Android', '118.8986', '31.906548', '2017-04-24 23:00:00', null, '10.157.22.209', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('712', '1970084', 'Android', '118.89852783203125', '31.906503363715277', '2017-05-01 18:41:25', null, '10.157.22.209', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('713', '1970113', 'Android', '0.0', '0.0', '2017-05-01 18:42:08', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('714', '1970104', 'iOS', '118.898920', '31.906515', '2017-04-28 23:00:00', null, 'error', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('715', '1970104', 'iOS', '118.898920', '31.906515', '2017-05-01 18:42:50', null, 'error', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('716', '1970131', 'Android', '118.898575', '31.906562', '2017-05-01 19:01:01', null, '192.168.199.175', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('717', '1970114', 'Android', '118.898578', '31.906528', '2017-05-01 20:44:40', null, '192.168.199.177', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('718', '1970115', 'Android', '118.898493', '31.906626', '2017-05-01 20:48:15', null, '192.168.199.166', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('719', '1970113', 'Android', '0.0', '0.0', '2017-05-01 20:49:18', null, '10.56.134.224', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('720', '1970112', 'Android', '118.898567', '31.906527', '2017-05-01 20:49:58', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('721', '1970116', 'Android', '118.898548', '31.906511', '2017-05-01 20:50:38', null, '192.168.199.129', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('722', '1970131', 'Android', '118.89885', '31.906343', '2017-05-01 21:17:25', null, '10.78.123.229', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('723', '1970114', 'Android', '118.898571', '31.906522', '2017-05-02 18:23:17', null, '192.168.199.176', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('724', '1970128', 'Android', '118.898555', '31.906528', '2017-05-01 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('725', '1970128', 'Android', '118.898555', '31.906528', '2017-05-02 18:28:45', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('726', '1970114', 'Android', '118.898573', '31.906534', '2017-05-02 20:48:11', null, '192.168.199.176', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('727', '1970112', 'Android', '118.898547', '31.906527', '2017-05-03 18:18:19', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('728', '1970112', 'Android', '118.898482', '31.906461', '2017-05-03 18:18:43', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('729', '1970112', 'Android', '118.898482', '31.906461', '2017-05-03 18:18:46', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('730', '1970131', 'Android', '118.898625', '31.906533', '2017-05-03 18:20:10', null, '10.78.123.229', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('731', '1970113', 'Android', '0.0', '0.0', '2017-05-03 18:22:01', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('732', '1970116', 'Android', '118.898602', '31.906541', '2017-05-03 18:24:03', null, '192.168.199.130', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('733', '1970115', 'Android', '118.898556', '31.906517', '2017-05-03 18:25:54', null, '192.168.199.167', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('734', '1970128', 'Android', '0.0', '0.0', '2017-05-02 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('735', '1970128', 'Android', '0.0', '0.0', '2017-05-03 18:32:22', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('736', '1970133', 'Android', '118.898697', '31.906381', '2017-05-01 23:00:00', null, '192.168.199.212', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('737', '1970133', 'Android', '118.898697', '31.906381', '2017-05-03 18:41:29', null, '192.168.199.212', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('738', '1970104', 'iOS', '118.898693', '31.906630', '2017-05-01 23:00:00', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('739', '1970104', 'iOS', '118.898693', '31.906630', '2017-05-03 19:15:06', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('740', '1970113', 'Android', '0.0', '0.0', '2017-05-03 20:12:04', null, '100.113.95.201', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('741', '1970113', 'Android', '0.0', '0.0', '2017-05-03 20:12:05', null, '100.113.95.201', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('742', '1970116', 'Android', '118.898586', '31.90654', '2017-05-03 21:00:14', null, '192.168.199.130', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('743', '1970131', 'Android', '118.898579', '31.906511', '2017-05-03 21:04:34', null, '192.168.199.175', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('744', '1970112', 'Android', '118.898552', '31.906449', '2017-05-03 21:04:45', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('745', '1970112', 'Android', '118.898564', '31.906469', '2017-05-04 17:57:53', null, '10.158.52.246', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('746', '1970112', 'Android', '118.898556', '31.906443', '2017-05-04 20:21:50', null, '100.114.95.111', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('747', '1970128', 'Android', '118.898576', '31.906514', '2017-05-03 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('748', '1970128', 'Android', '118.898576', '31.906514', '2017-05-05 13:29:28', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('749', '1970104', 'iOS', '118.898710', '31.906627', '2017-05-03 23:00:00', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('750', '1970104', 'iOS', '118.898710', '31.906627', '2017-05-05 18:16:05', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('751', '1970104', 'iOS', '118.898667', '31.906539', '2017-05-05 23:00:00', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('752', '1970104', 'iOS', '118.898697', '31.906587', '2017-05-06 14:38:11', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('753', '1970116', 'Android', '118.898558', '31.906566', '2017-05-06 17:20:27', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('754', '1970133', 'Android', '118.898569', '31.906554', '2017-05-03 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('755', '1970133', 'Android', '118.898569', '31.906554', '2017-05-06 18:35:18', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('756', '1970104', 'iOS', '118.898634', '31.906582', '2017-05-06 18:50:54', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('757', '1970104', 'iOS', '118.898687', '31.906616', '2017-05-06 18:50:55', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('758', '1970116', 'Android', '118.89854', '31.906564', '2017-05-06 19:42:11', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('759', '1970104', 'iOS', '118.898656', '31.906578', '2017-05-06 23:00:00', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('760', '1970104', 'iOS', '118.898656', '31.906578', '2017-05-07 14:54:56', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('761', '1970131', 'Android', '118.898557', '31.90626', '2017-05-07 18:10:59', null, '10.59.161.28', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('762', '1970113', 'Android', '0.0', '0.0', '2017-05-03 23:00:00', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('763', '1970113', 'Android', '0.0', '0.0', '2017-05-07 18:15:53', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('764', '1970115', 'Android', '118.89852322048611', '31.906422254774306', '2017-05-03 23:00:00', null, '10.136.33.125', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('765', '1970114', 'Android', '118.898552', '31.906601', '2017-05-07 18:17:28', null, '192.168.199.177', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('766', '1970115', 'Android', '118.8983070203993', '31.906390516493055', '2017-05-07 18:17:55', null, '10.136.33.125', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('767', '1970133', 'Android', '118.898563', '31.9065', '2017-05-06 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('768', '1970133', 'Android', '118.898563', '31.9065', '2017-05-07 18:18:15', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('769', '1970116', 'Android', '118.898587', '31.90654', '2017-05-07 18:23:07', null, '192.168.199.129', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('770', '1970128', 'Android', '118.898575', '31.906511', '2017-05-05 23:00:00', null, '192.168.199.210', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('771', '1970128', 'Android', '118.898579', '31.906537', '2017-05-07 18:42:45', null, '192.168.199.210', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('772', '1970112', 'Android', '118.898563', '31.906534', '2017-05-07 19:11:01', null, '10.42.211.35', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('773', '1970131', 'Android', '118.898547', '31.906564', '2017-05-07 20:41:11', null, '192.168.199.175', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('774', '1970114', 'Android', '118.898575', '31.906475', '2017-05-07 20:44:07', null, '192.168.199.177', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('775', '1970116', 'Android', '118.898595', '31.906549', '2017-05-07 20:51:03', null, '192.168.199.129', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('776', '1970115', 'Android', '118.898555', '31.906528', '2017-05-07 20:51:54', null, '192.168.199.166', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('777', '1970113', 'Android', '0.0', '0.0', '2017-05-07 20:53:55', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('778', '1970112', 'Android', '118.898574', '31.906525', '2017-05-07 21:12:20', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('779', '1970128', 'Android', '118.898565', '31.906449', '2017-05-07 23:00:00', null, '10.233.84.57', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('780', '1970128', 'Android', '118.898562', '31.906532', '2017-05-08 15:10:51', null, '10.233.84.57', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('781', '1970128', 'Android', '118.898562', '31.906532', '2017-05-08 15:10:52', null, '10.233.84.57', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('782', '1970131', 'Android', '118.898587', '31.906591', '2017-05-08 18:15:52', null, '192.168.199.175', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('783', '1970113', 'Android', '0.0', '0.0', '2017-05-08 18:24:25', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('784', '1970133', 'Android', '118.898571', '31.906552', '2017-05-07 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('785', '1970133', 'Android', '118.898571', '31.906552', '2017-05-08 18:25:19', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('786', '1970116', 'Android', '0.0', '0.0', '2017-05-08 18:27:17', null, '192.168.199.129', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('787', '1970115', 'Android', '118.898535', '31.906547', '2017-05-08 18:28:49', null, '192.168.199.166', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('788', '1970104', 'iOS', '0.000000', '0.000000', '2017-05-07 23:00:00', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('789', '1970104', 'iOS', '118.898764', '31.906672', '2017-05-08 19:45:50', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('790', '1970104', 'iOS', '118.898764', '31.906672', '2017-05-08 19:45:51', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('791', '1970104', 'iOS', '118.898764', '31.906672', '2017-05-08 19:45:52', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('792', '1970115', 'Android', '118.898566', '31.90655', '2017-05-08 20:51:45', null, '192.168.199.166', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('793', '1970116', 'Android', '118.898576', '31.906531', '2017-05-08 20:54:27', null, '192.168.199.129', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('794', '1970113', 'Android', '0.0', '0.0', '2017-05-08 20:55:10', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('795', '1970131', 'Android', '0.0', '0.0', '2017-05-08 20:57:44', null, '192.168.199.175', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('796', '1970114', 'Android', '118.898552', '31.906548', '2017-05-09 16:52:58', null, '192.168.199.176', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('797', '1970128', 'Android', '118.898589', '31.906514', '2017-05-09 18:31:26', null, '10.129.117.63', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('798', '1970114', 'Android', '118.898549', '31.906546', '2017-05-09 19:07:19', null, '192.168.199.176', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('799', '1970112', 'Android', '118.898584', '31.906521', '2017-05-10 17:30:47', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('800', '1970112', 'Android', '0.0', '0.0', '2017-05-10 18:06:12', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('801', '1970104', 'iOS', '118.899583', '31.907400', '2017-05-08 23:00:00', null, 'error', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('802', '1970104', 'iOS', '118.899583', '31.907400', '2017-05-10 20:39:37', null, 'error', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('803', '1970113', 'Android', '0.0', '0.0', '2017-05-11 14:52:09', null, '10.58.183.5', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('804', '1970112', 'Android', '118.898579', '31.906447', '2017-05-11 17:21:50', null, '10.248.12.12', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('805', '1970112', 'Android', '118.89858', '31.906453', '2017-05-11 17:21:52', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('806', '1970112', 'Android', '118.89858', '31.906453', '2017-05-11 17:22:07', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('807', '1970112', 'Android', '118.898556', '31.906526', '2017-05-11 20:34:08', null, '10.107.116.169', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('808', '1970113', 'Android', '0.0', '0.0', '2017-05-11 23:57:07', null, '10.58.183.5', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('809', '1970113', 'Android', '0.0', '0.0', '2017-05-11 23:57:09', null, '10.58.183.5', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('810', '1970113', 'Android', '0.0', '0.0', '2017-05-11 23:57:10', null, '10.58.183.5', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('811', '1970113', 'Android', '0.0', '0.0', '2017-05-12 11:02:12', null, '10.229.62.169', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('812', '1970113', 'Android', '0.0', '0.0', '2017-05-12 11:02:14', null, '10.229.62.169', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('813', '1970113', 'Android', '0.0', '0.0', '2017-05-12 11:02:16', null, '10.229.62.169', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('814', '1970113', 'Android', '0.0', '0.0', '2017-05-12 11:02:42', null, '10.229.62.169', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('815', '1970113', 'Android', '0.0', '0.0', '2017-05-12 11:14:42', null, '10.229.62.169', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('816', '1970113', 'Android', '0.0', '0.0', '2017-05-12 11:14:48', null, '10.229.62.169', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('817', '1970112', 'Android', '118.898571', '31.906428', '2017-05-12 14:17:08', null, '192.168.199.157', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('818', '1970113', 'Android', '0.0', '0.0', '2017-05-12 18:13:49', null, '10.110.197.177', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('819', '1970128', 'Android', '118.898576', '31.906502', '2017-05-09 23:00:00', null, '10.49.7.105', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('820', '1970128', 'Android', '118.898576', '31.906502', '2017-05-12 18:26:53', null, '10.49.7.105', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('821', '1970133', 'Android', '118.89857', '31.906538', '2017-05-08 23:00:00', null, '192.168.199.212', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('822', '1970133', 'Android', '118.89857', '31.906538', '2017-05-12 18:31:59', null, '192.168.199.212', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('823', '1970112', 'Android', '118.898548', '31.906569', '2017-05-12 19:48:24', null, '192.168.199.157', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('824', '1970113', 'Android', '0.0', '0.0', '2017-05-12 21:02:27', null, '10.27.177.173', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('825', '1970116', 'Android', '118.898576', '31.906541', '2017-05-14 19:20:47', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('826', '1970115', 'Android', '118.898533', '31.906523', '2017-05-14 19:21:44', null, '192.168.199.166', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('827', '1970131', 'Android', '118.898546', '31.906537', '2017-05-14 19:23:00', null, '192.168.199.175', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('828', '1970113', 'Android', '118.898567', '31.906537', '2017-05-14 19:23:37', null, '192.168.199.213', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('829', '1970113', 'Android', '118.898567', '31.906537', '2017-05-14 19:23:43', null, '10.167.60.47', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('830', '1970113', 'Android', '118.898567', '31.906505', '2017-05-14 19:23:44', null, '10.167.60.47', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('831', '1970112', 'Android', '118.898555', '31.906543', '2017-05-14 19:23:56', null, '192.168.199.158', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('832', '1970113', 'Android', '118.898549', '31.906528', '2017-05-14 19:24:06', null, '192.168.199.213', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('833', '1970113', 'Android', '118.898549', '31.906528', '2017-05-14 19:24:07', null, '192.168.199.213', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('834', '1970128', 'Android', '118.898566', '31.906508', '2017-05-12 23:00:00', null, '192.168.199.210', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('835', '1970128', 'Android', '118.898571', '31.906494', '2017-05-14 19:24:47', null, '192.168.199.210', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('836', '1970116', 'Android', '118.89856', '31.90651', '2017-05-14 20:44:05', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('837', '1970112', 'Android', '118.898548', '31.90653', '2017-05-14 20:44:59', null, '192.168.199.158', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('838', '1970115', 'Android', '118.898528', '31.906555', '2017-05-14 20:45:21', null, '192.168.199.166', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('839', '1970113', 'Android', '118.898532', '31.906473', '2017-05-14 20:46:36', null, '10.167.60.47', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('840', '1970113', 'Android', '118.89854', '31.906468', '2017-05-14 20:46:37', null, '10.167.60.47', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('841', '1970113', 'Android', '118.89854', '31.906468', '2017-05-14 20:46:39', null, '10.167.60.47', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('842', '1970113', 'Android', '118.898472', '31.906335', '2017-05-14 20:46:59', null, '10.167.60.47', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('843', '1970113', 'Android', '118.898521', '31.906393', '2017-05-14 23:00:00', null, '192.168.199.214', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('844', '1970113', 'Android', '118.898521', '31.906393', '2017-05-15 18:21:00', null, '192.168.199.214', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('845', '1970116', 'Android', '118.898577', '31.906497', '2017-05-15 18:22:42', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('846', '1970131', 'Android', '118.898562', '31.906546', '2017-05-14 23:00:00', null, '10.159.149.18', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('847', '1970131', 'Android', '118.898552', '31.906552', '2017-05-15 18:23:46', null, '10.159.149.18', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('848', '1970115', 'Android', '118.89857', '31.906512', '2017-05-15 18:33:27', null, '192.168.199.166', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('849', '1970104', 'iOS', '118.897088', '31.909605', '2017-05-10 23:00:00', null, 'error', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('850', '1970104', 'iOS', '118.898685', '31.906571', '2017-05-15 18:56:29', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('851', '1970133', 'Android', '0.0', '0.0', '2017-05-12 23:00:00', null, '192.168.199.211', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('852', '1970133', 'Android', '0.0', '0.0', '2017-05-15 19:18:55', null, '192.168.199.211', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('853', '1970104', 'iOS', '118.898693', '31.906579', '2017-05-15 19:53:41', null, '192.168.199.235', 'NULL', '1');
INSERT INTO `jit_signinfo` VALUES ('854', '1970104', 'iOS', '118.898693', '31.906579', '2017-05-15 19:53:42', null, '192.168.199.235', 'NULL', '0');
INSERT INTO `jit_signinfo` VALUES ('855', '1970115', 'Android', '118.898429', '31.906462', '2017-05-15 20:40:04', null, '192.168.199.166', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('856', '1970113', 'Android', '118.898536', '31.906253', '2017-05-15 20:40:05', null, '192.168.199.214', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('857', '1970116', 'Android', '118.898583', '31.906542', '2017-05-15 20:40:20', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('858', '1970114', 'Android', '118.898538', '31.906539', '2017-05-16 18:30:49', null, '192.168.199.176', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('859', '1970114', 'Android', '118.898541', '31.906552', '2017-05-16 19:06:52', null, '192.168.199.176', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('860', '1970114', 'Android', '118.898565', '31.906498', '2017-05-17 13:50:56', null, '192.168.199.176', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('861', '1970114', 'Android', '118.898561', '31.906547', '2017-05-17 15:55:26', null, '192.168.199.176', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('862', '1970112', 'Android', '118.898572', '31.906507', '2017-05-17 15:58:58', null, '192.168.199.158', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('863', '1970133', 'Android', '118.898575', '31.906486', '2017-05-15 23:00:00', null, '192.168.199.212', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('864', '1970133', 'Android', '118.898575', '31.906486', '2017-05-17 18:12:25', null, '192.168.199.212', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('865', '1970131', 'Android', '118.898562', '31.906536', '2017-05-15 23:00:00', null, '10.159.149.18', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('866', '1970131', 'Android', '118.898562', '31.906536', '2017-05-17 18:19:39', null, '10.159.149.18', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('867', '1970113', 'Android', '118.898566', '31.90654', '2017-05-17 18:32:27', null, '192.168.199.214', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('868', '1970113', 'Android', '118.89858', '31.906543', '2017-05-17 18:32:31', null, '192.168.199.214', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('869', '1970113', 'Android', '118.89858', '31.906543', '2017-05-17 18:32:33', null, '192.168.199.214', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('870', '1970128', 'Android', '118.898584', '31.906498', '2017-05-14 23:00:00', null, '192.168.199.213', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('871', '1970128', 'Android', '118.898584', '31.906498', '2017-05-17 18:33:33', null, '192.168.199.213', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('872', '1970116', 'Android', '118.898502', '31.906581', '2017-05-17 20:27:37', null, '192.168.199.128', 'mac', '0');
INSERT INTO `jit_signinfo` VALUES ('873', '1970116', 'Android', '118.898542', '31.906528', '2017-05-17 20:29:13', null, '192.168.199.128', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('874', '1970113', 'Android', '118.898564', '31.906534', '2017-05-17 20:29:31', null, '192.168.199.214', 'mac', '1');
INSERT INTO `jit_signinfo` VALUES ('875', '1970113', 'Android', '118.898534', '31.906525', '2017-05-17 20:29:36', null, '192.168.199.214', 'mac', '0');
