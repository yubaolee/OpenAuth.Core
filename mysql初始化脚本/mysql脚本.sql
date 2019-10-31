/*
 Navicat Premium Data Transfer

 Source Server         : local mysql_000000
 Source Server Type    : MySQL
 Source Server Version : 50641
 Source Host           : localhost:3306
 Source Schema         : openauthdb

 Target Server Type    : MySQL
 Target Server Version : 50641
 File Encoding         : 65001

 Date: 01/11/2019 00:45:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for application
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'AppId',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '应用名称',
  `AppSecret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用密钥',
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用描述',
  `Icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用图标',
  `Disable` tinyint(4) NOT NULL COMMENT '是否可用',
  `CreateTime` date NOT NULL COMMENT '创建日期',
  `CreateUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of application
-- ----------------------------
INSERT INTO `application` VALUES ('110', 'OpenAuth.Net', 'openauthdotnetyubaolee', '最好用的.NET权限工作流框架', NULL, 0, '2018-04-14', NULL);
INSERT INTO `application` VALUES ('119', 'XXX管理平台', 'manageryubaolee', '这是一个第三的平台', NULL, 0, '2018-04-14', NULL);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT '分类名称或描述',
  `DtCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类标识',
  `DtValue` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通常与分类标识一致，但万一有不一样的情况呢？',
  `Enable` tinyint(1) NOT NULL DEFAULT 0,
  `SortNo` int(11) NOT NULL DEFAULT 0 COMMENT '排序号',
  `Description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '分类表，也可用作数据字典。表示一个全集，比如：男、女、未知。关联的分类类型表示按什么进行的分类，如：按照性别对人类对象集' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('01a2736c-cebe-43a2-8068-7e3f88fa7c23', '审核', 'SYS_ORDERSTATUS_CHECK', 'SYS_ORDERSTATUS_CHECK', 1, 0, '', 'SYS_ORDERSTATUS', '2019-10-29 21:20:40', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:20:40', '', '');
INSERT INTO `category` VALUES ('07d21d6d-3bce-4b73-8273-c9f948f468fe', '释放', 'PICKSTATUS_RELEASE', 'PICKSTATUS_RELEASE', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:29:35', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:29:35', '', '');
INSERT INTO `category` VALUES ('2615b6bf-7fc3-46e1-8105-708dda0e6c42', '发货完成', 'PICKSTATUS_OUTSTOCK', 'PICKSTATUS_OUTSTOCK', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:32:02', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:32:02', '', '');
INSERT INTO `category` VALUES ('354f50b7-0d93-43d6-a721-a4931c650ea3', '创建', 'SYS_ORDERSTATUS_CREATE', 'SYS_ORDERSTATUS_CREATE', 1, 0, '', 'SYS_ORDERSTATUS', '2019-10-29 21:20:02', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:20:02', '', '');
INSERT INTO `category` VALUES ('74f7bcc8-50a3-4c02-9a25-ee2fa4575e25', '集货完成', 'PICKSTATUS_STAGED', 'PICKSTATUS_STAGED', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:31:11', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:31:11', '', '');
INSERT INTO `category` VALUES ('8641c594-e43e-4469-a5b5-5da06a53eaf9', '打包完成', 'PICKSTATUS_PACK', 'PICKSTATUS_PACK', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:31:50', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:31:50', '', '');
INSERT INTO `category` VALUES ('86b8d963-63b6-4936-87b1-af248cd26c44', '已完成', 'SYS_ORDERSTATUS_FINISHED', 'SYS_ORDERSTATUS_FINISHED', 1, 0, '', 'SYS_ORDERSTATUS', '2019-10-29 21:27:32', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:27:32', '', '');
INSERT INTO `category` VALUES ('9bddbcfd-f41e-429f-b112-76db0c1bf0f3', '复核完成', 'PICKSTATUS_CHECKED', 'PICKSTATUS_CHECKED', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:30:37', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:30:37', '', '');
INSERT INTO `category` VALUES ('b1d4301b-2378-4598-9b96-8592afbb64d1', '缓存完成', 'PICKSTATUS_CACHE', 'PICKSTATUS_CACHE', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:30:53', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:30:53', '', '');
INSERT INTO `category` VALUES ('d2dd6a7f-797e-4ff2-96cc-56bf9fbfc24b', '装车完成', 'PICKSTATUS_CAR', 'PICKSTATUS_CAR', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:31:27', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:31:27', '', '');
INSERT INTO `category` VALUES ('d8152952-cf55-40ba-af81-0d4863247d6a', '拣选完成', 'PICKSTATUS_PICKFINISH', 'PICKSTATUS_PICKFINISH', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:30:16', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:30:16', '', '');
INSERT INTO `category` VALUES ('de4ccb7b-19e4-4203-a092-b2d8bafe3131', '拣选执行中', 'PICKSTATUS_PICKEXECUTE', 'PICKSTATUS_PICKEXECUTE', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:29:55', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:29:55', '', '');
INSERT INTO `category` VALUES ('e6292744-a6e8-4a6f-b077-14bd35e31a27', '创建', 'PICKSTATUS_CREATE', 'PICKSTATUS_CREATE', 1, 0, '', 'SYS_PICKSTATUS', '2019-10-29 21:29:18', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:29:18', '', '');
INSERT INTO `category` VALUES ('faef67e8-48e4-44e5-981c-eebb78d79a0f', '已处理', 'SYS_ORDERSTATUS_DISPOSED', 'SYS_ORDERSTATUS_DISPOSED', 1, 0, '', 'SYS_ORDERSTATUS', '2019-10-29 21:27:05', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-29 21:27:05', '', '');

-- ----------------------------
-- Table structure for categorytype
-- ----------------------------
DROP TABLE IF EXISTS `categorytype`;
CREATE TABLE `categorytype`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类表ID',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类类型' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of categorytype
-- ----------------------------
INSERT INTO `categorytype` VALUES ('SYS_ORDERSTATUS', '订单状态', '2019-10-29 21:18:56');
INSERT INTO `categorytype` VALUES ('SYS_ORDERTYPE', '订单类型', '2019-10-29 21:18:32');
INSERT INTO `categorytype` VALUES ('SYS_PICKSTATUS', '拣选任务状态', '2019-10-29 21:28:50');
INSERT INTO `categorytype` VALUES ('USERTYPE', '按用户类型分类', '2017-11-29 21:27:42');

-- ----------------------------
-- Table structure for dataprivilegerule
-- ----------------------------
DROP TABLE IF EXISTS `dataprivilegerule`;
CREATE TABLE `dataprivilegerule`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据ID',
  `SourceCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资源标识（模块编号）',
  `SubSourceCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '二级资源标识',
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT '权限描述',
  `SortNo` int(11) NOT NULL DEFAULT 0 COMMENT '排序号',
  `PrivilegeRules` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT '权限规则',
  `Enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可用',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '系统授权规制表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dataprivilegerule
-- ----------------------------
INSERT INTO `dataprivilegerule` VALUES ('e7c95fb1-91f7-422e-a11a-73cea0c404b9', 'Resource', NULL, '资源数据规则', 0, '{\"Operation\":\"or\",\"Filters\":[{\"Key\":\"AppId\",\"Value\":\"110\",\"Contrast\":\"==\"},{\"Key\":\"Name\",\"Value\":\"登陆\",\"Contrast\":\"==\"}],\"Children\":[{\"Operation\":\"and\",\"Filters\":[{\"Key\":\"Name\",\"Value\":\"注销账号\",\"Contrast\":\"==\"},{\"Key\":\"AppId\",\"Value\":\"119\",\"Contrast\":\"==\"}],\"Children\":null}]}', 0, '2019-10-29 11:05:02', '00000000-0000-0000-0000-000000000000', '', '2019-10-29 11:05:02', '', '');

-- ----------------------------
-- Table structure for flowinstance
-- ----------------------------
DROP TABLE IF EXISTS `flowinstance`;
CREATE TABLE `flowinstance`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键Id',
  `InstanceSchemeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程实例模板Id',
  `Code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '实例编号',
  `CustomName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '自定义名称',
  `ActivityId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '当前节点ID',
  `ActivityType` int(11) DEFAULT NULL COMMENT '当前节点类型（0会签节点）',
  `ActivityName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '当前节点名称',
  `PreviousId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '前一个ID',
  `SchemeContent` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '流程模板内容',
  `SchemeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流程模板ID',
  `DbName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据库名称',
  `FrmData` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '表单数据',
  `FrmType` int(11) NOT NULL COMMENT '表单类型',
  `FrmContentData` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '表单中的控件属性描述',
  `FrmContentParse` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '表单控件位置模板',
  `FrmId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '表单ID',
  `SchemeType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流程类型',
  `Disabled` int(11) NOT NULL COMMENT '有效标志',
  `CreateDate` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户',
  `FlowLevel` int(11) NOT NULL COMMENT '等级',
  `Description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '实例备注',
  `IsFinish` int(11) NOT NULL COMMENT '是否完成',
  `MakerList` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '执行人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工作流流程实例表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of flowinstance
-- ----------------------------
INSERT INTO `flowinstance` VALUES ('034ad4f0-95e6-40bf-b3c5-38bd60b542d9', '', '1564334796391', '会签2019-07-29 01:26:40', '1564334444885', 4, 'node_7', '1564334437844', '{\"title\":\"newFlow_1\",\"initNum\":16,\"lines\":[{\"id\":\"1564334446774\",\"type\":\"sl\",\"from\":\"1564334430924\",\"to\":\"1564334435460\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334447796\",\"type\":\"sl\",\"from\":\"1564334435460\",\"to\":\"1564334437844\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334448572\",\"type\":\"sl\",\"from\":\"1564334437844\",\"to\":\"1564334439828\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334449628\",\"type\":\"sl\",\"from\":\"1564334437844\",\"to\":\"1564334440404\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334450572\",\"type\":\"sl\",\"from\":\"1564334439828\",\"to\":\"1564334441965\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334451684\",\"type\":\"sl\",\"from\":\"1564334440404\",\"to\":\"1564334441965\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334453900\",\"type\":\"sl\",\"from\":\"1564334441965\",\"to\":\"1564334444885\",\"name\":\"\",\"dash\":false,\"Compares\":null}],\"nodes\":[{\"id\":\"1564334430924\",\"name\":\"node_1\",\"type\":\"start round mix\",\"left\":17,\"top\":12,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null},{\"id\":\"1564334435460\",\"name\":\"node_2\",\"type\":\"node\",\"left\":141,\"top\":49,\"width\":104,\"height\":26,\"alt\":true,\"setInfo\":{\"NodeDesignate\":null,\"NodeDesignateData\":null,\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":null,\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"test\",\"UserId\":\"6ba79766-faa0-4259-8139-a4a6d35784e0\",\"Description\":\"\",\"TagedTime\":\"2019-07-29 01:28\",\"NodeConfluenceType\":null,\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334437844\",\"name\":\"会签入口，设置会签类型\",\"type\":\"fork\",\"left\":141,\"top\":138,\"width\":104,\"height\":76,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"admin\",\"UserId\":\"49df1602-f5f3-4d52-afb7-3802da619558\",\"Description\":\"\",\"TagedTime\":\"2019-07-29 01:30\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":1,\"ConfluenceNo\":null}},{\"id\":\"1564334439828\",\"name\":\"admin\",\"type\":\"node\",\"left\":23,\"top\":272,\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"SPECIAL_USER\",\"NodeDesignateData\":{\"users\":[\"49df1602-f5f3-4d52-afb7-3802da619558\"],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"admin\",\"UserId\":\"49df1602-f5f3-4d52-afb7-3802da619558\",\"Description\":\"\",\"TagedTime\":\"2019-07-29 01:30\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334440404\",\"name\":\"test\",\"type\":\"node\",\"left\":234,\"top\":265,\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"SPECIAL_USER\",\"NodeDesignateData\":{\"users\":[\"6ba79766-faa0-4259-8139-a4a6d35784e0\"],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":null,\"UserName\":null,\"UserId\":null,\"Description\":null,\"TagedTime\":null,\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334441965\",\"name\":\"默认所有人\",\"type\":\"join\",\"left\":140,\"top\":406,\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"admin\",\"UserId\":\"49df1602-f5f3-4d52-afb7-3802da619558\",\"Description\":\"\",\"TagedTime\":\"2019-07-29 01:30\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334444885\",\"name\":\"node_7\",\"type\":\"end round\",\"left\":351,\"top\":420,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null}],\"areas\":[]}', '73819920-f085-4003-8874-4361b6461c92', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"1\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:26:45', '00000000-0000-0000-0000-000000000000', 'System', 0, '', 1, '');
INSERT INTO `flowinstance` VALUES ('0ae5abe6-f571-4e08-b264-667dc27c5025', '', '1564334583446', '带复杂表单的2019-07-29 01:23:03', '1564334557205', 2, 'node_2', '1564334555981', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":66,\"top\":46,\"type\":\"start round mix\",\"id\":\"1564334555981\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":50,\"top\":145,\"type\":\"node\",\"id\":\"1564334557205\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"node_3\",\"left\":56,\"top\":206,\"type\":\"node\",\"id\":\"1564334557764\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"node_4\",\"left\":66,\"top\":294,\"type\":\"end round\",\"id\":\"1564334559716\",\"width\":26,\"height\":26,\"alt\":true}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334555981\",\"to\":\"1564334557205\",\"id\":\"1564334561500\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334557205\",\"to\":\"1564334557764\",\"id\":\"1564334562229\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334557764\",\"to\":\"1564334559716\",\"id\":\"1564334563268\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":8}', '989bd1f3-29f0-43cd-ad01-b55654907dbb', 'FrmLeaveReq', '{\"id\":\"\",\"userName\":\"李玉宝\",\"requestType\":\"事假\",\"startDate\":\"2019-07-08T16:00:00.000Z\",\"startTime\":\"2019-07-28T17:23:14.000Z\",\"endDate\":\"2019-07-24T16:00:00.000Z\",\"endTime\":\"2019-07-28T17:23:18.000Z\",\"requestComment\":\"太累了，就是想休息一下\",\"attachment\":\"\",\"files\":[],\"extendInfo\":\"\"}', 1, '', '', '8faff4e5-b729-44d2-ac26-e899a228f63d', '', 0, '2019-07-29 01:23:57', '00000000-0000-0000-0000-000000000000', 'System', 0, '这种结构只能企业版使用', 0, '1');
INSERT INTO `flowinstance` VALUES ('0ee22872-f120-4c5a-84ec-7f4e36bd0141', '', '1564334742060', '带分支条件的请假2019-07-29 01:25:44', '1564334139783', 4, 'node_2', '1564334156607', '{\"title\":\"newFlow_1\",\"initNum\":16,\"lines\":[{\"id\":\"1564334158551\",\"type\":\"sl\",\"from\":\"1564334138399\",\"to\":\"1564334153687\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334159304\",\"type\":\"sl\",\"from\":\"1564334153687\",\"to\":\"1564334154471\",\"name\":\"\",\"dash\":false,\"Compares\":[{\"Operation\":\"<\",\"FieldName\":\"DAYS\",\"FieldType\":null,\"Value\":\"3\"}]},{\"id\":\"1564334160383\",\"type\":\"sl\",\"from\":\"1564334153687\",\"to\":\"1564334155295\",\"name\":\"\",\"dash\":false,\"Compares\":[{\"Operation\":\">=\",\"FieldName\":\"DAYS\",\"FieldType\":null,\"Value\":\"3\"}]},{\"id\":\"1564334161911\",\"type\":\"sl\",\"from\":\"1564334154471\",\"to\":\"1564334156607\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334163959\",\"type\":\"sl\",\"from\":\"1564334155295\",\"to\":\"1564334156607\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334165255\",\"type\":\"sl\",\"from\":\"1564334156607\",\"to\":\"1564334139783\",\"name\":\"\",\"dash\":false,\"Compares\":null}],\"nodes\":[{\"id\":\"1564334138399\",\"name\":\"node_1\",\"type\":\"start round mix\",\"left\":44,\"top\":27,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null},{\"id\":\"1564334139783\",\"name\":\"node_2\",\"type\":\"end round\",\"left\":50,\"top\":295,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null},{\"id\":\"1564334153687\",\"name\":\"所有人可以审批\",\"type\":\"node\",\"left\":163,\"top\":43,\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"超级管理员\",\"UserId\":\"00000000-0000-0000-0000-000000000000\",\"Description\":\"\",\"TagedTime\":\"2019-07-29 01:26\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334154471\",\"name\":\"小于3的test可以审批\",\"type\":\"node\",\"left\":23,\"top\":141,\"width\":167,\"height\":76,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"SPECIAL_USER\",\"NodeDesignateData\":{\"users\":[\"6ba79766-faa0-4259-8139-a4a6d35784e0\"],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"test\",\"UserId\":\"6ba79766-faa0-4259-8139-a4a6d35784e0\",\"Description\":\"\",\"TagedTime\":\"2019-07-29 01:28\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334155295\",\"name\":\"大于3的admin可以审批\",\"type\":\"node\",\"left\":288,\"top\":146,\"width\":143,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"SPECIAL_USER\",\"NodeDesignateData\":{\"users\":[\"49df1602-f5f3-4d52-afb7-3802da619558\"],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":null,\"UserName\":null,\"UserId\":null,\"Description\":null,\"TagedTime\":null,\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334156607\",\"name\":\"默认\",\"type\":\"node\",\"left\":171,\"top\":291,\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"admin\",\"UserId\":\"49df1602-f5f3-4d52-afb7-3802da619558\",\"Description\":\"\",\"TagedTime\":\"2019-07-29 01:30\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}}],\"areas\":[]}', 'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"1\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:25:56', '00000000-0000-0000-0000-000000000000', 'System', 0, '这个时执行完成的', 1, '');
INSERT INTO `flowinstance` VALUES ('20be4e87-0e9e-467c-9011-3c6ccd650931', '', '1564334643592', '会签2019-07-29 01:24:05', '1564334435460', 2, 'node_2', '1564334430924', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":17,\"top\":12,\"type\":\"start round mix\",\"id\":\"1564334430924\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":141,\"top\":49,\"type\":\"node\",\"id\":\"1564334435460\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"会签入口，设置会签类型\",\"left\":141,\"top\":138,\"type\":\"fork\",\"id\":\"1564334437844\",\"width\":104,\"height\":76,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"admin\",\"left\":23,\"top\":272,\"type\":\"node\",\"id\":\"1564334439828\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"49df1602-f5f3-4d52-afb7-3802da619558\"],\"roles\":[]}}},{\"name\":\"test\",\"left\":234,\"top\":265,\"type\":\"node\",\"id\":\"1564334440404\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"6ba79766-faa0-4259-8139-a4a6d35784e0\"],\"roles\":[]}}},{\"name\":\"默认所有人\",\"left\":140,\"top\":406,\"type\":\"join\",\"id\":\"1564334441965\",\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"node_7\",\"left\":351,\"top\":420,\"type\":\"end round\",\"id\":\"1564334444885\",\"width\":26,\"height\":26,\"alt\":true}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334430924\",\"to\":\"1564334435460\",\"id\":\"1564334446774\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334435460\",\"to\":\"1564334437844\",\"id\":\"1564334447796\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334437844\",\"to\":\"1564334439828\",\"id\":\"1564334448572\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334437844\",\"to\":\"1564334440404\",\"id\":\"1564334449628\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334439828\",\"to\":\"1564334441965\",\"id\":\"1564334450572\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334440404\",\"to\":\"1564334441965\",\"id\":\"1564334451684\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334441965\",\"to\":\"1564334444885\",\"id\":\"1564334453900\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":16}', '73819920-f085-4003-8874-4361b6461c92', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"3\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:24:14', '00000000-0000-0000-0000-000000000000', 'System', 0, '', 0, '1');
INSERT INTO `flowinstance` VALUES ('61959fe9-377a-4e6c-9f5d-6b7018a80bca', '', '1564334700493', '带分支条件的请假2019-07-29 01:25:02', '1564334154471', 2, '小于3的test可以审批', '1564334153687', '{\"title\":\"newFlow_1\",\"initNum\":16,\"lines\":[{\"id\":\"1564334158551\",\"type\":\"sl\",\"from\":\"1564334138399\",\"to\":\"1564334153687\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334159304\",\"type\":\"sl\",\"from\":\"1564334153687\",\"to\":\"1564334154471\",\"name\":\"\",\"dash\":false,\"Compares\":[{\"Operation\":\"<\",\"FieldName\":\"DAYS\",\"FieldType\":null,\"Value\":\"3\"}]},{\"id\":\"1564334160383\",\"type\":\"sl\",\"from\":\"1564334153687\",\"to\":\"1564334155295\",\"name\":\"\",\"dash\":false,\"Compares\":[{\"Operation\":\">=\",\"FieldName\":\"DAYS\",\"FieldType\":null,\"Value\":\"3\"}]},{\"id\":\"1564334161911\",\"type\":\"sl\",\"from\":\"1564334154471\",\"to\":\"1564334156607\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334163959\",\"type\":\"sl\",\"from\":\"1564334155295\",\"to\":\"1564334156607\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334165255\",\"type\":\"sl\",\"from\":\"1564334156607\",\"to\":\"1564334139783\",\"name\":\"\",\"dash\":false,\"Compares\":null}],\"nodes\":[{\"id\":\"1564334138399\",\"name\":\"node_1\",\"type\":\"start round mix\",\"left\":44,\"top\":27,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null},{\"id\":\"1564334139783\",\"name\":\"node_2\",\"type\":\"end round\",\"left\":50,\"top\":295,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null},{\"id\":\"1564334153687\",\"name\":\"所有人可以审批\",\"type\":\"node\",\"left\":163,\"top\":43,\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"test\",\"UserId\":\"6ba79766-faa0-4259-8139-a4a6d35784e0\",\"Description\":\"\",\"TagedTime\":\"2019-07-29 01:29\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334154471\",\"name\":\"小于3的test可以审批\",\"type\":\"node\",\"left\":23,\"top\":141,\"width\":167,\"height\":76,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"SPECIAL_USER\",\"NodeDesignateData\":{\"users\":[\"6ba79766-faa0-4259-8139-a4a6d35784e0\"],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":null,\"UserName\":null,\"UserId\":null,\"Description\":null,\"TagedTime\":null,\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334155295\",\"name\":\"大于3的admin可以审批\",\"type\":\"node\",\"left\":288,\"top\":146,\"width\":143,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"SPECIAL_USER\",\"NodeDesignateData\":{\"users\":[\"49df1602-f5f3-4d52-afb7-3802da619558\"],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":null,\"UserName\":null,\"UserId\":null,\"Description\":null,\"TagedTime\":null,\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334156607\",\"name\":\"默认\",\"type\":\"node\",\"left\":171,\"top\":291,\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":null,\"UserName\":null,\"UserId\":null,\"Description\":null,\"TagedTime\":null,\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}}],\"areas\":[]}', 'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"1\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:25:16', '00000000-0000-0000-0000-000000000000', 'System', 0, '这是个天数比较少的分支', 0, '6ba79766-faa0-4259-8139-a4a6d35784e0');
INSERT INTO `flowinstance` VALUES ('7a1fb1a4-06a6-49d5-a311-b988aed776e1', '', '1564334976909', 'admin的会签2019-07-29 01:29:39', '1564334435460', 2, 'node_2', '1564334430924', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":17,\"top\":12,\"type\":\"start round mix\",\"id\":\"1564334430924\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":141,\"top\":49,\"type\":\"node\",\"id\":\"1564334435460\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"会签入口，设置会签类型\",\"left\":141,\"top\":138,\"type\":\"fork\",\"id\":\"1564334437844\",\"width\":104,\"height\":76,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"admin\",\"left\":23,\"top\":272,\"type\":\"node\",\"id\":\"1564334439828\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"49df1602-f5f3-4d52-afb7-3802da619558\"],\"roles\":[]}}},{\"name\":\"test\",\"left\":234,\"top\":265,\"type\":\"node\",\"id\":\"1564334440404\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"6ba79766-faa0-4259-8139-a4a6d35784e0\"],\"roles\":[]}}},{\"name\":\"默认所有人\",\"left\":140,\"top\":406,\"type\":\"join\",\"id\":\"1564334441965\",\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"node_7\",\"left\":351,\"top\":420,\"type\":\"end round\",\"id\":\"1564334444885\",\"width\":26,\"height\":26,\"alt\":true}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334430924\",\"to\":\"1564334435460\",\"id\":\"1564334446774\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334435460\",\"to\":\"1564334437844\",\"id\":\"1564334447796\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334437844\",\"to\":\"1564334439828\",\"id\":\"1564334448572\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334437844\",\"to\":\"1564334440404\",\"id\":\"1564334449628\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334439828\",\"to\":\"1564334441965\",\"id\":\"1564334450572\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334440404\",\"to\":\"1564334441965\",\"id\":\"1564334451684\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334441965\",\"to\":\"1564334444885\",\"id\":\"1564334453900\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":16}', '73819920-f085-4003-8874-4361b6461c92', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"1\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:29:47', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', 0, '', 0, '1');
INSERT INTO `flowinstance` VALUES ('7c8ffe55-13fd-4236-9816-63eb7e22aa68', '', '1572350961242', '按角色执行2019-10-29 20:09:25', '1564334332325', 2, '管理员', '1564334327861', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":99,\"top\":32,\"type\":\"start round mix\",\"id\":\"1564334327861\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":70,\"top\":295,\"type\":\"end round\",\"id\":\"1564334330157\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"管理员\",\"left\":43,\"top\":131,\"type\":\"node\",\"id\":\"1564334332325\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_ROLE\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[\"09ee2ffa-7463-4938-ae0b-1cb4e80c7c13\"]}}},{\"name\":\"测试人员\",\"left\":185,\"top\":226,\"type\":\"node\",\"id\":\"1564334333133\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_ROLE\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[\"0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d\"]}}}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334327861\",\"to\":\"1564334332325\",\"id\":\"1564334335789\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334332325\",\"to\":\"1564334333133\",\"id\":\"1564334336629\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334333133\",\"to\":\"1564334330157\",\"id\":\"1564334337805\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":9}', '0b21f59c-7809-4275-acb4-8e8c08e0167e', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"5\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-10-29 20:10:45', '00000000-0000-0000-0000-000000000000', 'System', 0, '预约好突然', 0, '49df1602-f5f3-4d52-afb7-3802da619558,1df68dfd-3b6d-4491-872f-00a0fc6c5a64');
INSERT INTO `flowinstance` VALUES ('b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', '', '1564334869743', 'test的普通请假2019-07-29 01:27:53', '1564334038904', 4, 'node_4', '1564334036152', '{\"title\":\"newFlow_1\",\"initNum\":9,\"lines\":[{\"id\":\"1564334041040\",\"type\":\"sl\",\"from\":\"1564334032785\",\"to\":\"1564334035352\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334041720\",\"type\":\"sl\",\"from\":\"1564334035352\",\"to\":\"1564334036152\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334042927\",\"type\":\"sl\",\"from\":\"1564334036152\",\"to\":\"1564334038904\",\"name\":\"\",\"dash\":false,\"Compares\":null}],\"nodes\":[{\"id\":\"1564334032785\",\"name\":\"node_1\",\"type\":\"start round mix\",\"left\":19,\"top\":36,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null},{\"id\":\"1564334035352\",\"name\":\"所有人可以审批\",\"type\":\"node\",\"left\":133,\"top\":50,\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"http://xxxx.com/api/workflow/callback\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"超级管理员\",\"UserId\":\"00000000-0000-0000-0000-000000000000\",\"Description\":\"\",\"TagedTime\":\"2019-10-29 14:44\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334036152\",\"name\":\"所有人可以审批\",\"type\":\"node\",\"left\":139,\"top\":123,\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":1,\"UserName\":\"超级管理员\",\"UserId\":\"00000000-0000-0000-0000-000000000000\",\"Description\":\"\",\"TagedTime\":\"2019-10-29 14:44\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334038904\",\"name\":\"node_4\",\"type\":\"end round\",\"left\":47,\"top\":193,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null}],\"areas\":[]}', '61806396-9498-492b-bc22-9f9e95a389bc', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"1\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:28:05', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test', 0, '', 1, '');
INSERT INTO `flowinstance` VALUES ('be9b74cf-2e74-40f3-9ebf-3508f6e79bde', '', '1564334669608', '带分支条件的请假（很多天数）', '1564334153687', 2, '所有人可以审批', '1564334138399', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":44,\"top\":27,\"type\":\"start round mix\",\"id\":\"1564334138399\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":50,\"top\":295,\"type\":\"end round\",\"id\":\"1564334139783\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"所有人可以审批\",\"left\":163,\"top\":43,\"type\":\"node\",\"id\":\"1564334153687\",\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"小于3的test可以审批\",\"left\":23,\"top\":141,\"type\":\"node\",\"id\":\"1564334154471\",\"width\":167,\"height\":76,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"6ba79766-faa0-4259-8139-a4a6d35784e0\"],\"roles\":[]}}},{\"name\":\"大于3的admin可以审批\",\"left\":288,\"top\":146,\"type\":\"node\",\"id\":\"1564334155295\",\"width\":143,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"49df1602-f5f3-4d52-afb7-3802da619558\"],\"roles\":[]}}},{\"name\":\"默认\",\"left\":171,\"top\":291,\"type\":\"node\",\"id\":\"1564334156607\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334138399\",\"to\":\"1564334153687\",\"id\":\"1564334158551\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334153687\",\"to\":\"1564334154471\",\"id\":\"1564334159304\",\"name\":\"\",\"dash\":false,\"alt\":true,\"Compares\":[{\"FieldName\":\"DAYS\",\"Operation\":\"<\",\"Value\":\"3\"}]},{\"type\":\"sl\",\"from\":\"1564334153687\",\"to\":\"1564334155295\",\"id\":\"1564334160383\",\"name\":\"\",\"dash\":false,\"alt\":true,\"Compares\":[{\"FieldName\":\"DAYS\",\"Operation\":\">=\",\"Value\":\"3\"}]},{\"type\":\"sl\",\"from\":\"1564334154471\",\"to\":\"1564334156607\",\"id\":\"1564334161911\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334155295\",\"to\":\"1564334156607\",\"id\":\"1564334163959\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334156607\",\"to\":\"1564334139783\",\"id\":\"1564334165255\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":16}', 'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"5\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:24:52', '00000000-0000-0000-0000-000000000000', 'System', 0, '', 0, '1');
INSERT INTO `flowinstance` VALUES ('d4f8d2b9-6374-4c10-8d3c-1ca540bc309b', '', '1572341191142', '带复杂表单的2019-10-29 17:26:42', '1564334557205', 2, 'node_2', '1564334555981', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":66,\"top\":46,\"type\":\"start round mix\",\"id\":\"1564334555981\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":50,\"top\":145,\"type\":\"node\",\"id\":\"1564334557205\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"node_3\",\"left\":56,\"top\":206,\"type\":\"node\",\"id\":\"1564334557764\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"node_4\",\"left\":66,\"top\":294,\"type\":\"end round\",\"id\":\"1564334559716\",\"width\":26,\"height\":26,\"alt\":true}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334555981\",\"to\":\"1564334557205\",\"id\":\"1564334561500\",\"name\":\"\",\"dash\":false},{\"type\":\"sl\",\"from\":\"1564334557205\",\"to\":\"1564334557764\",\"id\":\"1564334562229\",\"name\":\"\",\"dash\":false},{\"type\":\"sl\",\"from\":\"1564334557764\",\"to\":\"1564334559716\",\"id\":\"1564334563268\",\"name\":\"\",\"dash\":false}],\"areas\":[],\"initNum\":8}', '989bd1f3-29f0-43cd-ad01-b55654907dbb', 'FrmLeaveReq', '{\"id\":\"\",\"userName\":\"1\",\"requestType\":\"病假\",\"startDate\":\"2019-10-07T16:00:00.000Z\",\"startTime\":\"2019-10-29T09:26:52.000Z\",\"endDate\":\"2019-10-27T16:00:00.000Z\",\"endTime\":\"2019-10-29T09:26:54.000Z\",\"requestComment\":\"111\",\"attachment\":\"\",\"files\":[],\"extendInfo\":\"\"}', 1, '', '', '8faff4e5-b729-44d2-ac26-e899a228f63d', '', 0, '2019-10-29 17:27:06', '00000000-0000-0000-0000-000000000000', 'System', 0, '11', 0, '1');
INSERT INTO `flowinstance` VALUES ('df6df6b5-53f7-4db4-931b-12e3352ef413', '', '1564334658879', '按角色执行2019-07-29 01:24:21', '1564334332325', 2, '管理员', '1564334327861', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":99,\"top\":32,\"type\":\"start round mix\",\"id\":\"1564334327861\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":70,\"top\":295,\"type\":\"end round\",\"id\":\"1564334330157\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"管理员\",\"left\":43,\"top\":131,\"type\":\"node\",\"id\":\"1564334332325\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_ROLE\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[\"09ee2ffa-7463-4938-ae0b-1cb4e80c7c13\"]}}},{\"name\":\"测试人员\",\"left\":185,\"top\":226,\"type\":\"node\",\"id\":\"1564334333133\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_ROLE\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[\"0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d\"]}}}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334327861\",\"to\":\"1564334332325\",\"id\":\"1564334335789\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334332325\",\"to\":\"1564334333133\",\"id\":\"1564334336629\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334333133\",\"to\":\"1564334330157\",\"id\":\"1564334337805\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":9}', '0b21f59c-7809-4275-acb4-8e8c08e0167e', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"1\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:24:26', '00000000-0000-0000-0000-000000000000', 'System', 0, '', 0, '49df1602-f5f3-4d52-afb7-3802da619558');
INSERT INTO `flowinstance` VALUES ('ee589689-3ae0-4037-abec-ba70e566da16', '', '1564334720434', '普通的请假2019-07-29 01:25:24', '1564334035352', 2, '所有人可以审批', '1564334032785', '{\"title\":\"newFlow_1\",\"initNum\":9,\"lines\":[{\"id\":\"1564334041040\",\"type\":\"sl\",\"from\":\"1564334032785\",\"to\":\"1564334035352\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334041720\",\"type\":\"sl\",\"from\":\"1564334035352\",\"to\":\"1564334036152\",\"name\":\"\",\"dash\":false,\"Compares\":null},{\"id\":\"1564334042927\",\"type\":\"sl\",\"from\":\"1564334036152\",\"to\":\"1564334038904\",\"name\":\"\",\"dash\":false,\"Compares\":null}],\"nodes\":[{\"id\":\"1564334032785\",\"name\":\"node_1\",\"type\":\"start round mix\",\"left\":19,\"top\":36,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null},{\"id\":\"1564334035352\",\"name\":\"所有人可以审批\",\"type\":\"node\",\"left\":133,\"top\":50,\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"http://xxxx.com/api/workflow/callback\",\"NodeRejectType\":null,\"Taged\":2,\"UserName\":\"test\",\"UserId\":\"6ba79766-faa0-4259-8139-a4a6d35784e0\",\"Description\":\"最近有很多事情要处理\",\"TagedTime\":\"2019-07-29 01:28\",\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334036152\",\"name\":\"所有人可以审批\",\"type\":\"node\",\"left\":139,\"top\":123,\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeDesignate\":\"ALL_USER\",\"NodeDesignateData\":{\"users\":[],\"roles\":[],\"orgs\":null},\"NodeCode\":null,\"NodeName\":null,\"ThirdPartyUrl\":\"\",\"NodeRejectType\":null,\"Taged\":null,\"UserName\":null,\"UserId\":null,\"Description\":null,\"TagedTime\":null,\"NodeConfluenceType\":\"all\",\"ConfluenceOk\":null,\"ConfluenceNo\":null}},{\"id\":\"1564334038904\",\"name\":\"node_4\",\"type\":\"end round\",\"left\":47,\"top\":193,\"width\":26,\"height\":26,\"alt\":true,\"setInfo\":null}],\"areas\":[]}', '61806396-9498-492b-bc22-9f9e95a389bc', '', '{\"REASON\":\"身体原因\",\"DAYS\":\"1\",\"CUSTOME_NAME\":\"玉宝\"}', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', 'ef89f96a-af33-407c-b02e-897faf46ecf0', '', 0, '2019-07-29 01:25:30', '00000000-0000-0000-0000-000000000000', 'System', 0, '', 3, '1');

-- ----------------------------
-- Table structure for flowinstanceoperationhistory
-- ----------------------------
DROP TABLE IF EXISTS `flowinstanceoperationhistory`;
CREATE TABLE `flowinstanceoperationhistory`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键Id',
  `InstanceId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实例进程Id',
  `Content` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作内容',
  `CreateDate` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工作流实例操作记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of flowinstanceoperationhistory
-- ----------------------------
INSERT INTO `flowinstanceoperationhistory` VALUES ('07ebabd9-7880-4d9a-b365-4a1dc608a82a', 'be9b74cf-2e74-40f3-9ebf-3508f6e79bde', '【创建】超级管理员创建了一个流程进程【1564334669608/带分支条件的请假（很多天数）】', '2019-07-29 01:24:52', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('0b39f449-3369-41d7-b053-00487c2fafbe', 'ee589689-3ae0-4037-abec-ba70e566da16', '【创建】超级管理员创建了一个流程进程【1564334720434/普通的请假2019-07-29 01:25:24】', '2019-07-29 01:25:30', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('1fa6c074-8ec0-4a5a-8c39-2dc62d0140eb', '0ae5abe6-f571-4e08-b264-667dc27c5025', '【创建】超级管理员创建了一个流程进程【1564334583446/带复杂表单的2019-07-29 01:23:03】', '2019-07-29 01:23:58', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('250181cb-f242-47cf-bc16-fcc307443727', '034ad4f0-95e6-40bf-b3c5-38bd60b542d9', '【创建】超级管理员创建了一个流程进程【1564334796391/会签2019-07-29 01:26:40】', '2019-07-29 01:26:45', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('299d30e1-41d2-4f9f-a330-593fc7b87c20', 'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', '【创建】test创建了一个流程进程【1564334869743/test的普通请假2019-07-29 01:27:53】', '2019-07-29 01:28:05', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstanceoperationhistory` VALUES ('318f827b-316d-4230-841b-990b0e1aab37', 'df6df6b5-53f7-4db4-931b-12e3352ef413', '【创建】超级管理员创建了一个流程进程【1564334658879/按角色执行2019-07-29 01:24:21】', '2019-07-29 01:24:26', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('3d49913b-e389-4c7d-9f35-237e3abafa58', '034ad4f0-95e6-40bf-b3c5-38bd60b542d9', '【admin】【2019-07-29 01:30】同意,备注：', '2019-07-29 01:30:46', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');
INSERT INTO `flowinstanceoperationhistory` VALUES ('41aac141-92c6-400d-a58f-3950b1f05e44', '7c8ffe55-13fd-4236-9816-63eb7e22aa68', '【创建】超级管理员创建了一个流程进程【1572350961242/按角色执行2019-10-29 20:09:25】', '2019-10-29 20:10:45', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('41dc5606-9b46-4a2f-9a99-b7d439327cc9', '0ee22872-f120-4c5a-84ec-7f4e36bd0141', '【默认】【2019-07-29 01:30】同意,备注：', '2019-07-29 01:30:13', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');
INSERT INTO `flowinstanceoperationhistory` VALUES ('4564baf4-2f5a-4268-82ae-bb587c1a7a64', 'ee589689-3ae0-4037-abec-ba70e566da16', '【所有人可以审批】【2019-07-29 01:28】不同意,备注：最近有很多事情要处理', '2019-07-29 01:28:55', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstanceoperationhistory` VALUES ('624ed4bf-b2c1-4624-82f5-415ebffeecdb', 'd4f8d2b9-6374-4c10-8d3c-1ca540bc309b', '【创建】超级管理员创建了一个流程进程【1572341191142/带复杂表单的2019-10-29 17:26:42】', '2019-10-29 17:27:06', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('81d18fa5-f843-4d29-bf08-1423ed7df968', '0ee22872-f120-4c5a-84ec-7f4e36bd0141', '【小于3的test可以审批】【2019-07-29 01:28】同意,备注：', '2019-07-29 01:28:31', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstanceoperationhistory` VALUES ('92b7c75f-3dd3-4cdb-96ef-09d393005d85', 'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', '【所有人可以审批】【2019-10-29 14:44】同意,备注：', '2019-10-29 14:44:20', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('97643f81-40b4-4941-8cd9-ec35b517da5b', '20be4e87-0e9e-467c-9011-3c6ccd650931', '【创建】超级管理员创建了一个流程进程【1564334643592/会签2019-07-29 01:24:05】', '2019-07-29 01:24:14', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('9c375436-d2a1-4edd-9123-737ec337f2a4', '034ad4f0-95e6-40bf-b3c5-38bd60b542d9', '【admin】【2019-07-29 01:30】同意,备注：', '2019-07-29 01:30:30', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');
INSERT INTO `flowinstanceoperationhistory` VALUES ('b2594853-41a7-4c4f-bcd1-3fdf63036e9b', '0ee22872-f120-4c5a-84ec-7f4e36bd0141', '【所有人可以审批】【2019-07-29 01:26】同意,备注：', '2019-07-29 01:26:15', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('b304569d-e14a-4411-ad10-780bf5eaf3a0', '0ee22872-f120-4c5a-84ec-7f4e36bd0141', '【创建】超级管理员创建了一个流程进程【1564334742060/带分支条件的请假2019-07-29 01:25:44】', '2019-07-29 01:25:56', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('de782bfd-1320-4c6e-9e18-f7c92ad64173', '61959fe9-377a-4e6c-9f5d-6b7018a80bca', '【所有人可以审批】【2019-07-29 01:29】同意,备注：', '2019-07-29 01:29:14', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstanceoperationhistory` VALUES ('e633903e-4969-46eb-b194-c7de5c27cb8d', '034ad4f0-95e6-40bf-b3c5-38bd60b542d9', '【node_2】【2019-07-29 01:28】同意,备注：', '2019-07-29 01:28:22', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstanceoperationhistory` VALUES ('ecd380ab-3f22-4a8b-a341-4a8ff70eefff', '61959fe9-377a-4e6c-9f5d-6b7018a80bca', '【创建】超级管理员创建了一个流程进程【1564334700493/带分支条件的请假2019-07-29 01:25:02】', '2019-07-29 01:25:16', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('ee6147cc-f897-4284-b295-8e20b7c94dd0', 'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', '【所有人可以审批】【2019-10-29 14:44】同意,备注：', '2019-10-29 14:44:24', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('efa37871-2d37-4bae-8e0d-5bf98ff44241', '7a1fb1a4-06a6-49d5-a311-b988aed776e1', '【创建】admin创建了一个流程进程【1564334976909/admin的会签2019-07-29 01:29:39】', '2019-07-29 01:29:47', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');

-- ----------------------------
-- Table structure for flowinstancetransitionhistory
-- ----------------------------
DROP TABLE IF EXISTS `flowinstancetransitionhistory`;
CREATE TABLE `flowinstancetransitionhistory`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键Id',
  `InstanceId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实例Id',
  `FromNodeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '开始节点Id',
  `FromNodeType` int(11) DEFAULT NULL COMMENT '开始节点类型',
  `FromNodeName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '开始节点名称',
  `ToNodeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '结束节点Id',
  `ToNodeType` int(11) DEFAULT NULL COMMENT '结束节点类型',
  `ToNodeName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '结束节点名称',
  `TransitionSate` int(11) NOT NULL COMMENT '转化状态',
  `IsFinish` int(11) NOT NULL COMMENT '是否结束',
  `CreateDate` datetime(0) NOT NULL COMMENT '转化时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作人Id',
  `CreateUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作人名称',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工作流实例流转历史记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of flowinstancetransitionhistory
-- ----------------------------
INSERT INTO `flowinstancetransitionhistory` VALUES ('0a8aff1c-572b-4db4-9906-a3954a1d0288', '034ad4f0-95e6-40bf-b3c5-38bd60b542d9', '1564334435460', 2, 'node_2', '1564334437844', 0, '会签入口，设置会签类型', 0, 0, '2019-07-29 01:28:22', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstancetransitionhistory` VALUES ('0b11504f-9231-4cdb-862a-4d4546b9a4bd', '0ae5abe6-f571-4e08-b264-667dc27c5025', '1564334555981', 3, 'node_1', '1564334557205', 2, 'node_2', 0, 0, '2019-07-29 01:23:58', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('10efe1e8-6424-4d88-bc30-8b6722002e56', '0ee22872-f120-4c5a-84ec-7f4e36bd0141', '1564334153687', 2, '所有人可以审批', '1564334154471', 2, '小于3的test可以审批', 0, 0, '2019-07-29 01:26:15', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('121c3968-8532-43ae-b46a-dcae0973567a', 'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', '1564334032785', 3, 'node_1', '1564334035352', 2, '所有人可以审批', 0, 0, '2019-07-29 01:28:05', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstancetransitionhistory` VALUES ('19eada42-ade5-4cb1-a65b-a5d75243fe10', '034ad4f0-95e6-40bf-b3c5-38bd60b542d9', '1564334437844', 0, '会签入口，设置会签类型', '1564334444885', 4, 'node_7', 0, 1, '2019-07-29 01:30:46', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');
INSERT INTO `flowinstancetransitionhistory` VALUES ('3ac494f7-66c9-4d77-a86d-bfe93d4e1bd2', 'df6df6b5-53f7-4db4-931b-12e3352ef413', '1564334327861', 3, 'node_1', '1564334332325', 2, '管理员', 0, 0, '2019-07-29 01:24:26', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('3c9db424-34b8-43cb-b571-ca8a3102fa78', '034ad4f0-95e6-40bf-b3c5-38bd60b542d9', '1564334430924', 3, 'node_1', '1564334435460', 2, 'node_2', 0, 0, '2019-07-29 01:26:45', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('41eee5d1-e98b-46f0-99d6-fa35781059e3', 'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', '1564334036152', 2, '所有人可以审批', '1564334038904', 4, 'node_4', 0, 1, '2019-10-29 14:44:24', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('7951ef7e-7457-4d31-b661-3e7c57cbac3a', 'd4f8d2b9-6374-4c10-8d3c-1ca540bc309b', '1564334555981', 3, 'node_1', '1564334557205', 2, 'node_2', 0, 0, '2019-10-29 17:27:06', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('8fc96020-e719-4c5c-bc2f-88ad8b8361ad', 'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', '1564334035352', 2, '所有人可以审批', '1564334036152', 2, '所有人可以审批', 0, 0, '2019-10-29 14:44:20', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('9ed0cdc3-0f57-4381-bb86-f41537556832', '61959fe9-377a-4e6c-9f5d-6b7018a80bca', '1564334153687', 2, '所有人可以审批', '1564334154471', 2, '小于3的test可以审批', 0, 0, '2019-07-29 01:29:14', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstancetransitionhistory` VALUES ('b53cd6a4-0aa9-4de5-83e8-3966423e537a', '20be4e87-0e9e-467c-9011-3c6ccd650931', '1564334430924', 3, 'node_1', '1564334435460', 2, 'node_2', 0, 0, '2019-07-29 01:24:14', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('b7770b94-16ad-49cb-b2f8-b94ed032388a', '7a1fb1a4-06a6-49d5-a311-b988aed776e1', '1564334430924', 3, 'node_1', '1564334435460', 2, 'node_2', 0, 0, '2019-07-29 01:29:47', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');
INSERT INTO `flowinstancetransitionhistory` VALUES ('c13213e0-af27-4665-b8bc-4c73a7f2df23', '7c8ffe55-13fd-4236-9816-63eb7e22aa68', '1564334327861', 3, 'node_1', '1564334332325', 2, '管理员', 0, 0, '2019-10-29 20:10:45', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('c2128257-6b49-43a5-ac93-7b00d2e1b342', '0ee22872-f120-4c5a-84ec-7f4e36bd0141', '1564334138399', 3, 'node_1', '1564334153687', 2, '所有人可以审批', 0, 0, '2019-07-29 01:25:56', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('ca236899-b327-4e8b-85d4-8668c9ae5d89', 'ee589689-3ae0-4037-abec-ba70e566da16', '1564334032785', 3, 'node_1', '1564334035352', 2, '所有人可以审批', 0, 0, '2019-07-29 01:25:30', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('d2c558c2-4f31-4dea-8f2e-5fa3ac9748a0', '0ee22872-f120-4c5a-84ec-7f4e36bd0141', '1564334154471', 2, '小于3的test可以审批', '1564334156607', 2, '默认', 0, 0, '2019-07-29 01:28:31', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstancetransitionhistory` VALUES ('e22a49a2-5065-47f2-ba95-79d7174a308e', '0ee22872-f120-4c5a-84ec-7f4e36bd0141', '1564334156607', 2, '默认', '1564334139783', 4, 'node_2', 0, 1, '2019-07-29 01:30:13', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');
INSERT INTO `flowinstancetransitionhistory` VALUES ('e34b5d5e-aae4-4de0-9b31-6bd514ffe92f', 'be9b74cf-2e74-40f3-9ebf-3508f6e79bde', '1564334138399', 3, 'node_1', '1564334153687', 2, '所有人可以审批', 0, 0, '2019-07-29 01:24:52', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('f7f86afc-be9d-4521-b346-3e36355758b0', '61959fe9-377a-4e6c-9f5d-6b7018a80bca', '1564334138399', 3, 'node_1', '1564334153687', 2, '所有人可以审批', 0, 0, '2019-07-29 01:25:16', '00000000-0000-0000-0000-000000000000', '超级管理员');

-- ----------------------------
-- Table structure for flowscheme
-- ----------------------------
DROP TABLE IF EXISTS `flowscheme`;
CREATE TABLE `flowscheme`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键Id',
  `SchemeCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流程编号',
  `SchemeName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流程名称',
  `SchemeType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流程分类',
  `SchemeVersion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流程内容版本',
  `SchemeCanUser` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '流程模板使用者',
  `SchemeContent` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '流程内容',
  `FrmId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '表单ID',
  `FrmType` int(11) NOT NULL COMMENT '表单类型',
  `AuthorizeType` int(11) NOT NULL COMMENT '模板权限类型：0完全公开,1指定部门/人员',
  `SortCode` int(11) NOT NULL COMMENT '排序码',
  `DeleteMark` int(11) NOT NULL COMMENT '删除标记',
  `Disabled` int(11) NOT NULL COMMENT '有效',
  `Description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `CreateDate` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户',
  `ModifyDate` datetime(0) DEFAULT NULL COMMENT '修改时间',
  `ModifyUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '修改用户主键',
  `ModifyUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '修改用户',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工作流模板信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of flowscheme
-- ----------------------------
INSERT INTO `flowscheme` VALUES ('0b21f59c-7809-4275-acb4-8e8c08e0167e', '1564334009729', '按角色执行', '', '', '', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":99,\"top\":32,\"type\":\"start round mix\",\"id\":\"1564334327861\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":70,\"top\":295,\"type\":\"end round\",\"id\":\"1564334330157\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"管理员\",\"left\":43,\"top\":131,\"type\":\"node\",\"id\":\"1564334332325\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_ROLE\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[\"09ee2ffa-7463-4938-ae0b-1cb4e80c7c13\"]}}},{\"name\":\"测试人员\",\"left\":185,\"top\":226,\"type\":\"node\",\"id\":\"1564334333133\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_ROLE\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[\"0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d\"]}}}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334327861\",\"to\":\"1564334332325\",\"id\":\"1564334335789\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334332325\",\"to\":\"1564334333133\",\"id\":\"1564334336629\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334333133\",\"to\":\"1564334330157\",\"id\":\"1564334337805\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":9}', 'ef89f96a-af33-407c-b02e-897faf46ecf0', 0, 0, 0, 0, 0, '节点按指定的角色执行而不是指定的人', '2019-07-29 01:19:25', '', '', '2019-07-29 01:19:25', '', '');
INSERT INTO `flowscheme` VALUES ('61806396-9498-492b-bc22-9f9e95a389bc', '1564334009729', '普通的请假', '', '', '', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":19,\"top\":36,\"type\":\"start round mix\",\"id\":\"1564334032785\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"所有人可以审批\",\"left\":133,\"top\":50,\"type\":\"node\",\"id\":\"1564334035352\",\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"http://xxxx.com/api/workflow/callback\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"所有人可以审批\",\"left\":139,\"top\":123,\"type\":\"node\",\"id\":\"1564334036152\",\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"node_4\",\"left\":47,\"top\":193,\"type\":\"end round\",\"id\":\"1564334038904\",\"width\":26,\"height\":26,\"alt\":true}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334032785\",\"to\":\"1564334035352\",\"id\":\"1564334041040\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334035352\",\"to\":\"1564334036152\",\"id\":\"1564334041720\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334036152\",\"to\":\"1564334038904\",\"id\":\"1564334042927\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":9}', 'ef89f96a-af33-407c-b02e-897faf46ecf0', 0, 0, 0, 0, 0, '非常简单的请假流程', '2019-07-29 01:14:48', '', '', '2019-07-29 01:14:48', '', '');
INSERT INTO `flowscheme` VALUES ('73819920-f085-4003-8874-4361b6461c92', '1564334009729', '会签', '', '', '', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":17,\"top\":12,\"type\":\"start round mix\",\"id\":\"1564334430924\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":141,\"top\":49,\"type\":\"node\",\"id\":\"1564334435460\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"会签入口，设置会签类型\",\"left\":141,\"top\":138,\"type\":\"fork\",\"id\":\"1564334437844\",\"width\":104,\"height\":76,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"admin\",\"left\":23,\"top\":272,\"type\":\"node\",\"id\":\"1564334439828\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"49df1602-f5f3-4d52-afb7-3802da619558\"],\"roles\":[]}}},{\"name\":\"test\",\"left\":234,\"top\":265,\"type\":\"node\",\"id\":\"1564334440404\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"6ba79766-faa0-4259-8139-a4a6d35784e0\"],\"roles\":[]}}},{\"name\":\"默认所有人\",\"left\":140,\"top\":406,\"type\":\"join\",\"id\":\"1564334441965\",\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"node_7\",\"left\":351,\"top\":420,\"type\":\"end round\",\"id\":\"1564334444885\",\"width\":26,\"height\":26,\"alt\":true}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334430924\",\"to\":\"1564334435460\",\"id\":\"1564334446774\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334435460\",\"to\":\"1564334437844\",\"id\":\"1564334447796\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334437844\",\"to\":\"1564334439828\",\"id\":\"1564334448572\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334437844\",\"to\":\"1564334440404\",\"id\":\"1564334449628\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334439828\",\"to\":\"1564334441965\",\"id\":\"1564334450572\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334440404\",\"to\":\"1564334441965\",\"id\":\"1564334451684\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334441965\",\"to\":\"1564334444885\",\"id\":\"1564334453900\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":16}', 'ef89f96a-af33-407c-b02e-897faf46ecf0', 0, 0, 0, 0, 0, '需要多人审批的流程，比如需要多人全部批准该步骤才能通过，或至少有一个通过', '2019-07-29 01:22:03', '', '', '2019-07-29 01:22:03', '', '');
INSERT INTO `flowscheme` VALUES ('989bd1f3-29f0-43cd-ad01-b55654907dbb', '1564334009729', '带复杂表单的', '', '', '', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":66,\"top\":46,\"type\":\"start round mix\",\"id\":\"1564334555981\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":50,\"top\":145,\"type\":\"node\",\"id\":\"1564334557205\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"node_3\",\"left\":56,\"top\":206,\"type\":\"node\",\"id\":\"1564334557764\",\"width\":104,\"height\":26,\"alt\":true},{\"name\":\"node_4\",\"left\":66,\"top\":294,\"type\":\"end round\",\"id\":\"1564334559716\",\"width\":26,\"height\":26,\"alt\":true}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334555981\",\"to\":\"1564334557205\",\"id\":\"1564334561500\",\"name\":\"\",\"dash\":false},{\"type\":\"sl\",\"from\":\"1564334557205\",\"to\":\"1564334557764\",\"id\":\"1564334562229\",\"name\":\"\",\"dash\":false},{\"type\":\"sl\",\"from\":\"1564334557764\",\"to\":\"1564334559716\",\"id\":\"1564334563268\",\"name\":\"\",\"dash\":false}],\"areas\":[],\"initNum\":8}', '8faff4e5-b729-44d2-ac26-e899a228f63d', 1, 0, 0, 0, 0, '这是一个带有复杂表单的流程，比如需要上传文件', '2019-07-29 01:22:45', '', '', '2019-10-29 17:25:20', '', '');
INSERT INTO `flowscheme` VALUES ('bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', '1564334009729', '带分支条件的请假', '', '', '', '{\"title\":\"newFlow_1\",\"nodes\":[{\"name\":\"node_1\",\"left\":44,\"top\":27,\"type\":\"start round mix\",\"id\":\"1564334138399\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"node_2\",\"left\":50,\"top\":295,\"type\":\"end round\",\"id\":\"1564334139783\",\"width\":26,\"height\":26,\"alt\":true},{\"name\":\"所有人可以审批\",\"left\":163,\"top\":43,\"type\":\"node\",\"id\":\"1564334153687\",\"width\":104,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}},{\"name\":\"小于3的test可以审批\",\"left\":23,\"top\":141,\"type\":\"node\",\"id\":\"1564334154471\",\"width\":167,\"height\":76,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"6ba79766-faa0-4259-8139-a4a6d35784e0\"],\"roles\":[]}}},{\"name\":\"大于3的admin可以审批\",\"left\":288,\"top\":146,\"type\":\"node\",\"id\":\"1564334155295\",\"width\":143,\"height\":56,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"SPECIAL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[\"49df1602-f5f3-4d52-afb7-3802da619558\"],\"roles\":[]}}},{\"name\":\"默认\",\"left\":171,\"top\":291,\"type\":\"node\",\"id\":\"1564334156607\",\"width\":104,\"height\":36,\"alt\":true,\"setInfo\":{\"NodeConfluenceType\":\"all\",\"NodeDesignate\":\"ALL_USER\",\"ThirdPartyUrl\":\"\",\"NodeDesignateData\":{\"users\":[],\"roles\":[]}}}],\"lines\":[{\"type\":\"sl\",\"from\":\"1564334138399\",\"to\":\"1564334153687\",\"id\":\"1564334158551\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334153687\",\"to\":\"1564334154471\",\"id\":\"1564334159304\",\"name\":\"\",\"dash\":false,\"alt\":true,\"Compares\":[{\"FieldName\":\"DAYS\",\"Operation\":\"<\",\"Value\":\"3\"}]},{\"type\":\"sl\",\"from\":\"1564334153687\",\"to\":\"1564334155295\",\"id\":\"1564334160383\",\"name\":\"\",\"dash\":false,\"alt\":true,\"Compares\":[{\"FieldName\":\"DAYS\",\"Operation\":\">=\",\"Value\":\"3\"}]},{\"type\":\"sl\",\"from\":\"1564334154471\",\"to\":\"1564334156607\",\"id\":\"1564334161911\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334155295\",\"to\":\"1564334156607\",\"id\":\"1564334163959\",\"name\":\"\",\"dash\":false,\"alt\":true},{\"type\":\"sl\",\"from\":\"1564334156607\",\"to\":\"1564334139783\",\"id\":\"1564334165255\",\"name\":\"\",\"dash\":false,\"alt\":true}],\"areas\":[],\"initNum\":16}', 'ef89f96a-af33-407c-b02e-897faf46ecf0', 0, 0, 0, 0, 0, '在连接线上可以设置分支条件', '2019-07-29 01:17:46', '', '', '2019-07-29 01:17:46', '', '');

-- ----------------------------
-- Table structure for form
-- ----------------------------
DROP TABLE IF EXISTS `form`;
CREATE TABLE `form`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单模板Id',
  `Name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '表单名称',
  `FrmType` int(11) NOT NULL COMMENT '表单类型，0：默认动态表单；1：Web自定义表单',
  `WebId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '系统页面标识，当表单类型为用Web自定义的表单时，需要标识加载哪个页面',
  `Fields` int(11) NOT NULL COMMENT '字段个数',
  `ContentData` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '表单中的控件属性描述',
  `ContentParse` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '表单控件位置模板',
  `Content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '表单原html模板未经处理的',
  `SortCode` int(11) NOT NULL COMMENT '排序码',
  `DeleteMark` int(11) NOT NULL COMMENT '删除标记',
  `DbName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据库名称',
  `Disabled` int(11) NOT NULL COMMENT '有效',
  `Description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `CreateDate` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户',
  `ModifyDate` datetime(0) DEFAULT NULL COMMENT '修改时间',
  `ModifyUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '修改用户主键',
  `ModifyUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '修改用户',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '表单模板表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of form
-- ----------------------------
INSERT INTO `form` VALUES ('8faff4e5-b729-44d2-ac26-e899a228f63d', '系统内置的复杂请假条表单', 1, 'FrmLeaveReq', 0, '', '', '', 0, 0, '', 0, '企业版内置的复杂请假条表单', '2019-07-29 01:03:36', '', '', '2019-07-29 01:03:36', '', '');
INSERT INTO `form` VALUES ('b08bb00f-e1df-44f8-904f-58ee5b1f4eb4', '领料单', 0, '', 0, '[{\"leipiplugins\":\"select\",\"name\":\"TOOLS\",\"title\":\"TOOLS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"电脑,平板,手机,签字笔\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"TOOLS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"电脑\\\" selected=\\\"selected\\\">电脑</option><option value=\\\"平板\\\">平板</option><option value=\\\"手机\\\">手机</option><option value=\\\"签字笔\\\">签字笔</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"NUMBERS\",\"title\":\"NUMBERS\",\"value\":\"1\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"int\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"NUMBERS\\\" value=\\\"1\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"int\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"name\":\"APPLY_REASON\",\"title\":\"APPLY_REASON\",\"leipiplugins\":\"textarea\",\"value\":\"\",\"orgrich\":\"0\",\"orgfontsize\":\"\",\"orgwidth\":\"300\",\"orgheight\":\"80\",\"style\":\"width:300px;height:80px;\",\"content\":\"<textarea title=\\\"APPLY_REASON\\\" name=\\\"leipiNewField\\\" leipiplugins=\\\"textarea\\\" value=\\\"\\\" orgrich=\\\"0\\\" orgfontsize=\\\"\\\" orgwidth=\\\"300\\\" orgheight=\\\"80\\\" style=\\\"width:300px;height:80px;\\\"></textarea>\"},{\"leipiplugins\":\"checkboxs\",\"name\":\"\",\"title\":\"NEEDRETURN\",\"parse_name\":\"checkboxs_0\",\"value\":\"归还,无需归还\",\"content\":\"<span leipiplugins=\\\"checkboxs\\\"  title=\\\"NEEDRETURN\\\"><input type=\\\"checkbox\\\" name=\\\"leipiNewField\\\" value=\\\"归还\\\"  checked=\\\"checked\\\"/>归还&nbsp;<input type=\\\"checkbox\\\" name=\\\"leipiNewField\\\" value=\\\"无需归还\\\"  />无需归还&nbsp;</span>\",\"options\":[{\"name\":\"leipiNewField\",\"value\":\"归还\",\"checked\":\"checked\",\"type\":\"checkbox\"},{\"name\":\"leipiNewField\",\"value\":\"无需归还\",\"type\":\"checkbox\"}]}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">领料单</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><table data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td width=\"534\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 24px;\">名目</span></td><td width=\"534\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 24px;\">数量</span></td><td width=\"534\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 24px;\">说明</span></td></tr><tr><td width=\"534\" valign=\"top\">{TOOLS}</td><td width=\"534\" valign=\"top\">{NUMBERS}</td><td width=\"534\" valign=\"top\">{APPLY_REASON}</td></tr><tr><td valign=\"top\" rowspan=\"1\" colspan=\"3\" style=\"word-break: break-all;\">{checkboxs_0}</td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">领料单</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><table data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td width=\"534\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 24px;\">名目</span></td><td width=\"534\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 24px;\">数量</span></td><td width=\"534\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 24px;\">说明</span></td></tr><tr><td width=\"534\" valign=\"top\">{|-<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option><option value=\"签字笔\">签字笔</option></select>&nbsp;&nbsp;</span>-|}</td><td width=\"534\" valign=\"top\"><input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/></td><td width=\"534\" valign=\"top\"><textarea title=\"APPLY_REASON\" name=\"leipiNewField\" leipiplugins=\"textarea\" value=\"\" orgrich=\"0\" orgfontsize=\"\" orgwidth=\"300\" orgheight=\"80\" style=\"width:300px;height:80px;\"></textarea></td></tr><tr><td valign=\"top\" rowspan=\"1\" colspan=\"3\" style=\"word-break: break-all;\">{|-<span leipiplugins=\"checkboxs\"  title=\"NEEDRETURN\"><input type=\"checkbox\" name=\"leipiNewField\" value=\"归还\"  checked=\"checked\"/>归还&nbsp;<input type=\"checkbox\" name=\"leipiNewField\" value=\"无需归还\"  />无需归还&nbsp;</span>-|}</td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>', 0, 0, '', 0, '带有选择框文本框复选框等的领料单据', '2019-07-29 01:13:02', '', '', '2019-07-29 01:13:02', '', '');
INSERT INTO `form` VALUES ('ef89f96a-af33-407c-b02e-897faf46ecf0', '请假条表单', 0, '', 0, '[{\"type\":\"text\",\"name\":\"REASON\",\"title\":\"REASON\",\"value\":\"身体原因\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"REASON\\\" value=\\\"身体原因\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"},{\"leipiplugins\":\"select\",\"name\":\"DAYS\",\"title\":\"DAYS\",\"size\":\"1\",\"orgwidth\":\"150\",\"style\":\"width: 150px;\",\"value\":\"1,3,5,10\",\"selected\":\"selected\",\"content\":\"<span leipiplugins=\\\"select\\\"><select name=\\\"leipiNewField\\\" title=\\\"DAYS\\\" leipiplugins=\\\"select\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" style=\\\"width: 150px;\\\"><option value=\\\"1\\\" selected=\\\"selected\\\">1</option><option value=\\\"3\\\">3</option><option value=\\\"5\\\">5</option><option value=\\\"10\\\">10</option></select>&nbsp;&nbsp;</span>\"},{\"type\":\"text\",\"name\":\"CUSTOME_NAME\",\"title\":\"CUSTOME_NAME\",\"value\":\"玉宝\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"CUSTOME_NAME\\\" value=\\\"玉宝\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', '<p style=\"text-align: center;\"><span style=\"font-size: 36px;\">请假条</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p style=\"text-align: center;\">因<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>，本人想请假{|-<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>-|}天，望领导批准！</p><p><br/></p><p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style=\"text-align: right;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/></p>', 0, 0, '', 0, '带有选择框文本框的请假条', '2019-07-29 01:07:03', '', '', '2019-07-29 01:07:03', '', '');
INSERT INTO `form` VALUES ('febe218d-21a6-44b6-b7ce-b83e73556ad9', '审批流程', 0, 'FrmLeaveReq', 0, '[{\"type\":\"text\",\"name\":\"姓名\",\"title\":\"姓名\",\"value\":\"\",\"leipiplugins\":\"text\",\"orghide\":\"0\",\"orgalign\":\"left\",\"orgwidth\":\"150\",\"orgtype\":\"text\",\"style\":\"text-align: left; width: 150px;\",\"content\":\"<input name=\\\"leipiNewField\\\" type=\\\"text\\\" title=\\\"姓名\\\" value=\\\"\\\" leipiplugins=\\\"text\\\" orghide=\\\"0\\\" orgalign=\\\"left\\\" orgwidth=\\\"150\\\" orgtype=\\\"text\\\" style=\\\"text-align: left; width: 150px;\\\"/>\"}]', '<p>{姓名}</p>', '<p><input name=\"leipiNewField\" type=\"text\" title=\"姓名\" value=\"\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/></p>', 0, 0, '', 0, '', '2019-10-29 13:57:35', '', '', '2019-10-29 13:57:35', '', '');

-- ----------------------------
-- Table structure for frmleavereq
-- ----------------------------
DROP TABLE IF EXISTS `frmleavereq`;
CREATE TABLE `frmleavereq`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `UserName` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请假人姓名',
  `RequestType` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请假分类，病假，事假，公休等',
  `StartDate` date NOT NULL COMMENT '开始日期',
  `StartTime` datetime(0) DEFAULT NULL COMMENT '开始时间',
  `EndDate` date NOT NULL COMMENT '结束日期',
  `EndTime` datetime(0) DEFAULT NULL COMMENT '结束时间',
  `RequestComment` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '请假说明',
  `Attachment` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '附件，用于提交病假证据等',
  `CreateDate` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户',
  `FlowInstanceId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属流程ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模拟一个自定页面的表单，该数据会关联到流程实例FrmData，可用于复杂页面的设计及后期的数据分析' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of frmleavereq
-- ----------------------------
INSERT INTO `frmleavereq` VALUES ('06307008-1dd9-48ad-a516-bcf4714cc9a7', '1', '病假', '2019-10-07', '2019-10-29 09:26:52', '2019-10-27', '2019-10-29 09:26:54', '111', '', '2019-10-29 17:27:06', '', '', 'd4f8d2b9-6374-4c10-8d3c-1ca540bc309b');
INSERT INTO `frmleavereq` VALUES ('59b5b72f-b8fb-44d4-bb24-319d02b2ab80', '李玉宝', '事假', '2019-07-08', '2019-07-28 17:23:14', '2019-07-24', '2019-07-28 17:23:18', '太累了，就是想休息一下', '', '2019-07-29 01:23:58', '', '', '0ae5abe6-f571-4e08-b264-667dc27c5025');

-- ----------------------------
-- Table structure for module
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '功能模块流水号',
  `CascadeId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '节点语义ID',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '功能模块名称',
  `Url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主页面URL',
  `HotKey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '热键',
  `IsLeaf` tinyint(4) NOT NULL COMMENT '是否叶子节点',
  `IsAutoExpand` tinyint(4) NOT NULL COMMENT '是否自动展开',
  `IconName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '节点图标文件名称',
  `Status` int(11) NOT NULL COMMENT '当前状态',
  `ParentName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父节点名称',
  `Vector` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '矢量图标',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `ParentId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父节点流水号',
  `Code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `IsSys` tinyint(4) NOT NULL COMMENT '是否为系统模块',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '功能模块表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of module
-- ----------------------------
INSERT INTO `module` VALUES ('0031262c-689c-4b96-bae2-2c9d67076ade', '.0.1.9.', '流程设计', '/flowSchemes/index', '', 0, 0, 'layui-icon-engine', 0, '基础配置', '', 6, '7580672f-a390-4bb6-982d-9a4570cb5199', 'FlowScheme', 1);
INSERT INTO `module` VALUES ('069475e3-c997-487a-9f29-e6a864c5c1d4', '.0.2.', '流程中心', '/', '', 0, 0, 'layui-icon-senior', 0, '根节点', '', 3, NULL, NULL, 1);
INSERT INTO `module` VALUES ('15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9', '.0.4.', '仓储中心', '/', '', 0, 0, '', 0, '根节点', '', 2, NULL, '', 0);
INSERT INTO `module` VALUES ('37bb9414-19a0-4223-9056-71f8c758a930', '.0.2.5.', '已处理流程', '/flowinstances/disposed', '', 0, 0, 'layui-icon-ok-circle', 0, '流程中心', '', 3, '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstanceDisposed', 1);
INSERT INTO `module` VALUES ('4abafc83-c8f5-452f-9882-e113a86e7a3e', '.0.2.6.', '待处理流程', '/flowinstances/wait', '', 0, 0, 'layui-icon-help', 0, '流程中心', '', 1, '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstanceWait', 1);
INSERT INTO `module` VALUES ('6a9e1346-0c01-44d2-8eb1-f929fdab542a', '.0.1.10.', '部门管理', '/OrgManager/Index', '', 0, 0, 'layui-icon-group', 0, '基础配置', '', 4, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Org', 1);
INSERT INTO `module` VALUES ('7580672f-a390-4bb6-982d-9a4570cb5199', '.0.1.', '基础配置', ' /', '', 0, 0, 'layui-icon-set-fill', 0, '根节点', '', 1, NULL, NULL, 1);
INSERT INTO `module` VALUES ('7bc7e527-478d-49fd-868d-5f31951586f5', '.0.3.1.', '系统日志', '/SysLogs/Index', '', 0, 0, 'layui-icon-theme', 0, '消息日志', '', 1, 'b19bce90-5508-43b6-93ed-cd9ff9e356a9', 'SysLog', 1);
INSERT INTO `module` VALUES ('7bc7e527-478d-49fd-868d-5f31951586f6', '.0.3.2.', '我的消息', '/SysMessages/Index', '', 0, 0, 'layui-icon-theme', 0, '消息日志', '', 2, 'b19bce90-5508-43b6-93ed-cd9ff9e356a9', 'SysMessage', 1);
INSERT INTO `module` VALUES ('92b00259-2d15-43e7-9321-adffb29e8bf2', '.0.1.11.', '表单设计', '/forms/index', '', 0, 0, 'layui-icon-theme', 0, '基础配置', '', 5, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Form', 1);
INSERT INTO `module` VALUES ('9486ff22-b696-4d7f-8093-8a3e53c45453', '.0.2.7.', '我的流程', '/flowInstances/Index', '', 0, 0, 'layui-icon-share', 0, '流程中心', '', 2, '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstance', 1);
INSERT INTO `module` VALUES ('98a949e8-8704-40a7-b9a1-c0e8801e4057', '.0.4.1.', '入库订单', '/wmsinboundordertbls/index', '', 0, 0, '', 0, '仓储中心', '', 1, '15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9', 'WmsInboundOrderTbl', 0);
INSERT INTO `module` VALUES ('9a87c0fa-9172-42a1-9505-7492433dcb8e', '.0.1.16.', '数据权限', '/dataprivilegerules/index', '', 0, 0, 'layui-icon-auz', 0, '基础配置', '', 1, '7580672f-a390-4bb6-982d-9a4570cb5199', 'DataPrivilegeRule', 0);
INSERT INTO `module` VALUES ('a94d5648-c2a9-405e-ba6f-f1602ec9b807', '.0.1.12.', '字典分类', '/Categories/Index', '', 0, 0, 'layui-icon-app', 0, '基础配置', '', 7, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Category', 0);
INSERT INTO `module` VALUES ('b19bce90-5508-43b6-93ed-cd9ff9e356a9', '.0.3.', '消息日志', ' /', '', 0, 0, 'layui-icon-set-fill', 0, '根节点', '', 4, NULL, NULL, 1);
INSERT INTO `module` VALUES ('bc80478d-0547-4437-9cff-be4b40144bdf', '.0.1.13.', '模块管理', '/ModuleManager/Index', '', 0, 0, 'layui-icon-tabs', 0, '基础配置', '', 1, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Module', 1);
INSERT INTO `module` VALUES ('bedb41a2-f310-4775-af99-01be08adda93', '.0.1.14.', '角色管理', '/RoleManager/Index', '', 0, 0, 'layui-icon-user', 0, '基础配置', '', 2, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Role', 1);
INSERT INTO `module` VALUES ('e8dc5db6-4fc4-4795-a1cc-681cbcceec91', '.0.1.3.', '资源管理', '/Resources/Index', '', 0, 0, 'layui-icon-cellphone', 0, '基础配置', '', 8, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Resource', 0);
INSERT INTO `module` VALUES ('ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', '.0.1.15.', '用户管理', '/UserManager/Index', '', 0, 0, 'layui-icon-friends', 0, '基础配置', '', 3, '7580672f-a390-4bb6-982d-9a4570cb5199', 'User', 1);

-- ----------------------------
-- Table structure for moduleelement
-- ----------------------------
DROP TABLE IF EXISTS `moduleelement`;
CREATE TABLE `moduleelement`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号',
  `DomId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'DOM ID',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `Attr` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '元素附加属性',
  `Script` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '元素调用脚本',
  `Icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '元素图标',
  `Class` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '元素样式',
  `Remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  `Sort` int(11) NOT NULL COMMENT '排序字段',
  `ModuleId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '功能模块Id',
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模块元素表(需要权限控制的按钮)' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of moduleelement
-- ----------------------------
INSERT INTO `moduleelement` VALUES ('06fe4738-b4f4-4ecf-b9da-07dd3bb26cb3', 'btnDel', '撤销订单', '', '', 'layui-icon-delete', 'layui-btn-danger', '', 2, '98a949e8-8704-40a7-b9a1-c0e8801e4057', '', '');
INSERT INTO `moduleelement` VALUES ('0d25438e-1436-48e0-aedf-0f1690693282', 'btnAccessModule', '为角色分配模块', '', 'assignRoleModule(this)', 'layui-icon-search', 'layui-btn-normal', '为角色分配模块', 4, 'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('13617796-049c-4ae4-a62b-1ca84002b273', 'btnDelCategory', '删除分类', '', '', 'layui-icon-delete', 'layui-btn-danger', '', 0, 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', '', '');
INSERT INTO `moduleelement` VALUES ('15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', 'btnAssignReource', '为角色分配资源', '', 'openRoleReourceAccess(this)', 'layui-icon-search', 'layui-btn-normal', '为角色分配资源', 3, 'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('17ae4fd4-ab4e-439e-ba1d-2a53b46d112b', 'btnDel', '删除', '', 'del()', 'layui-icon-delete', 'layui-btn-danger', '', 2, '0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('18cc3217-28a6-49b2-9a20-080230065984', 'btnEdit', '编辑', '', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '', 1, '0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('1a473afd-cbd4-41e9-9471-81f9435aaabe', 'btnEdit', '编辑', ' ', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '编辑分类', 0, 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('1c870438-4260-43a5-8996-a6e1dc8bbf6a', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '添加部门', 0, '6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', 'btnEdit', '编辑', '', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '编辑角色', 1, 'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('2d595a2a-5de5-479e-a331-b53c799a6b10', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '添加分类', 0, 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('2feefce1-e3d8-42ac-b811-2352679628da', 'btnDel', '删除', '', 'del()', 'layui-icon-delete', 'layui-btn-danger', '刪除用戶', 2, 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('34730f5a-d307-457b-9041-5f7de30abfa9', 'btnEdit', '编辑', '', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '编辑用户', 1, 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('362d1eda-c85e-4b14-a80a-b923291e08de', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '添加', 0, 'f0f06b8f-0a86-487c-8b0e-0a12573ccd46', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('38109ca0-32ec-44bd-a243-017e591b532b', 'btnEditStock', '编辑', ' ', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '编辑进出库', 0, '89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('3dc0ec4d-bf86-4bae-9ec0-1d6c2403fb99', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '', 1, '92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('44075557-496e-4dde-bb75-7b69f51ab4fe', 'btnEdit', '编辑', '', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '编辑模块', 2, 'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('4bfa8ea0-6b0d-426f-8687-b654575ca780', 'btnEdit', '编辑', '', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '编辑资源', 2, 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('4f2737db-633f-4946-8a71-b08b9885f151', 'btnEdit', '编辑', '', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '', 2, '92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('50c9df24-b233-42cb-9a0d-4ce158c75f86', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '添加用戶', 0, 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('584c7a3b-d28a-47b4-8648-7797d05d83d1', 'btnDel', '删除', '', 'del()', 'layui-icon-delete', 'layui-btn-danger', '', 3, '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('5ed1681c-13d2-4c87-8675-a8d95c0b40ae', 'btnAddMenu', '添加菜单', '', 'assignButton()', 'layui-icon-add-1', 'layui-btn-normal', '为模块分配按钮', 4, 'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('5ed1681c-13d2-4c87-8676-a8d95c0b40ae', 'btnEditMenu', '编辑菜单', '', '', 'layui-icon-add-1', 'layui-btn-normal', '编辑菜单', 5, 'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('5ed1681c-13d2-4c87-8677-a8d95c0b40ae', 'btnDelMenu', '删除菜单', '', '', 'layui-icon-delete', 'layui-btn-danger', '', 6, 'bc80478d-0547-4437-9cff-be4b40144bdf', '', '');
INSERT INTO `moduleelement` VALUES ('645b40ac-4223-44a7-aab4-66eb56cf9864', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '添加角色', 0, 'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('68484265-7802-4f06-b024-33e8b2f2edcf', 'btnAdd', '新的申请', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '申请物品', 0, '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('68fc793f-069f-43e1-a012-42ac2d7c585c', 'btnDel', '删除', '', 'del()', 'layui-icon-delete', 'layui-btn-danger', '删除角色', 2, 'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('6c814946-db5c-48bd-84dd-b1c38196ad74', 'btnAdd', '添加模版', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '', 0, '0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('6db928fe-93df-460f-9472-8bb0b6cae52c', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '添加进出库', 0, '89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', 'btnVerification', '处理', '', 'verificationForm()', 'layui-icon-triangle-r', 'layui-btn-normal', '', 5, '4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', 'btnDel', '删除', '', 'del()', 'layui-icon-delete', 'layui-btn-danger', '删除部门', 2, '6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('7f071c63-1620-4486-9264-5806b2e63218', 'btnAccessRole', '为用户分配角色', '', 'openUserRoleAccess(this)', 'layui-icon-search', 'layui-btn-normal', '为用户分配角色', 5, 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('816b12b3-e916-446d-a2fa-329cfd13c831', 'btnDetail', '进度详情', '', '', 'layui-icon-search', 'layui-btn-normal', '', 4, '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('81ce1abe-209d-4e4c-a8d2-efbc6a3b45ba', 'btnAdd', '添加', '', '', 'layui-icon-add-1', 'layui-btn-normal', '', 1, '9a87c0fa-9172-42a1-9505-7492433dcb8e', '', '');
INSERT INTO `moduleelement` VALUES ('826b12b3-e916-446d-a2fa-329cfd13c831', 'btnDetail', '进度详情', '', '', 'layui-icon-search', 'layui-btn-normal', '', 4, '4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('84694ea5-d6e1-4a65-8a59-7b5b779688d4', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '添加模块', 1, 'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('84e38920-f6e5-499c-bf52-a3c6f8499ff7', 'btnDelStock', '删除', ' ', 'del()', 'layui-icon-delete', 'layui-btn-danger', '删除分类', 0, 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('8966b04f-8e26-4046-8b03-0c64f9f833dd', 'btnDel', '删除', '', 'del()', 'layui-icon-delete', 'layui-btn-danger', '', 3, '92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('95c2dde0-f2a7-4474-8aa7-c7eaa7c4c87f', 'btnDel', '删除', '', '', 'layui-icon-delete', 'layui-btn-danger', '', 1, '9a87c0fa-9172-42a1-9505-7492433dcb8e', '', '');
INSERT INTO `moduleelement` VALUES ('9c96e485-84a6-45f0-b6a7-f01dab94b0c6', 'btnPreview', '预览', '', 'preview()', 'layui-icon-search', 'layui-btn-normal', '', 4, '92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('9e2c6754-f258-4b14-96a0-b9d981196a65', 'btnAdd', '添加', '', 'add()', 'layui-icon-add-1', 'layui-btn-normal', '添加资源', 0, 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('a7eea5dc-3b10-4550-9cf3-0dba9b9fc32c', 'btnAddCategory', '添加分类', '', '', 'layui-icon-add-1', 'layui-btn-normal', '', 0, 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', '', '');
INSERT INTO `moduleelement` VALUES ('b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', 'btnDetail', '查看详情', '', '', 'layui-icon-search', 'layui-btn-normal', '', 0, '37bb9414-19a0-4223-9056-71f8c758a930', '', '');
INSERT INTO `moduleelement` VALUES ('c35d8f5b-0d38-4f31-84f9-39e476eeab08', 'btnAdd', '新订单', '', '', 'layui-icon-add-1', 'layui-btn-normal', '', 1, '98a949e8-8704-40a7-b9a1-c0e8801e4057', '', '');
INSERT INTO `moduleelement` VALUES ('c3d7b478-21e9-4c1e-b866-a3c80be7909b', 'btnRefresh', '刷新', '', 'refresh()', 'layui-icon-refresh', 'layui-btn-normal', '刷新分类', 0, 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', 'btnDel', '删除', '', 'del()', 'layui-icon-delete', 'layui-btn-danger', '删除进出库', 0, '89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('c7d7daf0-3669-4a22-8bed-b092617deb9c', 'btnDel', '删除', '', 'del()', 'layui-icon-delete', 'layui-btn-danger', '删除资源', 3, 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('d1ba6a72-ba14-44c0-baba-46d0ad96fe8a', 'btnRefresh', '刷新', '', 'refresh()', 'layui-icon-refresh', 'layui-btn-normal', '刷新用户', 3, 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('d352c8ee-3dff-4d28-a0de-903ae68f2533', 'btnPreview', '预览', '', 'preview()', 'layui-icon-cellphone', 'layui-btn-normal', '', 1, '0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('daddf3b9-71b5-45ac-b85d-5a11c522f2f4', 'btnDel', '删除', ' ', 'del()', 'layui-icon-delete', 'layui-btn-danger', '删除模块', 3, 'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('ef42721f-d223-4a00-a1d9-80b81121f21a', 'btnEdit', '编辑', ' ', 'edit()', 'layui-icon-edit', 'layui-btn-normal', '编辑部门', 0, '6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL);
INSERT INTO `moduleelement` VALUES ('f8dde22a-2a37-47c4-8e67-70fb3af5303e', 'btnRefresh', '刷新', '', 'refresh()', 'layui-icon-refresh', 'layui-btn-normal', '刷新部门', 0, '6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL);

-- ----------------------------
-- Table structure for org
-- ----------------------------
DROP TABLE IF EXISTS `org`;
CREATE TABLE `org`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号',
  `CascadeId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '节点语义ID',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组织名称',
  `HotKey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '热键',
  `ParentName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父节点名称',
  `IsLeaf` tinyint(4) NOT NULL COMMENT '是否叶子节点',
  `IsAutoExpand` tinyint(4) NOT NULL COMMENT '是否自动展开',
  `IconName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '节点图标文件名称',
  `Status` int(11) NOT NULL COMMENT '当前状态',
  `BizCode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务对照码',
  `CustomCode` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自定义扩展码',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateId` int(11) NOT NULL COMMENT '创建人ID',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `ParentId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父节点流水号',
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组织表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of org
-- ----------------------------
INSERT INTO `org` VALUES ('08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '.0.1.4.1.', '研发小组', '', '汇丰软件部', 0, 0, '', 0, '0', '', '2016-10-14 11:40:31', 0, 1, '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `org` VALUES ('182dac38-64a0-414c-990c-7c9b7558a367', '.0.4.', '中部片区', '', '根节点', 0, 0, '', 0, '', '', '2019-10-31 21:52:38', 0, 0, NULL, '', '');
INSERT INTO `org` VALUES ('1b965fff-3dcd-42ff-9624-2c8eb4f9b1c6', '.0.5.1.', '广州营销中心', '', '华南片区', 0, 0, '', 0, '', '', '2019-10-31 21:56:39', 0, 0, '8e31553c-cab8-4eb3-90b5-5f8ff1d21801', '', '');
INSERT INTO `org` VALUES ('2089637b-403d-4d4d-91ff-c8a554973f96', '.0.4.1.', '海外市场部', '', '中部片区', 0, 0, '', 0, '', '', '2019-10-31 21:53:54', 0, 0, '182dac38-64a0-414c-990c-7c9b7558a367', '', '');
INSERT INTO `org` VALUES ('3d2ad14c-2c56-4a90-a2db-6bde26b0b8b3', '.0.3.1.', '成都营销中心', '', '西南片区', 0, 0, '', 0, '', '', '2019-10-31 21:55:42', 0, 0, '60620558-89a2-4b28-8637-52f514773725', '', '');
INSERT INTO `org` VALUES ('4a3920f1-1470-477e-97ec-0996eb83b638', '.0.1.6.', '市场2部', '', '总部大区', 0, 0, '', 0, '', '', '2019-10-31 21:55:07', 0, 0, '543a9fcf-4770-4fd9-865f-030e562be238', '', '');
INSERT INTO `org` VALUES ('543a9fcf-4770-4fd9-865f-030e562be238', '.0.1.', '总部大区', '', '根节点', 0, 0, '', 0, '0', '', '2016-10-14 11:37:13', 0, 0, NULL, NULL, NULL);
INSERT INTO `org` VALUES ('60620558-89a2-4b28-8637-52f514773725', '.0.3.', '西南片区', '', '根节点', 0, 0, '', 0, '', '', '2019-10-31 21:52:30', 0, 0, NULL, '', '');
INSERT INTO `org` VALUES ('66386671-0494-4e83-8346-fbcf73283f7b', '.0.2.', '华东片区', '', '根节点', 0, 0, '', 0, '', '', '2019-10-31 21:52:19', 0, 0, NULL, '', '');
INSERT INTO `org` VALUES ('8047e605-c54a-48bd-81da-daa9c1fc9091', '.0.4.2.', '郑州营销中心', '', '中部片区', 0, 0, '', 0, '', '', '2019-10-31 21:54:50', 0, 0, '182dac38-64a0-414c-990c-7c9b7558a367', '', '');
INSERT INTO `org` VALUES ('86449128-d5ac-44bf-b999-f7735b7458fd', '.0.1.4.', '软件部', '', '总部大区', 0, 0, '', 1, '0', '', '2016-05-26 15:11:03', 0, 1, '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `org` VALUES ('8e31553c-cab8-4eb3-90b5-5f8ff1d21801', '.0.5.', '华南片区', '', '根节点', 0, 0, '', 0, '', '', '2019-10-31 21:52:55', 0, 0, NULL, '', '');
INSERT INTO `org` VALUES ('9cd918bf-28bc-44de-8e07-23cacbb67f42', '.0.1.7.', '总经办', '', '总部大区', 0, 0, '', 0, '', '', '2019-10-31 21:57:40', 0, 0, '543a9fcf-4770-4fd9-865f-030e562be238', '', '');
INSERT INTO `org` VALUES ('b2083488-64e5-44cc-b8f4-929ffa6f2f72', '.0.2.1.', '上海VIP中心', '', '华东片区', 0, 0, '', 0, '', '', '2019-10-31 21:56:25', 0, 0, '66386671-0494-4e83-8346-fbcf73283f7b', '', '');
INSERT INTO `org` VALUES ('c36e43df-3a99-45da-80d9-3ac5d24f4014', '.0.1.5.', '市场1部', '', '总部大区', 0, 0, '', 0, '0', '', '2016-05-26 15:10:40', 0, 1, '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `org` VALUES ('c455d009-12d7-4c78-953f-264f0ca67a3d', '.0.6.1.', '天津营销中心', '', '华北片区', 0, 0, '', 0, '', '', '2019-10-31 21:56:54', 0, 0, 'eed8756d-587b-46de-96c7-0a400e3d80fa', '', '');
INSERT INTO `org` VALUES ('ced1b2f0-4b53-44b8-9c42-a5d607ccc9c9', '.0.1.8.', '上市办', '', '总部大区', 0, 0, '', 0, '', '', '2019-10-31 21:57:53', 0, 0, '543a9fcf-4770-4fd9-865f-030e562be238', '', '');
INSERT INTO `org` VALUES ('df442c27-68a0-428e-a309-cba23a994a9d', '.0.3.2.', '重庆营销中心', '', '西南片区', 0, 0, '', 0, '', '', '2019-10-31 21:56:06', 0, 0, '60620558-89a2-4b28-8637-52f514773725', '', '');
INSERT INTO `org` VALUES ('eed8756d-587b-46de-96c7-0a400e3d80fa', '.0.6.', '华北片区', '', '根节点', 0, 0, '', 0, '', '', '2019-10-31 21:53:04', 0, 0, NULL, '', '');

-- ----------------------------
-- Table structure for relevance
-- ----------------------------
DROP TABLE IF EXISTS `relevance`;
CREATE TABLE `relevance`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号',
  `Description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `Key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '映射标识',
  `Status` int(11) NOT NULL COMMENT '状态',
  `OperateTime` datetime(0) NOT NULL COMMENT '授权时间',
  `OperatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '授权人',
  `FirstId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '第一个表主键ID',
  `SecondId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '第二个表主键ID',
  `ThirdId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '第三个表主键ID',
  `ExtendInfo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '扩展信息',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '多对多关系集中映射' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of relevance
-- ----------------------------
INSERT INTO `relevance` VALUES ('01ba383d-fe81-473a-84a1-f64ce8a5aae5', '', 'UserOrg', 0, '2019-10-31 21:50:42', '', '229f3a49-ab27-49ce-b383-9f10ca23a9d5', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '', '');
INSERT INTO `relevance` VALUES ('023c001e-d7be-4e1d-b5dc-8c14535a2cf9', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '584c7a3b-d28a-47b4-8648-7797d05d83d1', '', '');
INSERT INTO `relevance` VALUES ('03b55a9e-a44f-44fa-9383-4117bf8aba60', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'XXX_DELETEACCOUNT', NULL, NULL);
INSERT INTO `relevance` VALUES ('03be9b5e-38b0-4525-8431-b26d35ce6ce3', '', 'UserElement', 0, '2016-09-07 15:30:43', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('06dfd97d-17e0-42b8-bde7-40006d8c8eb2', '', 'UserElement', 0, '2018-04-06 14:50:37', '', '49df1602-f5f3-4d52-afb7-3802da619558', '584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL);
INSERT INTO `relevance` VALUES ('06f4c4a2-faa8-4bad-9184-50ceb517f30b', '', 'ProcessUser', 0, '2016-09-08 16:48:14', '0', '10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('077e24ab-4c48-4a5e-bfa9-90ea00449136', '', 'RoleOrg', 0, '2018-09-12 00:08:47', '', '3e761e88-ddf7-4a62-b219-9a315b4564f2', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('08ff97f7-17fc-4072-b29a-287135898ece', '', 'RoleResource', 0, '2016-09-04 23:20:22', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'fdf3aac3-4507-40ad-aa2f-d7f0459de252', NULL, NULL);
INSERT INTO `relevance` VALUES ('0a9bcd14-0e27-474a-8c0e-0d023d6013eb', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Resource', 'Description', '');
INSERT INTO `relevance` VALUES ('0b3d3a9b-8a96-43d4-918c-fa7e3ea5f5ca', '', 'RoleOrg', 0, '2018-09-12 00:08:37', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('0f056416-c2ce-4045-af18-e935928c7139', '', 'UserOrg', 0, '2019-10-31 21:51:39', '', '49df1602-f5f3-4d52-afb7-3802da619558', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '', '');
INSERT INTO `relevance` VALUES ('0fd5b371-b010-4846-8833-95cc1e813a32', '', 'UserElement', 0, '2016-09-07 15:31:16', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL);
INSERT INTO `relevance` VALUES ('10a76196-ba0c-4294-bb8f-dcd063eb4aab', '', 'UserOrg', 0, '2017-10-12 09:13:38', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('10e58d75-dec1-4b85-882f-9dac79ad1210', '', 'RoleResource', 0, '2016-10-21 18:08:13', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', 'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL);
INSERT INTO `relevance` VALUES ('1196cfff-9a57-4ef2-a3ee-abd438871264', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Resource', 'AppId', '');
INSERT INTO `relevance` VALUES ('120d7a5d-203c-4261-95f5-0125757fb386', '', 'UserElement', 0, '2016-10-20 17:01:01', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL);
INSERT INTO `relevance` VALUES ('13433400-a32c-4539-b988-8b417c09bc0e', '', 'UserModule', 0, '2016-09-07 15:30:07', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('13612a4c-b20c-4bd0-a2cd-0ae47576364d', '', 'UserElement', 0, '2016-10-20 16:34:12', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL);
INSERT INTO `relevance` VALUES ('13f1fd43-b36f-4cd9-9870-952645e0c23a', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'c7d7daf0-3669-4a22-8bed-b092617deb9c', '', '');
INSERT INTO `relevance` VALUES ('1490edd4-9bd3-4e71-bfa4-56f6558c1d3f', '', 'UserElement', 0, '2018-04-06 09:48:24', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL);
INSERT INTO `relevance` VALUES ('16154fc4-d18e-44a3-bcf2-5539b168aba7', '', 'RoleElement', 0, '2016-10-24 17:25:15', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '18cc3217-28a6-49b2-9a20-080230065984', NULL, NULL);
INSERT INTO `relevance` VALUES ('1740ff26-a4d0-44cc-9fab-a0105c2c60b6', '', 'UserOrg', 0, '2017-10-12 13:59:49', '', '63c9c82a-e0d3-4bde-bbd2-057cda2f5283', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('1873ed85-a88a-4236-bd40-2c416aa2576c', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', '7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL);
INSERT INTO `relevance` VALUES ('19c9621c-3d23-46b7-a841-54d5c82ec8e8', '', 'UserOrg', 0, '2016-09-02 13:56:53', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('1acec4c4-0136-4e2b-a839-8676dbd6594a', '', 'ProcessUser', 0, '2016-09-14 11:38:23', '0', '6c6afe3c-349c-4198-8710-cf19c90f3afd', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('1b52e0cb-2df1-41e2-90ab-fc051be1d983', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '069475e3-c997-487a-9f29-e6a864c5c1d4', '', '');
INSERT INTO `relevance` VALUES ('1ced1564-2fea-4c04-8aea-f071fa5bb293', '', 'UserModule', 0, '2016-09-05 16:24:55', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('1cf19b35-e2c2-436f-99b9-03ac2b232cc6', '', 'RoleElement', 0, '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '44075557-496e-4dde-bb75-7b69f51ab4fe', NULL, NULL);
INSERT INTO `relevance` VALUES ('2014027e-0cff-41cf-974b-56126d6eaa9a', '', 'RoleElement', 0, '2016-09-05 09:22:11', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', 'c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', NULL, NULL);
INSERT INTO `relevance` VALUES ('20f03189-18c8-4d2d-b924-85375f4b6c26', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Category', 'Description', '');
INSERT INTO `relevance` VALUES ('21b6a747-c573-4990-9327-ec3d1323127c', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'c3d7b478-21e9-4c1e-b866-a3c80be7909b', '', '');
INSERT INTO `relevance` VALUES ('22ccf653-9972-4611-ba0e-384c28c51f0f', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'c3d7b478-21e9-4c1e-b866-a3c80be7909b', '', '');
INSERT INTO `relevance` VALUES ('242e9543-3343-41d4-8816-15ffeeaef551', '', 'UserElement', 0, '2016-09-07 15:31:16', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL);
INSERT INTO `relevance` VALUES ('27c4d50c-32da-4dbc-88a1-84b343cdd649', '', 'UserElement', 0, '2016-10-20 17:01:00', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '6839a297-350b-4215-b680-4e5dfdae5615', NULL, NULL);
INSERT INTO `relevance` VALUES ('2942a7e1-5100-4523-b039-181cfc19a4cf', '', 'UserOrg', 0, '2019-10-31 21:51:39', '', '49df1602-f5f3-4d52-afb7-3802da619558', '543a9fcf-4770-4fd9-865f-030e562be238', '', '');
INSERT INTO `relevance` VALUES ('29b06cd6-af0c-4c63-9aba-e5431c5d62ec', '', 'UserOrg', 0, '2017-10-12 09:13:38', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('2a1b833c-dc81-46e2-b308-e22e0f112f77', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '2d595a2a-5de5-479e-a331-b53c799a6b10', '', '');
INSERT INTO `relevance` VALUES ('2a36a2b7-41aa-4190-b88c-75d44a56ad6e', '', 'UserModule', 0, '2017-02-06 00:14:18', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL);
INSERT INTO `relevance` VALUES ('2bb3fddb-0f51-442e-8dbf-236beb47d8a6', '', 'RoleOrg', 0, '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('2ca288a6-d222-4328-951e-c01c3e77a0c7', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL);
INSERT INTO `relevance` VALUES ('2d0fcc88-a7c0-4d33-8a08-1d688e9dde83', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL);
INSERT INTO `relevance` VALUES ('2d15e438-cc3a-41e9-9b13-325bfd5c804a', '', 'RoleElement', 0, '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '84e38920-f6e5-499c-bf52-a3c6f8499ff7', NULL, NULL);
INSERT INTO `relevance` VALUES ('2ebff9a4-b2d5-4a35-a7dd-2cfa2f5b0522', '', 'ProcessUser', 0, '2016-09-07 17:33:39', '0', '52cc7933-a045-4dcc-8c17-1b618bfa772b', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('30c82d18-7892-4e5f-9aee-e4f483a858c2', '', 'UserModule', 0, '2016-09-05 16:24:55', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('332a373c-f485-4f85-9af9-7792f7462bf1', '', 'RoleModule', 0, '2016-09-02 17:03:47', '0', '648b04c4-4ac2-4d69-bef6-07081ef27871', '89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL);
INSERT INTO `relevance` VALUES ('340c60fe-8b95-474c-aa04-9197903998d2', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL);
INSERT INTO `relevance` VALUES ('361feb63-bde2-49c7-86ec-6df3ec6f0fe3', '', 'RoleElement', 0, '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '1c870438-4260-43a5-8996-a6e1dc8bbf6a', NULL, NULL);
INSERT INTO `relevance` VALUES ('392a5a3c-245c-49b3-ba9a-e6e90551f01e', '', 'UserOrg', 0, '2019-10-31 21:51:39', '', '49df1602-f5f3-4d52-afb7-3802da619558', '86449128-d5ac-44bf-b999-f7735b7458fd', '', '');
INSERT INTO `relevance` VALUES ('392dc41e-7186-4efb-a8e5-b5317e4122fb', '', 'RoleResource', 0, '2018-09-10 12:54:14', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'OPENAUTH_DELETEACCOUNT', NULL, NULL);
INSERT INTO `relevance` VALUES ('3bcaab20-e096-480e-a9bb-0fdb70686714', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL);
INSERT INTO `relevance` VALUES ('3de0359b-6331-4dc7-a00e-751f71dbadb5', '', 'ProcessUser', 0, '2016-09-28 09:23:30', '0', '68295d2a-4dfd-4c5e-81e3-9c787e2603bc', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('3e9b3e79-c972-4c50-a36d-ab179d2ad09d', '', 'RoleModule', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '069475e3-c997-487a-9f29-e6a864c5c1d4', '', '');
INSERT INTO `relevance` VALUES ('4190f00a-11a0-4814-849b-cc5232fa4dd4', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'OPENAUTH_DELETEACCOUNT', NULL, NULL);
INSERT INTO `relevance` VALUES ('4459ffd7-446b-456b-aee5-48e67ca000f8', '', 'UserOrg', 0, '2019-10-31 21:51:45', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '', '');
INSERT INTO `relevance` VALUES ('460d1c98-2a68-43cf-8d38-d40ceb89916f', '', 'UserOrg', 0, '2017-10-12 09:13:38', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('4757bb30-e4bc-4c2d-a824-947ef151d341', '', 'UserRole', 0, '2016-09-07 20:21:16', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '4980a85b-e3db-4607-bc2c-0baf0140d7df', NULL, NULL);
INSERT INTO `relevance` VALUES ('4ba3982b-f0ae-4f9a-980e-1eaedc3b5f2e', '', 'UserElement', 0, '2016-09-07 17:48:34', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL);
INSERT INTO `relevance` VALUES ('4c2fb006-53d6-4041-8cf6-e5d74d788897', '', 'UserModule', 0, '2018-04-06 09:48:19', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('4c69794b-9957-4f6b-b0fb-6455fe643565', '', 'UserElement', 0, '2018-04-06 14:50:41', '', '49df1602-f5f3-4d52-afb7-3802da619558', '826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('4daccce5-cb7b-46aa-8bed-3c85c72436be', '', 'RoleOrg', 0, '2018-09-12 00:08:37', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('4e613188-0387-4d17-a60d-703b4a606d75', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL);
INSERT INTO `relevance` VALUES ('4e665304-9f05-410e-b68f-44d45281b788', '', 'RoleOrg', 0, '2018-09-12 00:08:47', '', '3e761e88-ddf7-4a62-b219-9a315b4564f2', 'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL);
INSERT INTO `relevance` VALUES ('4e693bbd-8ddb-42af-b888-30885612c154', '', 'UserOrg', 0, '2019-10-31 21:58:43', '', '96f63f9d-e8c8-4258-963e-3327ed7d6f56', '3d2ad14c-2c56-4a90-a2db-6bde26b0b8b3', '', '');
INSERT INTO `relevance` VALUES ('4e6c69a6-eeba-45d9-923d-16a7c002ac3e', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '7580672f-a390-4bb6-982d-9a4570cb5199', '', '');
INSERT INTO `relevance` VALUES ('4ec39ee9-9ee9-4aa9-a0db-eb0fdf8d2f00', '', 'UserElement', 0, '2018-04-06 09:48:27', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL);
INSERT INTO `relevance` VALUES ('4ee89c07-55e2-4ca6-9ef1-449cfe0a2c3c', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'OPENAUTH_LOGIN', NULL, NULL);
INSERT INTO `relevance` VALUES ('4fde1dc6-9d73-4c7c-9238-28981858c5a6', '', 'RoleModule', 0, '2016-09-05 09:21:56', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL);
INSERT INTO `relevance` VALUES ('5167dbcd-3a32-4ae8-827e-6f381cc58fa2', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'fa816af1-a28d-47b5-9b8b-c46e18f902e9', NULL, NULL);
INSERT INTO `relevance` VALUES ('53a4be87-4fa8-415b-97b5-2298ce8b17c8', '', 'UserResource', 0, '2018-04-14 14:38:04', '', '49df1602-f5f3-4d52-afb7-3802da619558', 'XXX_LOGIN', NULL, NULL);
INSERT INTO `relevance` VALUES ('54a8edde-af09-48e1-adb5-5ffc90b02c4d', '', 'RoleModule', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '9486ff22-b696-4d7f-8093-8a3e53c45453', '', '');
INSERT INTO `relevance` VALUES ('54b2e9b6-1f7c-4a39-92c9-98f58429c1fc', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL);
INSERT INTO `relevance` VALUES ('54d8d1b8-2b5b-498d-9c0d-33e8bad86572', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '826b12b3-e916-446d-a2fa-329cfd13c831', '', '');
INSERT INTO `relevance` VALUES ('55b10ecc-3fb3-4127-b69e-e7a3467d7a1a', '', 'RoleElement', 0, '2016-09-05 09:22:11', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '6db928fe-93df-460f-9472-8bb0b6cae52c', NULL, NULL);
INSERT INTO `relevance` VALUES ('5725ff79-43c6-4778-bbff-131cf364dab6', '', 'UserElement', 0, '2016-10-20 17:01:01', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL);
INSERT INTO `relevance` VALUES ('575221eb-0e4d-4cfa-9cd8-59607784d43d', '', 'UserRole', 0, '2019-10-31 21:59:41', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '3e761e88-ddf7-4a62-b219-9a315b4564f2', '', '');
INSERT INTO `relevance` VALUES ('5a20d59c-6ee6-4fe2-98fe-7b35b11026ae', '', 'UserElement', 0, '2016-09-07 15:30:20', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL);
INSERT INTO `relevance` VALUES ('5a86259a-9555-4aa7-be8d-a874f88b66a8', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '9486ff22-b696-4d7f-8093-8a3e53c45453', '', '');
INSERT INTO `relevance` VALUES ('5b0ec87e-3465-48c2-98da-e4c28a6f8f34', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', '', '');
INSERT INTO `relevance` VALUES ('5b2d5db8-d603-4be3-add2-c85ef3c53ddc', '', 'UserResource', 0, '2018-04-14 14:38:05', '', '49df1602-f5f3-4d52-afb7-3802da619558', 'OPENAUTH_LOGIN', NULL, NULL);
INSERT INTO `relevance` VALUES ('5ccce632-f8f0-452b-8faf-4a5372004e85', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'XXX_CHECKUSER', NULL, NULL);
INSERT INTO `relevance` VALUES ('620b368a-7b56-4c74-ab85-8bc91d08ddc9', '', 'RoleElement', 0, '2016-09-04 23:20:42', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', NULL, NULL);
INSERT INTO `relevance` VALUES ('62fc2363-2a9a-48cb-b455-aa43d0cf978a', '', 'RoleModule', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '4abafc83-c8f5-452f-9882-e113a86e7a3e', '', '');
INSERT INTO `relevance` VALUES ('63a22a27-c8bd-4bdf-a3bb-6ffeae19484e', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', '', '');
INSERT INTO `relevance` VALUES ('6431a464-6f1f-4ffc-8157-89212b70f09a', '', 'RoleOrg', 0, '2016-09-05 00:00:00', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('64879608-334c-48c7-bd80-a562d9619d95', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Category', 'Name', '');
INSERT INTO `relevance` VALUES ('64e4f5aa-28ef-4690-9b20-5f0b543964f6', '', 'UserElement', 0, '2016-09-07 15:30:20', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('6645b6fb-efcf-4e48-9c13-84f79bc5be34', '', 'RoleOrg', 0, '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('66e25fc5-093d-42ab-85dc-a38f6600889b', '', 'UserOrg', 0, '2016-09-02 13:57:32', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', 'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL);
INSERT INTO `relevance` VALUES ('68912e65-256e-45b6-b48e-036382598d32', '', 'RoleOrg', 0, '2016-10-17 10:03:49', '0', '2eb423d6-6ad9-4efe-b423-872478a2a434', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('68984a83-ce96-4144-9e23-0e0f2249fb45', '', 'UserOrg', 0, '2019-10-31 21:51:30', '', 'de8be521-f1ec-4483-b124-0be342890507', 'c36e43df-3a99-45da-80d9-3ac5d24f4014', '', '');
INSERT INTO `relevance` VALUES ('6b9c4789-042c-4f6f-a749-ee68ee87462d', '', 'ProcessUser', 0, '2016-10-27 16:47:52', '0', '054ff054-d8ae-4911-a596-8fb1f66b348f', '3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL);
INSERT INTO `relevance` VALUES ('6da6d662-8cef-47cd-80b3-fa885b2dca7a', '', 'RoleOrg', 0, '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('6db5666b-6f8c-4e83-bada-0b45054bd9a4', '', 'RoleElement', 0, '2016-09-04 23:20:42', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '0d25438e-1436-48e0-aedf-0f1690693282', NULL, NULL);
INSERT INTO `relevance` VALUES ('6f0ed92f-f2b9-4e7b-a965-3cd3d38abe2e', '', 'RoleModule', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '7580672f-a390-4bb6-982d-9a4570cb5199', '', '');
INSERT INTO `relevance` VALUES ('6f563fe2-21f0-441f-8b43-9afd92b53356', '', 'RoleModule', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', '', '');
INSERT INTO `relevance` VALUES ('6fe52499-f800-47ce-96fc-a2b5b43505d5', '', 'UserElement', 0, '2018-04-06 09:48:22', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL);
INSERT INTO `relevance` VALUES ('70c89239-dc86-4ac9-9779-7dcbb4dfe685', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', '', '');
INSERT INTO `relevance` VALUES ('715d017a-68b6-468d-aa3f-32ca4cfd4b9e', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL);
INSERT INTO `relevance` VALUES ('72bf4729-af60-42f5-b0d7-717362ffad7f', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '2feefce1-e3d8-42ac-b811-2352679628da', NULL, NULL);
INSERT INTO `relevance` VALUES ('72d150c7-60a5-428e-8a7e-d484d2c97cd8', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Resource', 'Id', '');
INSERT INTO `relevance` VALUES ('736e90f7-3747-472e-816d-dbb7fdf3b0bb', '', 'RoleOrg', 0, '2018-09-12 00:08:42', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('7475b0c3-f204-4f95-a22f-80591fe76bc7', '', 'ProcessUser', 0, '2016-10-31 11:52:39', '0', 'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('75340ad3-fb80-4646-b1de-ba801688ddc2', '', 'RoleElement', 0, '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '5ed1681c-13d2-4c87-8675-a8d95c0b40ae', NULL, NULL);
INSERT INTO `relevance` VALUES ('77ac794c-9142-443f-b19c-3b9d960c8ba4', '', 'UserOrg', 0, '2019-10-31 21:51:45', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '86449128-d5ac-44bf-b999-f7735b7458fd', '', '');
INSERT INTO `relevance` VALUES ('77bd93da-2c2b-4ba8-bf05-3a1382811a6a', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL);
INSERT INTO `relevance` VALUES ('77eec82a-f713-4584-872c-761fdbcdb456', '', 'UserElement', 0, '2018-04-06 14:50:37', '', '49df1602-f5f3-4d52-afb7-3802da619558', '68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL);
INSERT INTO `relevance` VALUES ('77fc08e6-98ae-4d33-b294-bd9fed5b14ed', '', 'UserElement', 0, '2018-04-06 14:50:36', '', '49df1602-f5f3-4d52-afb7-3802da619558', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('797c6e5f-7f3c-4891-89b9-a054e10f6c00', '', 'UserModule', 0, '2018-04-06 09:48:01', '', '49df1602-f5f3-4d52-afb7-3802da619558', '37bb9414-19a0-4223-9056-71f8c758a930', NULL, NULL);
INSERT INTO `relevance` VALUES ('7dcc9577-f27b-429f-8552-d223d4b48617', '', 'UserRole', 0, '2019-10-31 21:59:41', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '', '');
INSERT INTO `relevance` VALUES ('7f25286f-246b-4143-98eb-c3e574fe7455', '', 'ProcessUser', 0, '2016-09-07 17:33:39', '0', '52cc7933-a045-4dcc-8c17-1b618bfa772b', '3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL);
INSERT INTO `relevance` VALUES ('7fd7f976-f10e-44aa-a7ba-7ca40d2e8f90', '', 'RoleOrg', 0, '2016-10-17 10:03:30', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('80310629-5e52-482c-9a0f-5c5bdfabcd9e', '', 'RoleOrg', 0, '2016-09-05 00:00:00', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('832f4a8f-7791-4aa6-bcd2-20dcb6f5ef37', '', 'UserElement', 0, '2016-09-02 14:53:04', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL);
INSERT INTO `relevance` VALUES ('84a52091-08a0-4a46-b661-3cd206771c29', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL);
INSERT INTO `relevance` VALUES ('854e0658-ab8a-4869-b157-9941955acdc6', '', 'RoleElement', 0, '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '1a473afd-cbd4-41e9-9471-81f9435aaabe', NULL, NULL);
INSERT INTO `relevance` VALUES ('85ab02d8-995f-4f66-9828-e53f04af09b9', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', '', '');
INSERT INTO `relevance` VALUES ('88a4c966-d042-4a2e-b133-ff7eded1c5de', '', 'RoleElement', 0, '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', NULL, NULL);
INSERT INTO `relevance` VALUES ('89e5dd60-0981-4cd9-b9ad-577b7b817556', '', 'RoleDataProperty', 0, '2019-10-29 15:28:12', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'Category', 'Id', '');
INSERT INTO `relevance` VALUES ('8af3581e-257f-4655-bac2-5b5afb85ef88', '', 'UserOrg', 0, '2019-10-31 21:59:08', '', '758a34c7-5a31-438c-bdf7-02fdd846b901', 'b2083488-64e5-44cc-b8f4-929ffa6f2f72', '', '');
INSERT INTO `relevance` VALUES ('8b633f3c-965b-4e35-8496-c364890d7760', '', 'RoleElement', 0, '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'c3d7b478-21e9-4c1e-b866-a3c80be7909b', NULL, NULL);
INSERT INTO `relevance` VALUES ('8fa4a52f-9c0a-43c9-9b7e-b378efb4e1df', '', 'RoleResource', 0, '2018-09-10 12:54:14', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'OPENAUTH_LOGIN', NULL, NULL);
INSERT INTO `relevance` VALUES ('9043a72d-862f-49b4-bfe3-51d9bd289f14', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '816b12b3-e916-446d-a2fa-329cfd13c831', '', '');
INSERT INTO `relevance` VALUES ('9210adfa-b783-4368-8c8d-86c30ec9cdd1', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '37bb9414-19a0-4223-9056-71f8c758a930', '', '');
INSERT INTO `relevance` VALUES ('92b2d699-9875-4978-af79-24c83ff4e212', '', 'UserOrg', 0, '2019-10-31 21:58:43', '', '96f63f9d-e8c8-4258-963e-3327ed7d6f56', 'df442c27-68a0-428e-a309-cba23a994a9d', '', '');
INSERT INTO `relevance` VALUES ('92f0b297-96c1-47d4-84dd-571374431bc0', '', 'RoleElement', 0, '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '84694ea5-d6e1-4a65-8a59-7b5b779688d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('93bcac7a-0ff1-488c-8d1c-3da7e44cbefc', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a', NULL, NULL);
INSERT INTO `relevance` VALUES ('95cd06bd-7cad-4790-b5f8-15738360da95', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '4abafc83-c8f5-452f-9882-e113a86e7a3e', '', '');
INSERT INTO `relevance` VALUES ('960224e6-5910-472b-a5ef-b2aa9a8b106f', '', 'UserRole', 0, '2016-09-06 17:06:15', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL);
INSERT INTO `relevance` VALUES ('962b278b-0894-4b36-b1a0-6c5c3d11d4c3', '', 'UserElement', 0, '2018-04-06 14:50:17', '', '49df1602-f5f3-4d52-afb7-3802da619558', 'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL);
INSERT INTO `relevance` VALUES ('965f010b-2fd6-4b34-ba23-3e44c1af2877', '', 'RoleOrg', 0, '2016-09-08 16:19:18', '0', '36094f5d-07e7-40d5-91dc-ff60f98b496a', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('966531b6-584c-4f0a-b934-c33aab795f1c', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '2d595a2a-5de5-479e-a331-b53c799a6b10', '', '');
INSERT INTO `relevance` VALUES ('98136fef-6d02-4823-bc12-6e5e619e1275', '', 'UserRole', 0, '2019-10-31 21:59:25', '', '758a34c7-5a31-438c-bdf7-02fdd846b901', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '', '');
INSERT INTO `relevance` VALUES ('9ad706e3-8e6b-4bc7-a502-371b298ef062', '', 'RoleElement', 0, '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'ef42721f-d223-4a00-a1d9-80b81121f21a', NULL, NULL);
INSERT INTO `relevance` VALUES ('9d568d6d-d78d-47d6-8fb6-b1327cdbe83a', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL);
INSERT INTO `relevance` VALUES ('9e46a946-6e81-4f61-bcba-21e4f7fac3df', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL);
INSERT INTO `relevance` VALUES ('9e57e1ff-e9cf-4600-a872-ac85f7845bb0', '', 'RoleOrg', 0, '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', 'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL);
INSERT INTO `relevance` VALUES ('9ea4add6-9fdf-4046-8b6f-84f0a1cb2967', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '1a473afd-cbd4-41e9-9471-81f9435aaabe', '', '');
INSERT INTO `relevance` VALUES ('9edc7b81-2b51-4193-8805-6062e596ccdc', '', 'UserOrg', 0, '2016-09-02 13:57:32', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('9fa50449-5d87-4579-9f1f-9cdcd876976b', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '6839a297-350b-4215-b680-4e5dfdae5615', NULL, NULL);
INSERT INTO `relevance` VALUES ('a051aa08-38da-4b6d-8d90-10b3c2485e4b', '', 'RoleOrg', 0, '2016-09-05 00:00:00', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `relevance` VALUES ('a06fe8c6-3f5e-4085-9bbf-e366571a356c', '', 'RoleElement', 0, '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'daddf3b9-71b5-45ac-b85d-5a11c522f2f4', NULL, NULL);
INSERT INTO `relevance` VALUES ('a0904102-e26a-4bc5-9c95-ed5ef977586b', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', '6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL);
INSERT INTO `relevance` VALUES ('a4df5a15-fd77-40fb-84cd-3b7844bd0147', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '1a473afd-cbd4-41e9-9471-81f9435aaabe', '', '');
INSERT INTO `relevance` VALUES ('a5bef7bf-ecdb-4480-ad64-b39a02269607', '', 'UserModule', 0, '2018-04-06 09:48:37', '', '49df1602-f5f3-4d52-afb7-3802da619558', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('a8094b46-de5a-40ea-a8ee-69ea905480ef', '', 'RoleModule', 0, '2016-09-05 09:21:56', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('a8123b37-ba70-4aab-aef6-1938733b5210', '', 'RoleElement', 0, '2016-09-04 23:20:42', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'c0d8505c-061a-467d-862a-c94f27caa208', NULL, NULL);
INSERT INTO `relevance` VALUES ('a9821db0-49bd-49be-a554-afa811c99760', '', 'RoleResource', 0, '2016-09-04 23:20:22', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL);
INSERT INTO `relevance` VALUES ('aa051096-a23a-431d-9053-bb954f9453a7', '', 'RoleElement', 0, '2016-09-04 23:20:54', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '4bfa8ea0-6b0d-426f-8687-b654575ca780', NULL, NULL);
INSERT INTO `relevance` VALUES ('ab190397-32a8-4b0f-bf34-2d648d6fe974', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Resource', 'Name', '');
INSERT INTO `relevance` VALUES ('ab84b111-fb5d-4ddd-99d5-479954d9d521', '', 'RoleOrg', 0, '2016-09-08 16:19:18', '0', '36094f5d-07e7-40d5-91dc-ff60f98b496a', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('ab924ba7-8a74-4804-82b0-ecbbedf4c13e', '', 'RoleElement', 0, '2016-09-05 09:22:11', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '38109ca0-32ec-44bd-a243-017e591b532b', NULL, NULL);
INSERT INTO `relevance` VALUES ('ac184827-9899-4b40-8939-61fe9d2b187c', '', 'UserElement', 0, '2016-09-07 17:48:49', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL);
INSERT INTO `relevance` VALUES ('acb4d37f-8b45-4a99-b364-99f3881dfcda', '', 'RoleElement', 0, '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'f8dde22a-2a37-47c4-8e67-70fb3af5303e', NULL, NULL);
INSERT INTO `relevance` VALUES ('acc51898-5335-4903-83b9-4701a782bc4d', '', 'UserElement', 0, '2016-10-20 17:01:02', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'fa816af1-a28d-47b5-9b8b-c46e18f902e9', NULL, NULL);
INSERT INTO `relevance` VALUES ('ad267296-5eba-4d59-b821-8148d8cfb3c6', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL);
INSERT INTO `relevance` VALUES ('ad29467e-eeee-494c-ab82-f6be5d2619d5', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '50c9df24-b233-42cb-9a0d-4ce158c75f86', NULL, NULL);
INSERT INTO `relevance` VALUES ('ad30e13e-6b75-48f9-97e3-c723d3e36a28', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'OPENAUTH_MODIFYACCOUNT', NULL, NULL);
INSERT INTO `relevance` VALUES ('ad5bc7a6-e307-4fa8-a4ef-ce9e09f7e21b', '', 'RoleModule', 0, '2016-09-05 09:21:56', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('ad905aa6-d3d8-4fe9-99b4-5f8be7891d1e', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'XXX_ADMIN', NULL, NULL);
INSERT INTO `relevance` VALUES ('ae619801-1959-44fd-a75b-a8cca4d559b4', '', 'RoleOrg', 0, '2018-09-12 00:08:37', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `relevance` VALUES ('af263192-daa8-4f29-99b9-1efb96e31627', '', 'RoleElement', 0, '2016-09-04 23:20:42', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '645b40ac-4223-44a7-aab4-66eb56cf9864', NULL, NULL);
INSERT INTO `relevance` VALUES ('b08d7763-a725-406f-a7d5-d144f00d716e', '', 'UserOrg', 0, '2016-09-02 13:56:41', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `relevance` VALUES ('b17f9a6d-ab0b-4967-aef2-ce7d95fa581a', '', 'UserRole', 0, '2019-10-31 21:59:34', '', '49df1602-f5f3-4d52-afb7-3802da619558', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '', '');
INSERT INTO `relevance` VALUES ('b241dd3d-2965-44e4-929d-9dacb6444e09', '', 'RoleOrg', 0, '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `relevance` VALUES ('b246cd89-548c-4471-a43b-6f10b40c26b1', '', 'RoleOrg', 0, '2018-09-12 00:08:42', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('b2490ac0-ba16-48a2-b39d-49f6b87f9387', '', 'UserModule', 0, '2018-04-06 09:48:17', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('b2edfee4-f980-4aa5-b547-492d677e0674', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL);
INSERT INTO `relevance` VALUES ('b3b8f695-a179-489b-90b4-7814ab048a69', '', 'UserElement', 0, '2018-04-06 09:48:21', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('b4c2a294-125c-4768-9214-cea3ccf39a1c', '', 'RoleOrg', 0, '2018-09-12 00:08:42', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `relevance` VALUES ('b672a830-c3a5-408b-a746-65608534b24c', '', 'UserModule', 0, '2017-12-15 17:07:05', '', '49df1602-f5f3-4d52-afb7-3802da619558', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('b8606463-4957-424f-bcab-1ea27c15c2c5', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', '', '');
INSERT INTO `relevance` VALUES ('b9e63d17-35c8-4456-abab-8f43a1c99adc', '', 'UserModule', 0, '2018-04-06 09:47:59', '', '49df1602-f5f3-4d52-afb7-3802da619558', '4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL);
INSERT INTO `relevance` VALUES ('ba5f4663-04e1-4b09-8e84-459507df2aeb', '', 'UserOrg', 0, '2019-10-31 21:50:51', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '', '');
INSERT INTO `relevance` VALUES ('bbdc3ea9-3f21-48b0-9d7a-39545d6183d0', '', 'UserElement', 0, '2018-04-06 09:48:25', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('bc869e2f-4417-4db5-92ac-611a0caf918d', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '816b12b3-e916-446d-a2fa-329cfd13c831', '', '');
INSERT INTO `relevance` VALUES ('bd783f53-23fa-41f4-8cec-7c61fab52072', '', 'UserOrg', 0, '2018-03-15 09:19:06', '', '0ceff0f8-f848-440c-bc26-d8605ac858cd', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('bda5f089-64d6-4fb8-9012-d7f3ff36902a', '', 'UserOrg', 0, '2017-10-12 13:59:09', '', 'ffd92ed2-5330-4ec2-a42d-6e0e9005db3b', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('bed2842a-e9ff-4598-889f-2889033f8e67', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '4bfa8ea0-6b0d-426f-8687-b654575ca780', '', '');
INSERT INTO `relevance` VALUES ('bee6572d-8fb8-4e0e-af15-93aafc989717', '', 'RoleElement', 0, '2016-09-04 23:20:42', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '68fc793f-069f-43e1-a012-42ac2d7c585c', NULL, NULL);
INSERT INTO `relevance` VALUES ('bef744ab-2323-4552-9a09-f529911f8c59', '', 'UserOrg', 0, '2019-10-31 21:58:43', '', '96f63f9d-e8c8-4258-963e-3327ed7d6f56', '60620558-89a2-4b28-8637-52f514773725', '', '');
INSERT INTO `relevance` VALUES ('bf096b00-8793-43ea-b56b-f72e4e8444a9', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '68484265-7802-4f06-b024-33e8b2f2edcf', '', '');
INSERT INTO `relevance` VALUES ('c14addeb-1812-4a78-9152-1f7115b22d89', '', 'UserRole', 0, '2016-09-05 00:00:47', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL);
INSERT INTO `relevance` VALUES ('c2d3b7d6-b47d-4bd8-9dc6-d9134d86713f', '', 'RoleOrg', 0, '2016-10-17 10:03:30', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('c3050d65-d26b-4e46-bece-a212b0cc00ec', '', 'RoleElement', 0, '2016-09-04 23:20:42', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL);
INSERT INTO `relevance` VALUES ('c4771ac5-3375-4de9-adb8-a603398f0d62', '', 'RoleElement', 0, '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '2d595a2a-5de5-479e-a331-b53c799a6b10', NULL, NULL);
INSERT INTO `relevance` VALUES ('c50fae2a-b36f-486f-9d53-e58406590101', '', 'ProcessUser', 0, '2016-10-27 16:47:52', '0', '054ff054-d8ae-4911-a596-8fb1f66b348f', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('c58cb482-6ab7-49eb-b5b0-e45424b6e502', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '34730f5a-d307-457b-9041-5f7de30abfa9', NULL, NULL);
INSERT INTO `relevance` VALUES ('c68dccbb-b7c5-4db1-b426-b58a19f42145', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '9e2c6754-f258-4b14-96a0-b9d981196a65', '', '');
INSERT INTO `relevance` VALUES ('c733cfbe-2f71-41e4-92a6-4ff97cf88dc4', '', 'UserModule', 0, '2018-04-06 09:48:19', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL);
INSERT INTO `relevance` VALUES ('c8e31bf2-183c-486e-8898-064ba745e501', '', 'RoleDataProperty', 0, '2019-10-29 15:28:12', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'Category', 'Description', '');
INSERT INTO `relevance` VALUES ('c9099371-8d4e-4f5b-9686-2c60a2c1c641', '', 'ProcessUser', 0, '2016-09-08 16:48:14', '0', '10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', '3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL);
INSERT INTO `relevance` VALUES ('c98b3d02-a76b-4ecc-94a5-cfeffd5e29fb', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL);
INSERT INTO `relevance` VALUES ('d22b89f8-50d1-4816-9bb2-576ea49d9245', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '68484265-7802-4f06-b024-33e8b2f2edcf', '', '');
INSERT INTO `relevance` VALUES ('da6c0645-0bf9-4ade-9dd3-1b09e91e504c', '', 'RoleElement', 0, '2016-09-05 09:22:07', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('db9a5462-8f52-4755-afd7-39887dff55b5', '', 'RoleDataProperty', 0, '2019-10-29 15:28:12', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'Category', 'Name', '');
INSERT INTO `relevance` VALUES ('df2d90b3-4e2e-40e9-b406-220009726460', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL);
INSERT INTO `relevance` VALUES ('dfbcc1cb-4103-46ac-8f4f-ce8bb3402392', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '584c7a3b-d28a-47b4-8648-7797d05d83d1', '', '');
INSERT INTO `relevance` VALUES ('dfd5430b-3422-465a-be79-05a1e06deed2', '', 'RoleElement', 0, '2016-09-04 23:20:54', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL);
INSERT INTO `relevance` VALUES ('e12b77de-b7ce-4f38-b7a3-f3b2d285f33b', '', 'RoleOrg', 0, '2016-10-17 10:03:49', '0', '2eb423d6-6ad9-4efe-b423-872478a2a434', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('e28c0dcd-168a-4b60-a514-7b6eb8026709', '', 'RoleOrg', 0, '2016-10-17 10:03:30', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('e5689793-8dd7-4d07-bf2e-4977eba430f4', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '84e38920-f6e5-499c-bf52-a3c6f8499ff7', '', '');
INSERT INTO `relevance` VALUES ('e619a82e-edfb-4542-94df-0b92850667ad', '', 'RoleResource', 0, '2018-04-14 14:39:56', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'OPENAUTH_MODIFYACCOUNT', NULL, NULL);
INSERT INTO `relevance` VALUES ('e785147c-f46b-474f-8fad-73b14fa69822', '', 'UserRole', 0, '2016-09-06 17:06:29', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '4980a85b-e3db-4607-bc2c-0baf0140d7df', NULL, NULL);
INSERT INTO `relevance` VALUES ('e84f6b9c-716d-4e94-a1aa-7fd0d1a2e23e', '', 'RoleModule', 0, '2016-09-02 17:03:47', '0', '648b04c4-4ac2-4d69-bef6-07081ef27871', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('e9cf3d63-6305-46c7-93b4-14053387c62c', '', 'UserModule', 0, '2018-04-06 09:48:18', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '37bb9414-19a0-4223-9056-71f8c758a930', NULL, NULL);
INSERT INTO `relevance` VALUES ('ec72f6ae-09ee-4db9-99a1-bf15c8e35dda', '', 'ProcessUser', 0, '2016-09-14 11:38:23', '0', '6c6afe3c-349c-4198-8710-cf19c90f3afd', '3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL);
INSERT INTO `relevance` VALUES ('ec9c80ce-dbdf-4ba5-9091-82f75392c3b0', '', 'UserElement', 0, '2016-09-07 15:30:43', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL);
INSERT INTO `relevance` VALUES ('ee1986a0-24cc-4dec-b5f5-68ef959ab650', '', 'UserElement', 0, '2018-04-06 14:50:40', '', '49df1602-f5f3-4d52-afb7-3802da619558', '79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL);
INSERT INTO `relevance` VALUES ('ee4f39fd-4fbf-4f68-9a70-d6c7d7db9723', '', 'ProcessUser', 0, '2016-10-31 11:52:39', '0', 'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', '3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL);
INSERT INTO `relevance` VALUES ('eec41fcb-61c0-4e56-a5c0-a9f8be6e6fdc', '', 'UserModule', 0, '2016-09-07 15:30:06', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('f03f503b-3898-44a0-a588-3ba4e27b72d5', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Category', 'Id', '');
INSERT INTO `relevance` VALUES ('f42343b9-adc2-4368-9028-7ed2f76fba68', '', 'UserRole', 0, '2019-10-29 17:00:19', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '', '');
INSERT INTO `relevance` VALUES ('f4ba636a-9002-43e6-93eb-95132a3e68c5', '', 'ProcessUser', 0, '2016-09-28 09:23:30', '0', '68295d2a-4dfd-4c5e-81e3-9c787e2603bc', '3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL);
INSERT INTO `relevance` VALUES ('f579a427-a9ed-4ebe-8411-72e8e6abd01d', '', 'UserElement', 0, '2016-09-05 16:25:26', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('f61ee29b-7988-404d-b692-5a8f667684be', '', 'UserElement', 0, '2018-04-06 09:48:23', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL);
INSERT INTO `relevance` VALUES ('f6367ca1-0486-46a4-b9c6-65c00936a516', '', 'RoleElement', 0, '2016-09-04 23:20:54', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '9e2c6754-f258-4b14-96a0-b9d981196a65', NULL, NULL);
INSERT INTO `relevance` VALUES ('f671f582-9111-4000-aadd-660449d0d4b0', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'XXX_LOGIN', NULL, NULL);
INSERT INTO `relevance` VALUES ('f6a9cdf7-50c1-48b4-ae29-f999691f3a1d', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Category', 'TypeId', '');
INSERT INTO `relevance` VALUES ('fa7c4d39-b31a-4668-8716-d40a62aa722b', '', 'UserOrg', 0, '2017-10-12 13:59:49', '', '63c9c82a-e0d3-4bde-bbd2-057cda2f5283', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('feeacec1-f3a5-4edc-b16e-d77266c2e53a', '', 'UserRole', 0, '2019-10-31 21:59:34', '', '49df1602-f5f3-4d52-afb7-3802da619558', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '', '');
INSERT INTO `relevance` VALUES ('feec44e3-3f88-4ac2-a4ad-a5bd3161f1bb', '', 'UserOrg', 0, '2019-10-31 21:59:08', '', '758a34c7-5a31-438c-bdf7-02fdd846b901', '66386671-0494-4e83-8346-fbcf73283f7b', '', '');
INSERT INTO `relevance` VALUES ('fffb23bb-4b47-4a4d-bf93-9d7c8755b6f0', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '84e38920-f6e5-499c-bf52-a3c6f8499ff7', '', '');

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资源标识',
  `CascadeId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT '节点语义ID',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT '名称',
  `SortNo` int(11) NOT NULL DEFAULT 0 COMMENT '排序号',
  `Description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT '描述',
  `ParentName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父节点名称',
  `ParentId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父节点流ID',
  `AppId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '资源所属应用ID',
  `AppName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属应用名称',
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类ID',
  `Disable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否可用',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '资源表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Id',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `Status` int(11) NOT NULL COMMENT '当前状态',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人ID',
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '管理员', 0, '2018-04-09 22:48:24', '', '', '');
INSERT INTO `role` VALUES ('0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '测试', 0, '2018-04-09 22:48:29', '', '', '');
INSERT INTO `role` VALUES ('3e761e88-ddf7-4a62-b219-9a315b4564f2', '汇丰测试', 0, '2018-04-09 22:48:42', '', '', '');
INSERT INTO `role` VALUES ('77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '神', 0, '2018-04-14 13:16:45', '', '', '');

-- ----------------------------
-- Table structure for stock
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据ID',
  `Name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `Number` int(11) NOT NULL COMMENT '产品数量',
  `Price` decimal(10, 1) NOT NULL COMMENT '产品单价',
  `Status` int(11) NOT NULL COMMENT '出库/入库',
  `Viewable` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '可见范围',
  `User` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人',
  `Time` datetime(0) NOT NULL COMMENT '操作时间',
  `OrgId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '组织ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '出入库信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for syslog
-- ----------------------------
DROP TABLE IF EXISTS `syslog`;
CREATE TABLE `syslog`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '日志内容',
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类ID',
  `Href` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作所属模块地址',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  `CreateId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人ID',
  `CreateName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作人',
  `Ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作机器的IP地址',
  `Result` int(11) NOT NULL DEFAULT 0 COMMENT '操作的结果：0：成功；1：失败；',
  `Application` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属应用',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '系统日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sysmessage
-- ----------------------------
DROP TABLE IF EXISTS `sysmessage`;
CREATE TABLE `sysmessage`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `FromId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ToId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FromName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ToName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `FromStatus` int(11) NOT NULL DEFAULT 0 COMMENT '-1:已删除；0:默认',
  `ToStatus` int(11) NOT NULL DEFAULT 0 COMMENT '-1:已删除；0:默认未读；1：已读',
  `Href` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '点击消息跳转的页面等',
  `Title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CreateId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '系统消息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for uploadfile
-- ----------------------------
DROP TABLE IF EXISTS `uploadfile`;
CREATE TABLE `uploadfile`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Id',
  `FileName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `FilePath` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件路径',
  `Description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `FileType` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件类型',
  `FileSize` int(11) DEFAULT NULL COMMENT '文件大小',
  `Extension` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '扩展名称',
  `Enable` tinyint(4) NOT NULL COMMENT '是否可用',
  `SortCode` int(11) NOT NULL COMMENT '排序',
  `DeleteMark` tinyint(4) NOT NULL COMMENT '删除标识',
  `CreateUserId` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上传人',
  `CreateUserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上传人姓名',
  `CreateTime` datetime(0) NOT NULL COMMENT '上传时间',
  `Thumbnail` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '缩略图',
  `BelongApp` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属应用',
  `BelongAppId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属应用ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号',
  `Account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户登录帐号',
  `Password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户姓名',
  `Sex` int(11) NOT NULL COMMENT '性别',
  `Status` int(11) NOT NULL COMMENT '用户状态',
  `BizCode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务对照码',
  `CreateTime` datetime(0) NOT NULL COMMENT '经办时间',
  `CreateId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户基本信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('0ceff0f8-f848-440c-bc26-d8605ac858cd', 'test5', 'test5', 'test5', 1, 1, '', '2018-03-15 09:19:05', '', '', '');
INSERT INTO `user` VALUES ('1df68dfd-3b6d-4491-872f-00a0fc6c5a64', 'test4', 'test4', 'test4', 1, 1, '', '2017-12-12 14:07:11', '', '', '');
INSERT INTO `user` VALUES ('229f3a49-ab27-49ce-b383-9f10ca23a9d5', 'test3', 'test3', 'test3', 1, 1, '', '2017-12-12 14:07:05', '', '', '');
INSERT INTO `user` VALUES ('49df1602-f5f3-4d52-afb7-3802da619558', 'admin', 'admin', 'admin', 1, 0, '', '2017-12-11 16:18:54', '', '', '');
INSERT INTO `user` VALUES ('6ba79766-faa0-4259-8139-a4a6d35784e0', 'test', 'test', 'test', 1, 0, '', '2017-12-11 16:19:00', '', '', '');
INSERT INTO `user` VALUES ('758a34c7-5a31-438c-bdf7-02fdd846b901', 'test77', 'test77', 'test77', 0, 0, '', '2019-10-31 21:59:08', '00000000-0000-0000-0000-000000000000', '', '');
INSERT INTO `user` VALUES ('96f63f9d-e8c8-4258-963e-3327ed7d6f56', 'test66', 'test66', 'test66', 0, 0, '', '2019-10-31 21:58:43', '00000000-0000-0000-0000-000000000000', '', '');
INSERT INTO `user` VALUES ('de8be521-f1ec-4483-b124-0be342890507', 'test2', 'test2', 'test2', 1, 0, '', '2017-12-11 16:19:06', '', '', '');

-- ----------------------------
-- Table structure for wmscustomermst
-- ----------------------------
DROP TABLE IF EXISTS `wmscustomermst`;
CREATE TABLE `wmscustomermst`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户ID',
  `Name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公司全称',
  `SName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公司简称',
  `Telephone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话',
  `Fax` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传真号',
  `Email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电子邮件',
  `Remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `Address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '详细地址',
  `ContactPhone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人电话',
  `ContactUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人',
  `CustType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户类型(SYS_CUSTOMERTYPE)',
  `Shipper` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人',
  `TransferType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运方式(SYS_TRANCFERTYPE)',
  `DeliverArea` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送区域',
  `DeliverRoute` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送路线',
  `DeliverId` decimal(32, 0) DEFAULT NULL COMMENT '配送序号',
  `DeliveAddr` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送地址',
  `CUSTLOCATION` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户范围',
  `IsFactory` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否厂家',
  `DeliverRemark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送备注',
  `IsOwner` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否货主',
  `IsPurchaser` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否供应商',
  `CustProperty` tinyint(1) NOT NULL DEFAULT 0 COMMENT '客户性质区分',
  `CustCorrCode` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户对应码',
  `ShippingAddress` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '证照地址',
  `IsColdDeliver` tinyint(1) DEFAULT 0 COMMENT '是否冷链配送(0:否,1:是)',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '客户主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsdelivertbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsdelivertbl`;
CREATE TABLE `wmsdelivertbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据Id',
  `OutBoundOrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出库通知单单号',
  `DeliverAreaId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送区域',
  `DeliverRouteId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送支线',
  `DeliverSortId` decimal(32, 0) DEFAULT NULL COMMENT '配送序号',
  `DelvierRemark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送备注',
  `RequestArrivalDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '要求到货日期',
  `DeliverAddr` varchar(520) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配送地址',
  `Contactor` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户联系人',
  `ContactPhone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户联系电话',
  `ShipperContactor` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人联系人',
  `ShipType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运方式',
  `ShipperPhone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人联系电话',
  `ShipperId` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人',
  `CustomerFax` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户传真',
  `ShipperFax` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人传真',
  `CustPickFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '自提标识',
  `LicenseAddr` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '证照地址',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '配送信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsgoodsareamst
-- ----------------------------
DROP TABLE IF EXISTS `wmsgoodsareamst`;
CREATE TABLE `wmsgoodsareamst`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区ID',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库ID',
  `GoodsAreaType` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货区类型',
  `Name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货区名称',
  `SName` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区简称',
  `QualityFlg` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '品质区分(SYS_QUALITYFLAG)',
  `GoodsTopCategory` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品类别(SYS_GOODSTOPCATEGORY)',
  `GoodsCategory` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流转类型(SYS_GOODSCATEGORY)',
  `UnitAttri` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '整零区分(SYS_UNITATTRI)',
  `ContainerType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '保管类型(SYS_CONTAINERTYPE)',
  `AllowedQty` decimal(18, 2) DEFAULT NULL COMMENT '每个货位允许存放的最大货容',
  `AllowedQtyFlg` decimal(8, 0) DEFAULT NULL COMMENT '是否启用货容标识(0:否,1:是)',
  `AreaNo` decimal(32, 0) NOT NULL COMMENT '拣选序号',
  `StagingType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '集货类型(SYS_STAGINGTYPE)',
  `SorterNo` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'SORTER编号',
  `LotMixtureFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '允许混批',
  `Enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `NumFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '数量启用标志',
  `ManagerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员ID',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `OperMode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拣选方式(SYS_OPERMODE整品箱、零品箱、清单)',
  `BlockId` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '作业区号',
  `OwnerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主ID',
  `OwnerMixtureFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否允许混货主',
  `TempTypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '温控条件(SYS_TEMPTYPE)',
  `PutAwayType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上架类型(SYS_GOODSAREAPUTAWAYTYPE)',
  `BusinessType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '业务区分(SYS_REGIONBUSTYPE)',
  `ShareFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '共享标志',
  `PickType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货区拣选类型',
  `TransferType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运方式(SYS_TRANCFERTYPE)',
  `CustType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户类型(SYS_CUSTOMERTYPE)',
  `GoodsReceType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收货方式(SYS_FULLBOXINTYPE)',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`, `StockId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '货区主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsgoodsbatchmst
-- ----------------------------
DROP TABLE IF EXISTS `wmsgoodsbatchmst`;
CREATE TABLE `wmsgoodsbatchmst`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '批号序列号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品批号',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品SKU',
  `ProductDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生产日期',
  `ExpireDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '失效日期',
  `Length` decimal(18, 2) DEFAULT NULL COMMENT '长,去掉了商品主表的长宽高，新增批号时默认的长宽高取批号主表里面的',
  `Width` decimal(18, 2) DEFAULT NULL COMMENT '宽',
  `Height` decimal(18, 2) DEFAULT NULL COMMENT '高',
  `BigNetWeight` decimal(18, 4) DEFAULT NULL COMMENT '大包装重量',
  `BigUnitCap` decimal(18, 4) DEFAULT NULL COMMENT '大包装体积',
  `BigPerNum` decimal(18, 2) DEFAULT NULL COMMENT '大包装数量',
  `MidUnitNetWeight` decimal(18, 4) DEFAULT NULL COMMENT '中包装重量',
  `MidUnitCap` decimal(18, 4) DEFAULT NULL COMMENT '中包装体积',
  `MidPerNum` decimal(18, 2) DEFAULT NULL COMMENT '中包装数量',
  `StandNetWeight` decimal(18, 4) DEFAULT NULL COMMENT '标准包装重量',
  `StandCap` decimal(18, 4) DEFAULT NULL COMMENT '标准包装体积',
  `FirstTime` datetime(0) DEFAULT NULL COMMENT '首次入库时间',
  `Certificate` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '注册证',
  `AvaType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '效期类别(SYS_EXPIREDFLAG)',
  `WidthCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品宽度代码(SYS_WIDTHCODE)',
  `HeightCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品高度代码(SYS_HEIGHTCODE)',
  `ProdSite` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '产地',
  `StandLength` decimal(18, 2) DEFAULT NULL COMMENT '标准单位长',
  `StandWidth` decimal(18, 2) DEFAULT NULL COMMENT '标准单位宽',
  `StandHeight` decimal(18, 2) DEFAULT NULL COMMENT '标准单位高',
  `RecType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收货方式(SYS_RECETYPE)',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`, `GoodsBatch`, `GoodsId`) USING BTREE,
  INDEX `AK_GOODSBATCHMST`(`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '批号主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsgoodsmst
-- ----------------------------
DROP TABLE IF EXISTS `wmsgoodsmst`;
CREATE TABLE `wmsgoodsmst`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据ID',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品SKU',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主ID',
  `GoodsTypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品分类',
  `SpellCode` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拼音码',
  `Name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `TradeMark` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '厂牌',
  `Model` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '规格',
  `LicenseNumber` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '批准文号',
  `BatchFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '同批标志',
  `HoldDays` decimal(16, 0) DEFAULT NULL COMMENT '保质天数',
  `PrintFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '打印标志',
  `SkuBarCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '条形码',
  `StyleId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '外形特征',
  `ProdArea` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '原产地',
  `ChemicalName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '化学名',
  `SName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品简称',
  `EnglishName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品英文名',
  `BigUnit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '大包装单位',
  `BigPerNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大包装数量',
  `MidUnit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '中包装单位',
  `MidPerNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中包装数量',
  `StandUnit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标准包装单位',
  `IsBig` tinyint(1) NOT NULL DEFAULT 1 COMMENT '大单位启用',
  `IsMid` tinyint(1) NOT NULL DEFAULT 0 COMMENT '中单位启用',
  `IsStand` tinyint(1) NOT NULL DEFAULT 1 COMMENT '标准单位启用',
  `StandGrossWeight` decimal(18, 4) DEFAULT NULL COMMENT '大单位净重(*)',
  `StandNetWeight` decimal(18, 4) DEFAULT NULL COMMENT '标准单位净重',
  `StandCap` decimal(18, 4) DEFAULT NULL COMMENT '标准单位体积',
  `StaticStock` decimal(18, 2) DEFAULT NULL COMMENT '固定补足点',
  `SafeStock` decimal(18, 2) DEFAULT NULL COMMENT '安全库存',
  `UpperStock` decimal(18, 2) DEFAULT NULL COMMENT '最高库存',
  `DownStock` decimal(18, 2) DEFAULT NULL COMMENT '最低库存',
  `PriceType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '价格类型',
  `ListPrice` decimal(18, 2) DEFAULT NULL COMMENT '国家牌价',
  `RetailPrice` decimal(18, 2) DEFAULT NULL COMMENT '零售价',
  `BuyPrice` decimal(18, 2) DEFAULT NULL COMMENT '买入价',
  `CustPrice` decimal(18, 2) DEFAULT NULL COMMENT '批发价',
  `StockPrice` decimal(18, 2) DEFAULT NULL COMMENT '寄托价',
  `SalePrice` decimal(18, 2) DEFAULT NULL COMMENT '销售价',
  `HoldDayType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '保质天数方式',
  `Remark` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `DockLayer` decimal(18, 2) DEFAULT NULL COMMENT '码垛层数',
  `DockQty` decimal(18, 2) DEFAULT NULL COMMENT '码垛箱数',
  `DockSum` decimal(18, 2) DEFAULT NULL COMMENT '码垛总箱数',
  `Enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `AttriStockArea` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '区域储备类型',
  `TempTypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '保管温度条件(SYS_TEMPTYPE)',
  `IsBigUnit` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否大单位核算',
  `TransType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '运输类型(SYS_TRANSTYPE)',
  `TaxRate` decimal(10, 4) DEFAULT NULL COMMENT '税率(单据里面下传税率)',
  `FullMark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '厂牌全称',
  `Width` decimal(18, 2) DEFAULT NULL COMMENT '宽',
  `Length` decimal(18, 2) DEFAULT NULL COMMENT '长',
  `Height` decimal(18, 2) DEFAULT NULL COMMENT '高',
  `InboxFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否进箱式立体库',
  `InCacheFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否进缓存',
  `BusinessScope` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '经营范围(SYS_JYFW)',
  `IsSkuBarCode` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有条形码',
  `ImportFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '进口标识',
  `TemperatureArea` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '温度区间(SYS_TEMPERATURE)',
  `TopTemp` decimal(5, 1) DEFAULT NULL COMMENT '最高温度',
  `LowerTemp` decimal(5, 1) DEFAULT NULL COMMENT '最低温度',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '商品主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsgoodsposmst
-- ----------------------------
DROP TABLE IF EXISTS `wmsgoodsposmst`;
CREATE TABLE `wmsgoodsposmst`  (
  `GoodsPosId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货位ID',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库ID',
  `GoodsAreaId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区ID',
  `Name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货位名称',
  `SName` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货位简称',
  `BarCode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '条形码',
  `PosLayer` decimal(18, 2) DEFAULT NULL COMMENT '层',
  `PosRow` decimal(18, 2) DEFAULT NULL COMMENT '列',
  `Length` decimal(18, 2) DEFAULT NULL COMMENT '长',
  `Width` decimal(18, 2) DEFAULT NULL COMMENT '宽',
  `Height` decimal(18, 2) DEFAULT NULL COMMENT '高',
  `Weight` decimal(18, 4) DEFAULT NULL COMMENT '可存放重量',
  `Volumn` decimal(18, 4) DEFAULT NULL COMMENT '可存放体积',
  `UsedVolumn` decimal(18, 4) DEFAULT NULL COMMENT '使用体积',
  `ContainNum` decimal(18, 4) DEFAULT NULL COMMENT '允许托盘数',
  `InRoad` decimal(32, 0) DEFAULT NULL COMMENT '进货线路',
  `OutRoad` decimal(32, 0) DEFAULT NULL COMMENT '出货线路',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `UsedFlg` decimal(8, 0) DEFAULT NULL COMMENT '占用标志',
  `LotMixtureFlg` decimal(8, 0) DEFAULT NULL COMMENT '允许混批',
  `Enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主ID',
  `SubBayNo` decimal(3, 0) NOT NULL DEFAULT 0 COMMENT '子货位号',
  `WidthCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货架宽度代码(SYS_WIDTHCODE)',
  `HeightCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货架高度代码(SYS_HEIGHTCODE)',
  `PutAwayRestricted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '入库禁用(0:未禁用,1:禁用)',
  `RetrievalRestricted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '出库禁用(0:未禁用,1:禁用)',
  `SubBayRestricted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '子货位禁用(0:未禁用,1:禁用)',
  `Empty` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否空货位',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`GoodsPosId`, `StockId`, `GoodsAreaId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '货位主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsinboundarrivaldtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsinboundarrivaldtbl`;
CREATE TABLE `wmsinboundarrivaldtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '到货通知单明细号',
  `AsnNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '到货通知单号',
  `InboundOrderId` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入库通知单号',
  `GoodsBatch` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品批号',
  `InboundOrderDtId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库通知单明细号',
  `GoodsId` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '品质(SYS_QUALITYFLAG)',
  `CustGoodsId` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户商品编号',
  `Volume` decimal(18, 4) DEFAULT NULL COMMENT '体积',
  `NetWeight` decimal(18, 4) DEFAULT NULL COMMENT '净重',
  `GrossWeight` decimal(18, 4) DEFAULT NULL COMMENT '毛重',
  `BigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大单位数量',
  `MidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中单位数',
  `StandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '标准单位数',
  `ArrivalNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际入库数量',
  `InBigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已入大单位数',
  `InMidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已入中单位数',
  `InStandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已入标准单位数',
  `InNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已入数量',
  `PickNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已上架数量',
  `PurchaseNo` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '采购单号',
  `StockId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主编号(固定值CQM)',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`, `AsnNo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '到货通知单明细' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsinboundarrivaltbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsinboundarrivaltbl`;
CREATE TABLE `wmsinboundarrivaltbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '到货通知单号',
  `AsnStatus` int(11) NOT NULL DEFAULT 0 COMMENT '到货通知单状态(SYS_ASNSTATUS)',
  `InstockType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库类型(SYS_INSTCTYPE)',
  `StockId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `ShipperId` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人编号',
  `SupplierId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '供应商编号',
  `OwnerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主编号',
  `ScheduledDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '预定入库日期',
  `ActualDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '实际入库日期',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `Enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `IsBatch` tinyint(1) DEFAULT NULL COMMENT '是否整批处理',
  `Treator` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '经办人',
  `BlindReason` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盲收原因',
  `ReportNum` int(11) DEFAULT NULL COMMENT '送货清单数量',
  `NoReportRemark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '缺送货清单原因',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '到货通知单' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsinboundorderdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsinboundorderdtbl`;
CREATE TABLE `wmsinboundorderdtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库通知单明细号',
  `OrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库通知单号',
  `Price` decimal(18, 6) DEFAULT NULL COMMENT '含税单价',
  `PriceNoTax` decimal(18, 6) DEFAULT NULL COMMENT '无税单价',
  `InStockStatus` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否收货中(0:非收货中,1:收货中)',
  `AsnStatus` int(11) NOT NULL DEFAULT 1 COMMENT '到货状况(SYS_GOODSARRIVESTATUS)',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品批号',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品质(SYS_QUALITYFLAG)',
  `OrderNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '通知数量',
  `InNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '到货数量',
  `LeaveNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '剩余数量',
  `HoldNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '占用数量',
  `ProdDate` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生产日期',
  `ExpireDate` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '失效日期',
  `TaxRate` decimal(10, 2) DEFAULT NULL COMMENT '税率',
  `OwnerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主编号',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`, `OrderId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '入库通知单明细' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsinboundordertbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsinboundordertbl`;
CREATE TABLE `wmsinboundordertbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库通知单号',
  `ExternalNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '相关单据号',
  `ExternalType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '相关单据类型',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '入库通知单状态(SYS_INSTCINFORMSTATUS)',
  `OrderType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库类型(SYS_INSTCTYPE)',
  `GoodsType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品类别',
  `PurchaseNo` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '采购单号',
  `StockId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主编号(固定值CQM)',
  `ShipperId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人编号',
  `SupplierId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '供应商编号',
  `ScheduledInboundTime` datetime(0) DEFAULT NULL COMMENT '预定入库时间',
  `Remark` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `Enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '有效标志',
  `TransferType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运方式',
  `InBondedArea` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否入保税库(0:否,1:是)',
  `ReturnBoxNum` decimal(8, 0) NOT NULL DEFAULT 0 COMMENT '销退箱数',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '入库通知单（入库订单）' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of wmsinboundordertbl
-- ----------------------------
INSERT INTO `wmsinboundordertbl` VALUES ('2019102203RK0001', '2019102203RK0001', '1', 1, '普通入库', '普通商品', '2019102203RK0001', 'BJ003', 'CDC001', 'SF', 'SF', '2019-10-10 00:00:00', '', 1, '1', 0, 1, '2019-10-31 21:27:14', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-31 21:27:14', '', '');
INSERT INTO `wmsinboundordertbl` VALUES ('2019102203RK0002', '2019102203RK0002', '1', 1, '普通入库', '普通商品', '2019102203RK0002', 'BJ003', 'CDC001', 'SF', 'SF', '2019-10-10 00:00:00', '', 1, '1', 0, 1, '2019-10-31 21:27:14', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-31 21:27:14', '', '');
INSERT INTO `wmsinboundordertbl` VALUES ('2019102203RK0003', '2019102203RK0003', '1', 1, '普通入库', '普通商品', '2019102203RK0003', 'BJ003', 'CDC001', 'SF', 'SF', '2019-10-10 00:00:00', '', 1, '1', 0, 1, '2019-10-31 21:27:14', '00000000-0000-0000-0000-000000000000', '超级管理员', '2019-10-31 21:27:14', '', '');

-- ----------------------------
-- Table structure for wmsinstockpickdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsinstockpickdtbl`;
CREATE TABLE `wmsinstockpickdtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '上架单明细号',
  `InstockPickId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '上架单号',
  `InstockRecvId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货单号',
  `InstockRecvDtId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货单明细号',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '上架任务状态(SYS_INSTOCKPICKSTATUS)',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品批号',
  `BigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大单位数量',
  `MidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中单位数',
  `StandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '标准单位数',
  `Num` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '数量',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '品质(SYS_QUALITYFLAG)',
  `PurchaseNo` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '采购单号',
  `QualityReasonCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '品质原因代码(SYS_QUALITYREASON)',
  `ContainerType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '容器类别(SYS_PIKCRELATYPE)',
  `ContainerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '容器编号',
  `GoodsAreaId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区编号',
  `GoodsPosId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货位编号',
  `PickUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上架人',
  `PickBeginTime` datetime(0) DEFAULT NULL COMMENT '上架开始时间',
  `PickEndTime` datetime(0) DEFAULT NULL COMMENT '上架结束时间',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `IsAllowOut` tinyint(1) DEFAULT NULL COMMENT '允许出库标记',
  `SortId` decimal(32, 0) DEFAULT NULL COMMENT '顺序号',
  `Volume` decimal(18, 4) DEFAULT NULL COMMENT '体积',
  `Weight` decimal(18, 4) DEFAULT NULL COMMENT '重量',
  `InStockDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入库时间',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`InstockPickId`, `Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '上架任务明细' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsinstockpicktbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsinstockpicktbl`;
CREATE TABLE `wmsinstockpicktbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '上架单号',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主',
  `ConfirmUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '确认人',
  `ConfirmTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '确认时间',
  `Enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `PickStatus` int(11) NOT NULL DEFAULT 0 COMMENT '上架单状态(SYS_INSTOCKPICKSTATUS)',
  `PickDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上架时间',
  `Operator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上架操作员',
  `PutawayType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上架类型(SYS_GOODSAREAPUTAWAYTYPE)',
  `InstockType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入库类型(SYS_INSTCTYPE)',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '上架任务' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsinstockrecdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsinstockrecdtbl`;
CREATE TABLE `wmsinstockrecdtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货单明细号',
  `InstockRecvId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货单号',
  `InboundOrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入库通知单号',
  `InboundOrderDtId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库通知单明细号',
  `PurchaseId` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '采购单号',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品批号',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '品质',
  `OwnerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主',
  `Volume` decimal(18, 4) DEFAULT NULL COMMENT '体积',
  `NetWeight` decimal(18, 4) DEFAULT NULL COMMENT '净重',
  `BigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大单位数量',
  `MidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中单位数',
  `StandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '标准单位数',
  `ApplyNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '申请数量',
  `InBigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已入大单位数',
  `InMidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已入中单位数',
  `InStandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已入标准单位数',
  `InNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已入库数量',
  `PickNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '已上架数量',
  `GrossWeight` decimal(18, 4) DEFAULT NULL COMMENT '毛重',
  `ContainerNo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '容器编号',
  `UnusualFlg` tinyint(1) DEFAULT NULL COMMENT '异常标识',
  `CheckBigUnitNum` decimal(18, 2) DEFAULT NULL COMMENT '抽样件数',
  `CheckStandUnitNum` decimal(18, 2) DEFAULT NULL COMMENT '抽样个数',
  `RecvUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收货人',
  `RecvDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收货日期',
  `Checkuser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '验收人',
  `CheckDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '验收日期',
  `LastInNum` decimal(18, 2) DEFAULT NULL COMMENT '上次入库数',
  `NoReportRemark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '缺送货清单原因',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`InstockRecvId`, `Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '收货单明细' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsinstockrectbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsinstockrectbl`;
CREATE TABLE `wmsinstockrectbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货单号',
  `AsnNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '到货通知单号',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '收货单状态(SYS_INSTOCKTATUS)',
  `InstockType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库类型(SYS_INSTCTYPE)',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `ShipperId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人',
  `SupplierId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '供应商',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主',
  `ScheduledDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '预定入库日期',
  `ActualDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '实际入库日期',
  `PlatformNo` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '月台号',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `Enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `IsBatch` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否整批处理',
  `Treator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '经办人',
  `InvoiceNo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发票号',
  `AsnDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '到货日期',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '收货单' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsloadingdocdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsloadingdocdtbl`;
CREATE TABLE `wmsloadingdocdtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '装车单明细号',
  `LoadingDocId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '装车单号',
  `OrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出库指示单号',
  `OrderDetailId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出库指示明细号码',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '批号',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品质(SYS_QUALITYFLAG)',
  `LoadBigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '装车大单位数',
  `LoadMidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '装车中单位数',
  `LoadStandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '装车标准单位数',
  `LoadNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '装车数量',
  `ArriveBigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '到货大单位数',
  `ArriveMidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '到货中单位数',
  `ArriveStandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '到货标准单位数',
  `ArriveNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '到货数量',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '到货状态',
  `SendDocId` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发货单号',
  `BackNum` decimal(18, 2) DEFAULT NULL COMMENT '退回数量',
  `BackReason` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '退回原因',
  `BackFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '退回标示',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  `Remark` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注，拒收照片',
  PRIMARY KEY (`Id`, `LoadingDocId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '装车单明细表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsloadingdoctbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsloadingdoctbl`;
CREATE TABLE `wmsloadingdoctbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '装车单号',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '装车单状态(SYS_LOADINGDOC_STATUS)',
  `LoadingNoticeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '预装车指示单号',
  `VehicleLicense` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '车牌号',
  `DriverName` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '司机名',
  `Telphone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话',
  `ShipperId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人',
  `TransportationMode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '承运方式',
  `SendUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '送货员',
  `TotalItemCaseQty` decimal(18, 2) NOT NULL COMMENT '总计箱数',
  `UnloadingPointNumber` decimal(18, 2) NOT NULL COMMENT '卸货点数',
  `Route` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '起止路线',
  `Miles` decimal(18, 2) DEFAULT NULL COMMENT '行驶里程',
  `TransferPoint` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '中转单位',
  `PlatformId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '月台',
  `BillNos` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '随车单据',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `LoadingConfirmUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '装货完毕确认人',
  `LoadingConfirmTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '装货完毕时间',
  `ShippingConfirmUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发货确认人',
  `ShippingConfirmTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发货时间',
  `ActionFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '有效标识',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主',
  `StockId` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仓库编号',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '装车单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsloadingnoticedtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsloadingnoticedtbl`;
CREATE TABLE `wmsloadingnoticedtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '明细号',
  `LoadingNoticeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预装车指示号',
  `OrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '出库通知单号',
  `LoadingTurnNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '预装车周转箱数',
  `LoadingCoopNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '预装车笼车数',
  `LoadingSalverNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '预装车托盘数',
  `LoadingBigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '预装车箱数',
  `LoadingTolBigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '预装车总箱数',
  `UnionNum` decimal(18, 2) DEFAULT NULL COMMENT '拼箱数',
  `MultiCustUnionNum` decimal(18, 2) DEFAULT NULL COMMENT '多客户拼箱数',
  `TotalItemWeightPlan` decimal(18, 4) DEFAULT NULL COMMENT '预装车重量',
  `TotalItemVolumPlan` decimal(18, 4) DEFAULT NULL COMMENT '预装车体积',
  PRIMARY KEY (`Id`, `LoadingNoticeId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '配载单、预装车单明细表\r\n' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsloadingnoticetbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsloadingnoticetbl`;
CREATE TABLE `wmsloadingnoticetbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预装车指示号',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '预装车状态(SYS_LOADINGNOTICE_STATUS)',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `ShipperId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '承运人',
  `PlatformId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '月台号',
  `PermittedTonnage` decimal(18, 4) DEFAULT NULL COMMENT '车辆准载吨位',
  `PermittedCap` decimal(18, 4) DEFAULT NULL COMMENT '车辆准载体积',
  `PermittedContainVechile` decimal(18, 2) DEFAULT NULL COMMENT '车辆准载笼车',
  `PermittedPallet` decimal(18, 2) DEFAULT NULL COMMENT '车辆准载托盘',
  `UnloadingPointNumber` decimal(18, 2) NOT NULL COMMENT '卸货点数',
  `TotalItemWeightPlan` decimal(18, 4) NOT NULL COMMENT '预装车重量',
  `TotalItemVolumPlan` decimal(18, 4) NOT NULL COMMENT '预装车体积',
  `TotalUnitNum` decimal(18, 2) DEFAULT NULL COMMENT '预装车箱数',
  `TransformType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '承运方式',
  `VehicleLicense` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '车牌',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `CustGroup` varchar(1280) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户组',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主',
  `VechileType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '车辆类型(SYS_VECHILETYPE)',
  `VechileFee` tinyint(1) NOT NULL DEFAULT 0 COMMENT '特殊收费 ',
  `OutCacheUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '缓存出库人',
  `OutCacheTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '缓存出库时间',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '配载单、预装车单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsmovetaskdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsmovetaskdtbl`;
CREATE TABLE `wmsmovetaskdtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '明细编号',
  `MoveTaskId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务编号',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主编号',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移动仓库',
  `GoodsAreaId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移动货区',
  `GoodsPosId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移动货位',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品批号',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品质',
  `PurchaseNo` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采购单号',
  `InBatchCode` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入库批次',
  `IsAllowOut` tinyint(1) NOT NULL DEFAULT 0 COMMENT '允许出库标记',
  `BillId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内部单据号(下架的任务号)',
  `BigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大单位数量',
  `MidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中单位数',
  `StandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '标准单位数',
  `Num` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '数量',
  `ActBigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际大单位数量',
  `ActMidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际中单位数量',
  `ActStandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际标准数量',
  `ActNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际数量',
  `Volume` decimal(18, 4) DEFAULT NULL COMMENT '体积',
  `NetWeight` decimal(18, 4) DEFAULT NULL COMMENT '净重',
  `GrossWeight` decimal(18, 4) DEFAULT NULL COMMENT '毛重',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '说明',
  `Operator` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作人',
  `OperateDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作日期',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`, `MoveTaskId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '移库任务明细' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsmovetaskgrouptbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsmovetaskgrouptbl`;
CREATE TABLE `wmsmovetaskgrouptbl`  (
  `MoveTaskGroupId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移库单编号',
  `TaskId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移库任务编号',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`MoveTaskGroupId`, `TaskId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '移库任务组' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsmovetasktbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsmovetasktbl`;
CREATE TABLE `wmsmovetasktbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务编号',
  `MoveIndicationId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移库指示编号',
  `MoveIndicationDetailId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '明细编号',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '状态',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移入仓库',
  `MoveType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移库类型',
  `MoveReason` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '移动原因',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `InOutType` tinyint(1) NOT NULL DEFAULT 1 COMMENT '移入移出类型（1移入，2移出）',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '移库任务' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsoutboundarrivaltbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsoutboundarrivaltbl`;
CREATE TABLE `wmsoutboundarrivaltbl`  (
  `LoadingDocId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '装车单号',
  `OutBoundOrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出库指示单号',
  `SendDocId` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发货单号',
  `OutStockNum` decimal(18, 2) DEFAULT NULL COMMENT '出库数量',
  `ArrivalNum` decimal(18, 2) DEFAULT NULL COMMENT '到货数量',
  `ArrivalStatus` int(11) NOT NULL DEFAULT 0 COMMENT '到货状态(SYS_ARRIVAL_STATUS)',
  `ArrivalDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '到货日期',
  `SigUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签收人',
  `ArrivalRemark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '到货备注',
  `ConfirmUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '到货确认人',
  `ConfirmTime` datetime(0) DEFAULT NULL COMMENT '到货确认时间',
  PRIMARY KEY (`LoadingDocId`, `OutBoundOrderId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '到货信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsoutboundorderdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsoutboundorderdtbl`;
CREATE TABLE `wmsoutboundorderdtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出库通知明细号',
  `OrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出库通知单号',
  `GoodsId` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品批号',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '品质(SYS_QUALITYFLAG)',
  `Price` decimal(18, 6) NOT NULL DEFAULT 0.000000 COMMENT '含税单价',
  `PriceNoTax` decimal(18, 6) DEFAULT NULL COMMENT '不含税单价',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主ID',
  `BoxId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '箱号',
  `BigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大单位数',
  `MidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中单位数',
  `StandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '标准单位数',
  `Num` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '出库数量',
  `Amount` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '出库金额',
  `Volume` decimal(18, 4) DEFAULT NULL COMMENT '体积',
  `NetWeight` decimal(18, 4) DEFAULT NULL COMMENT '净重',
  `GrossWeight` decimal(18, 4) DEFAULT NULL COMMENT '毛重',
  `TaxRate` decimal(10, 2) DEFAULT NULL COMMENT '税率',
  PRIMARY KEY (`Id`, `OrderId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '出库通知单明细表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsoutboundordertbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsoutboundordertbl`;
CREATE TABLE `wmsoutboundordertbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出库通知单号',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '出库通知单状态(SYS_ORDERSTATUS)',
  `StockId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `OrderNo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '订单号',
  `OutStockType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '出库类型(SYS_OUTSTCTYPE)',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主',
  `CustId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户',
  `IsUrgency` tinyint(1) NOT NULL DEFAULT 0 COMMENT '加急否(0:否,1:是)',
  `IsPayNeed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否需要收款(0:否,1:是)',
  `IsOrderMerged` tinyint(1) NOT NULL DEFAULT 0 COMMENT '订单合并标识(0:否,1:是)',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `ConfirmUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '审核人',
  `ConfirmDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '审核时间',
  `Treator` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '经办人',
  `IsBatch` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否整批处理(0:否,1:是)',
  `Enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `RequireDate` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '要求到货日期',
  `ErpAddressFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否指定地址(0:否,1:是)',
  `ExternalPoId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '三方相关单据号',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '出库通知单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsoutboundpicktaskdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsoutboundpicktaskdtbl`;
CREATE TABLE `wmsoutboundpicktaskdtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拣选任务支号',
  `PickTaskId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拣选任务号',
  `OrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '出库通知单号',
  `OrderDetailId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '出库指示明细号码',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '拣选任务状态(SYS_PICKSTATUS)',
  `GoodsId` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '批号',
  `BigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大单位数量',
  `MidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中单位数',
  `StandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '标准单位数',
  `Num` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '数量',
  `ActBigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际大单位数量',
  `ActMidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际中单位数量',
  `ActStandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际标准数量',
  `ActNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '实际数量',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品质(SYS_QUALITYFLAG)',
  `PickAreaId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拣选货区',
  `PickPosId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拣选货位',
  `OwnerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主',
  `CheckFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '复核标记',
  `CheckUser` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '-' COMMENT '复核人',
  `CheckNum` decimal(18, 2) DEFAULT NULL COMMENT '复核数量',
  `CheckError` tinyint(1) NOT NULL DEFAULT 0 COMMENT '复核异常',
  `CheckErrorReason` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '异常原因',
  `BusinessType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '业务区分(SYS_REGIONBUSTYPE)',
  `PickingUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拣选人',
  `PickingStartTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拣选项开始时间',
  `PickingEndTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拣选项结束时间',
  `UnionNum` decimal(18, 2) DEFAULT NULL COMMENT '拼箱数',
  `MultiUnionNum` decimal(18, 2) DEFAULT NULL COMMENT '多客户拼箱数',
  `BoxNum` decimal(18, 2) DEFAULT NULL COMMENT '零品箱数',
  `StagingNum` decimal(18, 2) DEFAULT NULL COMMENT '集货拼箱数',
  `PickingNum` decimal(18, 2) DEFAULT NULL COMMENT '拣选人拣选数量',
  `CheckEndTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '复核结束时间',
  `RepTaskFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '补货标记',
  `BufferPosId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '缓存货位',
  `OutLabelNo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '出库标签号（打印号）',
  `TransferType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运方式(SYS_TRANCFERTYPE)',
  PRIMARY KEY (`Id`, `PickTaskId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '拣选任务明细表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsoutboundpicktasktbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsoutboundpicktasktbl`;
CREATE TABLE `wmsoutboundpicktasktbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拣选任务号',
  `PickwaveId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分拣波次号',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '拣选状态(SYS_PICKSTATUS)',
  `StagingZoneId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '集货区',
  `StagingLocationId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '集货货位',
  `StagingUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '集货人',
  `StagingTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '集货时间',
  `PickUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拣选人',
  `PickTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拣选时间',
  `RELEASEGROUPID` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '释放组号',
  `RepTaskFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '补货标记',
  `MultiCustJoinFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '多客户拼箱标记',
  `MultiCustJoinBoxNo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '多客户拼箱号',
  `CheckUser` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '复核人',
  `CheckStartTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '复核开始时间',
  `CheckEndTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '复核结束时间',
  `CheckFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '复核标记',
  `BoxNum` decimal(18, 2) DEFAULT NULL COMMENT '箱数',
  `PackUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '打包人',
  `PackTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '打包时间',
  `PackFlg` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '打包标记',
  `OutlabelNo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '出库标签号(打印号)',
  `BufferPosId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '缓存货位',
  `LoadingDocId` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '装车单号',
  `StockId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '80' COMMENT '仓库编号',
  `OwnerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主',
  `BufferFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否进缓存标记',
  `LoadingUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '装车人',
  `LoadingTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '装车时间',
  `Priority` decimal(8, 0) DEFAULT NULL COMMENT '优先级',
  `FillFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '补流程标记(0:否,1:是)',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '拣选任务表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsownermst
-- ----------------------------
DROP TABLE IF EXISTS `wmsownermst`;
CREATE TABLE `wmsownermst`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主ID',
  `Name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公司全称',
  `SName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公司简称',
  `Telephone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话',
  `Fax` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传真号',
  `Email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电子邮件',
  `Remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `Address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '详细地址',
  `ContactPhone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人电话',
  `ContactUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人',
  `TaxNum` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '税号',
  `BankNum` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '银行账号',
  `PrintOrder` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否打印随货通行单',
  `ShowPrice` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发货单是否显示价格',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '货主主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmspickwavedtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmspickwavedtbl`;
CREATE TABLE `wmspickwavedtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '波次明细号',
  `PickwaveId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '波次号',
  `OrderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出库通知单单号',
  `StagingZoneId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '集货区',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`Id`, `PickwaveId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '出库波次明细表(分拣波次明细表)' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmspickwavetbl
-- ----------------------------
DROP TABLE IF EXISTS `wmspickwavetbl`;
CREATE TABLE `wmspickwavetbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分拣波次号',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '分拣波次状态(SYS_PICKWAVESTATUS)',
  `Harry` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否加急',
  `ReleaseUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '释放人ID',
  `ReleaseUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '释放人',
  `ReleaseTime` datetime(0) DEFAULT NULL COMMENT '释放时间',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '分拣波次表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsshippermst
-- ----------------------------
DROP TABLE IF EXISTS `wmsshippermst`;
CREATE TABLE `wmsshippermst`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '承运人ID',
  `SpellCode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拼音码',
  `IsBarcodePrint` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否打印条码标志',
  `Enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `TransferType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运类型(SYS_TRANCFERTYPE)',
  `Telephone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `Email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电子邮件',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `Addres` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '地址',
  `SName` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '承运人简称',
  `Name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '承运人名称',
  `ContactUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '承运人主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsstockadjdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsstockadjdtbl`;
CREATE TABLE `wmsstockadjdtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '明细编号',
  `AdjId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调整单编号',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `GoodsAreaId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区编号',
  `GoodsPosId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货位编号',
  `OwnerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主(*)',
  `CheckTaskTime` decimal(18, 0) DEFAULT NULL COMMENT '盘点次数',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品批号',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品质',
  `BigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大单位数量',
  `MidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中单位数',
  `StandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '标准单位数',
  `Num` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '数量',
  `AdjReason` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '调整原因',
  `PurchaseNo` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采购单号',
  `Status` int(11) NOT NULL COMMENT '盘点任务状态',
  `CheckStartTime` datetime(0) DEFAULT NULL COMMENT '盘点开始时间',
  `CheckEndTime` datetime(0) DEFAULT NULL COMMENT '盘点结束时间',
  `ProductTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生产日期(*)',
  `BoxId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '箱号',
  `InBatchCode` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入库批次(*)',
  `AllowOut` tinyint(1) DEFAULT NULL COMMENT '允许出库标记',
  `Price` decimal(18, 2) DEFAULT NULL COMMENT '单价(*)',
  `Amount` decimal(18, 2) DEFAULT NULL COMMENT '金额(*)',
  `Volume` decimal(18, 4) DEFAULT NULL COMMENT '体积(*)',
  `NetWeight` decimal(18, 4) DEFAULT NULL COMMENT '净重(*)',
  `GrossWeight` decimal(18, 4) DEFAULT NULL COMMENT '毛重(*)',
  `BillId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '相关单据号',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`AdjId`, `Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '调整单明细' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsstockadjtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsstockadjtbl`;
CREATE TABLE `wmsstockadjtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调整单编号',
  `StockCheckId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盘点指示编号',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调整仓库',
  `AdjType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调整类型(SYS_ADJTYPE)',
  `AdjReason` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '调整原因(*)',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '状态',
  `AdjUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盘点人ID',
  `AdjUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盘点人',
  `AdjTime` datetime(0) DEFAULT NULL COMMENT '调整时间',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `ConfirmUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '审核人ID',
  `ConfirmUser` datetime(0) DEFAULT NULL COMMENT '审核人',
  `ConfirmDate` datetime(0) DEFAULT NULL COMMENT '审核时间',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '调整单' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsstockchangelogtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsstockchangelogtbl`;
CREATE TABLE `wmsstockchangelogtbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品质(SYS_QUALITYFLAG)',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主编号',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `GoodsAreaId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区编号',
  `GoodsPosId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货位编号',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品批号',
  `BoxId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '托盘号',
  `ProductDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生产日期',
  `GoodsTypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户商品大类',
  `PurchaseNo` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采购单号',
  `InbatchCode` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库批次',
  `IsAllowOut` tinyint(1) NOT NULL DEFAULT 1 COMMENT '允许出库标记',
  `OperateType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '交易类型(SYS_STOCKOPTION)',
  `InFlg` tinyint(1) NOT NULL COMMENT '进出标志',
  `BigUnitNum` decimal(18, 2) DEFAULT NULL COMMENT '交易大单位数量',
  `MidUnitNum` decimal(18, 2) DEFAULT NULL COMMENT '交易中单位数',
  `StandUnitNum` decimal(18, 2) DEFAULT NULL COMMENT '交易标准单位数',
  `InAmount` decimal(18, 2) DEFAULT NULL COMMENT '交易金额',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '库存履历表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsstockcheckdtbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsstockcheckdtbl`;
CREATE TABLE `wmsstockcheckdtbl`  (
  `Id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '盘点指示明细编号',
  `StockCheckId` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '盘点指示编号',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `GoodsAreaId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区编号',
  `GoodsPosId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货位编号',
  `OwnerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '货主(*)',
  `CheckTaskTime` decimal(18, 0) DEFAULT NULL COMMENT '盘点次数',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品批号',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品质',
  `BigUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '大单位数量',
  `MidUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '中单位数',
  `StandUnitNum` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '标准单位数',
  `Num` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '数量',
  `PurchaseNo` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采购单号',
  `Status` int(11) NOT NULL COMMENT '盘点任务状态',
  `CheckStartTime` datetime(0) DEFAULT NULL COMMENT '盘点开始时间',
  `CheckEndTime` datetime(0) DEFAULT NULL COMMENT '盘点结束时间',
  `ProductTime` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '生产日期(*)',
  `BoxId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '箱号',
  `InBatchCode` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入库批次(*)',
  `AllowOut` tinyint(1) DEFAULT NULL COMMENT '允许出库标记',
  `Price` decimal(18, 2) DEFAULT NULL COMMENT '单价(*)',
  `Amount` decimal(18, 2) DEFAULT NULL COMMENT '金额(*)',
  `Volume` decimal(18, 4) DEFAULT NULL COMMENT '体积(*)',
  `NetWeight` decimal(18, 4) DEFAULT NULL COMMENT '净重(*)',
  `GrossWeight` decimal(18, 4) DEFAULT NULL COMMENT '毛重(*)',
  `BillId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '相关单据号',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`, `StockCheckId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '盘点指示明细' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsstockchecktbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsstockchecktbl`;
CREATE TABLE `wmsstockchecktbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '盘点指示编号',
  `StockId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '盘点仓库',
  `GoodsAreaId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区',
  `GoodsPosId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货位',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '状态',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `CheckType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盘点类型(SYS_CHECKTYPE)',
  `CheckUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盘点人ID',
  `CheckUser` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盘点人',
  `CheckTime` datetime(0) DEFAULT NULL COMMENT '盘点时间',
  `ConfirmUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '审核人ID',
  `ConfirmUser` datetime(0) DEFAULT NULL COMMENT '审核人',
  `ConfirmDate` datetime(0) DEFAULT NULL COMMENT '审核时间',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '盘点指示' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsstockgoodstbl
-- ----------------------------
DROP TABLE IF EXISTS `wmsstockgoodstbl`;
CREATE TABLE `wmsstockgoodstbl`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据ID',
  `OwnerId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货主编号',
  `GoodsId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `GoodsBatch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品批号',
  `ContainerId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '托盘号',
  `PurchseNo` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '采购单号',
  `InBatchCode` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入库批次',
  `IsAllowOut` tinyint(1) NOT NULL DEFAULT 1 COMMENT '允许出库标记',
  `QualityFlg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品质(SYS_QUALITYFLAG)',
  `StockId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库编号',
  `GoodsAreaId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货区编号',
  `GoodsPosId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货位编号',
  `ProductDate` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生产日期',
  `BigUnitNum` decimal(18, 2) DEFAULT 0.00 COMMENT '存储大单位数量',
  `MidUnitNum` decimal(18, 2) DEFAULT 0.00 COMMENT '存储中单位数量',
  `StandardUnitNum` decimal(18, 2) DEFAULT 0.00 COMMENT '存储标准单位数量',
  `LockedStandardUnitNum` decimal(18, 2) DEFAULT 0.00 COMMENT '被锁标准单位数量',
  `LockedMidUnitNum` decimal(18, 2) DEFAULT 0.00 COMMENT '被锁中单位数',
  `LockedBigUnitNum` decimal(18, 2) DEFAULT 0.00 COMMENT '被锁大单位数量',
  `Volume` decimal(18, 4) DEFAULT NULL COMMENT '体积',
  `GrossWeight` decimal(18, 4) DEFAULT NULL COMMENT '毛重',
  `NetWeight` decimal(18, 4) DEFAULT NULL COMMENT '净重',
  `Amount` decimal(18, 2) DEFAULT NULL COMMENT '金额',
  `InStockDate` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入库日期',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '在库库存表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wmsstockmst
-- ----------------------------
DROP TABLE IF EXISTS `wmsstockmst`;
CREATE TABLE `wmsstockmst`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库ID',
  `Name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仓库名称',
  `ManagerId` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员',
  `SName` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '显示名称',
  `Remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `Enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '有效标志(SYS_ACTIONFLAG)',
  `PrintFlg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '打印标志',
  `Fax` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传真号',
  `Address` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仓库地址',
  `Telephone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话',
  `ManagerTel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员电话',
  `CreateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `CreateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `UpdateTime` datetime(0) DEFAULT NULL COMMENT '最后更新时间',
  `UpdateUserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人ID',
  `UpdateUserName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '仓库主表' ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
