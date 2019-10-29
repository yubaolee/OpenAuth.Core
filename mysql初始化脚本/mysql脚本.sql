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
INSERT INTO `module` VALUES ('0031262c-689c-4b96-bae2-2c9d67076ade', '.0.1.9.', '流程设计', '/flowSchemes/index', '', 0, 0, 'layui-icon-engine', 0, '基础配置', '', 0, '7580672f-a390-4bb6-982d-9a4570cb5199', 'FlowScheme', 1);
INSERT INTO `module` VALUES ('069475e3-c997-487a-9f29-e6a864c5c1d4', '.0.2.', '流程中心', '/', '', 0, 0, 'layui-icon-senior', 0, '根节点', '', 0, NULL, NULL, 1);
INSERT INTO `module` VALUES ('37bb9414-19a0-4223-9056-71f8c758a930', '.0.2.5.', '已处理流程', '/flowinstances/disposed', '', 0, 0, 'layui-icon-ok-circle', 0, '流程中心', '', 0, '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstanceDisposed', 1);
INSERT INTO `module` VALUES ('4abafc83-c8f5-452f-9882-e113a86e7a3e', '.0.2.6.', '待处理流程', '/flowinstances/wait', '', 0, 0, 'layui-icon-help', 0, '流程中心', '', 0, '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstanceWait', 1);
INSERT INTO `module` VALUES ('6a9e1346-0c01-44d2-8eb1-f929fdab542a', '.0.1.10.', '部门管理', '/OrgManager/Index', '', 0, 0, 'layui-icon-group', 0, '基础配置', '', 0, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Org', 1);
INSERT INTO `module` VALUES ('7580672f-a390-4bb6-982d-9a4570cb5199', '.0.1.', '基础配置', ' /', '', 0, 0, 'layui-icon-set-fill', 0, '根节点', '', 0, NULL, NULL, 1);
INSERT INTO `module` VALUES ('7bc7e527-478d-49fd-868d-5f31951586f5', '.0.3.1.', '系统日志', '/SysLogs/Index', '', 0, 0, 'layui-icon-theme', 0, '消息日志', '', 0, 'b19bce90-5508-43b6-93ed-cd9ff9e356a9', 'SysLog', 1);
INSERT INTO `module` VALUES ('7bc7e527-478d-49fd-868d-5f31951586f6', '.0.3.2.', '我的消息', '/SysMessages/Index', '', 0, 0, 'layui-icon-theme', 0, '消息日志', '', 0, 'b19bce90-5508-43b6-93ed-cd9ff9e356a9', 'SysMessage', 1);
INSERT INTO `module` VALUES ('92b00259-2d15-43e7-9321-adffb29e8bf2', '.0.1.11.', '表单设计', '/forms/index', '', 0, 0, 'layui-icon-theme', 0, '基础配置', '', 0, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Form', 1);
INSERT INTO `module` VALUES ('9486ff22-b696-4d7f-8093-8a3e53c45453', '.0.2.7.', '我的流程', '/flowInstances/Index', '', 0, 0, 'layui-icon-share', 0, '流程中心', '', 0, '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstance', 1);
INSERT INTO `module` VALUES ('9a87c0fa-9172-42a1-9505-7492433dcb8e', '.0.1.16.', '数据权限', '/dataprivilegerules/index', '', 0, 0, 'layui-icon-auz', 0, '基础配置', '', 1, '7580672f-a390-4bb6-982d-9a4570cb5199', 'DataPrivilegeRule', 0);
INSERT INTO `module` VALUES ('a94d5648-c2a9-405e-ba6f-f1602ec9b807', '.0.1.12.', '字典分类', '/Categories/Index', '', 0, 0, 'layui-icon-app', 0, '基础配置', '', 0, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Category', 0);
INSERT INTO `module` VALUES ('b19bce90-5508-43b6-93ed-cd9ff9e356a9', '.0.3.', '消息日志', ' /', '', 0, 0, 'layui-icon-set-fill', 0, '根节点', '', 0, NULL, NULL, 1);
INSERT INTO `module` VALUES ('bc80478d-0547-4437-9cff-be4b40144bdf', '.0.1.13.', '模块管理', '/ModuleManager/Index', '', 0, 0, 'layui-icon-tabs', 0, '基础配置', '', 0, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Module', 1);
INSERT INTO `module` VALUES ('bedb41a2-f310-4775-af99-01be08adda93', '.0.1.14.', '角色管理', '/RoleManager/Index', '', 0, 0, 'layui-icon-user', 0, '基础配置', '', 0, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Role', 1);
INSERT INTO `module` VALUES ('e8dc5db6-4fc4-4795-a1cc-681cbcceec91', '.0.1.3.', '资源管理', '/Resources/Index', '', 0, 0, 'layui-icon-cellphone', 0, '基础配置', '', 0, '7580672f-a390-4bb6-982d-9a4570cb5199', 'Resource', 0);
INSERT INTO `module` VALUES ('ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', '.0.1.15.', '用户管理', '/UserManager/Index', '', 0, 0, 'layui-icon-friends', 0, '基础配置', '', 0, '7580672f-a390-4bb6-982d-9a4570cb5199', 'User', 1);

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
INSERT INTO `org` VALUES ('08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '.0.4.', '研发小组', '', '根节点', 0, 0, '', 0, '0', '', '2016-10-14 11:40:31', 0, 1, NULL, NULL, NULL);
INSERT INTO `org` VALUES ('2b1d982f-d8e5-4fff-aaf5-4400fd9e204f', '.0.3.', '1', '', '根节点', 0, 0, '', 0, '', '', '2019-10-29 13:41:59', 0, 0, NULL, '', '');
INSERT INTO `org` VALUES ('543a9fcf-4770-4fd9-865f-030e562be238', '.0.1.', '集团总部', '', '根节点', 0, 0, '', 0, '0', '', '2016-10-14 11:37:13', 0, 0, NULL, NULL, NULL);
INSERT INTO `org` VALUES ('86449128-d5ac-44bf-b999-f7735b7458fd', '.0.2.1.', '汇丰软件部', '', '汇丰', 0, 0, '', 1, '0', '', '2016-05-26 15:11:03', 0, 1, 'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL);
INSERT INTO `org` VALUES ('c36e43df-3a99-45da-80d9-3ac5d24f4014', '.0.2.', '汇丰', '', '根节点', 0, 0, '', 0, '0', '', '2016-05-26 15:10:40', 0, 1, NULL, NULL, NULL);

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
INSERT INTO `relevance` VALUES ('023c001e-d7be-4e1d-b5dc-8c14535a2cf9', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '584c7a3b-d28a-47b4-8648-7797d05d83d1', '', '');
INSERT INTO `relevance` VALUES ('03b55a9e-a44f-44fa-9383-4117bf8aba60', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'XXX_DELETEACCOUNT', NULL, NULL);
INSERT INTO `relevance` VALUES ('03be9b5e-38b0-4525-8431-b26d35ce6ce3', '', 'UserElement', 0, '2016-09-07 15:30:43', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('06dfd97d-17e0-42b8-bde7-40006d8c8eb2', '', 'UserElement', 0, '2018-04-06 14:50:37', '', '49df1602-f5f3-4d52-afb7-3802da619558', '584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL);
INSERT INTO `relevance` VALUES ('06f4c4a2-faa8-4bad-9184-50ceb517f30b', '', 'ProcessUser', 0, '2016-09-08 16:48:14', '0', '10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('077e24ab-4c48-4a5e-bfa9-90ea00449136', '', 'RoleOrg', 0, '2018-09-12 00:08:47', '', '3e761e88-ddf7-4a62-b219-9a315b4564f2', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('08ff97f7-17fc-4072-b29a-287135898ece', '', 'RoleResource', 0, '2016-09-04 23:20:22', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'fdf3aac3-4507-40ad-aa2f-d7f0459de252', NULL, NULL);
INSERT INTO `relevance` VALUES ('0a9bcd14-0e27-474a-8c0e-0d023d6013eb', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Resource', 'Description', '');
INSERT INTO `relevance` VALUES ('0b3d3a9b-8a96-43d4-918c-fa7e3ea5f5ca', '', 'RoleOrg', 0, '2018-09-12 00:08:37', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('0b729611-c225-4fb6-8584-404a58373ff0', '', 'UserOrg', 0, '2018-09-12 00:10:31', '', '49df1602-f5f3-4d52-afb7-3802da619558', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('0fd5b371-b010-4846-8833-95cc1e813a32', '', 'UserElement', 0, '2016-09-07 15:31:16', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL);
INSERT INTO `relevance` VALUES ('10a76196-ba0c-4294-bb8f-dcd063eb4aab', '', 'UserOrg', 0, '2017-10-12 09:13:38', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('10e58d75-dec1-4b85-882f-9dac79ad1210', '', 'RoleResource', 0, '2016-10-21 18:08:13', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', 'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL);
INSERT INTO `relevance` VALUES ('1196cfff-9a57-4ef2-a3ee-abd438871264', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Resource', 'AppId', '');
INSERT INTO `relevance` VALUES ('120d7a5d-203c-4261-95f5-0125757fb386', '', 'UserElement', 0, '2016-10-20 17:01:01', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL);
INSERT INTO `relevance` VALUES ('13433400-a32c-4539-b988-8b417c09bc0e', '', 'UserModule', 0, '2016-09-07 15:30:07', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('13612a4c-b20c-4bd0-a2cd-0ae47576364d', '', 'UserElement', 0, '2016-10-20 16:34:12', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL);
INSERT INTO `relevance` VALUES ('13f1fd43-b36f-4cd9-9870-952645e0c23a', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'c7d7daf0-3669-4a22-8bed-b092617deb9c', '', '');
INSERT INTO `relevance` VALUES ('142584e6-7770-4b9a-863d-740577597ee5', '', 'UserOrg', 0, '2019-10-29 20:18:23', '', 'de8be521-f1ec-4483-b124-0be342890507', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '', '');
INSERT INTO `relevance` VALUES ('1490edd4-9bd3-4e71-bfa4-56f6558c1d3f', '', 'UserElement', 0, '2018-04-06 09:48:24', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL);
INSERT INTO `relevance` VALUES ('16154fc4-d18e-44a3-bcf2-5539b168aba7', '', 'RoleElement', 0, '2016-10-24 17:25:15', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '18cc3217-28a6-49b2-9a20-080230065984', NULL, NULL);
INSERT INTO `relevance` VALUES ('1729e26b-ad34-4726-b6fa-8fc0dbd4ee6c', '', 'UserOrg', 0, '2019-10-29 17:05:03', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', '543a9fcf-4770-4fd9-865f-030e562be238', '', '');
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
INSERT INTO `relevance` VALUES ('29b06cd6-af0c-4c63-9aba-e5431c5d62ec', '', 'UserOrg', 0, '2017-10-12 09:13:38', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('2a1b833c-dc81-46e2-b308-e22e0f112f77', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '2d595a2a-5de5-479e-a331-b53c799a6b10', '', '');
INSERT INTO `relevance` VALUES ('2a36a2b7-41aa-4190-b88c-75d44a56ad6e', '', 'UserModule', 0, '2017-02-06 00:14:18', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL);
INSERT INTO `relevance` VALUES ('2ab3e3b4-cdcc-4f8b-86f1-aa9c2d51d1dd', '', 'UserOrg', 0, '2018-09-12 00:10:43', '', '229f3a49-ab27-49ce-b383-9f10ca23a9d5', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('2bb3fddb-0f51-442e-8dbf-236beb47d8a6', '', 'RoleOrg', 0, '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('2ca288a6-d222-4328-951e-c01c3e77a0c7', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL);
INSERT INTO `relevance` VALUES ('2d0fcc88-a7c0-4d33-8a08-1d688e9dde83', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL);
INSERT INTO `relevance` VALUES ('2d15e438-cc3a-41e9-9b13-325bfd5c804a', '', 'RoleElement', 0, '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '84e38920-f6e5-499c-bf52-a3c6f8499ff7', NULL, NULL);
INSERT INTO `relevance` VALUES ('2ebff9a4-b2d5-4a35-a7dd-2cfa2f5b0522', '', 'ProcessUser', 0, '2016-09-07 17:33:39', '0', '52cc7933-a045-4dcc-8c17-1b618bfa772b', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('30c82d18-7892-4e5f-9aee-e4f483a858c2', '', 'UserModule', 0, '2016-09-05 16:24:55', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('332a373c-f485-4f85-9af9-7792f7462bf1', '', 'RoleModule', 0, '2016-09-02 17:03:47', '0', '648b04c4-4ac2-4d69-bef6-07081ef27871', '89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL);
INSERT INTO `relevance` VALUES ('340c60fe-8b95-474c-aa04-9197903998d2', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL);
INSERT INTO `relevance` VALUES ('361feb63-bde2-49c7-86ec-6df3ec6f0fe3', '', 'RoleElement', 0, '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '1c870438-4260-43a5-8996-a6e1dc8bbf6a', NULL, NULL);
INSERT INTO `relevance` VALUES ('386d6cb7-c465-422c-974f-3250b0e4888f', '', 'UserOrg', 0, '2018-09-12 00:10:35', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('392dc41e-7186-4efb-a8e5-b5317e4122fb', '', 'RoleResource', 0, '2018-09-10 12:54:14', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'OPENAUTH_DELETEACCOUNT', NULL, NULL);
INSERT INTO `relevance` VALUES ('3bcaab20-e096-480e-a9bb-0fdb70686714', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL);
INSERT INTO `relevance` VALUES ('3de0359b-6331-4dc7-a00e-751f71dbadb5', '', 'ProcessUser', 0, '2016-09-28 09:23:30', '0', '68295d2a-4dfd-4c5e-81e3-9c787e2603bc', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL);
INSERT INTO `relevance` VALUES ('3e9b3e79-c972-4c50-a36d-ab179d2ad09d', '', 'RoleModule', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '069475e3-c997-487a-9f29-e6a864c5c1d4', '', '');
INSERT INTO `relevance` VALUES ('4190f00a-11a0-4814-849b-cc5232fa4dd4', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'OPENAUTH_DELETEACCOUNT', NULL, NULL);
INSERT INTO `relevance` VALUES ('45fcbc8b-2951-40a1-8329-4bdf3c8f70e4', '', 'UserOrg', 0, '2018-09-12 00:10:35', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('460d1c98-2a68-43cf-8d38-d40ceb89916f', '', 'UserOrg', 0, '2017-10-12 09:13:38', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('4757bb30-e4bc-4c2d-a824-947ef151d341', '', 'UserRole', 0, '2016-09-07 20:21:16', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '4980a85b-e3db-4607-bc2c-0baf0140d7df', NULL, NULL);
INSERT INTO `relevance` VALUES ('4ba3982b-f0ae-4f9a-980e-1eaedc3b5f2e', '', 'UserElement', 0, '2016-09-07 17:48:34', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL);
INSERT INTO `relevance` VALUES ('4c2fb006-53d6-4041-8cf6-e5d74d788897', '', 'UserModule', 0, '2018-04-06 09:48:19', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('4c69794b-9957-4f6b-b0fb-6455fe643565', '', 'UserElement', 0, '2018-04-06 14:50:41', '', '49df1602-f5f3-4d52-afb7-3802da619558', '826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('4daccce5-cb7b-46aa-8bed-3c85c72436be', '', 'RoleOrg', 0, '2018-09-12 00:08:37', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('4e613188-0387-4d17-a60d-703b4a606d75', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL);
INSERT INTO `relevance` VALUES ('4e665304-9f05-410e-b68f-44d45281b788', '', 'RoleOrg', 0, '2018-09-12 00:08:47', '', '3e761e88-ddf7-4a62-b219-9a315b4564f2', 'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL);
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
INSERT INTO `relevance` VALUES ('77bd93da-2c2b-4ba8-bf05-3a1382811a6a', '', 'RoleModule', 0, '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL);
INSERT INTO `relevance` VALUES ('77eec82a-f713-4584-872c-761fdbcdb456', '', 'UserElement', 0, '2018-04-06 14:50:37', '', '49df1602-f5f3-4d52-afb7-3802da619558', '68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL);
INSERT INTO `relevance` VALUES ('77fc08e6-98ae-4d33-b294-bd9fed5b14ed', '', 'UserElement', 0, '2018-04-06 14:50:36', '', '49df1602-f5f3-4d52-afb7-3802da619558', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('797c6e5f-7f3c-4891-89b9-a054e10f6c00', '', 'UserModule', 0, '2018-04-06 09:48:01', '', '49df1602-f5f3-4d52-afb7-3802da619558', '37bb9414-19a0-4223-9056-71f8c758a930', NULL, NULL);
INSERT INTO `relevance` VALUES ('7f25286f-246b-4143-98eb-c3e574fe7455', '', 'ProcessUser', 0, '2016-09-07 17:33:39', '0', '52cc7933-a045-4dcc-8c17-1b618bfa772b', '3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL);
INSERT INTO `relevance` VALUES ('7fd7f976-f10e-44aa-a7ba-7ca40d2e8f90', '', 'RoleOrg', 0, '2016-10-17 10:03:30', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL);
INSERT INTO `relevance` VALUES ('80310629-5e52-482c-9a0f-5c5bdfabcd9e', '', 'RoleOrg', 0, '2016-09-05 00:00:00', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('8203d3db-c0d6-44b1-96c9-6e78e714657e', '', 'UserOrg', 0, '2019-10-29 20:18:23', '', 'de8be521-f1ec-4483-b124-0be342890507', '86449128-d5ac-44bf-b999-f7735b7458fd', '', '');
INSERT INTO `relevance` VALUES ('832f4a8f-7791-4aa6-bcd2-20dcb6f5ef37', '', 'UserElement', 0, '2016-09-02 14:53:04', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL);
INSERT INTO `relevance` VALUES ('84a52091-08a0-4a46-b661-3cd206771c29', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL);
INSERT INTO `relevance` VALUES ('854e0658-ab8a-4869-b157-9941955acdc6', '', 'RoleElement', 0, '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '1a473afd-cbd4-41e9-9471-81f9435aaabe', NULL, NULL);
INSERT INTO `relevance` VALUES ('85ab02d8-995f-4f66-9828-e53f04af09b9', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', '', '');
INSERT INTO `relevance` VALUES ('88a4c966-d042-4a2e-b133-ff7eded1c5de', '', 'RoleElement', 0, '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', NULL, NULL);
INSERT INTO `relevance` VALUES ('89e5dd60-0981-4cd9-b9ad-577b7b817556', '', 'RoleDataProperty', 0, '2019-10-29 15:28:12', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'Category', 'Id', '');
INSERT INTO `relevance` VALUES ('8b633f3c-965b-4e35-8496-c364890d7760', '', 'RoleElement', 0, '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'c3d7b478-21e9-4c1e-b866-a3c80be7909b', NULL, NULL);
INSERT INTO `relevance` VALUES ('8fa4a52f-9c0a-43c9-9b7e-b378efb4e1df', '', 'RoleResource', 0, '2018-09-10 12:54:14', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'OPENAUTH_LOGIN', NULL, NULL);
INSERT INTO `relevance` VALUES ('9043a72d-862f-49b4-bfe3-51d9bd289f14', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '816b12b3-e916-446d-a2fa-329cfd13c831', '', '');
INSERT INTO `relevance` VALUES ('9210adfa-b783-4368-8c8d-86c30ec9cdd1', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '37bb9414-19a0-4223-9056-71f8c758a930', '', '');
INSERT INTO `relevance` VALUES ('92f0b297-96c1-47d4-84dd-571374431bc0', '', 'RoleElement', 0, '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '84694ea5-d6e1-4a65-8a59-7b5b779688d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('93bcac7a-0ff1-488c-8d1c-3da7e44cbefc', '', 'RoleElement', 0, '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a', NULL, NULL);
INSERT INTO `relevance` VALUES ('95cd06bd-7cad-4790-b5f8-15738360da95', '', 'RoleModule', 0, '2019-01-08 02:22:31', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '4abafc83-c8f5-452f-9882-e113a86e7a3e', '', '');
INSERT INTO `relevance` VALUES ('960224e6-5910-472b-a5ef-b2aa9a8b106f', '', 'UserRole', 0, '2016-09-06 17:06:15', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL);
INSERT INTO `relevance` VALUES ('962b278b-0894-4b36-b1a0-6c5c3d11d4c3', '', 'UserElement', 0, '2018-04-06 14:50:17', '', '49df1602-f5f3-4d52-afb7-3802da619558', 'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL);
INSERT INTO `relevance` VALUES ('965f010b-2fd6-4b34-ba23-3e44c1af2877', '', 'RoleOrg', 0, '2016-09-08 16:19:18', '0', '36094f5d-07e7-40d5-91dc-ff60f98b496a', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('966531b6-584c-4f0a-b934-c33aab795f1c', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '2d595a2a-5de5-479e-a331-b53c799a6b10', '', '');
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
INSERT INTO `relevance` VALUES ('a57900b2-caf1-4cbd-8ac2-f8dd9a40199d', '', 'UserRole', 0, '2018-09-12 00:10:24', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', NULL, NULL);
INSERT INTO `relevance` VALUES ('a5bef7bf-ecdb-4480-ad64-b39a02269607', '', 'UserModule', 0, '2018-04-06 09:48:37', '', '49df1602-f5f3-4d52-afb7-3802da619558', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('a72c1bc6-1fe1-4186-86e9-d1d9afc6b0eb', '', 'UserOrg', 0, '2019-10-29 17:05:03', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', '2b1d982f-d8e5-4fff-aaf5-4400fd9e204f', '', '');
INSERT INTO `relevance` VALUES ('a8094b46-de5a-40ea-a8ee-69ea905480ef', '', 'RoleModule', 0, '2016-09-05 09:21:56', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('a8123b37-ba70-4aab-aef6-1938733b5210', '', 'RoleElement', 0, '2016-09-04 23:20:42', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'c0d8505c-061a-467d-862a-c94f27caa208', NULL, NULL);
INSERT INTO `relevance` VALUES ('a9821db0-49bd-49be-a554-afa811c99760', '', 'RoleResource', 0, '2016-09-04 23:20:22', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL);
INSERT INTO `relevance` VALUES ('aa051096-a23a-431d-9053-bb954f9453a7', '', 'RoleElement', 0, '2016-09-04 23:20:54', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '4bfa8ea0-6b0d-426f-8687-b654575ca780', NULL, NULL);
INSERT INTO `relevance` VALUES ('aa72812e-b3de-4466-bd6c-2391450bbdbc', '', 'UserOrg', 0, '2019-10-29 17:05:03', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', 'c36e43df-3a99-45da-80d9-3ac5d24f4014', '', '');
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
INSERT INTO `relevance` VALUES ('b241dd3d-2965-44e4-929d-9dacb6444e09', '', 'RoleOrg', 0, '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `relevance` VALUES ('b246cd89-548c-4471-a43b-6f10b40c26b1', '', 'RoleOrg', 0, '2018-09-12 00:08:42', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('b2490ac0-ba16-48a2-b39d-49f6b87f9387', '', 'UserModule', 0, '2018-04-06 09:48:17', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL);
INSERT INTO `relevance` VALUES ('b2edfee4-f980-4aa5-b547-492d677e0674', '', 'RoleModule', 0, '2016-09-04 23:20:34', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL);
INSERT INTO `relevance` VALUES ('b3b8f695-a179-489b-90b4-7814ab048a69', '', 'UserElement', 0, '2018-04-06 09:48:21', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('b4c2a294-125c-4768-9214-cea3ccf39a1c', '', 'RoleOrg', 0, '2018-09-12 00:08:42', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL);
INSERT INTO `relevance` VALUES ('b672a830-c3a5-408b-a746-65608534b24c', '', 'UserModule', 0, '2017-12-15 17:07:05', '', '49df1602-f5f3-4d52-afb7-3802da619558', '9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL);
INSERT INTO `relevance` VALUES ('b8606463-4957-424f-bcab-1ea27c15c2c5', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', '', '');
INSERT INTO `relevance` VALUES ('b9e63d17-35c8-4456-abab-8f43a1c99adc', '', 'UserModule', 0, '2018-04-06 09:47:59', '', '49df1602-f5f3-4d52-afb7-3802da619558', '4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL);
INSERT INTO `relevance` VALUES ('ba41a404-f203-4467-baf5-a179563b1cf2', '', 'UserOrg', 0, '2019-10-29 17:05:03', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '', '');
INSERT INTO `relevance` VALUES ('bbdc3ea9-3f21-48b0-9d7a-39545d6183d0', '', 'UserElement', 0, '2018-04-06 09:48:25', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('bc869e2f-4417-4db5-92ac-611a0caf918d', '', 'RoleElement', 0, '2019-10-29 15:28:04', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '816b12b3-e916-446d-a2fa-329cfd13c831', '', '');
INSERT INTO `relevance` VALUES ('bd783f53-23fa-41f4-8cec-7c61fab52072', '', 'UserOrg', 0, '2018-03-15 09:19:06', '', '0ceff0f8-f848-440c-bc26-d8605ac858cd', '86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL);
INSERT INTO `relevance` VALUES ('bda5f089-64d6-4fb8-9012-d7f3ff36902a', '', 'UserOrg', 0, '2017-10-12 13:59:09', '', 'ffd92ed2-5330-4ec2-a42d-6e0e9005db3b', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('bed2842a-e9ff-4598-889f-2889033f8e67', '', 'RoleElement', 0, '2019-01-08 02:22:32', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '4bfa8ea0-6b0d-426f-8687-b654575ca780', '', '');
INSERT INTO `relevance` VALUES ('bee6572d-8fb8-4e0e-af15-93aafc989717', '', 'RoleElement', 0, '2016-09-04 23:20:42', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '68fc793f-069f-43e1-a012-42ac2d7c585c', NULL, NULL);
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
INSERT INTO `relevance` VALUES ('d97f0ff6-3a34-42cf-91c5-3f2ce81061e8', '', 'UserOrg', 0, '2019-10-29 17:05:03', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', '86449128-d5ac-44bf-b999-f7735b7458fd', '', '');
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
INSERT INTO `relevance` VALUES ('f0ab6f79-a9b6-4ddf-9a0c-c28330f029dd', '', 'UserRole', 0, '2019-10-29 21:13:04', '', '49df1602-f5f3-4d52-afb7-3802da619558', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '', '');
INSERT INTO `relevance` VALUES ('f41de4d2-369d-46e1-b84d-4bd2c37b8c20', '', 'UserOrg', 0, '2018-09-12 00:10:31', '', '49df1602-f5f3-4d52-afb7-3802da619558', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
INSERT INTO `relevance` VALUES ('f42343b9-adc2-4368-9028-7ed2f76fba68', '', 'UserRole', 0, '2019-10-29 17:00:19', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '', '');
INSERT INTO `relevance` VALUES ('f4ba636a-9002-43e6-93eb-95132a3e68c5', '', 'ProcessUser', 0, '2016-09-28 09:23:30', '0', '68295d2a-4dfd-4c5e-81e3-9c787e2603bc', '3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL);
INSERT INTO `relevance` VALUES ('f579a427-a9ed-4ebe-8411-72e8e6abd01d', '', 'UserElement', 0, '2016-09-05 16:25:26', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL);
INSERT INTO `relevance` VALUES ('f61ee29b-7988-404d-b692-5a8f667684be', '', 'UserElement', 0, '2018-04-06 09:48:23', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL);
INSERT INTO `relevance` VALUES ('f6367ca1-0486-46a4-b9c6-65c00936a516', '', 'RoleElement', 0, '2016-09-04 23:20:54', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '9e2c6754-f258-4b14-96a0-b9d981196a65', NULL, NULL);
INSERT INTO `relevance` VALUES ('f671f582-9111-4000-aadd-660449d0d4b0', '', 'RoleResource', 0, '2018-09-12 00:15:54', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'XXX_LOGIN', NULL, NULL);
INSERT INTO `relevance` VALUES ('f6a9cdf7-50c1-48b4-ae29-f999691f3a1d', '', 'RoleDataProperty', 0, '2019-01-08 02:23:02', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', 'Category', 'TypeId', '');
INSERT INTO `relevance` VALUES ('f6e2b76f-8cce-42de-af8e-b379e22b12c8', '', 'UserOrg', 0, '2019-10-29 20:18:23', '', 'de8be521-f1ec-4483-b124-0be342890507', '543a9fcf-4770-4fd9-865f-030e562be238', '', '');
INSERT INTO `relevance` VALUES ('fa7c4d39-b31a-4668-8716-d40a62aa722b', '', 'UserOrg', 0, '2017-10-12 13:59:49', '', '63c9c82a-e0d3-4bde-bbd2-057cda2f5283', '990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL);
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
-- Records of syslog
-- ----------------------------
INSERT INTO `syslog` VALUES ('00072020-0fdf-4f99-8907-7c8d9b8e0407', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:04:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('000ea356-21b1-457c-9d6c-332e34ba1018', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:40:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('00651a25-c96b-4e01-8ab6-064d63663bc0', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 17:32:11', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('006648df-e1a0-4eeb-ba7b-61599622d8f0', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:54:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('00acb8d8-a4a5-4131-93b1-943a191c9f79', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:11:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('00d33a19-a1fb-4951-8560-3e71b0f1bd40', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 20:22:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('00f8f408-2915-4cb6-825c-c644bd35ccdd', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:27:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('010ad513-7157-4857-9417-0848ff450242', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('010e5bc9-96c9-4775-baba-3bef3e74fb39', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 15:50:22', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('01134ccf-183e-4a7c-9058-828cbc8690da', '用户访问', '访问日志', '', 'modulemanager/index', '2019-10-29 14:32:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('012e332e-f49d-4d72-adf0-1e63dce4e709', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:24:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('01388fdc-39ec-44a0-a0a9-98c779cf6c70', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 18:10:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('014ed4cf-f12b-41e7-8989-789fc4c5db3e', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 15:50:20', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('015e0ac7-a87d-41c8-8690-68c0429777da', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 16:49:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0164254f-48ca-48e5-b5e4-75774ea8af74', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:30:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0181d063-1d10-4e38-aaa8-da829e54e248', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:08:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('01953fa8-75c8-4900-9549-38acc45faf53', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 16:49:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('01b92400-a9b3-40af-9108-7f39d18f9b87', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:56:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('01c2d868-c8e2-461e-8456-85494aa5e8b4', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 20:22:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('01ca90eb-0d6e-4b29-8303-12d55520c349', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('01d8e628-0fb8-4b2e-8080-0aba5f11f338', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('01e8e210-8d28-4057-ab1e-947b549885f2', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:28:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('01f2dc6a-b609-406f-b741-09378bbb567e', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 15:16:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('020028eb-3ce1-4845-b589-70abe5b6e073', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 20:13:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('021bca6a-d29c-4893-91fa-91f9ec9c4400', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('021dbea1-39d0-429c-968a-30510500ec55', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:01:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('02888059-5cda-4f66-b7d1-916ded137f9b', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:16:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('02907dcf-98d0-4dcd-8a4b-96536458634d', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:38:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('02e6e89d-15d2-4b31-ab8c-5f4516af3b85', '用户访问', '访问日志', '', 'modules/addmenu', '2019-10-29 22:06:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('03979aff-863e-4bb5-800c-df2e3de3c960', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('03b491f7-78e8-4591-b696-b615c5b0ef26', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 14:29:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('03c9b51f-e56e-47ac-a7a9-af3b4dfb4cad', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:02:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('03cd814c-4bbb-43b1-aa88-03afbfd3ef5a', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 11:08:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('03efcb85-8b9f-4c67-9ea7-440435f9df54', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:24:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0447f27a-7013-4e1f-b767-0258f7e1129e', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:49:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('04612514-6b22-441a-b46d-e5e7c41de9dd', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 11:21:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('04727437-59a2-4036-bc9f-9abd1cdeb5f7', '用户访问', '访问日志', '', 'flowinstances/edit', '2019-10-29 13:54:40', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('04c12c62-ed84-4be7-9e98-49b5b2d484b3', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:32:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('04e5aa69-9fb6-41a3-af2b-7152dd5a720a', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:27:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('058216ae-2708-48e4-b8ea-c350b10aee4b', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:18:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('05ef0fc5-7b80-4f6b-97fb-a47c6dd94fa8', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('06059e17-8b47-4dc8-9e11-a6b69d6ab6c9', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:56:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('060b4f80-66d3-468c-afd2-4c4e89aca0cc', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 18:16:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0622573c-9191-40db-a052-343196aa5a9c', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 17:06:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('06311850-840e-4812-8f22-391caeb1de1d', '用户访问', '访问日志', '', 'modules/loadforrole', '2019-10-29 16:30:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0648a47c-5a2a-4739-98f3-4b126ddd358b', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:57:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('06494120-206f-4b8d-986d-5961af6b294b', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('064d2c1d-a5c2-4f91-a9f9-65d4caff7173', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 16:31:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('069e8c2f-f149-4d13-897c-3827132cf696', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 15:28:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('06e67ab4-95d5-48bd-9cf4-ebf17706d74a', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:30:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('06f32461-d8e1-4e8f-ae28-1dcf202156c5', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:12:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('07100c20-17cc-48fd-afc3-f5ca50373667', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:51:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0774e532-9636-440a-88b4-0b2a9a615bc7', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 17:39:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('077f0f5c-2488-4bb3-ba93-e9f622760b93', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 16:43:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('07b9de18-f148-495c-a857-f30aea031b35', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 15:52:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('07c5588e-906b-4388-b7c4-de11c0cd762d', '用户访问', '访问日志', '', 'modules/loadmenusforrole', '2019-10-29 20:56:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('07fba888-67f2-483e-81ba-d84beae992da', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:40:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0828467a-265f-47e4-9956-67db3cc874c3', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:07:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('08458190-15e2-4770-93a3-f35fc75a94a1', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:40:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0868db18-fd0c-4b21-a35b-7c14cf895142', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:12:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('086ee5ea-3e4c-450c-9909-844f32cbef90', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:22:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('088685ca-81a5-4431-bfae-ca550bd6cf81', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 18:11:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('08a68673-d283-4d75-a3aa-e5277c07d12b', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:00:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('093a05e0-c1f0-4292-906e-195bc65839be', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:37:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('099933f7-d789-4ce7-a739-67820c38c8a3', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:06:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('09d1fbe7-35c3-4498-b8d3-665178a50d1f', '用户访问', '访问日志', '', 'modules/loadforrole', '2019-10-29 16:59:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('09d4b185-f360-4036-8f93-a07c096e9c65', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 20:07:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('09d76146-18cf-4b49-98a9-eb7e49024d52', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 17:22:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('09e56bcd-8642-49ee-a24b-fa6847a720a0', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 15:21:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('0a124923-acae-4bec-bccd-707ccd3f3446', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0a694334-ffc3-474f-b18c-7da078f7653b', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:37:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0a7928a4-7c08-460f-9c1a-f46215bf584f', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:49:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0ac70692-e5ac-4fa3-8fa3-02077ce01818', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:26:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b131211-8378-4a7f-bb41-75cfac6717db', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:40:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b13e89e-f233-42ef-b0d7-43aca8370877', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 16:43:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b1c415a-31f1-4de5-b6fe-2b0caa617700', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:54:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b254e02-358e-4d36-9773-1e7ba54177ee', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 21:20:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b57ede9-7314-4bc8-a2d9-fceee231f1fb', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 18:16:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b6071f5-adee-4b2e-b9b3-9d8d7a96d6f5', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 21:13:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b7b6988-6a1a-471d-92ab-9b1891b82182', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b95dff7-da47-46cc-ba80-ad3b242d0441', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:25:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0b9d1717-15df-4d7d-9f81-469a34052cd3', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:47:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0bc865ff-3b60-4f18-ad04-a3b3cf6660fc', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 16:09:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0be0d1a3-2136-43a4-b405-12e5c4e9f227', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 16:09:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0c0edb66-75ec-4bf3-930e-230adfaa7c92', '用户访问', '访问日志', '', 'roles/update', '2019-10-29 14:45:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0c4897eb-9179-4dd2-9312-8ec66b0e1c35', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:26:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0c60da44-a59a-4954-9358-56f18976d23e', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:53:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0cd8076f-1f34-499a-a6a8-0fb1e3aaffdf', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:59:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0d34da46-6dfb-4dcb-a73c-a7038994e5eb', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 15:51:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0d383a4d-f070-4027-aeb9-0a6325286c7e', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:52:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0d3b0fb7-0a95-4ff4-b6ca-d12a0235a1e6', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 13:22:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0d613063-ae86-4edc-a6ca-182dfad22fd4', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:24:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0d659870-e7df-406f-b6c5-055a455337ea', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 14:27:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0d87ed64-91f8-435e-b3d9-07eb177b5b37', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 14:17:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0d9b37c2-c51a-43d3-9de7-0d5763b48e2b', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:08:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0d9d0e16-7023-47af-b8c3-f41cef8a72aa', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 17:01:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0dec82ab-1ed6-46d7-bc5d-cd232ee6ebd2', '用户访问', '访问日志', '', 'roles/loadforuser', '2019-10-29 17:00:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0df153dd-ffe1-4f12-8b8e-30d4070b461d', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:25:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0df47b56-0297-4c2d-aa6b-ae8e378d1cc5', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:23:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0e292c3c-8ce3-4e14-8af0-38da38ede6c5', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:12:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0e2f5e17-256a-4484-9e64-645d7c751d67', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0e3ac58c-7dc2-464b-9ff2-a114f6d9e259', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:45:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0e4b569c-32d5-4b8f-8526-31a2cc1d0968', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 21:32:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0eb6d186-bafb-4fc0-8916-90320475a2e7', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:25:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0ebe05df-1511-4f96-a446-06b9f5586b58', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 17:21:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('0ee76c6a-9329-4305-b3a5-a2372fa01deb', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 13:21:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0ef959ed-38a9-4e53-a4f5-7f73913749f0', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 14:44:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0f047871-8757-4638-bcba-f2edb7b776a4', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 21:05:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0f079ef6-0209-44a9-a659-4087cf6f06ac', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:51:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0f4e86b7-e1f6-43ab-9ed4-de16e0b511e6', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 11:39:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0f681e9e-85b2-4074-9e21-8b47187f1158', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:15:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('0fe481db-8c7b-4c5e-b16b-ee50a59bd354', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 11:15:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('100389cb-7462-44c7-bf8c-44a07f19b865', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 15:28:01', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('101fd045-fd60-408b-89a2-16efad4457c6', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 18:17:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('102add13-ad34-4ba5-9eb7-d4ce89c48c76', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:30:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('107d0190-cd92-44c3-8d54-b10919da5e19', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 21:32:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('10c3b20b-a41d-46ab-92df-2c4314752cac', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:25:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('10d6a4fd-678d-4e2e-94cd-c65471fced46', '用户访问', '访问日志', '', 'modules/loadpropertiesforrole', '2019-10-29 15:28:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('10f8e139-f11e-49d0-ba8e-d014edc8e0f5', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:39:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('113b4b1f-1e11-42bc-a1d3-506af9f91f2b', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 14:44:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('115f6ad0-7605-4ac1-91a5-ea515d822bda', '用户访问', '访问日志', '', 'flowinstances/detail', '2019-10-29 13:53:09', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('117a5bc6-18d6-48d7-b28d-6cfea2ad8cda', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:46:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1188cf04-8be0-4a5d-907d-cdf02b4291db', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:13:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('11ab91d1-1def-44e4-ac5f-c275c9686743', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 18:17:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('11b14b87-0c8d-48ff-b0d0-c799257d806f', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:52:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('11c0042f-8e38-41f3-99f5-91ad0d6308a4', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:40:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('11c8c312-50a9-4fe4-a8f8-938a76365069', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:08:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('12085da4-c00c-4ed2-b2a6-8207374ea43f', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:08:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1274bbe8-dc12-41a2-b6fe-4a6686dab971', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:28:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('128c7627-cf5f-4938-83f1-866f2142a92b', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('128e9e19-4ded-4a2c-8afe-d1be71453b33', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:33:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('12a842e2-aeef-43d5-8eb4-f5b0aff0ea9d', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:26:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('12cfb549-2075-4bd0-b23e-4b2a1c5e2ce9', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 17:02:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('12e49649-1068-48c2-afec-fb3346aaba0d', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 21:05:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('12f71120-9094-4047-b133-55a4a6f04fed', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 14:27:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('13007fe0-7dab-4d8f-a218-33bf7f9d373c', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 12:40:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1324f58a-79f9-4838-b8f4-6bf25f39b36f', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 13:11:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('13332e23-eea8-4eb8-b418-08cf7ad7c1d9', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 13:36:42', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('133adb26-7cb1-4bc5-8950-f714d5c58423', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:02:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('138506b7-b8e5-4b31-a641-be1f4ebc01c1', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:47:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('13ff2703-515c-4a05-a4fa-a3da8d3ffa96', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 14:35:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1461e593-0cc2-4184-a239-e33b288b3ddc', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 17:05:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('14762adf-9010-4e02-a8ba-765256eef411', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 18:25:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1487a1ba-3342-4a39-8f46-d9f28c837523', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:25:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('14b0016f-cec4-4ae7-b5fe-388eba7d2ccc', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:47:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1505ae2a-9375-4e5a-8ded-4207dedff26c', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:07:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('15115b9f-4110-4e37-9a86-46674bf56181', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 11:38:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1539753b-9186-494e-82b2-aa95b4508ff7', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:47:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('153d2918-8505-4046-8574-5009759d36ec', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:27:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('15418c05-8510-47e0-8bd0-6edda46d26ea', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 13:11:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1576d406-bd82-4c31-b6cb-a15a6d4f0416', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:08:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1578cb56-9d1b-4ab7-b306-9676d8a4e9fe', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:59:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1589cf21-12d9-484b-b8d6-89efcab88b1f', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:06:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('15a8f599-8802-4c0a-8132-2ed29f8ef515', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 22:02:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('15e78da4-8e8a-4988-8dcb-3826ba95514b', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:24:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('161eb639-7692-48bb-b9cf-a07aff04c336', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:12:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1627f79e-825b-4f27-8534-8bedcfaebf85', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 12:11:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('165b5e32-377b-4e88-a910-c7c43c56fcda', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:35:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('165ed611-1a72-4de1-b376-92738df9041e', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:38:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('166e8ec2-a134-4b93-95a9-3ba7dbed1d8e', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 15:21:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('169d6a70-4457-47d1-a112-59a14d754885', '用户访问', '访问日志', '', 'users/load', '2019-10-29 20:18:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17028b62-abe7-4c85-9791-71778388376e', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 14:32:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('175b03eb-96da-4486-a901-cbb401532015', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:26:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1766dcd2-3eae-448c-b795-4ef7b1d33e8a', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:38:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17946de0-fc6c-4f06-b331-caea4dcccc26', '用户访问', '访问日志', '', 'roles/update', '2019-10-29 20:53:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17a29a6b-c9fb-44ec-98ff-37374893b2fc', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:57:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17a7b1d8-3d88-46c6-93ee-d544cec3bb77', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 21:58:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17a9a800-458c-4482-bfdf-40cbca21c3c5', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 17:24:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17d83023-6987-4a39-bdbb-89a201c9eff8', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 16:01:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17dd1ecf-6f12-4cb1-b09c-0e22b7115ebe', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:51:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17e43869-7fce-4464-a058-c2fe3654e362', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:35:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('17e8244c-9ad6-4e2b-a1ab-5bea0f6c6f1d', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 18:16:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('18229a5d-53f4-4cff-a6a3-95483e2251c7', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('18469f5c-bbf2-4d3a-bd93-af1ce0972708', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 21:13:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('18614f16-c72f-4c2f-8de4-a2a11f86d64b', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:44:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('186714c0-c8f2-4f4c-909b-52c17eef62ad', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:26:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('18716cec-100d-482b-ac81-5f71ed363a3d', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:37:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('18a50345-2c99-4cb6-8c0b-2fc05dea1342', '用户访问', '访问日志', '', 'modulemanager/index', '2019-10-29 17:02:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('18d17d98-2e50-419f-82d0-e653204a93d7', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:25:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('191dec1f-fc37-4e27-9415-ac3a1491ccae', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:27:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('19669ffa-3ffa-436f-afc1-6fcc1ea481c9', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:27:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('19b28292-0730-481b-a9c3-2254d3c6fb12', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 14:54:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('19c7f4ad-6310-420d-b917-06fba7aa8032', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 17:32:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1a13bb87-28db-47fb-9465-278cb81a198b', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 21:12:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1a184211-0a07-43ff-93bc-bfe85b166676', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:04:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1a1dc8bd-19ae-42a5-9f4a-455feecb2058', '用户访问', '访问日志', '', 'accessobjs/assign', '2019-10-29 21:13:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1a1f2daa-509d-4ee3-a290-2fb3f834e159', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 20:57:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1a3d2329-f550-469b-999d-6f72a2b92641', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:57:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1a56ccf1-c56c-4edb-b845-050b66ff4cfe', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 16:23:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1a5b01a7-06ee-4eb2-b5d3-f3d4e7dd9148', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:40:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1aa408f4-abe2-4703-b07f-aa84417f65ca', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 11:29:01', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1aa6392f-629d-406d-a7d9-ce8967b4f9a5', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 11:27:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1ab53bbd-90ca-455e-afd9-5a3312dad7f4', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 12:45:55', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('1b03899c-737f-4586-ad1d-0ee3b3033fa3', '用户访问', '访问日志', '', 'accessobjs/assign', '2019-10-29 15:28:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1b17ec74-2589-4abb-a2a7-8f34b2d09f7d', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:11:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1b2f6b46-dd8f-4b66-b09d-f24e0657ca0a', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:06:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1b39eafc-6fc5-4a69-96d5-17ec42725a88', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:50:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1b43ff6b-bb71-4144-8c13-90c40efa3ed0', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 13:58:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1b7beab7-6882-47e7-bb4f-24bac6f67fcd', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:24:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1b7efb2d-db83-4c3e-88fc-4838b63c082e', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:58:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1b886e48-4d71-4f37-881d-f83a802cb8e9', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:35:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1bb2438e-716b-4052-9325-75283b03dabc', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:24:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1c1dabea-7b10-4674-bad7-e37348452f08', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:08:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1c351d04-a109-49a7-962b-ad13d4a5fdb6', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:50:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1c3fc5aa-5af1-4b35-9c6e-a3f5a899a1d7', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 11:29:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1c439aac-22c4-472e-bcb6-0c9ba034a667', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 16:30:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1c7a7076-992a-4660-99ec-6aba5fb52c34', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 21:20:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1c81bcd2-0602-4992-8e4f-ae19030db2b2', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:45:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1c8558ea-20a3-4941-a693-52fcd2fafd2b', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 21:15:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1cb4492f-8220-4897-8d94-1fec92c2cea2', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 13:07:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1ccf3efb-9403-4c08-885b-984a059759ae', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:47:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1cdc29b9-ad3b-4173-8a86-a0b58c970043', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1d13b374-f72f-4ef5-b02b-21c9c6307d02', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:28:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1d26e5d5-6e8b-4b98-877a-19c7abccb74e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1d32d72d-5bb1-41ae-be5c-ba326f1c491f', '用户访问', '访问日志', '', 'orgs/add', '2019-10-29 16:13:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1d3735ee-c729-4edc-9521-8931fc968e11', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:09:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1d60540b-1b5d-4806-8fe5-45ec6835b449', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:35:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1d824fe9-51c9-4188-bcda-f8512d7175da', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:24:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1d8466e5-1e8c-4293-9ea6-1a18c7aebba2', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:45:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1d8a6c0e-d60e-4404-91be-fcbed825bf3d', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:15:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1da8a67e-4359-4f0f-934f-3e03ec70b19c', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:01:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1dba30e3-fad3-45be-8ded-c5023ceb6c83', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 16:00:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1dea64dd-adaa-438a-b8af-fbf264416c2a', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 13:37:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1e203901-eb1e-4cce-8acd-dd04eb081d92', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:26:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1e27ab1f-8605-4eb0-9d9e-7b5f2860bd15', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:24:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1e5fff03-a767-4c2d-b622-ca0fee54e804', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 14:32:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1e611da2-424d-4534-8c22-c8c0cbd1e369', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 14:45:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1e78650f-b32a-4f97-bb07-278a9e1e9453', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:53:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1e7f45f8-3451-416f-9ef0-cd0c5efa39b4', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1e84935a-cad4-49fa-8aad-d9a5baf2d38f', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 20:22:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1eafcd11-6e20-4070-bf3b-888be6f0a59a', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1ed38ce0-db23-4315-904a-6520aa3bb3eb', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:00:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1ef30a81-693a-4cb9-a5b1-e312c6aab3eb', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:41:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1f361bc6-0257-4c49-899f-f83dd381b572', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:23:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1f460bcc-de99-4e7b-b9dc-3b35a52d85d0', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:27:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1f503272-262f-43aa-a7e1-b8c22fe6506f', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 11:08:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1f7d3190-9a81-4ae1-8dfe-69b48149bc15', '用户访问', '访问日志', '', 'modulemanager/index', '2019-10-29 15:21:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('1f964ae4-3832-4eb2-9bc0-f66689fc8b50', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 20:58:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1fc9679b-14d6-42a4-bb44-d7fbbdb7f726', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 18:25:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('1ff68d3d-591f-47b2-8ab4-41cb9d7fbf0b', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:04:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('20074465-e0c4-47fd-9895-cbb07658286d', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 17:06:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('20413930-5f4a-4afc-8987-10b2e3874447', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2062c62a-0342-4093-8c3a-55d3b5e92d35', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:51:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('207164d6-d3f8-4dfc-865b-c392710259cf', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 17:35:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('20783f85-88bc-492a-9246-a856cac1f9bd', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 21:32:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('20a4a6c9-5ef4-4c1a-9b9c-d366c258b620', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 16:59:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('20ba6160-332d-4072-956c-1f1c56578517', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:30:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('20c1d0b4-c884-4b95-88e4-6089e222b35d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:30:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2144eb8c-096d-47db-94d4-188af9d10033', '用户访问', '访问日志', '', 'usermanager/index', '2019-10-29 15:53:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('214b0a3b-86a9-4834-9c04-7964a22767ea', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 18:10:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('214e8d16-b2db-4022-b6c2-decf99a4b2a8', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 12:40:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2180a958-29db-47de-bcac-c3eff56b4dbf', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:39:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('21928a32-9427-4d84-87a1-6dd9ef242505', '用户访问', '访问日志', '', 'modules/loadmenusforrole', '2019-10-29 16:30:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('21964c19-5d6b-48ad-bfb4-454054b461d9', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:30:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('21a20ef2-d566-4b9a-bd18-40244ebbfb8c', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 20:39:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('21ceb065-7fa4-42a4-b522-0370f6e31ea5', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:25:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('220dcb07-9ea9-401c-a7fa-5cb946136327', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:29:48', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('22196939-ac7e-4f77-9cce-9a5606447a42', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 21:32:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('22563285-d66a-4dc7-8fbb-bb083cc80984', '用户访问', '访问日志', '', 'forms/add', '2019-10-29 13:57:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('22682059-f1f0-409f-b98a-ebe0f6bd796b', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 21:15:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2283d55c-1b54-468d-b441-37ad99a35e6d', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 16:09:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('22c1cefc-359a-4d23-8223-cd031d8ae2df', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:25:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('231bc44b-62de-4a65-9927-447d3f08cd9d', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 13:11:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('234c205e-05a0-4156-a598-68149bdc8460', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:50:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('236ae152-3096-4ab8-8438-3d9b2446cf7b', '用户访问', '访问日志', '', 'orgs/add', '2019-10-29 16:13:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2377cf34-e6f5-4311-9bcb-ec83c9507d34', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:28:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('237950da-fad0-40e7-bf04-f9ce7430dfc7', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 15:51:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('237c48d6-94d8-4433-aaf7-944af2a6ec2b', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('23966e59-ab5b-4ec3-b2d3-3dfb6bd81253', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 11:40:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('23b91e3d-7029-4a6a-b961-afbce357c424', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 17:07:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('23df9ca0-36cd-4246-8fc6-8ed20aaebb11', '用户访问', '访问日志', '', 'roles/loadforuser', '2019-10-29 21:13:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('23e9c6ee-2f2b-4a54-859b-708367fb8e9a', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:47:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('23ec38b7-65d9-465c-b1a4-b38ce184e4f4', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:51:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('241b8179-897e-46cf-9d52-5964b0ba5c04', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 20:23:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('24386755-92c7-44f0-8ee4-8cd76595f4f2', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 17:00:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('246c335f-5a85-4aff-95a1-35875694a3b1', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 16:30:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('24866ccd-13a6-421c-8239-5726144253c9', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 17:04:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('24bfdf6e-50e0-40f7-8e9f-7069f0e0a49b', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:16:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('24d9958f-bbe6-4b96-ad61-42f52d41cb9d', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 14:44:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2517608c-e520-4a19-9c74-c229e2b278b1', '用户访问', '访问日志', '', 'usermanager/changepassword', '2019-10-29 15:30:21', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('25226f70-53be-481b-97b0-da00db8b7c57', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:51:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2525e49f-ada8-49b2-a24c-c5ce804669a9', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:21:17', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2542e9b9-430d-4add-9a52-f1d46ce84ed3', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:54:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('255404a7-47a3-4edd-be2d-b0c7b10bcd9b', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:12:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('25d0644c-032d-49e5-b571-501010c5e7f3', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:06:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('25e6161a-df0c-4b65-bbfd-817b86e814fb', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('25f7abf1-f6a9-4b58-a5e4-24fbfb3255e4', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:31:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('26228b2a-76b2-4809-9b35-af138bb8beb3', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 16:47:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('263840e4-0d3d-4258-a630-457957a9c7f3', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 12:47:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('26884cb2-0c40-46c9-b104-7f1d65602ffc', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 22:04:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('26941041-2a87-4162-957b-77be7259bd17', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:59:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('26c59699-7d12-45fe-996c-e6465f855d4f', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:30:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('26d40796-2333-4005-86f3-7463774101b6', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:23:14', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('26d96758-bf4f-4b1f-8ecd-7f0d068178b3', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:07:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('26f969dc-6da9-47df-86cb-9547c896fc90', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:52:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2707421a-9d92-498b-8299-de0d1957b8e8', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 14:16:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2732f168-d6da-43d7-8742-81b5dd2ad4bd', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:33:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('27821806-38f1-45b0-badc-00635b0c160e', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:01:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('279efbd2-98b5-4615-8c6b-5b71114c3b9e', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:02:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('27a130b0-4c9a-4176-ace0-9090173a6044', '用户访问', '访问日志', '', 'accessobjs/unassign', '2019-10-29 17:00:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('27a2d326-a513-456f-9a22-8ecd8b3094e3', '用户访问', '访问日志', '', 'users/load', '2019-10-29 20:51:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('28289052-d6be-438d-8eaf-f84b98b39542', '用户访问', '访问日志', '', 'modulemanager/index', '2019-10-29 10:59:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('283fa3d2-58fe-44e2-a34b-a1822a87a32c', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:37:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('284bf0a3-60db-4436-9171-9045cd412aa5', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 16:01:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('286799e7-5ddf-404f-ae5d-b6360791c83c', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:36:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('287bafe7-a61c-4aeb-bb5c-1627b27c88e7', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 20:13:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('28b20ba0-7ce9-470f-bbc0-bbf274bd2ba5', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:08:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('28df2a49-6031-4eaa-8ede-e815f7ea8b16', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2935371e-db66-4e41-81c5-7c37f4fa3c29', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:26:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('293feafd-c7b3-4dfc-86bc-22f4da2569b9', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:32:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('297b7768-f4d8-4d91-b8b6-648eb7dd6e97', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:22:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('297e46df-4625-4ca8-b2f5-18eefd149c3b', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:26:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('299c7b12-394c-4b6a-8f05-ced218ee0604', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:51:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('29d2a5be-7740-4081-95ed-bbaf4412e52c', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 17:05:24', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('29f270c5-bd3f-4d5b-baa9-23d0ba5e5878', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:11:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('29f3aa14-ed53-49b5-a903-020673934bf2', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('29fea386-ffa7-4a7d-8bfc-efb9afb6034d', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 17:06:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2a251c35-fbef-47e6-af28-0ae62f1fe5b2', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:08:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2a32a2de-a924-4cad-b9af-885dc0fced3e', '用户访问', '访问日志', '', 'users/load', '2019-10-29 14:32:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2a3c9714-adbc-465d-ab07-9a8ae8581d63', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:36:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2a866ae2-5b78-439c-b60b-09a0e6d747a2', '用户访问', '访问日志', '', 'usermanager/index', '2019-10-29 14:31:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('2a982ecf-e378-4f3e-b4c3-48ff6acbef99', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2aa2f79e-a0e3-42fa-bac7-3eea0fce195a', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 11:29:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2ad2d73d-576e-4e58-9142-bd1dfad92cb5', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:45:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2ae1cb85-df00-4739-85c7-80c848c5e63f', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 20:14:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2afee1ee-833f-4e10-bf11-6885c71f09ad', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 13:40:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2b217ffb-329c-484b-8a85-2a7e55863082', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 14:16:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2b512490-8e04-472d-b77f-4987d2cf48b3', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2b5fdd3d-a5fb-4214-a68d-c0c38383f2b6', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 22:04:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2b605275-5901-47e7-b30e-461a0c945b9c', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:22:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2b7a0d11-9af5-4deb-95da-ed01dee144d8', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:24:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2b809a58-af78-49c0-ab48-01b571a5019d', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 13:10:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2b90163a-64ff-43e2-adb2-47ee8f995beb', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 14:35:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2bb43c1a-2018-4518-aa4e-26eaa8c2ff3c', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:10:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2bb548db-d88d-4542-86fc-333fd6576e69', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:25:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2bdf1c5b-d9b0-47b0-bba2-4b258790c026', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 20:07:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2c0108e0-f9a2-4304-9ae2-29638ef04471', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2c13d2a0-72a3-4638-ab4e-5bee50cab290', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 14:45:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2c5c7f38-0dd6-4670-a634-824ebafecefc', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:35:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2c711591-92bf-4bf8-931b-0fe1aeadcb3c', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 19:08:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2cab3e9d-9b53-4ff6-b6d9-fea4ce67b0e0', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:48:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2cdcf5f6-59e8-4536-9b74-2b10c410acd0', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:22:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2ce1d819-3532-490b-b35c-a8caef367819', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 15:28:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2cfa4792-6752-40cc-a086-228a30dc822b', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 11:28:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2d161857-14fa-4488-9e9f-d349f6e077b3', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 18:17:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2d29c055-7ae1-44b8-85e9-915cddca9daf', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:39:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2d40b0cd-d55c-41bc-86f8-f9716b098640', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 20:22:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2d75196e-c638-4d9b-8fba-c325316a2ece', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 15:57:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('2d7c828b-6e78-4d02-aaf7-6419f2e55bb8', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 18:25:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2d868e20-c7a1-44fe-b12c-0a78019d8ea1', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 11:40:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2dc41623-a1c0-4615-b1ad-4a3763d9749d', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:47:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2ddf6f68-a5b3-4138-9670-d03ef6911919', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:33:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2df0a084-f197-4ead-8f32-e57f33f2c5a7', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 21:31:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2e096cb1-0efe-49d2-b39d-4290823b9c1f', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 11:41:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2e52fb6e-4472-40ad-9fc3-87eb4638c6f1', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:28:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2e651cdc-e6ec-4afb-ad22-68a2b380036f', '用户访问', '访问日志', '', 'rolemanager/assign', '2019-10-29 14:54:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('2ef1589b-b8a7-4d3e-b25c-2f0b978ff94c', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:40:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2f222eea-5111-4eb9-a4c5-b8ec1f6ee47b', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2f350e22-56e1-4b53-99e5-bb7595442c45', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 11:40:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2f47de61-d872-410a-9013-ec11941d9b01', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:32:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('2f4b28de-d565-42d1-91d1-8466703c37de', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:33:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('30283964-8013-4203-a8b9-b6293efe4a80', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:52:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('303a1515-249e-4e76-b164-0f010797fed8', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 13:54:00', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('3071f881-edcd-4a33-a4fe-52c84a9c9e71', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 16:48:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('30c2e838-9159-43e7-91f5-355b1aaf115e', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 12:47:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('30c9be1b-fcd0-45f3-bb6b-7b85b9df26d0', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 13:37:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('311e8aeb-f2e7-4457-9b5c-6b09542171cc', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:05:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('312948dc-98c7-455a-a27b-bacf62e6b9ef', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:24:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('314e80d1-7cdd-4963-bf46-0c406f9cba6d', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:17:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('31523e35-2630-4d90-bd9c-8cc061305f31', '用户访问', '访问日志', '', 'users/load', '2019-10-29 21:09:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('316062e7-134d-4557-9a5d-1dbbb66d60f7', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 19:07:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('316dd1c6-8b0d-448d-ba87-401a8c175afa', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 15:28:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('317cf927-062c-455d-8af8-01e6cc49561c', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 11:55:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3198eaf5-1af1-463f-8724-86a72ca5f76f', '用户访问', '访问日志', '', 'rolemanager/index', '2019-10-29 14:53:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('31b5281f-9916-4c09-8c04-479ff28ffcf7', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 14:44:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('31d61589-89b1-4d31-8af7-edb6968dda2e', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('31f148f3-d2d9-4c7d-8a81-8b3786b6178d', '用户访问', '访问日志', '', 'orgs/update', '2019-10-29 13:51:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('31f9d38e-31d7-4b5b-83f7-5096d6b5ea00', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 15:28:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('32037fac-b0d0-444e-a878-380359b62efd', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 11:08:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3238869f-5d38-4ca9-8766-f00f0d4080bc', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:35:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('32807a26-c5a1-45a1-8674-4b510592a53b', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 13:11:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('32938e08-3917-42bc-a8c7-a7c12a0f6f92', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:09:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('32d345d3-4e1f-4983-88d6-5ff559820d5a', '用户登录,结果：密码错误', '登录日志', '', '', '2019-10-29 14:19:16', 'admin', 'admin', '', 1, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('32e2c72b-b33c-4aea-84cf-e03bd594552e', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 15:28:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('331492ae-5be7-4f4a-af0e-28e1c8175ba6', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 14:35:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3331537d-6584-4454-86f6-a6ff4738e908', '用户访问', '访问日志', '', 'users/load', '2019-10-29 14:45:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3362ef6d-733a-40cc-a709-34bbb6106558', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 16:00:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('336669e6-b4c8-44b4-b333-6c410467157e', '用户访问', '访问日志', '', 'modules/loadforrole', '2019-10-29 20:56:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('339f02cd-3aff-4941-877c-af43971e5884', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:07:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('33b23faa-b730-4282-865b-949e523857be', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 14:27:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('33b3b274-e0a8-44dd-a133-8b5a2735620f', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('33fb58b8-d0d9-496b-8710-6eee830ba860', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:27:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('33ff2dd5-1902-4fde-9d28-8297ab6846a5', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 14:32:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('3424a39d-2603-4be9-af6a-0182cce54c4c', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:35:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('345999e4-1ccd-4cf5-bdce-01caa738090b', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:45:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('34d58245-786d-4a1b-9b6d-7c41f0c0a43c', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('34e5fb94-f594-4dcf-926a-46078a1e1d70', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 15:54:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('34ec2153-8128-4319-8726-67ad40cf1450', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:35:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3507e8d8-b9b5-46ad-a5c7-863f72113268', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 21:32:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('35172be8-588a-4746-87ba-6d816437b1a6', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3519fa26-b297-471e-8ff9-d2a101f4ad05', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:52:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3530199f-c3f0-441e-bfee-866b6bef9811', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:09:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3535e8d7-8be6-4a46-84a0-d2bc2ccdaa6d', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:40:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('354d6d73-6001-4d11-aee7-5b14c43e943e', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:40:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3568180e-0175-4347-9db1-b9aa791eb7db', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:45:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('356d2f1c-75bb-4ba3-bbde-78f26cab0da8', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:51:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('35954a47-f1b6-4a39-a433-eda0295809df', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:25:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('359e6cbc-593b-46cd-8256-66c117e9bcd4', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:26:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('35c09eb1-e4e3-4d38-8090-0d6b47d6e478', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 13:10:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('35ff7f48-0938-4c38-9799-5abb52b2d96c', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 20:56:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3642587b-3a9b-4129-8851-4c15424ed3bf', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:38:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('364512e7-f9cf-473b-87e1-1861bc485f51', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 16:47:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('366b8101-7cd0-4a8f-8865-315cb3552d6c', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:54:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('366f26fd-9d10-497d-bdc5-e805c28c2559', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 14:35:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('36880138-5b28-4c1c-8b0b-4b77fdfc49e1', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:39:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('369c094d-a7ea-4f44-b25a-f8a0a40c8a4f', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 21:32:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('36a1fb10-c92c-4e6d-8113-b79f69ffcb4b', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 13:11:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3702807d-e0e5-41f8-953c-7def7afb5243', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:51:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37060777-26f8-43e4-a2e9-be625ffe82c2', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 15:28:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('371895f5-40fa-435c-87ad-5e34e609da6e', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 15:51:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37879dc4-e64b-472d-9ba9-3bd8c312a951', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:28:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('379b32ed-c4b0-4aaa-b4f3-7fb6cd043925', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:17:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('379e66c6-dbb6-4c3a-bd1a-55f27c580e73', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:06:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37b0adbd-3c7b-4fc6-a57e-b6099c5c9030', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:58:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37b70e40-b1d1-4451-8830-33644266f093', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:30:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37b8f258-e21f-41bc-8008-b14099a83350', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:27:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37c3dcbd-bb52-4967-bb89-8edc7b53f981', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:17:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37dbc9a4-653c-4fca-b90d-fdb794cc3538', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:23:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37f0ea13-8f1f-4b1c-b9dd-8907bf6ba4d1', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 15:50:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('37fe6634-4654-4a10-8c1b-7f2b9577d585', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 17:06:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3802fc11-b5ba-4656-a2a4-7bccef57a553', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:45:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3815407c-efe1-4cd7-9f5d-51f12bd2e7b4', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:33:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('383f6bdd-f006-4000-ae24-7a7342825a81', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:02:27', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('388a0f72-9d3d-43cb-b410-b64b8d12becd', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:29:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('389f1c86-32d1-47c3-9419-c62c3d048793', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 20:24:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('38de2bde-e9d9-4a34-b47c-5b8a1e755456', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:07:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('38e54717-ad95-402f-97a3-4f8827818a2d', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 15:02:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('391c58e6-4524-4e19-b2a1-d673a85dec18', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:17:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('395a207c-0aad-4fb2-979f-e4f10a674486', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:27:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('395ff4b5-3c11-4c72-ac67-164e887aedf0', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 16:00:22', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3966d576-58c3-43bf-812f-6f82a39a56b9', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:26:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('39919e18-0088-4b5d-ae70-22263a7b0bd4', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:03:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('39cfaf62-fd0d-4f96-860e-806ed37b9adb', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:06:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('39dcc7d3-78d8-4122-8e4b-0557ff25fe66', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:38:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('39de2f31-7041-45b7-96d3-ad67514565b0', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 19:08:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a09ccca-762b-4acf-b608-7cb300eecc35', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:52:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a369490-7e0b-4b83-9e17-a91e82868ff3', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 14:27:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a4e741d-fa14-4240-b51f-4dd851c981b8', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:51:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a4fbd66-b09a-47d1-aff1-30782d68c11f', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:09:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a5aad3b-b072-4e19-9ea6-e437cc6d93b2', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:50:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a6c29bf-e040-4afd-b0d3-1a5f02c461ed', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a7dd67f-29c3-4369-bb37-8bd3a8d39a88', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 17:40:28', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a7f5f98-1905-41cd-826c-95528b58abe4', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 16:00:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a81f4a6-b117-4ec7-928e-c80493f50268', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:27:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a862dd7-7b5b-41db-ac99-3cea7ab6c75a', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 18:25:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3a8e6a4c-63c8-41d8-8361-0251b4495f7b', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:27:22', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3ab1e1de-2885-4c3d-8b75-fbf67067ec76', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:34:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3abff010-3a36-4ae7-829e-61fb81a87e8a', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3accf446-d251-4455-8ed3-c4cc6b3bd144', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:25:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3ad54c2d-b916-4752-bb45-3d3c2b0f6942', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:42:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3af174eb-b02f-4c91-9eef-6ab6a3e7a1bf', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 11:40:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3b2e10d9-4fb3-42d1-8b8c-230d8d737712', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:49:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3b5d5780-0ef2-4254-bb5c-1a41cd60755b', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:51:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3b61bee6-ef45-4953-9909-7620958083b3', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 11:08:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3b97867e-b1cf-4bda-998d-03b24340a1cc', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:52:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3bf4b94e-4023-426d-b4c3-cb472d1717a4', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 16:43:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3bfde92f-0fdc-4c32-a562-57556bb08623', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 13:40:40', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3c03737d-9684-4379-9c5d-aa72ffed5e68', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 15:34:24', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('3c24b9b3-0c60-49f5-9b9f-6a564869d17e', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 21:32:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3c3812f5-321e-47db-8c8e-cf6f40c8d529', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:30:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3c548444-fea6-49b6-90ac-ec56e303e9d2', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3c62b9e6-9d29-4d9e-9624-5eaac8e5c22b', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 15:21:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('3ca36308-3c0c-4152-8155-61a96425537b', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:27:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3d06d547-e87a-4b08-b4b4-fb3288a0a1ba', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3d4023d9-84d0-494d-86c0-9c2e5184019f', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 21:32:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3d788434-6695-4f4d-8153-c3d32af3ed0e', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:21:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3db24d0b-9ae6-43c5-8b8e-5114d12fc9dd', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:58:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3dc6bac2-b1cc-4a42-aa4e-e2724e6019b3', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:24:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3ddcbf89-5bfa-407a-b970-fee7e87ebdab', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 11:16:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3e0c252a-82de-460f-96f8-8a1890e7c04a', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:01:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3e7acd27-2840-4e71-bbc8-d245729daa2e', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:13:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3e7e030f-6adc-4023-97b9-ff959493d95a', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:51:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3e9bab0f-ec45-4e6c-b4ef-d89c910ec2f2', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3eb62ff6-3521-40c5-a4c0-0847a57bab71', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:35:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3ef72746-98f1-4b24-82da-fab3a5dd62d4', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 18:17:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3f2748de-13fd-45cb-8d25-cba66f366584', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 15:15:51', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3f33a635-c091-42eb-8f73-6db3070349aa', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:24:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3f5bbe00-e5bd-4e30-8ce9-68adece70828', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:49:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3f646ac2-6ac5-4356-9537-f365952a7966', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3f64fb84-ea89-4369-bb20-48d47e4ec62d', '用户访问', '访问日志', '', 'sysmessages/index', '2019-10-29 14:29:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('3f78f521-2350-4acd-8b5b-43d2ed19fcb0', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:08:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3fc7d41f-6239-4ce4-986e-70ab76ffc9c3', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:28:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('3fd9d48a-adfb-401d-9b5a-47200f6595d0', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:51:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('401bc119-c760-47a9-9148-370db6f7a666', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 20:39:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('404df47e-99cb-4f55-b849-c06ce50dcaef', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:45:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('40604867-c6ca-4b5e-bff2-e0ed344cffc8', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('40a4fce9-d0e8-433c-be6a-1e06b3dd9f1c', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:21:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('40a981e4-97d4-445f-a5c3-b13baaa81ef4', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('40b30b15-b35b-4dfb-ba14-95b42bee4ea9', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:15:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('40ecaa98-f80a-4543-9899-cac85a913cc2', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:48:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('413c0b81-cf27-4eef-9840-154e84ddbede', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:37:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('414b9f56-cc97-443f-8b3a-efb2a3100d5d', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:52:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('41519e5b-74ce-47a1-b7db-75bf8ba507cc', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 14:16:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('416c1b92-d0fd-44c4-8a1d-34a84b4d7e64', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 17:33:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('416d2dd5-e0d3-49f4-997a-57ca2ec73be6', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 21:17:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('41814df7-6167-413e-8f7f-8d1e988c4071', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 21:13:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('41b36702-8cc0-4534-a141-3d9161ef07fb', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 17:34:12', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('41b3a2d8-554a-4147-a016-40fba5f587a0', '用户访问', '访问日志', '', 'users/load', '2019-10-29 14:17:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('41efa4a4-f197-4d63-93e9-623a07fd6d13', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:02:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('420ced6a-e561-47b1-9c83-bf42eb1b6232', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 11:08:23', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('424a65f2-6aa5-4f5f-b69f-0fc182abe848', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 13:23:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('425ad713-4272-4ae9-832b-38427c5f3452', '用户访问', '访问日志', '', 'flowinstances/verification', '2019-10-29 14:44:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('42a82ee7-e92c-4c56-a470-943320b822dd', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:52:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('42b17e76-7628-4d62-a2de-3fe67540cdf6', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 15:58:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('42de4a42-1fdd-4400-87fa-4b304c76085a', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 14:17:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4300a350-3c8d-4e36-b0bd-86b4836fe121', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:49:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('431317e0-264b-4b7d-8bc4-4b9f891825ee', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 17:42:04', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('431e14f6-bb5d-49d4-a04d-b42e4f4f6f97', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:35:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4331b7c9-73a8-407c-873c-caf7b18f256f', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:23:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('435dff7f-5513-4252-93a6-9bd951bbc56f', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:55:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4368a1f4-f130-4263-a5ef-28d07a73b268', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:51:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('437647c4-7856-4e3b-ae6e-89ac1f097726', '用户访问', '访问日志', '', 'orgs/update', '2019-10-29 15:16:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('438758ff-d4f7-4e9c-9129-db71cf316e86', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 15:54:23', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4397941e-6066-4a6b-803f-b088f644224d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:17:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('43bb69ea-1e85-45df-b9d3-50ac074c95e0', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 15:53:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('43bb9601-292e-4710-b242-8ae9dfe5096c', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 11:40:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('43ef8957-a534-47c8-b41c-67ae8cde1362', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:43:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('442b0a63-3ea5-4296-8850-00d65792e431', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 12:46:10', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('44337275-888a-46fe-ad01-daa54e66ee62', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 17:00:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('444a6957-9009-4a76-ba4c-003397115117', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:17:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('449be7b5-60bb-46b8-8160-9f0c088f0798', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 15:29:48', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('44cb6251-87d8-470b-ae4a-ec767a51a349', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 15:27:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('44df7748-b008-41d7-929d-376d18e94a6e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:38:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('44edff2d-ad3c-46e2-8313-1345472c291f', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:10:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('44fa36fc-2ecb-4997-8b87-870f21bf8431', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 15:52:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('453c30ba-9df2-4892-95e5-773d01efb312', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:24:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('454d97f3-08d5-41a2-bb59-24f395532f6c', '用户访问', '访问日志', '', 'rolemanager/index', '2019-10-29 17:02:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('45602891-1821-4bd9-9343-7885c230b914', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:22:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4565c52d-944c-4d27-b117-4f826b71a1d0', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('459fe3df-ad68-4dc1-8385-5a62ce31d67d', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 14:17:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('45b31762-971c-46f0-b8e8-5c5f56acb0aa', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 15:50:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('45cea23d-52d7-4074-a217-1902c2c88521', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 12:46:10', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('45da4c55-6b7b-4ccf-8b83-d23296282186', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:30:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('45f17f8c-1988-462c-ac37-c8187f4c286e', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 19:42:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('45fd2842-6a3d-4410-b0b8-7ce320b5abce', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:38:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4608cd10-6883-46f2-b332-08ae8e373bff', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:35:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('466f9739-1be2-463d-b201-17ab6c80f4e4', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:08:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4687c6e9-b327-4c49-ac9c-551cd0496e6c', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 10:59:14', 'System', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('46b1af7c-2942-4161-91d4-d45dbeb7b7e7', '用户访问', '访问日志', '', 'users/load', '2019-10-29 20:31:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('46c42783-4939-4861-b2dd-c0cb6d685a50', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('46d4b919-b906-45ca-b9dd-24e8ad8d556b', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('46d50bea-e043-49a9-ab37-f7c6f2301250', '用户访问', '访问日志', '', 'flowschemes/nodeinfo', '2019-10-29 15:52:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('46eb2a2b-8cbb-4f30-9046-cb787eaa0f59', '用户访问', '访问日志', '', 'flowinstances/detail', '2019-10-29 15:16:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('473dbc60-cc8c-43b7-b90d-fa7b14f01b22', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 20:14:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('475adc8c-22c3-4c40-acc1-9d2cc67aa02f', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:28:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('47ba709f-13cd-4290-b273-0e36c28259a3', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:59:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('47c48aa7-d5b2-42af-8096-375cbc41e412', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('47cb7d72-c5d2-48ab-a5d2-7c32e2c4ea20', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:11:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('47ceab56-5a49-4017-beff-d33fdf50783d', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:27:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('47cfb690-bc95-465e-8f23-853556807b37', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 13:53:57', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('481eb148-ed82-44ed-aeba-c1a84b11553d', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 21:13:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4843dd3c-7767-4006-9aea-71b021dfce9b', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:32:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4844af3d-c9c6-49ca-906e-3dfbb1a8a394', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:53:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4856f806-62e6-4750-bce8-fab694cfb829', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:44:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('485d03ba-f1d2-43b5-9e8b-8a46752d0f3c', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:53:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('489eb5b9-3b6f-4c50-811e-b160abe341f7', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:48:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('48ab60ed-8d1e-4104-a9a2-1f03d2456dfa', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:35:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('48b27e49-914f-439c-8389-71cf0f01abe6', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:37:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('48f12a72-7622-4275-a911-09d472619d4f', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 16:47:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('48f1f3d3-f315-4dc3-b29a-2175779759e7', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 11:08:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('48fff1f5-20c9-4d92-966c-4a6b972630b6', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:50:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('491e5873-d13f-454d-8109-dafa208987d7', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:15:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('49497da7-6fe2-4bb3-8922-878053d55680', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 18:17:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('49647e9a-42ad-47ab-9467-7d52cc2e4beb', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 19:08:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('499034a8-d21b-4713-bafc-313b7b66c575', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('49a50ac8-998d-45bb-ab1e-b4524e4c33af', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('49a8ea74-3b7b-4e9f-9ab2-6b07fdaba166', '用户访问', '访问日志', '', 'flowschemes/design', '2019-10-29 15:17:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('49cc06c1-f11d-4288-8aed-b369a1c02128', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:05:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('49d26514-53c8-40e6-a5d7-c92c6c40456a', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:54:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('49ef78ab-13b1-4ccd-8777-d305f9454f7c', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 15:51:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('49f027e4-77f1-4478-9c9c-5c554213e282', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4a56895d-1ca7-4fee-aaa3-01d94084cd37', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 20:28:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4a56ca68-277a-4a65-ba1b-76461dd66215', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4a866ee1-ecfc-4e22-96f9-bb02bd05d2c5', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:00:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4a980b83-c1bf-4bf3-ac17-b0c8c732ae3c', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:50:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4aa2fd36-f42b-493d-ab31-836a1fdc9235', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4ab98c27-5cf7-42ca-854a-7d709cf9500d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 18:17:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4ae115db-d5e9-45fd-8e8d-da36dc2294fa', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:52:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4ae2ea52-65da-47a2-8adf-9ce567432b7b', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:23:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4aee73ce-8cf4-4149-82db-aa2363c8f6cd', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4afb6225-6317-4f8d-85da-72a771e67440', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 15:29:46', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('4b22443b-6ae8-41d7-b779-a73c4cff24f8', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:33:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4b558809-4d26-414c-b222-b9e46c66ab64', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 11:38:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4b8495d2-6556-41e3-b78d-fe4a99bb353b', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 17:02:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('4b89f02e-f534-48ae-b369-8e5a8032e868', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:23:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4ba981d9-e340-4c03-abf8-3e4af9bf6428', '用户访问', '访问日志', '', 'flowinstances/verification', '2019-10-29 15:53:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('4bc25e17-c2f6-44aa-96a0-4857c2324769', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 19:18:28', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('4bf1362f-1e93-41da-8c2b-0f9e1c2db903', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:52:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4c165b93-75f8-4e1c-9f17-c8d7ad05861d', '用户访问', '访问日志', '', 'flowinstances/verification', '2019-10-29 14:44:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4c75c67d-8938-4e7b-a801-7a1021e49c85', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:30:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4c80d8a2-ef57-4547-b0b2-fa8b636dfbae', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4cc1193c-90bb-40f8-8ad1-88ca4c3ee608', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 13:11:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4ce81bb6-61c3-42f4-a667-3b90c681436c', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 21:31:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4cecab79-fdf7-4d18-9743-4460fc1c35c5', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:30:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4cffe85d-2e4f-44bb-a793-0da849794dc5', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 11:08:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4d0d8f25-794d-4e63-9230-f9166a2000d1', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4d1805e9-08b7-4373-b42d-cb21e23f3056', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:44:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4d544b3a-b462-4b4e-aed1-24064a479e64', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 12:47:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4d66b1d5-9038-40c1-955f-a845c71be9db', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 14:44:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4d7d1b0f-252f-4a36-9841-4154f704b83b', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:05:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4d7e7159-4aed-447a-8bff-fdb1e78a2feb', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 12:45:53', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('4d9666ad-720e-4ab1-b09a-7853f0277c3e', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 11:19:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('4dde9b62-6f78-4e93-97de-dc7d0b89fc4b', '用户访问', '访问日志', '', 'orgs/update', '2019-10-29 13:41:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4de57afc-7035-44a4-9e1a-1d69d1424816', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:01:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e2e5780-edda-4861-a7ff-8c748e4a6f1a', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:27:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e30d1f5-4741-453a-bd6b-31ad04de61bc', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:08:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e353d91-07b0-42a2-874c-abcbea38faf7', '用户访问', '访问日志', '', 'usermanager/index', '2019-10-29 14:54:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('4e4b14ec-1700-477e-9db7-64ca73b1d581', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:40:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e4e05ac-d772-4af1-9e53-809655ee6d7c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:22:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e4e888d-79a8-403c-a1ab-eb81e53d7464', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:38:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e6c426f-34ca-4955-bd5d-0623a08140a6', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:49:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e783478-276a-4cd1-b9a8-50c0246052a1', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:26:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e92392a-6bd8-4e23-b00c-c13d6bf14e05', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 19:07:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4e96c42b-26d9-433f-aba1-6292945c5e5f', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:05:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4ee42901-3479-40a0-a981-6c9c6c3a1ce3', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 11:07:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4f09ffc2-6ee1-4425-b0b8-6acda876c45b', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 11:40:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4f58e811-f900-4248-b966-df934834afcf', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:01:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4f693bbe-74a5-4bea-a0e1-58b00375b9e7', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 18:17:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4f933b64-d8de-4050-a361-1a86a71ff632', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 13:56:20', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('4ff25d41-a8a2-4cc8-9d99-6077523eb374', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:36:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5080e50d-20ce-4d62-9716-b781e94568b9', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:05:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('513436bd-8985-4686-b27a-2267ceacbd33', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 11:15:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('51476661-99bd-4b0b-a1f8-4181556beaf7', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 17:27:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5159d95f-df17-4fe5-af0c-bd0d794542f6', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 12:11:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('516f3b32-3564-4610-a34a-5a47763f3dcd', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:45:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('519116ec-5a38-458b-9e53-c62d24d7f490', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 17:35:15', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5191e46a-acee-4d3b-9806-3f2de0734558', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 14:17:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('519f0f6f-a247-45a8-809f-c3d021e21946', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('519f80ef-ad81-447e-bf5d-7db62adf6117', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:09:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('51b4322d-5f83-411d-9a53-c32db6296623', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:28:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('51cb5541-8778-4102-80b8-38561a0ebd9d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:30:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('51f15404-bd63-4cb1-83be-75f2f864b7ef', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 19:08:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5215a20b-fbb2-4340-9ce8-fca5b039b58f', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:24:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5215fedc-058f-4ef4-a628-b9216be2d624', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:02:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5232d7cf-e027-407b-8892-e7b11af2b3e1', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('523d95bd-7085-47ee-a6a6-5b11d262f0cf', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 18:17:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('529b62d7-5ba5-4e96-9356-b5dc0a221628', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('53250263-77ed-4c43-b069-316703e5130f', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:28:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('53b22f61-2b9c-4cfd-957a-fda7c000b917', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:04:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('53b2ffb5-d56e-4e4e-8cca-50e77b1fbb88', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:43:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('53b7bf7b-d9a0-4179-ab11-dada49ff3454', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:38:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('53f6e961-3613-4f98-b51a-8b157e37c2dc', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:13:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('541e2449-38e3-423c-b762-9f810910d79f', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:23:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('54275215-b8bb-4486-883f-1266c5cd34b5', '用户访问', '访问日志', '', 'users/addorupdate', '2019-10-29 20:18:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('543031be-ee51-41e3-b3b2-857687d92dfd', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:09:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5458b2fe-36c0-474e-b34d-dd8cb161e1a6', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:35:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('546feb52-5a4f-4e57-ae6b-c8ac3cbf6f32', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 20:52:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5484417b-bd15-4101-872d-e67596ff1339', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:24:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('549d2945-7fbf-4d61-aa5e-a8c91fcd6c9a', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:21:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('54de83a8-57b6-42ac-a9a0-1749fb2609be', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:11:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('54f0fdac-7742-4454-94b8-a606add437c3', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 21:32:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5541727c-5ac3-4fae-a455-4b81c29d7f6d', '用户访问', '访问日志', '', 'roles/update', '2019-10-29 20:52:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('557d8953-7057-42cf-8f8e-b3e65d775684', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 21:12:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('558231e1-a3bc-4b6a-bcca-d11e8dc9630c', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:38:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('558ead2e-1a26-4f4b-abc9-986ee7431369', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('55b1e1db-12bc-4a2e-8420-31d3dc9e9707', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 13:40:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('55b999ce-ac82-4099-a179-bbb01e84ec37', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:38:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('55c3e286-4892-48e8-b01c-d7432e9a6642', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:06:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('55ca5f3b-2e3b-467b-a167-e47e54d852d8', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 13:11:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('55cace89-19c8-44f3-ae88-4ba3ed565365', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:26:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('55d4e8a3-d9a3-4354-be8a-2524b1b8a6c5', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:47:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5673379d-7f64-403f-b220-f07bfc53c34b', '用户访问', '访问日志', '', 'flowinstances/add', '2019-10-29 20:10:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('569b64f5-06e0-472e-8269-74d2e5e2b4c4', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:09:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('56b39d46-a4f9-4e7f-b7e9-b9c0079e9595', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 14:35:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('56cd3dc1-dc41-4405-8496-476c62cb53a9', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('56d2da75-8b25-4778-83a6-d7df286d400b', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:06:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('570966c0-3911-470b-91bc-8c6b8f622905', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 22:04:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('57326a7f-68f8-41d1-8f22-e26d21dfcaed', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 15:52:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('574d3110-de87-4613-9837-e072f58ae8d8', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:32:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('57938e08-4fbe-469e-9d43-aeec6ea6efa1', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 16:00:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('57f7cd78-5e60-452d-bd0f-6584de38eda7', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 20:23:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('58163f03-5644-46c2-808a-8aac602d9c91', '用户访问', '访问日志', '', 'accessobjs/assign', '2019-10-29 15:28:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('58175690-f429-4c49-86e7-331f2db19fa0', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 19:42:58', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('58412ff8-ee05-462d-8ded-6cb3ee176dea', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:48:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('58543e5f-07b9-4f61-8053-ca7f9fd31006', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:09:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('585c11fa-38ec-4755-9d71-d5bc901ef481', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:43:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('587b316a-be04-41d7-a63e-09e635b034c3', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:43:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('58a6e490-2747-4a95-93fc-36d4fe8c9749', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 20:52:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('58aebe6e-affd-45f6-93c6-eaf6a575eec1', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:26:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('58e85141-e39b-4b61-bc92-c4f55b910402', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 15:52:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('58f3e705-7195-4873-80dd-4ac5ba9f3c2d', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:28:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('59526c3a-8a91-42e4-a942-9fc733002ea5', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:29:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('595d756e-6294-4a16-9d67-fd90fea11b96', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 21:32:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5967eea2-896a-48b5-8ed8-ec2a41303b44', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:47:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('59760989-7ed6-4813-be26-be6f50b17f3a', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('598f0933-7fd1-4459-a0ff-d51892b3fdc6', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:27:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5994e432-607e-41f7-8db3-ad0f89305470', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:18:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('599f2c20-ac01-4b16-9295-df99365ea52b', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:01:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5a52d11b-bd3d-45ce-98fb-a866d39af529', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:16:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5a55f30f-86b2-4b21-8cc5-7d457d0eb0b4', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:29:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5a9a8e24-e3a0-4846-883f-e312b6bbc29d', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 15:25:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5abaed7e-feab-4321-b7fc-dfc0692b1524', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 15:57:56', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5ad37cd6-dc32-4634-bd4d-1fd3bc7a7905', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 14:32:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5b0fc2ac-10f0-40bd-8e48-70bd7b1eab81', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:37:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5b1aa1cd-2693-4fab-8e0f-aa91864a3800', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 15:39:43', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('5b1cd35a-ca82-4153-8e06-dbe77036f310', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:16:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5b3de430-25d3-483d-bc58-1c093013822b', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:23:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5b411459-8381-43cb-8e31-116788ffd779', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5b5fd929-95d1-49bf-9d35-b67300fa2a42', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5b7388ea-2cad-4c27-9a6b-bc9e9fe6f74a', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:25:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5ba9676d-1220-4daf-8d33-f7608b3d9d6c', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 13:38:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5baaa859-dbf2-4911-a02d-2610b2251857', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 14:17:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5bc236b1-0576-4fac-9dec-6656f4cd9c49', '用户访问', '访问日志', '', 'accessobjs/unassign', '2019-10-29 15:28:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5bd15acb-d77c-4a7a-a870-aa847fb2213d', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 11:27:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5bd37959-9152-4973-9ea1-992343ccdd6d', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:26:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5be08198-b2dc-400f-9a74-59f3cfeac1b5', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:35:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5bfb339a-afd9-4d92-9b86-d002c4dde38a', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:18:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5c25e1bc-4f5d-406c-8808-1ab76e12db3a', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:40:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5c5c9a52-9153-4f59-99bd-c6b56873af64', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 21:09:43', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5c6ec9a7-58f9-4253-a217-2a515d909073', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 15:51:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5c70e274-e085-4753-83f7-6df35a21e45e', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:22:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5c73366e-539c-4e51-b0c7-c7bad477c95c', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:23:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5cb123a0-ee88-4d53-a9e8-6f4fe61e957c', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:32:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5cc63e94-806e-4a98-8440-cabd3062e9fb', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 14:40:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5d1b4f5d-8356-4351-9941-992aceff0409', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:06:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5d5859d4-c379-4d8e-ad93-d5d4423d7372', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:40:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5d61e0b9-ea25-4ec2-996f-8a5c7117ce7c', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 20:52:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5d88b46d-bf22-4872-836e-2571193773f0', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:24:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5db61f06-6d7c-4866-91cd-d25b7b5439c5', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:40:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5dc8c8a4-5692-49ab-a268-8f27877a219d', '用户访问', '访问日志', '', 'usermanager/index', '2019-10-29 17:02:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('5dd19d3e-c82d-4922-93d8-ad778e8661bf', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 16:46:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5df46d5f-61cc-4963-8cc9-ecc46456addc', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 12:11:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5e34ce1d-5774-4bd6-ade7-e8dd3197b1ac', '用户访问', '访问日志', '', 'flowinstances/edit', '2019-10-29 15:15:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('5e4be6b0-7db0-4260-b189-b96cec455c94', '用户访问', '访问日志', '', 'check/logout', '2019-10-29 14:18:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5e891875-2b7d-4e3b-aaf2-bb23a660b84c', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:47:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5e972f5c-a0a1-4ce2-a06a-b0788007f24d', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:26:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5ea13327-ace1-4175-9224-42aa33b344ab', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:47:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5ed6c268-218e-4e13-8531-55c4e1cab37f', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:25:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5f5346e3-3b24-42b9-967a-0241421ec4cc', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:29:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5f6019fe-83f2-4435-8245-902e3b48e1d2', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:06:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5fb8fea6-9cb3-457c-b42a-58eeb3c9d2ea', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:17:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('5feb907d-5b57-45ff-981c-456a22f618b7', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('602ff567-0ba4-44c5-bf1f-936c9684debc', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 18:16:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('607ff720-72d6-446f-b6b3-fd23fb6dfc9f', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:45:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('60c65158-09a9-432b-9c95-c9e6364221e5', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 14:54:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('60c9a103-d04d-4a42-a944-657656a5704d', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 16:00:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('60e8a341-16b2-42fd-af51-914326223006', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:19:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('60eaa859-f0b5-431c-be14-24c37944b504', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:49:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6106d10a-be0d-437c-81aa-4945c4aa6e18', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 20:22:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('61143c29-23b2-4022-a58b-0f04c7ea7fd1', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 11:25:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('61277486-9ea4-4f7f-bf11-7c63dc28743e', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 18:17:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('61435717-dc21-49b8-b1a6-6abdb05e55d3', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('614dbe5f-577a-4d63-b4fd-0bebec688184', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:27:18', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('61825fc0-88d0-471b-aff4-7f1bf3dc3b1b', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 11:39:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('61c4792d-ce3d-414f-9477-4a675ce7feb2', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:47:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('61efa067-8c8b-498b-bfdd-0bf046e38831', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:23:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('62010bf9-55f3-4a53-92f8-e06f6badda1a', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:22:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('621f0099-3fa0-438f-a9fe-9b03eb021282', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 21:32:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6230c390-480c-4661-a28d-87b916604a99', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 17:41:47', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('6263f945-2210-4ea1-907f-138730daa966', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:41:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('62aab16f-ac87-4a43-abbb-52156fa46833', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('630d16f0-b685-4fa2-a322-9f9fab4c3697', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:47:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('63277e4f-0caf-4c89-bdd8-ef3fe429bc48', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 20:14:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6332b2cf-6c39-43f6-9163-1447c6fd6ea6', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:08:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('634c183f-5273-4825-95c1-4091c3ee0f1f', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 19:18:24', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('635eb14c-9bfd-4fac-ad48-a3f964a3402c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:55:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('637ba058-85d8-435e-afd9-8f84a3297319', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 16:46:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6398b241-9639-408d-b0d9-5d3ec5102556', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:25:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('639ef09d-3b49-45ef-8989-a091cc36ef6f', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:32:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('63a55bc3-150b-4738-9500-8d2c00aca691', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:35:27', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('63b852f6-09c2-4848-971a-a4cd559f6f2e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:17:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('640eaf3a-dd2b-4191-8cb9-55112d43293f', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:47:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('641801df-deef-422a-b580-5b69136f3038', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:39:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6429ecd1-3ab1-40f1-ae81-f91fd554f92b', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 13:40:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('645b4faa-6203-4177-a84d-22e413a1023e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:27:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6495389b-df80-4676-949b-68634425c4f1', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:52:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('64e7917a-2b45-4eb8-ab00-3340a85adafd', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 11:40:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('64ed1d83-98e0-4495-b208-0d70deb57c56', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:25:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('65675342-dac7-4185-af01-ed791284389e', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 21:12:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6584ae5a-501d-4dd6-b880-14b1cd195598', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 13:57:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('65ea3b35-654c-48c7-b6ad-24d2d7d3cfc3', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:30:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('65f7f64b-c5fd-4734-951f-4e636e7e3869', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 17:06:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('65fb54da-df3e-40f5-a0b1-d97bfb235f5b', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6616ca50-5be4-429c-a747-031beb447cb8', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:41:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('66349d33-8d8f-4029-b0de-25c79ae40a81', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:27:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6681b254-7428-491f-aecc-31c00fbd1f86', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:32:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('66b268e6-4518-4c30-804b-a35ad2a0f4a6', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 11:08:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('66c2c122-68ed-4ac2-a64c-0ab6baab84fe', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:35:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('66c3cadd-2a8a-4f20-9375-4b0160ef27c3', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('66cabd26-cbb1-4327-80ef-0018ec5e7e88', '用户访问', '访问日志', '', 'rolemanager/index', '2019-10-29 20:46:09', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('6705614b-b1c6-425e-8172-06268ae17197', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 21:12:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('67089dd1-aa4b-4f2e-98be-6c48df5b1684', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:04:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('670eea7e-3b1b-45e9-8bc2-a59c000f1168', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 17:21:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('672e15d2-703a-49cc-bcc3-a76e43da7d3c', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:50:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('67372afa-3e48-46cb-a95b-2c0e4332d260', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:41:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6737c9c7-b60a-443f-9d4c-ff3acd1a59ea', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:36:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('675f8926-a0de-4a3f-97e9-8e6643238a6f', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 11:28:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('67901fbe-3533-4160-a8ce-0e8ff8dece56', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:23:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6799c483-4e09-4f9f-b636-b1352b6111eb', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:40:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('67b0dee5-a8ad-4809-a7b3-28ecc5ed6b12', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:06:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('67de52fb-e26f-4172-bc00-72e7f8053fed', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:12:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6820af9d-a2d4-4557-92bb-9a19cb5785b1', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 18:17:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('685ec645-7a13-4398-a2ec-9206db9abcab', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:30:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('68bf3bf2-60b4-406e-8664-761fd346e04e', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 17:35:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('68ff5269-44de-428d-b464-312993c1f298', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:22:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('690c3f27-3107-419c-8ea6-bf89bd54eccb', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 13:11:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('690eeff2-b417-4f41-adc4-744cced88c06', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:09:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6919dccd-8d6b-4d12-b3d9-74b032edef01', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 11:08:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('69272cf7-6cbd-4d16-8a95-b68266cf2327', '用户访问', '访问日志', '', 'users/load', '2019-10-29 20:32:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6979f2a8-6ff6-4dfc-a7c9-11005b62a234', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:05:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('69c532e9-b40d-4918-ac2e-0a7e3de34af5', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 16:00:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('69ca0c80-febd-4af5-8b50-5ec78530a210', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 16:26:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('69ea2bbd-bbb5-44ce-8b64-eecee63391b0', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6a043171-ed80-459d-9a3f-5d4c285f86e4', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 15:54:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6a124571-8b75-4300-bc07-0d12ab0e0ad9', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:52:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6ac30d55-0465-4c43-b3df-9d3ac78e0335', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:04:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6b05b826-a46f-4660-971e-454ebab4418c', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:54:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6b07b77f-5393-4267-98f2-95ca2489c2b9', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:08:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6b36df74-c656-42cc-b59b-a33c5068e54d', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:25:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6b53dea3-613b-41c1-babf-adbe8243bb74', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6b683924-8f46-4f4d-9afc-2ecd8c963224', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:47:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6b9927cd-4f51-4c0e-9fa6-965e0b6ced8e', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:28:47', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6bbe698f-cd5a-4f81-8fce-bafafd392d2d', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:52:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6bc0af1b-f281-4995-98ea-ae465588d435', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:01:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c0444f5-6aa4-48a4-83f5-2208fd21b1c6', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:10:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c12be0f-6273-4e34-9519-d8f2b38fac02', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 20:22:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c297faf-f531-4d0f-9156-8faf954b05d1', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:18:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c2b2cd9-c446-4e7e-94a0-ece5c78e32ef', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:10:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c4adb05-b198-4e58-a82e-042ed2537e23', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:28:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c5770ab-8954-44fe-aa83-249be86c3e34', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 11:30:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c5ef1af-2e2b-4797-8745-dadd298e410e', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:25:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c63c332-9816-4e40-8fad-11ecd546fe29', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 16:45:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c6d0252-16ee-4a7f-919b-582ffca5a125', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 14:29:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c87daf7-6dbb-4134-8f30-2ea6e86f16ba', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6c98f198-5a05-47fd-ab7d-e9743bd7f3c7', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 14:17:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6cb86173-d6a6-403d-9c62-5b91c24e3427', '用户访问', '访问日志', '', 'users/load', '2019-10-29 14:31:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6ccf01fd-4b04-4aa5-96c8-c3d4f4194100', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:25:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6d149657-9456-445a-9f2c-5ff2b4b88aaf', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:45:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6d266e94-6ccc-4c44-9f1d-7664475b5926', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 14:54:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6d5d3d43-c851-4a89-9937-5ff7a40a56ca', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:05:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6d6a056b-e8f8-4291-ba10-9934a546e153', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:51:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6d780241-f460-4977-8fdc-94e20fa80dc9', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:40:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6d7cba6a-3ba0-4353-a270-d1d89bc7b5de', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:47:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6df23eac-ddec-419a-b475-1d83f7c68402', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 15:27:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6dff16cd-95e2-48f0-95b5-d6712ae30707', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 11:17:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6e6fcb06-5198-47dd-bddc-5b1ee523cc42', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:14:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6e9b5e6a-7cfc-49be-a1cf-375e4920aa91', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:50:27', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('6ed3e4ca-c38c-44bd-aea3-deec01ee8e12', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 15:38:04', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('6efd81ed-f63a-4ab0-8cc9-811a91856727', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 21:32:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6f12ce0e-0b85-43cd-88a5-5e85db3f0f76', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:52:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6f1ad79e-9ed8-4a56-8113-4bb71620f87a', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:59:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('6f72531f-9a94-4070-883b-c3c5ba6dde2a', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 11:03:01', 'System', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('6fa76d07-03c0-41ed-8d64-ce49c5e67a63', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 17:41:24', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('6fec5c3e-0121-47c1-aaf9-0b5d64f1a8c0', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 20:22:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('70211529-9caa-4b64-98c9-1a8e5e535876', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 12:44:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('703b8b65-c64e-428f-9eff-c513b4bc425c', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:32:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('70739eff-3aef-4477-9b08-02416d4c6216', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 11:08:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('70b7ec9a-8e9a-4506-b396-4d40a8efe9d4', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 16:01:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('70c9e5ac-8f44-4bc3-a8c9-aa329ea6990f', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 21:32:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('71033672-5ea4-4903-8109-59e1c2932e70', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:40:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7103e1fc-fede-47af-986b-4cac99b5f8e9', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 15:51:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('710fbf83-fc04-4784-8c50-2a1393405da4', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 18:03:37', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('711f66df-8b32-4d1f-813f-3db681902226', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 18:10:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7136b5b1-0e4e-41d4-aaf8-084d9050cf3e', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:39:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7152aadc-c913-47b4-a8db-c44bb48199df', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('716fbb18-3461-443f-9d25-c5c980e11935', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 15:27:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('71776abf-026a-43a7-9661-e1b0c9c7c670', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('717b4c5f-496e-4270-8891-97952ed0c5d2', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:00:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('71ba4edd-ba35-4768-9994-846172566d26', '用户访问', '访问日志', '', 'flowschemes/design', '2019-10-29 11:43:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('71f5004d-8606-41fa-998a-5b8eaed6e0c2', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 14:16:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7237c816-02d5-4719-af08-e7d68b707047', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:52:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7245182c-2299-4024-abe6-f997835eaac9', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 15:51:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('727303bf-0b5e-4d2a-9a5b-c41e471f0055', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 15:53:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('72a2e685-614f-4e2d-95d1-d62ec5de663a', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:21:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('72a9ab4e-8f28-4711-a124-600a4cf25d0e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:32:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('72c94d6a-ae8a-4827-b4e2-9bd1bff1aa31', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:40:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('72da3bd4-7b81-49b3-97a4-7d636ec6df1c', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:47:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('72f7ca6b-9874-4cb0-8967-445bdd778d41', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:26:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('732d5570-a609-4da6-81f3-2338ed48836c', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:45:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7342c4d1-d0f4-4fec-b5ae-8bb635cee06c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('734619be-e29e-4e24-87aa-206c06fe3ad0', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:48:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7348a193-9aa2-4f07-be79-5ffd3765da7b', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:30:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('734d9760-9158-4d08-aef1-98f3e973ff68', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 11:40:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('736ad243-ced9-4879-8eb4-5161577ab9ca', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:43:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('737a9a30-cd3b-4190-8316-31f0f756e361', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 18:04:24', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('7384a773-a3c8-4ea9-ae8a-beb5a4eb4492', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:38:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('73a22d08-ac18-4792-b411-8e74b76e7a53', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 20:52:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('73a3a796-7001-4cd0-9405-4d16b5fc5c82', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:04:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('73df9092-3af9-472d-b595-5edf49dbc8bc', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 15:38:03', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('74057c41-5442-49b5-aaad-51b01b0d991f', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 21:17:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('740b6ef6-e3b0-4e33-9b89-8bfaac61555a', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:38:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('74c5913c-6c40-4589-b660-09fc58b461a3', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:43:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('750059c7-64ad-4438-9bb7-4ddfad2ad8af', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('75016230-9f86-44ca-8147-8c57673540cc', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:22:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7504b5f2-25d0-4923-9d33-a34c82866235', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:07:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('753745d9-7fc6-413a-b2c3-24c22bb838cb', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:14:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('75734e6f-c8ee-482d-8cc2-e335bc819d0c', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:35:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('759a44c4-0bc5-4d34-9060-a01bb94d28b1', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:29:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('75b2a9e6-36a5-4249-b087-2a981b5dd73a', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:43:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('75bd523b-0e79-437b-80f6-5884f0992886', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 11:27:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('75bf5fb9-5248-475a-886b-5b45a2e183fa', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:51:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('75e19331-fec7-4175-8125-627f1cf06d5d', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 18:17:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('75f3061b-6802-4f50-9f64-63bb3e7ae073', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:38:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('75f63156-853d-4148-a8fe-05c33e3e8bbe', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:06:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('76a7f93a-19ac-462d-bc0d-dff7aaf28612', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 11:16:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('76c6df0e-f440-4869-a524-1d48f19cabb0', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 22:06:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('76cdc038-170f-4928-8909-565ff1efbb99', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('76d1b744-cde4-4b35-8316-05b642071dff', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 19:08:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('76e54753-20f3-4ffd-8c1e-d59647bc37a1', '用户访问', '访问日志', '', 'flowschemes/design', '2019-10-29 15:52:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('76f38fcf-1793-4fce-93c5-3f71085e7832', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:51:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7727cc83-0979-4798-be86-e7f03fb41c8a', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 19:08:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7764a93c-8b16-42b8-960b-3b9f8c08c112', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 18:16:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7795f79e-67ef-4dbc-976c-6110a17ac657', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:30:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('779e8642-2272-4c06-b301-7b514671be46', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:10:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('77a21603-48b0-4206-9e1a-281a94a9ae11', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:23:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('77b4c46b-ef21-4bfc-8c00-0a8f5535e227', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:40:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('78075b49-932a-4c5f-babb-60f3012b281f', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:02:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('780f0f33-f4c1-45bb-9b42-b2fab8f1c2df', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 16:33:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('784628ae-5afe-4abf-8a8c-1ad97315191d', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:26:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('785e05c0-5326-4f6b-81a2-0b05e04fd66f', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:40:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('788470ce-afac-424b-83fd-c1dd1a5cc0f9', '用户访问', '访问日志', '', 'rolemanager/index', '2019-10-29 11:40:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('788d8f61-de93-4e01-88bd-13a87e69aed5', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('78f6a366-d0ec-452f-be7b-51e474f35941', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('79af4e80-206d-419f-863d-19f6acb1dfa8', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:24:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('79c9566c-db86-432e-8528-ffe93ccd6252', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:48:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('79eee0ec-b19e-4ceb-82af-bd71222e935d', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:39:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('79f26fc4-a4c2-40d4-8fe4-df1dab6640f4', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:04:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7a3d820f-4866-4f72-902a-9ee03685e716', '用户访问', '访问日志', '', 'users/load', '2019-10-29 16:12:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7a5fff47-8baa-4334-a8c2-7f05a2028912', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:04:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7a6d0833-46ed-4fcf-a72d-24094a8d67c6', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 14:44:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7a7b10fa-f46b-4076-a4b7-9c2ffb2fd2d0', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:31:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7a821e0c-488b-4e49-a98e-5a002f32ee81', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:35:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7a887dc6-7241-4d29-9963-6c7179cf5899', '用户访问', '访问日志', '', 'check/logout', '2019-10-29 13:40:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7aa3ebaf-88ef-46a5-ad1a-0b5d0a4aeebd', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 13:38:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7add6836-1658-422b-a0cb-0479dc6dacf1', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7afad2ee-6559-437a-8d19-3dd0e7c7c01d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:47:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7afc8ae5-01b5-400c-a0f9-b6f726911e7f', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 19:43:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7b0c320d-e495-432f-a696-b2fdd57276d2', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 20:58:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7b20b362-2db9-4629-892c-c6ab72c4cb08', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 13:53:24', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('7b31bf4d-5523-4622-9289-1763fbf879b5', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 16:24:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7b6e29a3-9f32-4480-a4c4-89a5a4c4ecac', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 17:06:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7ba99eb8-7b70-47e4-bed6-66f0fb806417', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:51:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7c086a07-8cab-4457-8668-47086dcd1eba', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:02:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7c4c7090-e5e8-4623-a180-6af976f59b84', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 18:17:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7c8e198f-5752-4299-93fd-b309b2a73371', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 22:02:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7ca78431-47fb-4f29-b438-40b4982040a0', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 20:52:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7ca83fe0-8dda-419a-9693-fb10d8443e55', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:25:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7cc5289f-79c3-4139-b337-81321ff3599e', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:06:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7ce62e70-5301-4090-8feb-6ba91b6ecc8e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:35:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7d08a727-5a7a-4eb1-8c73-2eee4d1ae4bf', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:08:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7d479b1d-a7a1-4cd6-8dea-c6be8d0d640f', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 11:28:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7d49234f-ee41-4c1d-869f-50f6f00bd088', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:27:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7d53776e-9655-4327-86e6-d170a3f369ed', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 20:57:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7d62d1d6-8e23-40fb-b302-70473f52333b', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 18:04:59', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7d67f550-8fc8-4ec0-946a-2ffee819cc97', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:08:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7d6e7816-f6e1-4bf8-b7fa-90a844631cc5', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 13:11:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7da35ed6-fc08-4b7a-b76f-d2fd356ba361', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 12:44:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7df7b73f-12e8-401a-b3cc-b033ad39f6ea', '用户访问', '访问日志', '', 'flowinstances/detail', '2019-10-29 13:53:31', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('7e17776a-8a0d-4163-a86d-b985737d7e45', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7e3effc5-8328-483e-91f5-f44b13ef9c39', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 19:07:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7e441ee5-899d-4309-a260-88c8f930714f', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 11:08:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7ea4a80c-3aef-4038-8994-9b1e6964a837', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 17:53:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7ed0e5e3-a3f1-4ca2-91fb-c2d22ab73d5e', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 20:39:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7f0f053e-5177-4ef5-b1b7-872efebe5307', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 17:00:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7f483e75-2da5-4b02-861d-0cc24ffab36d', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:36:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7f62589f-c3e8-4f02-90eb-43cda668cb06', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:49:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7f78fb84-afd6-48cd-9e39-d4a244eba7c0', '用户访问', '访问日志', '', 'modules/addmenu', '2019-10-29 22:05:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('7fd0ffcb-0d12-4471-9228-2460926c75bc', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 17:41:32', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('7ff83ed8-8550-4e63-bea5-392b66ab946d', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:04:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('80019380-0aa4-4fff-87c9-2195fd73bb26', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:05:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8002d634-f5df-4b24-a63a-caaf1daa63a7', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:43:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('80166322-c366-4a6e-9cae-0384b34f1b45', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 11:40:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('80303ec9-6e7b-4143-b21c-105cace752f2', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 11:27:14', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('806ef1ab-b2c5-4a98-a538-3543269095b5', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:09:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('80ab23ad-1cb0-41cc-842d-1f760a5938b8', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:59:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('80bd929d-e0f5-402b-aa89-32b9d602a65a', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('80eec078-bcfe-4f53-adfe-0dae6319e327', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:33:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8115c613-f49d-4b16-bf43-7d778545a3fd', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 15:50:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('81597581-5659-4d6d-9005-c7d1f4944544', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 21:31:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('815ff73e-9679-43c4-9237-86e92f7571d0', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 21:13:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('81bac001-8c88-49dc-a092-68b5a9aa3b79', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 14:44:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('81d5f291-f269-41f0-a28b-5ac508077233', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 15:50:01', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('81eca172-b7cd-4288-a411-33187f24cee5', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:29:24', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('82191227-72d2-4bb7-be47-af30bdc20273', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:52:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('823d2a3d-28d9-4d28-8c91-f0c064a608af', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 19:07:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('829748dd-48f3-4797-89f5-f8949c2dc96f', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 17:05:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('82a3c756-0bd8-48ac-95f7-308d76da61f3', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:03:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('82a3eea1-30d5-4fab-9c60-858da01da4fc', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:26:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('82aa44a2-15fe-46ad-a93e-dfd088dac217', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 17:06:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('82f5d308-3e2f-40e3-a5e4-2f84a3f8a241', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('82fe8d88-84e4-4585-8e43-b0f7f280f0c8', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('835dd34a-642d-4803-a38b-f5f760548871', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:45:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8365bba6-7f52-48c5-a783-29b94aac82c6', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 20:58:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('836dc789-79d3-47d8-8d86-435923d50a86', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:52:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('839f4f25-c594-49cc-b59e-2736a30deca9', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:32:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('83c1e129-5e83-45c0-a271-37d2e459dfc0', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('83e7c887-7f04-4d23-bbab-82ded34f077e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('84029021-a886-44af-b555-c5d13c5b6e81', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 18:16:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8405aa3e-d12e-4b45-8dff-f37367e3a06e', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:23:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8418cf2b-6ccd-4160-8671-74804763c8c9', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:26:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8433f2f9-c53c-4591-af39-3e96fbe5db27', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 17:02:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('84446478-c185-4692-8126-506d6b4b3bf7', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 15:15:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('84981116-fa91-4cef-8b04-ae1d94ca410d', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 19:42:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('84bad6c9-a1c9-45e4-9371-33becf60654f', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 18:17:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('84d96653-e48a-4002-a4d8-fba02d35fc55', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 11:08:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('84e82ced-811b-4430-9859-07aa96c8c768', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:09:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('850545ab-6c1d-4994-94aa-77bdb2d3f214', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:05:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('85081b18-286d-425d-8bc6-00c41d055c15', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 20:22:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('851d7533-c205-491f-836d-5597ac46525b', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:30:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('85287d30-b36d-4ad0-9d9f-5e43c90a0e41', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 17:01:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('852cc7c8-9ba9-4679-aee7-2bd6b2696392', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('854daf5b-04ee-42a6-b63f-ad24b5501f32', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:06:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8596f542-dd4e-4f9c-aa88-1000a17a08fa', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:35:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('85b4f30e-5d4d-482a-8dc3-2306f03feed5', '用户访问', '访问日志', '', 'orgs/add', '2019-10-29 13:41:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('85c44317-0c29-4ae3-8139-4a4a9091e33a', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 15:26:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('85e7cbb5-ed5d-4459-ae65-5107fc0bffbf', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:53:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8616b99d-23f1-4c68-b1c3-b208c71ab865', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:23:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('863ea8f8-95f5-4fdd-b5d9-75bd54d7581a', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 21:32:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('868f9c26-66d0-4719-a74b-5ffc279363d6', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('869d193e-5f71-4e70-a444-90ddf806bd73', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 19:43:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('86ae6298-488c-441d-826d-9ccc723c7624', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('86d06a4e-fd02-49df-8099-3fe658fddf1b', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 13:23:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8702941c-1d66-4427-bb52-d4d46e46172c', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('87446d41-fe8c-4e90-b4bb-a5b39d3bd851', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 14:41:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('87aac004-c4ea-4561-bc74-b799161f26ad', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('87bb4d1f-e7e3-47ff-b602-7db3867a2605', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 13:11:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('87c6339a-8c6e-42b9-b0ce-f79fa67ac84c', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:05:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('87ce0466-d3b7-43d9-9a61-11027cdaeed2', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:24:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('87f81828-964c-4ebe-b150-9da77184c2ea', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 17:21:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('881d9dde-2a59-4c97-9b4e-c25ca6922fb1', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:27:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('882a38db-d0ab-49d1-a14d-197e9874aa2f', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 20:07:24', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('884411fe-0551-4b61-8d4c-7b553732b091', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:16:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('88706b67-5cfa-44a7-aaf4-a7861131ae6e', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:01:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('88785fea-ae06-4d3d-a0f1-1d3d2c781860', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:35:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8893c839-521c-4618-a1c9-5e5e629bf5f6', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 18:17:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('889d9ef2-b0e3-459b-822b-89cb5196dc32', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 20:15:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('88ff67d4-ea39-4c90-b533-38a70435df96', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:17:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('890a0982-c4a1-400b-983b-0de8a0358ca5', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 14:44:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8921e33b-7bfb-4969-ae1c-2991454217de', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:27:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('895a7cce-fff9-4b82-9eb9-907bae7579cf', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:18:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('89675910-3b77-4147-8e0f-49ac774ba29f', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 20:24:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('89d80af4-7eab-4e30-be3c-3f96746e7880', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 13:11:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8a12cc3a-4469-4312-8b29-1184f40f1090', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:08:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8a513b5b-ca9d-4b4c-9615-5fbfe6039d7e', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:09:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8a87390e-b49c-48e7-bd44-ec6e78c0bf0b', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:52:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8a9826e8-b294-4dda-a772-ac268f9d759e', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:37:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8acfd6bc-d7b4-4670-a664-e89fa4350dd3', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 21:32:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8ad6c715-9b56-4473-9bfb-0a04487f5af3', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8aedd399-7314-4308-9958-13f2e59e830c', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:39:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8b192bdf-96d6-4580-815b-fcc5639bca2e', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:30:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8b2fbf8e-4d6a-4dd1-92bd-e664d20ecf1f', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:59:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8b4a0f34-7b7e-47f6-a16e-371c77099071', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 11:07:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8b6ee849-37ed-40c0-9bf8-17721e19060c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:55:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8bd862bd-4623-46b8-b95f-0da0db3db57f', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 16:59:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8bf22973-21f0-4542-9e37-e6a988c1434a', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:01:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8bfa44d4-8607-4fd4-ac79-fe7d43d71ac1', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 11:27:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8c029df5-b5f6-4224-9950-8d90dd116afd', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 13:10:47', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8c7144df-330a-489c-b8b8-303c9a4952e3', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 11:40:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8c7d6df1-0517-4f0a-898a-553f14ce2b1c', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 20:52:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8c84f561-d1bd-44d9-8b32-a0dcdb433449', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:59:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8ccb16ab-6deb-46a2-879e-26d0e71b544e', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:35:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8ce9efcf-dbfe-4228-a070-195e426a4d0a', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:40:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8d3c4162-1d2a-4550-b8e3-b75ff0854410', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:26:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8d5196c5-8406-4ad5-9abd-e1051ed936cf', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:07:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8d6b2e4a-90c8-45e1-9d77-29df66dc1009', '用户访问', '访问日志', '', 'flowschemes/update', '2019-10-29 17:25:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8d87cbb8-0bc1-429b-9399-d188b91566b9', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:25:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8dd103ec-30f7-42f3-b00d-9715ad54caa0', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:40:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8de9f002-6667-4ce6-a8dc-59ad1b148cff', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:26:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8df1b9d0-0670-405a-9bac-9c19117cec80', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:28:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8e0f0b3c-8b87-4cb2-8c0b-502a9c0f65a7', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:05:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8e2d722e-906a-4abb-8fc2-2aa26dc169ff', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 11:41:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('8e300552-1c19-4982-9710-98f563c589a7', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 18:17:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8e551928-3347-4d1d-b1a0-d94dfb126414', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 15:21:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('8e59e2a0-bc6c-4882-8b31-15b133fede6d', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:10:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8e6034da-1c4e-4e4d-8505-e38e69f4950d', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:52:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8e6b82c2-5341-43ee-bcb5-a114604af3ed', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 21:05:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8e7f8864-0306-4941-be67-a3ec8af39404', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:30:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8e88dc23-d854-474a-bdbc-66c8e8127990', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 15:51:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8eaa5a28-8f9a-4537-bbd6-7bda1c082fb5', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:28:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8ebef7a1-0414-4684-918c-479728b6f541', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 13:22:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8eeeb58d-5f89-4dfe-81df-8bd0b765202b', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8ef07cfa-468b-498c-b6b1-bee4e97c452f', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 21:19:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8f4df0e6-9e12-47f6-a7eb-58796fd604d3', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 12:48:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8fb50641-fcfa-4d65-8c8c-3cd4f4b1add8', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 17:25:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8fd1f794-45ec-4e5c-8a50-7f8920be1b64', '用户访问', '访问日志', '', 'orgs/add', '2019-10-29 13:39:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('8fef5daf-5505-4dce-b4a6-8e1c686e594d', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 14:32:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('905532df-b30d-4b96-9012-8aacf073670b', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:37:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('909ef2e1-eb31-454c-9610-d6e30eda2de0', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('909fe2e8-d704-4391-9ff9-e7836fdd8e94', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 14:29:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('90b7fc8c-c337-40f7-9856-0baea29c7710', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('90da04d0-65a0-45a3-86f3-e88296de0ca2', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 15:58:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('90e3530f-1367-4cf9-a0b4-7cbb821cbf92', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 21:12:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('911b1b93-870f-4337-935b-0e07291ba292', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 20:39:18', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('911bffbe-6cee-4774-b9ac-dd7c2a8b157c', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 20:23:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9157e60d-e571-435c-9f2c-9862f986cb6a', '用户访问', '访问日志', '', 'flowschemes/design', '2019-10-29 16:33:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('918a7172-9de1-4d5a-aff4-c6bbbb3cf9da', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:36:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('918c0266-2dc6-4c37-8477-9a9b4c16ab93', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:48:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('91d75d3c-d440-4fb0-ae36-3ac87fe443e3', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:51:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('91f589df-fb66-4919-bfb7-59cecec25d84', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 13:53:35', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('921d10aa-2b4a-4e76-b599-ddcad03600a9', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 15:51:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('92466c3f-3c66-46e9-9d9d-1f3d79de1b56', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:17:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('924c8b7e-eb67-4872-82ba-1bf7f58e49ba', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:08:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9291cd5c-e1c9-43b9-b951-3c40e3f78009', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:15:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('92af7245-83b5-41d5-b897-008c6a916c3e', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:29:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('92df0160-9c20-43a9-8d83-9cf1ba301a3f', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:27:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9314c17d-993d-4132-916b-8446e978b7ed', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:47:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('93280fab-dec7-4136-8de5-40e76a47deae', '用户访问', '访问日志', '', 'modules/loadmenusforrole', '2019-10-29 17:06:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('934af50b-7b08-4448-8422-08b0b608108d', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 21:09:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('93598e68-d649-4ca8-8030-03983126bb66', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('93a125c8-c190-448f-bfa4-f1299b5b37a1', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 11:39:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('93beb37d-914b-43dd-8697-4df6a98aa39a', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:32:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('93d9f089-952e-4985-94e3-ca74fafb272c', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 20:24:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('94044b67-aae9-45ef-9b0a-5b2cf659b981', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('940fa05c-157c-414b-a33a-65ee28fc566d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9412575e-e2fa-4a83-8cb2-7c86c58d9ac9', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('941da0fb-4cc4-4237-a780-b49b3ab80456', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 13:22:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('94311ffd-5ffc-422f-9a09-699b0ab127e4', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:41:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9436c228-849d-4cbc-be2c-ab9b405d303a', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 14:43:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('94380d94-e5ce-46ea-bf0f-0c82fd48c016', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 13:21:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('943efcb5-a396-4ea8-b8a0-587d3a2f2b54', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 12:48:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9475e657-0d44-42d2-abd2-1e86a5be6f9c', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:27:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('94a758f6-9cbf-440f-92cf-88a81d6635c9', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 11:40:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('94bb473f-579d-47c6-ae88-86c2277e255b', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 16:30:01', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('94dd98b7-d27f-4d27-98bf-fc426c0e8583', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:29:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('94eac20d-0809-4fb5-b1b1-7da8bec00ff9', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 12:11:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('950cbe80-8875-4221-86de-5e78c1b99936', '用户访问', '访问日志', '', 'forms/edit', '2019-10-29 11:42:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('951bfc51-ee83-4192-93a0-b2abf9aba2e5', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('95565edd-53e8-46cb-b45c-bd6b5a402e9b', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:07:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('95825201-e36e-4209-af57-ecb39f6bee18', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:40:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('95bb54ba-ae42-4ab5-9742-fff6f2ab9779', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:06:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('95c2c845-a805-4469-a5f0-a6c1933bed00', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:34:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('95eda07d-44c4-4fb3-ada7-345d12b2e950', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 12:46:10', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('95f0f0b8-20bb-424d-9d5f-dceb3f5f2187', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:52:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('95f66282-b8f9-4273-a48f-a51de01fac69', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:45:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('961d8fbf-d882-4288-9c31-4801ec44cb2e', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:17:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('96200be1-30f3-419b-9ed3-3c64f3a881b6', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 14:35:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('962f556d-6e16-4ea7-b893-91dfe57d45f8', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 17:01:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('963e89d9-64fd-4b94-ae15-3aa4a51c3f6e', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:38:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('965be111-d7d5-4b59-bf6c-80fe2689bc5e', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:41:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('96792036-18fe-4d5e-8eec-586eeb0c424b', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:22:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9686d4b4-2b84-4918-b531-516691daf264', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:29:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('96966728-9572-4d76-a0fb-7c70c710574b', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 21:11:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('96cb7f9d-11ef-45f2-bffb-e545e1d5feba', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9768dbd1-30e6-4f71-bd1d-29935c8833b9', '用户访问', '访问日志', '', 'modulemanager/index', '2019-10-29 14:53:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('978174b5-5da1-4b26-b815-97053abc7288', '用户访问', '访问日志', '', 'modules/loadforrole', '2019-10-29 14:45:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('978bcf35-e39a-42d8-8a65-82e89e24fac4', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:51:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('97bc84c9-adfb-4065-8b08-053c94beb858', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 17:03:58', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('97ca0de5-a065-4d28-a657-71ef595d013c', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:13:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('97d2fcf5-60f9-4f25-ac93-c384199355ff', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 14:32:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('980b0d9f-c44d-4bbd-9571-327dd1bb85d1', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 11:38:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('98272cd6-8ebd-49e8-ab86-5454148d1293', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:48:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('98301f37-16d5-48f5-a8e0-0eaa15181457', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:54:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9835f4ca-b102-40eb-bd1e-726bd399810d', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:17:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('98396f43-7fb6-4ad6-8f00-5bb540018a0c', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 15:25:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('98d32fca-654a-4ff6-854f-2b8dc70c3087', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:08:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('98e22298-e78c-4a11-b7a8-e4f08ee781ea', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 13:11:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('98eb85aa-fa4c-430b-9faa-faddb6c84c82', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:28:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9902bccf-0174-4c3c-ba66-b6d6d1f66a32', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:17:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9903b7c6-65b7-4010-b38f-d110c78299f4', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:37:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('99177d7f-40c8-42f1-a636-99e9cbeab82f', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:37:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('99265f8d-ff78-4802-868e-7bc487984b97', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 15:51:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('99359807-06fd-4d30-bbee-50af761664b4', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:50:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9947f853-3747-47a1-8fe6-cb9f16eec361', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:32:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('994846af-f1f4-4c88-afbe-3c5c4a118489', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 18:25:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('99652c10-887f-4f4d-a96d-8baba4468d59', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:54:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('99dbe8c3-d2bc-40f7-931d-04735bdfb4ca', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 11:55:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9a0beaa7-6d5e-4d01-9725-ab5b94cbd1ee', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 22:06:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9a15dc10-7eeb-479f-8cac-10d5b108f1f2', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 11:26:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9a2033ee-4cf2-4ea1-8ffc-812d46073e9b', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 16:49:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9a34b4f4-e5bd-4d45-a49a-9aa31f0f4d57', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:39:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9aab1122-eae1-4c39-a870-d1e0ce910d80', '用户访问', '访问日志', '', 'usermanager/index', '2019-10-29 11:40:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9aacafbd-93b0-4225-9e72-c82f0c3f1f7c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:47:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9acb795f-374f-4a63-bed7-f94619a6efc8', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:02:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9aee793e-1db5-40e6-99f0-90c4dbcf145c', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 18:04:05', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9b06c989-84e4-42e4-81ce-fe62adc879c4', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:16:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9b1660d5-49b4-4860-b7c7-48b966d98dcb', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:57:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9b17a9b3-499a-4ff7-9c98-00ef6e1756fb', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:28:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9b27db30-3f45-4535-91f7-0c59d2418fa4', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 21:31:42', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9b374822-0f5c-4060-a3c3-8c97be74aa16', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9b3bf803-2fde-4dc5-9118-87b9a81b0483', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:25:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9b5f3ece-da2a-4242-a649-d3c292f56ee0', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 18:10:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9b69b269-6921-4a0d-a6ba-0a3654889e5f', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:24:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9beb40a5-9669-4b19-b670-1de451542b8b', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 21:32:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9c30bce1-d7a9-4b60-a8c8-4f6900dc42de', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 18:17:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9c32fda8-f68a-4d21-8f69-7be91305b364', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 16:48:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9c33a7e6-17c0-448a-bab0-3dde76a4f637', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:05:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9c3ee490-7f09-4660-a455-e9482def15c5', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:07:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9c3f3b83-7446-48f1-9fce-987943501a61', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:28:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9c4d0f8c-8d01-4a11-8104-09147fe95421', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9c7d6c1c-d3ff-405d-aa44-651a9e43f41c', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:34:27', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9c90c0ec-c9d9-4b19-87da-38716f89858e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9cac069c-f246-4f0e-bb09-ff0391a5e973', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:58:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9cbe3d5f-05b7-4a77-a36a-4c254dedd5fe', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:49:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9cc5218d-c102-40ab-8a0f-b67c435cb4c4', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:09:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9cd25976-7edb-4174-ba43-696f1ac01161', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:35:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9ce15d9f-4569-43f8-82be-7aa9f6d802bf', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:05:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9cf9f313-96ef-47a9-b309-099ad1dd4d5f', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:33:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9d08cb65-825b-4ae6-be13-24659b02d21b', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9d188c14-f095-4eb5-961d-77a956be6c73', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:50:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9d1b63b2-57c2-45b1-a2ed-58d4a615fef6', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:50:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9d5e9994-2e0b-4567-a5e3-76567efbff2d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:27:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9d96bc0a-1a00-4b8b-9553-2ce998bc46b9', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 16:30:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9dd08d32-67c8-495d-995a-11584f14144e', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 18:16:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9ddf02e0-68ac-4873-9158-c026c760e2ae', '用户访问', '访问日志', '', 'forms/edit', '2019-10-29 15:58:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9de16b9e-f8a5-4f3b-8a7a-3f6b214f0de5', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 16:30:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9e262b98-798a-4f4e-b963-ec1ccb460009', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:28:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9e28461c-6268-404e-8491-2846ca0f92f5', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 15:48:53', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9e30a9dc-0b4f-4733-ba10-99894217e7b7', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:32:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9e61ed65-ed49-4fa4-9f58-65589b8e8b28', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 15:29:47', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9e62e58d-b714-4139-81f5-17bcb0188f78', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:29:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9e6cc546-890f-477b-9fda-fc475a9b538a', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:09:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9e76e2b9-d856-4eea-9bf4-8d103b1a1886', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 14:32:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9e8ab1ef-ac58-4052-9f41-fee98893d7bd', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 18:16:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9e970a83-71f7-40b9-9e65-5b4f6ab6fb5a', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 20:07:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9f3d82fa-91b2-4d53-809b-4c9c3b007efd', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9f5f1bb6-23a5-4f73-9a00-8a96b1f6a8e2', '用户访问', '访问日志', '', 'modules/loadmenusforrole', '2019-10-29 14:45:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9f8049b6-350a-413e-ad6e-bfcfbb191e46', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:06:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9fb1c73f-8c94-4203-a13e-24f4f4ed17fd', '用户访问', '访问日志', '', 'flowschemes/design', '2019-10-29 15:53:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('9fc1beb4-2253-4d63-ad1b-742d0e728078', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:30:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9fd753bc-58b5-4b12-83df-c442fc92ee76', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:00:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('9fe197ff-7c9c-4803-a548-02b02abdf600', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 20:23:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a0051804-d49b-4f0b-81c3-efa5f4430336', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 22:06:32', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a00a0be5-0247-44ef-bf2d-b854058ea206', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 15:34:27', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a0492a64-b435-48b7-9239-81b45df8f1df', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:37:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a04e18fd-a13e-4c93-a90d-642671154589', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a0554df1-12dd-4c3a-a5a7-6803903f140b', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:30:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a05a50c2-f0a7-4e35-b14c-9bc27560739a', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a08fa6b6-2932-4085-bc45-960307092171', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 11:16:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a0976c68-e816-486a-b31d-a76ef47c7c6c', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:04:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a121b8c0-08e8-44de-8c5c-cda1c0c4ceb7', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:28:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a12500c8-41c3-429e-915c-3e5c71754b2e', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:00:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a15c2f4c-f451-4dc6-bd42-9fa484bd15ba', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 16:33:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a170811c-14b8-445b-bd6f-df52e45c0e08', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:51:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a1e44bd4-ee99-43be-8df7-51aa897016db', '用户访问', '访问日志', '', 'check/logout', '2019-10-29 17:33:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a2225c8d-a96e-47b8-a07f-3ff536db748c', '用户访问', '访问日志', '', 'modules/loadforrole', '2019-10-29 15:27:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a24c343c-a999-412d-9c12-4a14bcac85d4', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 15:26:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a25681a1-798b-45d9-94ac-f83de59cfd4e', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:26:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a2ba15cb-d671-4abf-8ee9-26b4d7345e4c', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 14:20:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a2d28b1f-454c-42da-924d-26a84c4a72b0', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 12:44:24', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a2e51f6f-53dc-4bae-889e-a81ef7f7bd58', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:24:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a2f0ae4b-7369-4f20-a225-867c2f2a955a', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:15:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a2f7489d-0162-44e5-b196-586db22d1a34', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:30:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a30dd065-acc8-4632-82a2-8ebdd93fbb93', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 18:17:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a31beb01-08eb-4b5a-ae55-47dcb430f1bb', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 14:54:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a33ce3e9-641a-4df2-b00a-4ff44aa45412', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:14:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a344fa0a-54cd-487b-a0d0-a909745d3d32', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:27:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a34b7786-dfd3-4d08-81c0-bcf452a846f5', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 15:54:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a38e798b-2ab1-4e2a-8d6c-f297a9e97d42', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:54:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a38fd760-25e2-4acf-83d6-792d0203c324', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:23:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a392786e-5f8a-4549-b638-fc7272f9ae6d', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 15:51:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a392c733-3b71-41bd-b41f-06df61ac26ce', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 11:40:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a3adedec-558a-48d7-9fdd-9463298bf86d', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:28:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a3f20669-cb14-4d16-8fee-223c0b6e026c', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 18:17:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a4092b89-0a75-44a8-ac31-4791e0f56a1f', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 17:01:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a43e4c06-6e8c-48c4-97df-262803fdbb52', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:52:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a45a362a-0c78-4ccd-b88e-3f59448f2580', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:58:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a4d11b19-fa76-4712-b7d3-eb274e30f43f', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 20:14:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a4ea2405-ddf0-40ee-b953-d0565884eb13', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a4f0d18a-927d-4220-8638-deb67d4b7db4', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:45:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a53cfab4-dad6-4fb4-93a4-573df0fd6350', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:59:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a5582dbb-ab0b-43c8-b543-5e26f6f11b06', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:30:14', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a560014b-1ab3-45e7-b3ef-98ddaa589c35', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:31:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a566c410-d911-483b-aab1-6163fe408b6c', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:49:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a56a5387-3ccd-4671-9ca4-ee9f4b725363', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:43:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a57dea35-f49c-4994-8aec-745f750a6852', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 18:17:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a57f2a93-02ff-4edc-b0a3-08be2c46fddb', '用户访问', '访问日志', '', 'flowschemes/nodeinfo', '2019-10-29 15:53:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a59c9e87-b3de-4dd5-8dd4-45ef63ce5a4f', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 17:02:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a5d13c5c-d9e7-411a-b2f2-5535e36394a8', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:36:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a5d53537-b3e1-4260-85ef-09b1a1438c0d', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:12:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a600a677-c725-4919-9a12-d46799c73b6f', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:05:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a6347739-b438-453c-a6ee-048518700305', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a64d2fb1-d80e-4da2-86bb-208236d3797d', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 17:02:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a656ec3d-4922-4f15-aa9b-6af97f379902', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:43:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a6584302-1552-4317-aaf5-8908f9702071', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:22:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a65a2319-17f2-4024-8630-2142fe710345', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 21:09:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a6c0b43b-55ac-4a4f-8058-033332ff82dc', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:51:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a6ca84c1-93d2-4002-9c1a-f8595a0ad382', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:15:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a6de0bcd-4ada-41a5-87e9-0178d07c6f3f', '用户访问', '访问日志', '', 'categorys/add', '2019-10-29 17:12:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a704850a-72c1-4773-8b62-b7a550bce63b', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 11:27:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a776214a-b96f-4232-aa42-5eec57318578', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:52:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a7a0a33a-e7b0-4ef0-a24c-97c49a17b1cb', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a7b4c21d-9220-4bcf-8a24-e61eee4178dc', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 21:58:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a7b50a62-f3bc-422e-a51c-edbee376564a', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 14:43:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a7b9262d-09dd-4ff0-878a-eea3c01f8768', '用户访问', '访问日志', '', 'flowinstances/detail', '2019-10-29 15:53:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a7c07c97-b330-428b-8f08-cc054d9b7b5f', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 18:16:05', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a7ce73f3-530b-4659-87de-995c81147fa0', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:36:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a83540ba-69e6-461b-aad8-cf9f6af877d5', '用户访问', '访问日志', '', 'flowschemes/design', '2019-10-29 15:52:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('a8596718-b0b4-402f-be82-fba1809c6a08', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:08:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a860b617-c4d3-4173-bae1-e7ce07eca87c', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:07:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a876de43-1632-4525-8d1b-1dc7a14b2cc2', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:35:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a886f5bc-99a7-47e0-9d32-5e2fba12cf80', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 21:32:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a8d57db3-9f05-4ec3-b15a-b5101d41a647', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:28:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a9c3540e-cec3-41d1-ab94-a16f35c43f80', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:24:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a9cded85-dc9d-4720-804f-7c8fd3c96d01', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:52:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a9e7fa4f-9c9b-4b09-a357-3f821512d9d8', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 19:07:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('a9eb76ea-139a-4c2c-a421-56cd660b1004', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:14:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('aa396d67-f9ce-4a4b-9027-74f0ace2a342', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 14:45:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('aa913147-35b8-4ee0-9eb3-0032af3187fe', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 14:45:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('aa978907-31a2-414b-96e2-265f68c7237b', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 18:25:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('aad01691-123b-44e6-86f7-da991aefa093', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:01:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('aaf7de94-a433-445a-92f2-ab847926577f', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:13:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ab255278-9be4-4d7e-b49b-5472cacdc7bc', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:06:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ab32afca-d0e1-4862-b9f8-31b76a8117c6', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 13:23:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ab4fbeae-289a-417e-a0e5-1aca28f2b86b', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ab50bc4a-8f26-4b63-89d8-135d50586534', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:27:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ab5ec626-91d4-43ba-bcfd-55ac86730b1c', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:29:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ab5f0761-3ced-49f8-9834-810edbf4b86c', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:48:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ab6e7595-f99d-42c7-b50e-44e178203e06', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 20:56:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ab74063d-85a8-4173-938f-89279681c3e0', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 17:02:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ab7422a2-2931-4445-92d8-41b6f77de17c', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 18:17:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('abcb0c55-a5b8-45ff-8776-ace14e19dee0', '用户访问', '访问日志', '', 'users/load', '2019-10-29 21:32:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('abec1035-6010-4de0-ba9a-f01df01aab47', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:51:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('abf2e726-be5c-44c2-bdca-4173a74ac75b', '用户访问', '访问日志', '', 'orgs/delete', '2019-10-29 13:40:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ac303488-aa08-45a5-a221-aa0b29023d76', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 15:51:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ac4bc0ca-9c25-47ac-8eb0-816e29c02b3b', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:26:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ac646f91-825f-4ef9-b5e4-1f5fb2021fdd', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:53:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ac6e4763-a05f-4ddd-9af7-bef845f57318', '用户访问', '访问日志', '', 'roles/loadforuser', '2019-10-29 14:18:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ac7d6e3a-76cd-4cdb-9aa7-12dbb88d25aa', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 19:43:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ac937ebd-0376-4d6b-80c4-90ebe9ca5ac7', '用户访问', '访问日志', '', 'users/load', '2019-10-29 20:51:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('aca7a004-b800-4260-9089-5eb8a0ea7e96', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:37:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('acabb138-86c2-4ae0-85f7-bce2d24fff70', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:51:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('acd3e93b-52e4-4738-862c-164206624b3f', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:59:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('acda2759-e889-4550-a566-d3b32d42e002', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:22:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ace443f4-d6a7-4d75-9511-3e2a92f68b4b', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:40:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('acf2b02a-b727-4d25-b621-61dc0e18124e', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:54:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ad23d437-073a-4d22-b6b3-0049ac169dac', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:35:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ad23f815-ca79-487b-9af3-33c98fabc1fb', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:22:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ad5eea3c-d3b7-468c-b119-96038550a853', '用户访问', '访问日志', '', 'accessobjs/unassigndataproperty', '2019-10-29 15:28:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ad8e02c7-bf79-4cb6-879e-806fe09326c0', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 11:18:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ad9d0ab3-1375-420d-8ee0-36f9ec38583c', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 14:31:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('adb400c5-32d5-4248-b2f8-df1f803d1d6f', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:08:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('adb884c5-43b6-4819-b8b7-4cfb2b65ea7a', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 17:05:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('add1e8d3-7ee0-4455-9ea1-0a3434202c82', '用户访问', '访问日志', '', 'orgmanager/index', '2019-10-29 14:54:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ade482ba-b37c-4f28-bce7-a398e813d952', '用户访问', '访问日志', '', 'accessobjs/unassign', '2019-10-29 15:28:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('adf36acd-8db8-4a4e-8a8c-513488ff60ae', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:06:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ae0b4367-f3d5-4ee9-bb3e-4d0d2cde4755', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 15:30:15', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ae132cec-50cd-46a7-b92f-21c7009d2ed4', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ae1404c2-64c4-473b-b5df-f3f221079428', '用户访问', '访问日志', '', 'rolemanager/index', '2019-10-29 14:32:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ae20133d-e52f-4371-a17c-cafd749cc64f', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:40:12', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ae4c4d0d-7004-47e4-a108-91c729b3c995', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:04:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ae5a5c46-5f85-43b0-a9f3-1fe8385909d6', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:52:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ae80a97e-e1fd-4fd7-8cf6-28d4734068bb', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 17:06:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ae988f04-7839-4f61-a4a3-acbd71ffcf13', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 11:30:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ae997339-84c4-4fc5-99bf-42fdb4c9cc4e', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 14:28:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('aeb5c821-deb7-4d35-8456-782405ab1eef', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 11:08:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('af01562c-2f8d-4a7c-84d7-9f8c206607db', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 21:32:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('af3f69e5-dcea-4eae-a97b-d713d0307df9', '用户访问', '访问日志', '', 'users/load', '2019-10-29 18:25:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('af404820-21f4-4cd0-8f18-be9d5d6e825b', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 20:22:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('af892195-36d2-4a36-98ff-a885a3d0c1ba', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 11:17:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('af9cfa10-5100-4fc1-93c3-eb997157f841', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:29:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('afc8b9a8-5478-4f8e-b7f0-f590f4ae7612', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:59:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('afc9fcca-575f-4377-9d39-0c7f31072e4f', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 21:07:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('affca08c-0b05-403d-840c-0c24c6d42536', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:23:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b01197fb-543b-4e8b-a059-ebde211f45cb', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b04b6725-46e4-4172-83ec-784c7afc32d2', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:40:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b05d6edb-a064-4aae-8bc0-dcbf92e5d3db', '用户访问', '访问日志', '', 'modules/loadmenusforrole', '2019-10-29 15:27:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b060923e-62c8-4a8c-9ffb-be43584a9912', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:08:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b0668db2-3a61-4030-b74e-a9feab2984e6', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 13:35:56', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b0680035-80c1-43ce-a59a-3f8a799059b2', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:38:04', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('b0682c8c-d38b-483c-aa97-e3cc4591b1ea', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:51:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b06f1425-cb53-47fc-936a-1a0b07fd6784', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 16:30:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b09252cf-5522-4f11-9d77-2e58bacdffe5', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 14:31:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('b0a335d8-f653-4f15-83ff-94857658b285', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:12:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b0d3e328-706a-4c72-ac40-223c30cca662', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:46:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b0e05dd5-5f93-467c-be41-b10252dc1d06', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 21:58:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b146c83c-507e-4074-8493-90f4d709b618', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:28:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b15e1618-dc08-4405-b2e9-228bde98d9e5', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:28:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b1725747-91cb-4b24-acbb-858e951704d3', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b25ad885-b636-4bec-a564-2592ab03ded4', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:40:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b25b5f31-083a-40e3-ad63-03985180c9e2', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 15:53:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('b25bd1e0-ef0c-4864-896e-3ebbba6c2147', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:52:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b2b6f264-60d7-4592-aff7-cfa75da7157d', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 21:32:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b3559200-392d-49d0-9be4-8f27d2330b04', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:00:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b369991c-d4a6-4619-8754-43b5972f925d', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:52:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b38fba03-b6da-4a9c-a4f3-29acbb94653e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:30:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b3a83d63-1283-4739-b22c-60c7c17f53d8', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 13:10:17', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b3ea11d0-d3b3-4a29-ba93-0f92f03fb5a9', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b3fc1fa4-767d-4da1-9558-61f39a126ed0', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:23:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b414b900-8a20-4844-af6c-87b6f30de7ff', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:37:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b422393e-ca1f-4cd5-9ce3-fcd4db07d410', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:06:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b47fab16-214d-441d-bc52-3d4fbeb57ea9', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 15:34:26', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('b4a116d3-989d-4cc9-81bc-4dfc64dcd8ab', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 18:17:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b4dfef5f-6066-43dc-b4b3-1ee62e568b09', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 14:17:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b4fbea07-8598-47e5-b9c3-2cc7c9b938e5', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b606436b-2688-4bbf-8a2e-8baeba9d642c', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:26:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b60c6aac-7e28-4cf5-b2a8-c11599699b9f', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 20:52:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b61ab641-0de9-40fb-944f-160d4004ddbf', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:25:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b6401369-3285-41af-a907-fe0a1fdc5d0f', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 14:32:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b6486c40-c25f-4c9b-9b32-03bfebaeccaa', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 15:24:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b66b2c33-ee46-426d-b75c-c9809098f250', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:45:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b67af40f-eb09-450f-8ca0-af92fcff2abc', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 14:31:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b6930f6c-c41e-43e2-8995-0a5dfdeeef16', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 11:15:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b6cd8c8b-ac2c-4ae8-a2ef-1d60cc66142a', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:30:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b6cf68d9-fd3a-437b-b727-76001802d562', '用户访问', '访问日志', '', 'users/load', '2019-10-29 16:12:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b71aa700-38c6-46e0-b8a8-ba16bf4b134c', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:36:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b7939117-40e7-4212-98da-b9255e2623a7', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:32:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b7b883a8-661a-4383-86e4-e52a49e993a2', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 15:27:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b7f0a6fe-d100-44b3-870b-b1f728ea5b4c', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 11:40:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b7f7b971-08de-4351-b26f-e35f6bcea0d0', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b80fd26b-1e49-4594-a171-dba2100ed90a', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 12:40:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b842201f-b885-4093-b10b-74a167804dd2', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:48:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b88b31a7-27b4-4e1f-820c-a16524356030', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:43:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b89911c6-52c4-4b46-b29b-fbfc82c26bb1', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:27:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b8fa8c8e-6ea0-4887-88f5-f42fdb8e2d97', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:38:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b9271986-e082-4ad7-9f71-573e13511498', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:30:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b956a23c-8687-4ba8-a093-9bcfaca299cb', '用户访问', '访问日志', '', 'forms/delete', '2019-10-29 19:07:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b9c7fcb7-29af-4adf-b5c8-f46e85b00aba', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:37:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b9ed6a72-5893-4901-815d-40f464dcbe25', '用户访问', '访问日志', '', 'forms/add', '2019-10-29 11:37:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('b9f1f409-824c-4ce2-be56-a2b548c30001', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 16:30:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ba21827c-302f-4c77-8459-0bd02e28c35a', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 14:32:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ba4f2d53-6d0a-44c2-b0dc-9e02d5988efd', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:40:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ba67dd0a-d9db-419f-b561-416f51394f74', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 16:24:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ba780210-e4aa-4b12-b5c3-9673c0d8406f', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 21:13:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ba9fc1d3-d8fb-4fa5-9083-b6a6f404c3e0', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 13:11:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('baa4ae36-bae9-4923-8701-23f1c7b1e123', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:44:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('baa51680-a39c-43d1-b63b-51593ca98ffe', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:24:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bb029b3a-a631-4f15-8cee-a3f3f1829fa6', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 21:11:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bb231a1a-905a-449f-b539-e92562a467e1', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bb673bb5-0c57-42a3-ae8f-9fc91f77a865', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:59:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bbd71919-f393-4cc3-a91f-16fcf35e3626', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:09:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc085edc-5bec-4645-9bc4-47d3c5702961', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 11:15:11', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc47d88c-7ef1-4fe6-9ff7-51af5fdc7702', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 11:08:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc48a950-ce41-410a-9cfe-9fe5ffb03bd1', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:09:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc49bc37-b175-417d-bab3-62b0e29eb1fb', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:50:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc4ebfe5-efb5-412b-9839-3a919bb6461c', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:33:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc690d78-ae30-4923-806a-8e83e2542f69', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 15:16:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc85cb45-7ed1-42ca-b710-509b08628ba6', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:44:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc9cdccd-b594-4720-baff-c05bf4a4dcc1', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:28:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bc9f2b98-d1fb-4970-acc8-d2129a2461aa', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 15:54:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bd04dded-d59d-4bcf-b4f3-990552e9fa9c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:45:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bd1149a2-685b-4055-84d6-08527659c54b', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:33:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bd22e0e0-ce3d-445a-ad85-2df710225882', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 18:25:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bd42b2bf-6946-4e46-bbeb-55533c2378e9', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:30:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bd697f1c-ef2b-47d5-87ba-c030908e0122', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:47:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bd6eb369-b534-424c-b39b-7b6247cf9b4d', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('be180032-4838-45b1-941e-7e671ff75151', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:16:36', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('be35fb1d-bd48-4a8e-926a-2b6375b1f1a6', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:29:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('be37f9c0-f0bd-433c-b220-ef442853dbe7', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:57:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('be70936f-1b7c-4fc0-8a3a-1272688ad1cc', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 20:58:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('be722c45-9c7b-4ccd-a6a6-01e38527201b', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:09:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bf02214d-ad7d-4faa-8ef3-03020793723b', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 11:55:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bf2d13a5-4da4-4b1c-8a96-a9f970faaf1c', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 21:12:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bf41fdf0-33a7-4678-aa62-891795537555', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:32:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bf42628e-ffc6-4f05-a041-869f5cebd9e4', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 15:39:17', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('bf7c29db-9c31-4a31-86e6-3e4594bc157a', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:01:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bf98ae23-f82e-4e9f-8c22-990edaa10eaa', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:27:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bfb3f1eb-95d7-4cc4-813d-efcd52f4f629', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:18:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bfcc3670-3746-4f6c-87b6-6cf241eed1d2', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('bfd4b4c7-7a71-4d8a-939d-d500208b3c7b', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 15:26:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c011e4cb-fe0c-4da3-8536-07e0a940b5a4', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c0392320-cefa-4644-addb-3c1fecaf5e4d', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 17:38:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c05c2593-9cab-4c0a-83ac-90b8f59926cf', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:41:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c05cf723-be94-4620-8b64-b8cfd1ef6f46', '用户访问', '访问日志', '', 'forms/index', '2019-10-29 11:41:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('c0834489-6702-4ad5-84a3-83350ce0fec1', '用户访问', '访问日志', '', 'users/addorupdate', '2019-10-29 17:05:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c099cdb3-e5b9-4f9b-9261-e1c55fda19a8', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:45:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c0e800bf-1bd5-4c88-bd16-899c389b82a8', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 14:34:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c103cc64-9095-41c2-ac38-e02bf2f9d182', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 20:09:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c15cc17a-8ddb-409e-b11e-2ccacbb3a7fd', '用户访问', '访问日志', '', 'users/load', '2019-10-29 16:46:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c179224f-29a2-48b7-accd-d0c621df346d', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:14:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c1ed054f-c07a-4c15-ad8a-8acfd9339608', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:22:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c214a863-c683-4762-9f90-6044273490cf', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:38:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c2453acc-da85-4a4b-8e77-6ed6e634d781', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:16:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c247f8df-bff4-41a5-9cbf-e1a0784ba70e', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 16:11:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c249c5f2-c817-474b-9001-3c47b4486ef4', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 11:28:52', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c25364d3-0eb3-4030-9061-56b4411bcbf0', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:27:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c2564896-b489-4b05-80d8-94e7af221601', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c269e7be-b295-47f9-971d-2bdea954afdf', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 16:45:40', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c277699f-0320-485c-a224-816a98af287e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:52:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c2877fae-8309-4883-90cd-7af23102882b', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:22:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c2a3394a-16b3-44bb-a11e-cf535f43304d', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 12:45:56', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('c2a4c084-567b-4b20-b9e3-9a50f5863391', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 16:25:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c2c847a8-4285-49d3-8263-2921205dbd21', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c2fc4929-1728-4b33-8582-fb49380feb12', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:41:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c30e44c3-57dc-464d-8571-d7683261cae4', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:16:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c33438f0-8c95-42fc-bea4-f5aeb736db37', '用户访问', '访问日志', '', 'modules/loadmenusforrole', '2019-10-29 16:59:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c337407b-75c4-423b-8760-9fe408643ee3', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:30:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c340c451-788d-4874-8107-e48a0051bdbf', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 17:22:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('c396d683-6892-4eba-a499-5b7e64de4846', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 15:50:38', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c3b03b2a-f07c-4987-954d-780680cacec4', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:35:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c3e3be8b-6179-4c09-a88f-44af194f6dcf', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:32:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c3e7720c-0c17-4bcc-a7a2-12c367ccc548', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:47:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c3ebb0b4-127b-493b-9a57-28dc576eea2b', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:33:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c417a27e-74b6-4b71-a735-c587f28ea211', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c44f7de6-717b-4b0e-b6eb-ad138f9fca53', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:33:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c45df6ff-ec50-459a-8c50-ec2b0ee66b5e', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:26:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c4721e17-fc1c-4638-9711-eef44d700f2b', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:37:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c4b338ac-0e18-4964-83c7-d8799f923f6b', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 12:48:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c4e7ec61-ada6-47e5-b063-f52bbdd356c3', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:05:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c5166802-d5fb-4361-8f3d-d35c15957664', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 14:44:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c5718a50-98fa-4d94-8477-50bf80853226', '用户访问', '访问日志', '', 'users/load', '2019-10-29 18:17:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c592a686-15d7-4b15-b850-09883702859a', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 13:38:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c5ca0aa9-e6fb-4099-a3b4-8d9b4e2aa104', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:05:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c5fa8274-386b-4397-b06f-d1ebf1cbdc29', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 15:52:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('c6334797-e493-46c0-9b4d-66dfd147e42e', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:40:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c64ecc8d-8a31-4a2e-8757-4e145ae97896', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 15:26:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c6b66be7-2ce5-473c-b68f-ae5984290689', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 18:25:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c6e290ed-8973-4888-86cb-ad9c1667ffb6', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:01:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c6e72286-bab5-4f28-bbd2-ccf83d2e993f', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 14:35:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c71dd09a-7adc-4e55-8f21-bbe6b1d1b4ba', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:16:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c72deb1f-126e-41a8-9db1-c9a0dbedf4d6', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 20:22:17', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c72e8725-92ac-4723-b562-3966552c93a4', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:47:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c7526475-c785-45d4-8fb2-e15ffb132b79', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:08:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c75468ff-e517-4d11-806a-3edc49acd688', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:45:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c7645034-903e-4efd-bad4-eca8fd28b70f', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:26:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c7811e7a-a5bf-47a1-a809-2e3af7e5c704', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 21:13:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c7bf6d40-4d18-465e-8676-b891cd2149da', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 11:16:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c7c0abaf-7d91-4658-8695-61c9e46a2941', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:16:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c7f6017e-05c6-466e-ba70-cb374ea4f85e', '用户访问', '访问日志', '', 'modules/loadforrole', '2019-10-29 17:06:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c8333485-6cbd-4fe5-bbd9-defd37e27c48', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:26:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c88b7522-3512-4bcc-8994-bf3c9792e8a9', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:40:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c89041ca-6c30-4084-8cac-f58828aa38ba', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 12:44:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c8c95d48-7b3f-4c04-90e1-47e3a624c549', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 14:44:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c8f9acff-3241-481f-b76d-d3d6b92a0de2', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 14:32:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('c921a266-6aff-4b27-9323-9dcceef8548f', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:43:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c9d6a25d-782d-4990-9b5f-c0632e21b7fa', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:07:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('c9e3a115-fc35-4fb6-b4f6-6f884df35a1c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:45:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ca1a138c-8bf7-49c4-a534-e751ee8eb7b3', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 19:18:23', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ca282dab-2304-433a-a528-2793d95a63f8', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 13:52:58', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ca7862dc-b236-4cd7-a394-9fe2cc6477db', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:51:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cac0d2b8-2ccf-4d7e-98c7-fca2b57eb339', '用户访问', '访问日志', '', 'flowinstances/detail', '2019-10-29 15:17:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('cac3f7e3-7b1f-4766-85cc-bd2388d31a9b', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:31:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cacc1c29-d1c1-4c45-956e-7e4ad54f3a90', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:51:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cb108e2c-5e72-44a4-8db8-fbaf4b025d51', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 15:17:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('cb6b4c96-b6e2-41bc-b094-6854b237c8b6', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:22:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cb725fa3-6fc2-42ef-b45a-207d7faf5a15', '用户访问', '访问日志', '', 'accessobjs/assign', '2019-10-29 17:00:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cbacbee5-d05e-466a-b3d2-08cc94953221', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:58:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cbe7de7e-e72e-47a6-9d48-4d530d9b20c5', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:28:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cbf652bf-fe96-431c-9012-e1afb40d49d3', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:05:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cc128d21-839c-4d50-b2fd-7660b882b3ab', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:25:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cc14502b-127a-4d79-a82d-c49e5b689d01', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:16:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cc8e8f04-12b5-4171-8db4-1097c646ac63', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:28:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cc95dd64-db09-4377-9e4c-7ea95695669d', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 20:23:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ccce307d-7bb0-4f74-80e8-a11e17dced39', '用户访问', '访问日志', '', 'accessobjs/unassign', '2019-10-29 21:13:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cce2bb4e-389a-4654-b782-a72a70370e64', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 13:11:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cd576761-254f-46a1-b827-8c61665151d2', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 21:20:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cd630d8c-d153-448f-b09d-dd514d73cda3', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:51:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cd80cd60-3b78-4edc-9e4f-73701214d747', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cd9445ea-f777-44ba-9018-ffd47b2e8aaa', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 19:18:27', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('cdc9ef6f-13e1-425d-ad18-e1911fc05dca', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:55:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cdd7b1ad-063e-45f3-81e8-034cc21c2efc', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:29:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cde71458-b031-48b4-948e-f74dbea337e7', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:23:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ce0b01d2-b0f4-42b2-8ac3-7dcf48a5e8ad', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 18:16:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ce3ce6dd-0f7f-4f2a-9d05-3d9cd85c7fc1', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ce59a3a7-aaa6-4166-a865-ab46f9623f89', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:13:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ce5c1529-9e10-4e46-a79d-d50b64b6d86d', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 20:24:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cec1fbf8-a552-4995-9d28-c3bcaab1efcb', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 15:24:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cec92e27-810c-48b2-b0e2-7437047a3473', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 18:25:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cecba1b4-866e-412c-8df6-cb42a946ab44', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:37:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cede2c89-b6b7-4c8d-8df8-d70953a8cae9', '用户访问', '访问日志', '', 'flowinstances/edit', '2019-10-29 15:29:50', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('cef17417-9500-4500-9c76-72ad6027bd9f', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:47:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cef63380-9ea9-43a8-aad8-b5c8c678003b', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:29:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cf0d3948-67b3-4141-a3ea-405c2144f533', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:25:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cf3384a2-b0a5-4e66-a900-cefbd0af4642', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 14:17:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cf422f8d-9558-4cc3-a215-9df11c82863d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:17:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cf57a733-cdcf-4c5d-be81-1acace8f7c49', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 14:53:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('cf5eafef-9d47-4e5e-941f-531e92863be5', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:00:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cf5fa00e-bf56-4082-be36-e8dd0fc1a80d', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 13:11:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('cf66dcf2-7d7c-4b4b-ba97-00e335c6b5ce', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d01d4bca-0148-4a7d-af12-00b5e6884e9c', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:58:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d01e949f-d1f8-47b7-8e49-ab0dbace995c', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 17:52:30', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d0346328-2dee-4744-9874-c45faa2a0daa', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 20:57:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d0ae3706-ffc5-48e5-aec9-d6c4ae4a206b', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:39:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d1077d41-2ed3-4dc1-9d92-cf99a95eba11', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:23:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d11a6462-98fd-4a90-8374-51447c953bb1', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 18:25:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d1319419-661f-4047-9de2-60fe2f056aa3', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 18:16:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d14ec520-00cb-4b83-bf54-db1c4ebe33e0', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 14:02:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d1a43294-74bd-4f11-b873-6bc7cd944715', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:38:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d1b248e1-2561-475e-ab89-6ae4c7a69b98', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:43:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d1b60e2b-d06f-4a7f-b883-c6d85423ad60', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:11:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d1c84851-5f57-4ced-b83b-6e3afdea3da1', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 19:07:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d1e666de-c41c-4600-bdc1-afa7c42e30a4', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:09:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d1fea3ce-20d1-4eb8-8a63-fff21ca94e08', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:09:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d2299a5d-ea3f-4ab3-a0c0-04a1938879b9', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 18:11:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d23cd50a-3034-4c53-ade5-dfb9c754d01a', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 16:08:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d247fa1e-21cf-4d4c-8924-bbf943807742', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:37:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d283451c-e4be-4958-8fb0-24884efa0344', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:38:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d28699de-930c-4c8c-9c7b-fdd09fcbd7e3', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 17:06:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d30077e9-dce8-4998-8e5d-afaf94c40b75', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:30:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d388f6fb-d882-440b-b2e8-69b5ab769838', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:28:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d38b042f-a3a1-4d8d-adc8-69fa039a85fd', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:48:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d38d0e35-4ad7-45dc-94ff-cdd2cedc6f00', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 14:35:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d39e839b-f500-4440-913c-76d3793d57d9', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:46:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d39e8f65-0ab6-447d-99e1-3b79d737c306', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d3c7ca93-088e-493b-89e8-7465c1ed0171', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:16:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d40213ac-b484-4e60-a42f-57952d1380b4', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:25:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d408cdc7-e0d3-4ea9-a396-467029b2a602', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d41ac890-5bdf-41aa-a61d-b6d5d88b7bc8', '用户访问', '访问日志', '', 'users/load', '2019-10-29 16:01:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d439ea2a-7829-4abf-95f3-39b385a612f2', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:40:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d4453a30-b830-4282-9290-5e0c044f7494', '用户访问', '访问日志', '', 'check/logout', '2019-10-29 22:06:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d4dea964-f690-4665-87de-925d5a442f8d', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 16:11:15', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d502f74f-6749-4205-8deb-8e0c2256faff', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 20:55:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d5274ffc-d8f4-4126-b10d-e21a79e3c9d2', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 16:24:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d52e18c8-91e1-410d-a226-8fa3f18bbd94', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 20:23:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d530a73a-40b5-496a-951e-2facbe1daeb0', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:27:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d53ee26d-ded1-48bf-851c-74c0e0da512f', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 15:51:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d58f122b-81c7-429d-8f68-8d13dc0e94a5', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 11:16:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d5af0035-669c-4359-bd49-729e0925bbce', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:08:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d5b18fca-7548-434d-b8a0-84e8aa933334', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 15:16:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d5ce11e8-ec22-45be-95d5-da03325fbd4d', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 14:41:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d5f4f088-5efc-4a09-beb3-1d082ae2f4d8', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:33:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d617cfe9-ffa8-43c0-8d77-80fa6c15a439', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d619e21c-dbab-4d79-9cc6-119be5235687', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 21:32:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d64c152a-d46c-4c66-8f7f-2d8a527bf29d', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 12:46:10', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('d65f8c93-b268-4de9-ac61-9231fecc5529', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:40:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d6a57e5e-f698-4afe-a27c-94ea4974bbbb', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 20:24:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d6c12570-834f-4e0b-829b-11d394920b1f', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d6e5b09d-83a9-4399-9df9-0940c6f21410', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:26:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d70a289b-b5e5-418d-abf7-dfa94085bd00', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 20:53:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d70d2bee-3a47-4d10-a5b1-6818134e8929', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:51:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d7199938-a191-4093-8744-bafa3521661d', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 15:27:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d728659a-8756-4112-aad7-e484390ca36a', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:52:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d7300ea7-50ec-46c9-807c-1fcdb1955e31', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 13:56:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d7313e40-9a6f-4a87-b202-86df75aaa3b2', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 15:24:39', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d74d4d21-ace1-4230-8d21-cb29aaabef4f', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 20:22:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d768ef68-d568-4c3e-8931-0ed473855a75', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:17:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d77bec3b-f0d6-4129-9645-ba0492547218', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:17:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d7b354bf-f75c-49d0-b998-57fe790ce1ee', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:37:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d807ca96-f85f-4df8-813d-8831d826238c', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d8167dfc-d612-4457-8beb-568bf6a8cc3c', '用户访问', '访问日志', '', 'rolemanager/index', '2019-10-29 15:21:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('d83286dc-6181-40b3-956a-85195c4b9051', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:17:13', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d83e164c-da33-4002-8b37-9538f2081df8', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 20:13:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d855fda4-2ac9-409d-95ed-b4f47e782cc5', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 16:30:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d88d62d8-3894-45ed-8210-1960d1fc9b10', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:00:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d8901ae1-840d-49dc-b60a-2b799e0d2dbf', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 14:45:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d8b681f8-6d40-4f42-bdc1-dcbfa39f9b33', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:24:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d8c10628-8f6d-448b-8c16-002fb03601b8', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 13:57:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d8f02d1d-4a4e-4910-acf6-ef95a1a8c13a', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:48:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d936dc3c-9363-46c7-8c1d-c36f1fe171ab', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 16:59:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d93a6a4d-491e-45f4-8df6-4216df88301f', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:22:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d9880f57-7ad2-4387-8e80-c4e295f57107', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 13:38:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d98f878d-1b07-4edf-84ea-4718f8863242', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:58:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d9a08d3f-0fd8-41c8-b024-6868a3bf4185', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:40:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d9bc614c-4f4f-4d03-b688-d625961fcc08', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:40:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('d9f08fe1-abbd-49ca-bb3a-e15b1ef5cb86', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 15:25:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('da1a7c58-8282-4448-a884-b249c1f9d7cb', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 15:15:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('da372ef5-23f6-4e16-b87f-373d026b7509', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 12:48:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('da3d12a6-a604-4384-91a6-cc335efa6105', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:52:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('da4c539c-9baa-4e2f-a3a8-af408a2a0a3a', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:52:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('da7f07f2-65f9-4f73-82e5-00d96a1107a5', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:22:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('da94fef7-be64-45ee-b71a-e22d1e2faef7', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:16:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('db702fc4-6c72-4596-a5ee-bef4d9f90b12', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 15:34:24', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('db8799cc-dfe1-4628-8609-3dcab723f5e1', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:30:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dbb5dc6e-f150-4623-a5b9-bb9813d4ba4f', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:13:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dbd0a611-4415-4f42-851c-960bfb8dddba', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 20:39:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dbe30fb7-0744-4063-9e7b-f51034d46924', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:39:42', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('dc22e7d7-9305-4a66-9e79-13156f200661', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 11:40:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dc4104a0-c47d-4113-8c17-e9468dadeada', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 22:06:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dc4ded5c-cc36-4409-a330-a3a6b3c380e9', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:38:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dc74a880-d634-4ad3-9a79-458759792207', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:25:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dc7f79dc-f4ae-4829-9eb0-b60301c4006a', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dcc7072b-de10-4970-9e89-dd261c8beee1', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:40:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dcda7dcf-c6ef-462e-9514-22e8253ba60a', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 16:01:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dd079acf-4812-4b1a-aba0-8260e35890a9', '用户访问', '访问日志', '', 'usermanager/index', '2019-10-29 15:21:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('dd312005-333d-41f0-9754-599e46c42240', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:35:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dd4bdbe2-9ede-4ba6-b86a-6bd42c9b4df0', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:41:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dd536707-0a8f-407e-88c8-ea6dc414de3c', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:59:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dd7cef64-f367-4ae3-abe4-89ae11fa61d2', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 17:27:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dda6d092-c009-4c95-9f64-7edefd1d65d7', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:16:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ddf192f8-2cfd-4062-aef4-9d4847b79a08', '用户访问', '访问日志', '', 'users/load', '2019-10-29 14:29:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ddf244cc-cce9-4f46-a304-4698f70e0f2f', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:43:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('de0def2e-5f2e-4359-859f-28e27540420a', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:36:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('de224dfa-0577-4518-bfe1-102bed9bce61', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 14:31:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('de47c022-b2bc-4049-9e96-96adb55e54ed', '用户访问', '访问日志', '', 'forms/edit', '2019-10-29 16:48:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('de6b530b-ce6b-421d-9aab-3996168e56f5', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:07:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('de8eb801-e077-4312-abd4-701fc2f15249', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:04:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('de91f859-bf7f-4be4-9057-b902c1abaaff', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 12:45:45', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('de96af00-bb6e-4ebb-b569-9254b153a12c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:59:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('de9ff502-1998-4c3e-b4b4-9819a2940108', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:59:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('deb35c30-1800-46aa-bfd8-dac83230c3c6', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 16:23:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('decc1217-b0ee-41a8-9961-f7a0666de8db', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 15:26:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('decf6312-fff3-47ca-b65b-b3f443c74fd6', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:27:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('df26c662-44af-40e7-98de-79575f0e6d62', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:37:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('df4bab36-0d0b-4a65-8c59-f97fc14803d0', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:52:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('df5df000-d137-4177-b241-1fc0fe534594', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 17:28:09', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('df966843-4f89-40c2-8f7a-e1e62b6df18a', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 11:15:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('df98bcdc-1796-4866-a477-18dd8178067e', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 14:17:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('df9d41e4-0515-4703-bda1-6c31b86e5b57', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 15:28:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dfa749cb-a0bb-4708-9f5b-a57655b5d3f9', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:29:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dfa75259-3357-42db-9ff7-54439aedb10a', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:29:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dfac4636-4092-4c5b-b051-d6aaf20e185f', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:25:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dfb1efd6-4592-45f4-8ee3-2ca4eb8bcc4e', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:30:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('dff89be1-162f-4c33-8451-f25f58b6c896', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:39:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e00d5bbe-7919-472d-b0f2-34d5ad6b6755', '用户访问', '访问日志', '', 'accessobjs/assigndataproperty', '2019-10-29 15:28:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e00f2a5f-6abe-4bde-b25b-edb3831488b8', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 20:39:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e048053b-5e63-40c8-ae67-7975ed42ea85', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 18:16:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e0612253-3dbc-49f4-a72c-1d569d240c0d', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:35:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e0662c13-a73e-498f-8172-616ded0d9826', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:47:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e06b344c-3051-4741-bf73-dc9df30675f1', '用户访问', '访问日志', '', 'flowschemes/nodeinfo', '2019-10-29 15:52:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('e0ea2131-bbea-45e7-a072-1d81868cf69a', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 11:38:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e0f59272-62bb-48bf-97cb-c39f1c2cdd70', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 11:17:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e143b61e-90de-4a00-b496-1d98a0e4f89b', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 12:40:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e163a913-d3de-44d4-b63f-1d483051e677', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 14:45:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e1762553-7f84-493c-803b-ca29f68c50b5', '用户访问', '访问日志', '', 'flowinstances/add', '2019-10-29 17:27:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e17e66d8-be0f-44b3-b7ca-eccb9764fc87', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:54:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e193c942-3529-4df3-a0c3-af2d6a2de84b', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:00:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e1982233-d9bc-4760-80f5-2f7bfa6c2824', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 16:01:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e19dc7f4-9838-4031-a68b-f58c1abb5db4', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:00:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e1d18cf7-b986-4048-b1df-103ff2286539', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:41:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e1e00703-eece-43b6-b64d-e6c1f7e9eb4b', '用户访问', '访问日志', '', 'forms/preview', '2019-10-29 11:41:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('e2040ca2-ee9d-4406-8571-0cf4c34dc5b3', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 20:14:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e21f58d8-4fb7-452d-b1a7-619ed61734c4', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e27e63db-4da4-4aa8-aa41-7f35a4f19422', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 11:55:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e2875d5d-b6f9-4e23-a602-5af31edf110b', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:54:30', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e2de4f40-071f-4bec-80ec-50cf0ca6a4bf', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 14:27:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e2ed2426-c407-4fb1-8191-eccf046e57ca', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:51:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e3226265-5afb-4ab0-9c99-00f4663526f6', '用户访问', '访问日志', '', 'flowinstances/edit', '2019-10-29 13:53:38', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('e3230aba-159d-483d-b5bf-c13980100fed', '用户登录,结果：密码错误', '登录日志', '', '', '2019-10-29 14:19:25', 'admin', 'admin', '', 1, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e3448181-b3fd-454d-ac53-c7be0c4d8d01', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 11:40:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e387bd9e-c01f-4ec6-a37c-dc10f187e7fb', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 11:43:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('e3ea3c10-9075-4f2f-b8c6-90190df50729', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 12:44:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e3eef08b-fd73-4907-ad34-8e3e9fcfb2e1', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:15:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e3f08729-c9d8-4a50-930e-b5b3d23340bf', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 21:31:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e40253c3-7783-4a9c-ac98-cdf8a6e97a02', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:05:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e403f725-b6d2-4f0a-8004-0f88672170dd', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 18:16:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e40ea7e7-1055-4cd8-94ac-2b54a102a907', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 13:57:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e4232b3f-8a27-46a9-ba41-f269bd04bb9e', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:27:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e45bcb74-eeaa-4a1d-b356-1732dace78cb', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 21:32:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e4923a90-095b-498d-9c18-a92ec1938fed', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 13:38:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e497c098-b522-49fd-8063-0b5864b252cd', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 14:27:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e4a36ae7-c6f5-4038-a9dd-af4096ecbf43', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e4ba718c-628a-4924-a9f5-2980172e2f19', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 16:43:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e4f025fb-6485-46f1-8daf-f39f82994cd8', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 19:07:24', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e55f8849-d004-4d3d-a532-a59663c43e22', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 21:11:41', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e5949d10-62a0-4eb1-a65f-05c16bd3fe00', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:27:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e5a514a5-9516-4c08-8504-e8752519d655', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 11:17:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e5bb25cc-d47c-4db4-b032-787a12443bb6', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 13:10:56', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e5d1740e-2e29-423c-bafa-11fb5c4b847b', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 18:17:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e5fbab2b-77da-4100-8afd-1b8d9e96d01b', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:30:08', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e61fdc24-6391-4fa2-9102-54a30313d14c', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:35', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e63e322d-8b7f-496a-b79d-43b6c65027b9', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:22:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e65f4ac4-65f5-4c50-aa8a-4cd8c538b046', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:40:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e6c63102-19ab-4d01-ae53-cb7fa7d7e820', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 20:58:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e6e94258-4356-4224-a9ab-6a03671dae84', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 14:54:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('e6ef2647-deed-44b1-9872-889f97541b32', '用户访问', '访问日志', '', 'users/load', '2019-10-29 16:12:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e75610b5-4403-4c95-8fbe-5fd0b95df27d', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:18:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e77c2141-6406-443e-aff1-e69a1bc098f9', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:39:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e78c4243-b0e4-4a76-b21a-17c331adf4c2', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 14:43:32', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e7e5e1a0-8270-476b-b5e2-d46a372185df', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 16:30:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e7ee9352-bc78-4686-8223-fec0e678c8c1', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 15:51:19', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e80ba86b-8b7c-4f7b-a81a-0cff1084810d', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 14:40:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e829ffed-b424-4d74-b229-a5c40d50cde0', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 16:12:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e835b823-a5c2-401c-b86f-55629a7d5430', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:51:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e846bf1f-1a30-4a26-9ec2-e002db136e9d', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:21:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e84f21e3-9721-42a2-b21d-fe41c7cdc823', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 17:01:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e8623c2a-3065-4c63-9abf-cb643c9d055c', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 17:35:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e88a7134-bbb4-4fd6-90e4-f44ca463310f', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:07:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e8a0e7cf-c424-479d-a67d-aefcee861aec', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 17:35:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e8c03e29-da5e-4f2e-9404-f6d550763d3e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:01:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e8c48e77-858d-40ff-a575-f05eca49c9a5', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:27:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e8e102a6-391a-4fe6-bac5-1b028659789c', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:31:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e8e79835-e7b5-40ce-a097-49fa879b8a8f', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 12:46:10', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('e8ed233a-22e6-485d-93fa-21f085da6391', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 16:23:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e90dc79e-cd61-483c-88d5-d7cbd8b81113', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 16:22:50', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e914997a-1437-4653-aec0-f9dd0f725a7f', '用户访问', '访问日志', '', 'users/load', '2019-10-29 11:40:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e9297666-36ba-4a22-940a-8ca81a52ecb4', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 20:10:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('e970abb1-8a6f-4779-b5c2-37c827a0223d', '用户访问', '访问日志', '', 'flowschemes/nodeinfo', '2019-10-29 17:23:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('e999b5bd-a086-431d-9314-0a14e740efe3', '用户访问', '访问日志', '', 'syslogs/index', '2019-10-29 14:29:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ea03e0f0-b12a-4d48-bcf5-236d99207128', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:25:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ea443f48-01f1-4188-99c7-65794f51e3e5', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 18:05:00', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ea8aa7d4-aa68-4334-b7dc-aea3e03d3007', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 14:20:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eab28833-9962-4275-8c59-c9ed3a93dcdc', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:37:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eafdf317-b4a1-4104-a769-6ef45eeb4c82', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:09:12', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eb06e927-47e8-4705-8a3b-b40344721b3b', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 11:27:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eb0fdc1e-47e4-4e11-a051-3c06ba17ff39', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 16:59:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eb8be92b-75d6-4c81-89c8-0d15fdaa6da3', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:28:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ebabb355-fb7b-4af0-8937-4fd903902ebd', '用户访问', '访问日志', '', 'forms/edit', '2019-10-29 11:41:37', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ebf32fde-f6e7-4740-afaa-be7b3343f86c', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 14:45:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ebff5a44-5ae5-4c88-9109-f2ffd8987c4a', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:02:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ec0d6e07-6a18-44d4-a520-047b992618bd', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 21:09:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ec136464-babc-42bb-909e-0991328ff2de', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 19:07:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ec63095f-59ca-4b58-8068-815ae2e569a0', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:24:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ecc171e0-7cf9-4988-b551-b3b559b376e6', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 20:22:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eccec036-b667-4f26-95f9-2f3177610c83', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 17:38:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ecdc71b4-f082-499c-970d-a98447766b89', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 12:40:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ecdf2008-128c-44e8-9c1f-945432e61453', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 21:32:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eceb696a-ebe2-48fa-8b9a-453d2102e311', '用户访问', '访问日志', '', 'categories/index', '2019-10-29 10:59:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ed354337-03ec-4323-8483-5c36efea84ee', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 17:06:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ed42c7a8-e786-4823-9f59-5e90b41d057a', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:24:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ed43c714-49b7-4c56-8e5d-e324b29f1dc5', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 13:26:02', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ed511622-fe45-4a69-a9dd-aaa74527a091', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:28:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ed8b32dc-b0f6-42e7-bee3-efbc484b5bef', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:22:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ed9b5e42-8823-4801-8d63-6efd282e27a6', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 13:36:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('edebc72c-6b56-4395-9d59-d2859306e6cc', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:30:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ee4a4bac-caff-4a23-a7e1-2e872c48c71c', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:24:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ee5990f7-d674-4195-9b39-3ad0af517c5e', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 14:40:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eee0a1dc-b3f4-45c6-be9d-013af7e66975', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 14:27:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eee46ea1-b5f5-449c-8924-d2f29224854d', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 11:40:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ef02914e-6d12-4c38-81f9-2fb15aabb406', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 20:15:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ef411367-4bb7-4e59-a272-e9a62a6fe11f', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 18:25:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ef6109c0-d63a-48ff-99d6-e638ad893a36', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 21:31:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ef7b500e-4201-4a72-b802-355f9a29235f', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:11:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ef9994a0-8e91-4e93-87a4-821127e8f28f', '用户访问', '访问日志', '', 'sysmessages/load', '2019-10-29 14:46:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('efc46b9e-8e2d-4318-8a2e-1ff2bf94cbc1', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 14:45:31', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('eff32519-89d2-4cc7-aefa-caddd9b90e6b', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:01:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f015ccf6-e03c-4634-b306-c545ee27fb93', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 15:50:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f0a99379-08c0-4f5f-8ffd-4612d9679770', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 18:10:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f0d7f50c-3689-4663-ba29-b3ea253e5197', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 17:28:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f0de5a80-0216-492d-93fe-82e87d30f289', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 20:15:20', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f15cb1ec-efaa-4dc8-bc21-0cbff213de88', '用户访问', '访问日志', '', 'resources/loadforrole', '2019-10-29 16:59:54', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f18b4058-e5fc-4f18-b2c7-d2d1504bdf7e', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 13:10:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f19b7245-cd0e-4803-8afe-cc6dd9294dc3', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 13:37:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f1d45b26-ef8e-4a02-884f-c7d874818aa4', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 18:16:32', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f1e11675-c44f-4d97-835d-9d56603ade1d', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:38:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f1e90143-31bd-462d-bf29-4636356b5e86', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 17:26:33', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f22897a3-d844-470a-9e9f-068573a19a3a', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:43:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f24fce6a-b65f-4963-a4a3-1416f8f42532', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 18:04:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f2dcaded-37b3-42e1-b48d-16dda4813eee', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:33:05', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f2fefe5a-37a6-4d3b-bcc3-45f463b7a082', '用户访问', '访问日志', '', 'check/getproperties', '2019-10-29 15:28:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f321a683-f141-4faa-b3b1-9e314eafa5e7', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:51:45', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f329a43a-8bc1-40a6-907b-afeb61ae3216', '用户访问', '访问日志', '', 'users/load', '2019-10-29 15:16:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f3304532-e602-4677-ab25-d3f7e384d144', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 21:12:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f334f9c5-8ee7-40cf-83c8-77fb2ab9c977', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:02:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f33ac072-f87d-455d-892e-ad5568365d5e', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 11:38:22', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f3518eed-9293-43bf-bf18-cf0b1a511f32', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:47:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f357ab29-a585-451e-a8b3-3fbfcc4bc8c9', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 17:22:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('f38f7e2c-7bfb-48b5-90d6-a76880115eac', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:41:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f3b2fc4a-9d4f-4d76-a6ef-9c06fa245eb0', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:23:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f3cf785a-5623-4286-b58f-f2bb0c1edcef', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 17:03:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f3dfe94c-7d8c-4faa-aa1e-d564e2aa9079', '用户访问', '访问日志', '', 'flowschemes/update', '2019-10-29 13:10:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f3f09ecb-f1cf-4370-a7bc-4aadfa6525a6', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 18:25:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f435efad-8c11-4df5-be29-07b144c85d39', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f44e6649-5aea-4b6c-b404-858a7ddf1a6d', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 14:41:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f470c49b-1ee0-48d4-a05a-242d42f05ad2', '用户访问', '访问日志', '', 'users/load', '2019-10-29 20:52:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f494ac89-d587-4919-a73e-0a98a2c3579d', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 14:32:09', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f4ad4f5b-ff42-4eca-8f64-e46381014dd3', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 19:18:24', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('f4adebb0-02cf-4d7c-9713-558f52ae2764', '用户访问', '访问日志', '', 'flowinstances/wait', '2019-10-29 15:30:13', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('f4b06421-b15e-431f-8943-ff6c3ee598a5', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:53:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f4e38bc2-22fc-419a-b41c-34a0150426e7', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:48:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f4e5aade-01cf-4108-94a5-2a7bc6671f4e', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:52:49', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f522b0ef-5948-4cda-802f-c0afe8ee4994', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 16:33:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f533da38-4694-4fc0-aa7c-272c433498ab', '用户访问', '访问日志', '', 'flowinstances/get', '2019-10-29 17:01:01', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f5443058-6658-49b1-88c9-a66fffaa6d3b', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f57473f2-0f04-4d67-8449-8194ac62566d', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:59:58', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f588c666-b5f9-4c5f-b403-f62058e13726', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:01:15', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f596972a-6b6b-48f5-9836-4f39e8dfb5be', '用户访问', '访问日志', '', 'flowinstances/index', '2019-10-29 15:15:25', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('f5cfe5df-0d59-443d-9790-4f27f530c680', '用户访问', '访问日志', '', 'forms/get', '2019-10-29 13:11:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f5d93f81-5095-4ef8-b313-4eff5af300b2', '用户访问', '访问日志', '', 'categorys/load', '2019-10-29 15:41:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f5de62d7-56a6-4ce6-b390-2d6aae9b9d0e', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 14:44:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f5e75e55-ba55-42a4-97f8-ff83fc704229', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:17:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f601a4a6-439c-41ef-bddb-9b22d03c4b86', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 15:51:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f6081bcf-d77d-4595-be81-a8937a4e3754', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 16:24:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f61b72d4-e044-46af-9c06-987bf8a91b1b', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:32:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f61f8c61-8968-4737-8f60-19b240363528', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 16:11:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f64555d7-0e6d-4864-9234-9d482cba4de6', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:25:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f669aa8c-4f7b-4e37-8a3d-0818c2a650c7', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 20:22:53', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f6b638be-80ac-4251-a63a-080f9941b74f', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f6c761f1-a220-447e-a3fe-27e825db2a8f', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 19:08:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f6ca2b54-d805-4dce-8474-c25d9d8bf337', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:25:23', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f7027553-a233-4c80-8db1-fc337a2a0704', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:36:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f72cd07c-6e4e-4888-9f35-696f2c339a0e', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:57:48', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f73c830c-a370-4139-a953-b4030bfbd9a2', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 14:28:50', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f7521aed-c09d-45ee-bdc7-86d91095964c', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 14:28:02', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f7af5fbe-8d9c-4257-88ea-ce68e207026b', '用户登录,结果：操作成功', '登录日志', '', '', '2019-10-29 20:58:00', 'System', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f80491f6-e5d2-4add-b1f4-2b126a8c11f1', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 13:49:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f8557be0-56d0-45a8-9ed3-bf94331cd040', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:35:16', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f898fc3f-5e6f-4917-8d5d-429079f1d41e', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 15:44:07', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f8af1b85-defd-4104-a470-0010a1883cf9', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:45:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f8f7b689-db6d-4722-a0cb-d45c02d673b1', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:30:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f916d4da-e8f8-4343-b820-9e37aee74409', '用户访问', '访问日志', '', 'flowinstances/edit', '2019-10-29 15:38:06', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('f935512e-969b-40c1-93d1-d458cffac275', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 15:21:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('f93ce0a9-faa0-41bf-93b4-eb27e0b61cd6', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 11:07:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f95e2eac-bb40-4ad7-be42-56c8acf10138', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 11:15:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f96b6d92-f33e-47f4-9909-450af9f1660e', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 17:06:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f9897d68-8081-4821-a6b6-304a1380ed83', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 15:51:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f98d58cd-9005-44f3-9530-87f900cef399', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 20:14:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f9ded25b-2132-41de-bc5e-24ef8fe4b2dc', '用户访问', '访问日志', '', 'forms/edit', '2019-10-29 16:33:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('f9e927e6-267d-4cb5-8ecb-5ffafeb18ec2', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 11:38:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('f9fa207d-84e7-4eec-b9e3-8bad9e5e594a', '用户访问', '访问日志', '', 'dataprivilegerules/load', '2019-10-29 20:13:43', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fa0373cf-ac90-44eb-81f9-93bee60dcc43', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 15:52:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fa1dd2a2-0e1a-4c05-8484-a2878d18d6da', '用户访问', '访问日志', '', 'flowinstances/disposed', '2019-10-29 12:45:43', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('fa60e7c5-84b8-46d9-92b7-11e7e9930e28', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:29:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fa61ef5a-7b34-4f58-8468-e371de1340aa', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 11:15:55', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fa65e27c-0964-4622-b982-645b70a9289f', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:25:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('faa0c9f5-d9a2-4fd6-9c41-9a6d25921915', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 13:25:20', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('faecc159-debe-4b18-a2c7-4899786fbad3', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 17:32:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fb0b33e1-0de9-402c-9aff-149a90dbaccb', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 16:59:39', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fb0e0b5a-183f-4723-b03d-75185d1572de', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 20:31:04', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fb1c1714-b8e7-4759-ae38-5ee3583ce284', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 17:05:38', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fb285e66-50b2-455c-ad97-8955a616027f', '用户访问', '访问日志', '', 'check/getmodulestree', '2019-10-29 20:07:52', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fbdbf16a-dc55-460a-96b4-1082a520e68a', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 16:30:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fc421721-8485-40ed-9ce8-bf89051d7874', '用户访问', '访问日志', '', 'users/load', '2019-10-29 13:25:10', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fc4477a1-e4b6-4628-bdb3-f75ce788fa6b', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 15:25:51', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fc4b3dab-0d67-401e-9ab3-08c773ed1d72', '用户访问', '访问日志', '', 'resources/index', '2019-10-29 15:29:46', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('fc5fcc45-e608-458e-b2ee-cb4b5f2ad521', '用户访问', '访问日志', '', 'forms/load', '2019-10-29 19:08:29', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fc720488-6214-423b-b6b4-7655796d6d1a', '用户访问', '访问日志', '', 'resources/load', '2019-10-29 16:09:18', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fc7d9f2e-95c9-4f22-a140-3e80b5a97eaa', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:34:36', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fc870c9f-a8cf-444d-aa3a-33694983e5f2', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 16:43:47', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fca54ca2-8c73-40a4-a001-332ff2b0d479', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 14:41:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fcb50802-0095-4ec1-b345-5801d6aaa55c', '用户访问', '访问日志', '', 'flowschemes/index', '2019-10-29 17:41:55', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('fcbb5791-debf-41ca-a787-96d53e94dad6', '用户访问', '访问日志', '', 'flowschemes/load', '2019-10-29 17:52:59', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fcbf25e1-dde2-463b-9256-cd343bc8c45c', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 12:40:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fcf9ad65-56b2-472b-a670-b0ebcb0d028a', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 21:32:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fd27572b-dff1-45e1-b1ae-58e7669a8f21', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:33:42', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fd7badf2-700b-4c40-8f0f-398653452eea', '用户访问', '访问日志', '', 'modules/loadmenus', '2019-10-29 20:52:34', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fd938afc-4d7f-4a20-8d04-f81160521930', '用户访问', '访问日志', '', 'applications/load', '2019-10-29 16:59:46', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fdaef607-ed15-456d-81ef-0c4899455904', '用户访问', '访问日志', '', 'flowschemes/get', '2019-10-29 15:52:03', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fdcd2968-71ae-4e18-b2e1-439e9df33d75', '用户访问', '访问日志', '', 'check/getmodules', '2019-10-29 16:23:57', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fdeb0ee2-f5f7-4ee6-99e0-c752b1be38a2', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 16:48:28', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fe510e03-8b2b-4aad-ab8a-381f2e7a4348', '用户访问', '访问日志', '', 'flowinstances/queryhistories', '2019-10-29 17:28:27', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fe5e853e-2dd5-4f2b-8d21-08a5c1776049', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 13:56:26', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('fe6023d6-db17-4b88-8f1c-da493f41bafc', '用户访问', '访问日志', '', 'users/loadbyrole', '2019-10-29 14:30:40', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('feaa24be-ae3c-4422-b2c6-8593404d4148', '用户访问', '访问日志', '', 'roles/load', '2019-10-29 15:27:24', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('feab7b7d-d74a-46cb-895a-50e18e6f4cac', '用户访问', '访问日志', '', 'flowinstances/load', '2019-10-29 17:32:17', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('febd2a61-0f26-49c3-95c6-cbb34791f72a', '用户访问', '访问日志', '', 'flowschemes/design', '2019-10-29 17:22:14', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.Mvc');
INSERT INTO `syslog` VALUES ('ff16805c-78df-4342-869a-f43fe196ad33', '用户访问', '访问日志', '', 'syslogs/load', '2019-10-29 16:30:06', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ff36a25a-cdc8-4ed9-a2f4-e1188b0a8be5', '用户访问', '访问日志', '', 'check/getsuborgs', '2019-10-29 15:50:44', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ff6b82b0-c2d1-4b5e-8df5-74e2a7f6a2a2', '用户访问', '访问日志', '', 'check/getorgs', '2019-10-29 14:17:21', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ff80aa14-65f3-49e0-9877-45227857e892', '用户访问', '访问日志', '', 'check/getusername', '2019-10-29 17:32:11', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');
INSERT INTO `syslog` VALUES ('ff98e342-8a86-4018-99b4-3305754cda91', '用户访问', '访问日志', '', 'users/load', '2019-10-29 17:25:30', '00000000-0000-0000-0000-000000000000', 'System', '', 0, 'OpenAuth.WebApi');

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

