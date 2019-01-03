/*
Navicat MySQL Data Transfer

Source Server         : 本地mysql
Source Server Version : 50722
Source Host           : localhost:3306
Source Database       : openauthdb

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-05-30 18:26:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `application`
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'AppId',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '应用名称',
  `AppSecret` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用密钥',
  `Description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用描述',
  `Icon` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '应用图标',
  `Disable` tinyint(4) NOT NULL COMMENT '是否可用',
  `CreateTime` date NOT NULL COMMENT '创建日期',
  `CreateUser` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='应用';

-- ----------------------------
-- Records of application
-- ----------------------------
INSERT INTO `application` VALUES ('110', 'OpenAuth.Net', 'openauthdotnetyubaolee', '最好用的.NET权限工作流框架', null, '0', '2018-04-14', null);
INSERT INTO `application` VALUES ('119', 'XXX管理平台', 'manageryubaolee', '这是一个第三的平台', null, '0', '2018-04-14', null);

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '分类表ID（可作为分类的标识）',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `Disabled` tinyint(4) NOT NULL COMMENT '是否可用',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `Icon` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '分类图标',
  `Description` text COLLATE utf8_bin COMMENT '分类描述',
  `TypeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '分类类型ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='分类表，表示一个全集，比如：男、女、未知。关联的分类类型表示按什么进行的分类，如：按照性别对人类对象集进行分类';

INSERT INTO `category`  VALUES ('ADMINISTRATOR', '管理员', 0, 1, null, null, 'USERTYPE');
INSERT INTO `category`  VALUES ('SYSTEMADMIN', '神', 0, 1, null, null, 'USERTYPE');

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for `categorytype`
-- ----------------------------
DROP TABLE IF EXISTS `categorytype`;
CREATE TABLE `categorytype` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '分类表ID',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='分类类型';

-- ----------------------------
-- Records of categorytype
-- ----------------------------
INSERT INTO `categorytype` VALUES ('USERTYPE', '按用户类型分类', '2017-11-29 21:27:42');

-- ----------------------------
-- Table structure for `flowinstance`
-- ----------------------------
DROP TABLE IF EXISTS `flowinstance`;
CREATE TABLE `flowinstance` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '主键Id',
  `InstanceSchemeId` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '流程实例模板Id',
  `Code` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '实例编号',
  `CustomName` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义名称',
  `ActivityId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '当前节点ID',
  `ActivityType` int(11) DEFAULT NULL COMMENT '当前节点类型（0会签节点）',
  `ActivityName` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '当前节点名称',
  `PreviousId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '前一个ID',
  `SchemeContent` longtext COLLATE utf8_bin COMMENT '流程模板内容',
  `SchemeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '流程模板ID',
  `DbName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '数据库名称',
  `FrmData` longtext COLLATE utf8_bin COMMENT '表单数据',
  `FrmType` int(11) NOT NULL COMMENT '表单类型',
  `FrmContentData` longtext COLLATE utf8_bin COMMENT '表单中的控件属性描述',
  `FrmContentParse` longtext COLLATE utf8_bin COMMENT '表单控件位置模板',
  `FrmId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '表单ID',
  `SchemeType` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '流程类型',
  `Disabled` int(11) NOT NULL COMMENT '有效标志',
  `CreateDate` datetime NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建用户',
  `FlowLevel` int(11) NOT NULL COMMENT '等级',
  `Description` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '实例备注',
  `IsFinish` int(11) NOT NULL COMMENT '是否完成',
  `MakerList` text COLLATE utf8_bin COMMENT '执行人',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作流流程实例表';

INSERT INTO `flowinstance` VALUES ('d73e4412-9c49-4511-a30e-0d2f844afcee', '', '1523002870978', '我请个假', '1523002637238', 2, 'admin审核', '1523002636766', '{"title":"newFlow_1","nodes":[{"name":"node_1","left":101,"top":105,"type":"start round mix","id":"1523002631942","width":26,"height":26,"alt":true},{"name":"所有人都可以审","left":218,"top":122,"type":"node","id":"1523002636766","width":104,"height":50,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"role":[],"org":[]},"NodeName":"所有人都可以审","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","Taged":1,"UserId":"00000000-0000-0000-0000-000000000000","UserName":"超级管理员","Description":"自己处理一下","TagedTime":"2018-04-06 16:22"}},{"name":"admin审核","left":215,"top":190,"type":"node","id":"1523002637238","width":104,"height":49,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"role":[],"org":[]},"NodeName":"admin审核","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"node_4","left":260,"top":287,"type":"end round","id":"1523002639310","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1523002631942","to":"1523002636766","id":"1523002641196","name":"","dash":false},{"type":"sl","from":"1523002636766","to":"1523002637238","id":"1523002642292","name":"","dash":false},{"type":"sl","from":"1523002637238","to":"1523002639310","id":"1523002643868","name":"","dash":false}],"areas":[],"initNum":9}', '', '', '{"data_1":"玉宝","data_2":"3","data_3":""}', 0, '[{"name":"data_1","title":"Name","value":"玉宝","leipiplugins":"text","orghide":"0","style":"text-align: left; width: 150px;","orgalign":"left","orgwidth":"150","orgtype":"text","type":"text","content":"<input name=\\"data_1\\" title=\\"Name\\" value=\\"玉宝\\" leipiplugins=\\"text\\" orghide=\\"0\\" style=\\"text-align: left; width: 150px;\\" orgalign=\\"left\\" orgwidth=\\"150\\" orgtype=\\"text\\" type=\\"text\\"/>"},{"leipiplugins":"select","name":"data_2","title":"Days","size":"1","style":"width: 150px;","orgwidth":"150","value":"1,3,5,7","selected":"selected","content":"<span leipiplugins=\\"select\\"><select name=\\"data_2\\" title=\\"Days\\" leipiplugins=\\"select\\" size=\\"1\\" style=\\"width: 150px;\\" orgwidth=\\"150\\"><option value=\\"1\\">1</option><option value=\\"3\\" selected=\\"selected\\">3</option><option value=\\"5\\">5</option><option value=\\"7\\">7</option></select>&nbsp;&nbsp;</span>"},{"title":"Comment","name":"data_3","leipiplugins":"textarea","value":"","orgrich":"1","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width: 316px; height: 139px;","content":"<textarea title=\\"Comment\\" name=\\"data_3\\" leipiplugins=\\"textarea\\" value=\\"\\" orgrich=\\"1\\" orgfontsize=\\"\\" orgwidth=\\"300\\" orgheight=\\"80\\" style=\\"width: 316px; height: 139px;\\"></textarea>"}]', '<p><br/></p><p style="text-align: center;">姓名：{data_1}</p><p style="text-align: center;">天数：{data_2}</p><p style="text-align: center;">备注：{data_3}</p>', 'a4cffd58-7bac-498a-a327-58a644dfdd93', '', 0, '2018-04-06 16:21:35', '00000000-0000-0000-0000-000000000000', 'System', 0, '', 0, '49df1602-f5f3-4d52-afb7-3802da619558');
INSERT INTO `flowinstance` VALUES ('d8fa445f-edd9-4604-8d9e-b17ba921f9dd', '', '1523688313680', '天气好，请个假', '1523688050220', 0, '会签开始（要包括所有会签节点的审核人）', '1523688045356', '{"title":"newFlow_1","nodes":[{"name":"node_1","left":88,"top":84,"type":"start round mix","id":"1523688043300","width":26,"height":26,"alt":true},{"name":"任何人可以审核","left":201,"top":79,"type":"node","id":"1523688045356","width":148,"height":52,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"任何人可以审核","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","Taged":1,"UserId":"00000000-0000-0000-0000-000000000000","UserName":"超级管理员","Description":"自己当然要通过啊","TagedTime":"2018-04-14 14:46"}},{"name":"会签开始（要包括所有会签节点的审核人）","left":198,"top":165,"type":"fork","id":"1523688050220","width":162,"height":81,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558","6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeName":"会签开始（要包括所有会签节点的审核人）","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"admin审核","left":119,"top":283,"type":"node","id":"1523688053956","width":104,"height":39,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":[]},"NodeName":"admin审核","NodeCode":"node_4","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"test审核","left":337,"top":286,"type":"node","id":"1523688054452","width":104,"height":38,"alt":true,"setInfo":{"NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeName":"test审核","NodeCode":"node_5","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"会签结束","left":221,"top":362,"type":"join","id":"1523688063308","width":104,"height":46,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"会签结束","NodeCode":"node_7","NodeRejectType":"0","NodeDesignate":"ALL_USER"}},{"name":"node_8","left":261,"top":443,"type":"end round","id":"1523688066308","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1523688043300","to":"1523688045356","id":"1523688073290","name":"","dash":false},{"type":"sl","from":"1523688045356","to":"1523688050220","id":"1523688074210","name":"","dash":false},{"type":"sl","from":"1523688050220","to":"1523688053956","id":"1523688075338","name":"","dash":false},{"type":"sl","from":"1523688050220","to":"1523688054452","id":"1523688079394","name":"","dash":false},{"type":"sl","from":"1523688053956","to":"1523688063308","id":"1523688080746","name":"","dash":false},{"type":"sl","from":"1523688054452","to":"1523688063308","id":"1523688082204","name":"","dash":false},{"type":"sl","from":"1523688063308","to":"1523688066308","id":"1523688084522","name":"","dash":false}],"areas":[],"initNum":16}', '', '', '{"data_1":"玉宝","data_2":"3","data_3":"想去洗个车啊，老板"}', 0, '[{"name":"data_1","title":"Name","value":"玉宝","leipiplugins":"text","orghide":"0","style":"text-align: left; width: 150px;","orgalign":"left","orgwidth":"150","orgtype":"text","type":"text","content":"<input name=\\"data_1\\" title=\\"Name\\" value=\\"玉宝\\" leipiplugins=\\"text\\" orghide=\\"0\\" style=\\"text-align: left; width: 150px;\\" orgalign=\\"left\\" orgwidth=\\"150\\" orgtype=\\"text\\" type=\\"text\\"/>"},{"leipiplugins":"select","name":"data_2","title":"Days","size":"1","style":"width: 150px;","orgwidth":"150","value":"1,3,5,7","selected":"selected","content":"<span leipiplugins=\\"select\\"><select name=\\"data_2\\" title=\\"Days\\" leipiplugins=\\"select\\" size=\\"1\\" style=\\"width: 150px;\\" orgwidth=\\"150\\"><option value=\\"1\\">1</option><option value=\\"3\\" selected=\\"selected\\">3</option><option value=\\"5\\">5</option><option value=\\"7\\">7</option></select>&nbsp;&nbsp;</span>"},{"title":"Comment","name":"data_3","leipiplugins":"textarea","value":"","orgrich":"1","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width: 316px; height: 139px;","content":"<textarea title=\\"Comment\\" name=\\"data_3\\" leipiplugins=\\"textarea\\" value=\\"\\" orgrich=\\"1\\" orgfontsize=\\"\\" orgwidth=\\"300\\" orgheight=\\"80\\" style=\\"width: 316px; height: 139px;\\"></textarea>"}]', '<p><br/></p><p style="text-align: center;">姓名：{data_1}</p><p style="text-align: center;">天数：{data_2}</p><p style="text-align: center;">备注：{data_3}</p>', 'a4cffd58-7bac-498a-a327-58a644dfdd93', '', 0, '2018-04-14 14:46:01', '00000000-0000-0000-0000-000000000000', 'System', 0, '', 0, '49df1602-f5f3-4d52-afb7-3802da619558,6ba79766-faa0-4259-8139-a4a6d35784e0');
INSERT INTO `flowinstance` VALUES ('e6566327-1a0e-4378-8f63-91acfa4722d2', '', '1523688457002', '不想上班请个假', '1523688045356', 2, '任何人可以审核', '1523688043300', '{"title":"newFlow_1","nodes":[{"name":"node_1","left":88,"top":84,"type":"start round mix","id":"1523688043300","width":26,"height":26,"alt":true},{"name":"任何人可以审核","left":201,"top":79,"type":"node","id":"1523688045356","width":148,"height":52,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"任何人可以审核","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER"}},{"name":"会签开始（要包括所有会签节点的审核人）","left":198,"top":165,"type":"fork","id":"1523688050220","width":162,"height":81,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558","6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeName":"会签开始（要包括所有会签节点的审核人）","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"admin审核","left":119,"top":283,"type":"node","id":"1523688053956","width":104,"height":39,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":[]},"NodeName":"admin审核","NodeCode":"node_4","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"test审核","left":337,"top":286,"type":"node","id":"1523688054452","width":104,"height":38,"alt":true,"setInfo":{"NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeName":"test审核","NodeCode":"node_5","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"会签结束","left":221,"top":362,"type":"join","id":"1523688063308","width":104,"height":46,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"会签结束","NodeCode":"node_7","NodeRejectType":"0","NodeDesignate":"ALL_USER"}},{"name":"node_8","left":261,"top":443,"type":"end round","id":"1523688066308","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1523688043300","to":"1523688045356","id":"1523688073290","name":"","dash":false},{"type":"sl","from":"1523688045356","to":"1523688050220","id":"1523688074210","name":"","dash":false},{"type":"sl","from":"1523688050220","to":"1523688053956","id":"1523688075338","name":"","dash":false},{"type":"sl","from":"1523688050220","to":"1523688054452","id":"1523688079394","name":"","dash":false},{"type":"sl","from":"1523688053956","to":"1523688063308","id":"1523688080746","name":"","dash":false},{"type":"sl","from":"1523688054452","to":"1523688063308","id":"1523688082204","name":"","dash":false},{"type":"sl","from":"1523688063308","to":"1523688066308","id":"1523688084522","name":"","dash":false}],"areas":[],"initNum":16}', '', '', '{"data_1":"玉宝","data_2":"3","data_3":""}', 0, '[{"name":"data_1","title":"Name","value":"玉宝","leipiplugins":"text","orghide":"0","style":"text-align: left; width: 150px;","orgalign":"left","orgwidth":"150","orgtype":"text","type":"text","content":"<input name=\\"data_1\\" title=\\"Name\\" value=\\"玉宝\\" leipiplugins=\\"text\\" orghide=\\"0\\" style=\\"text-align: left; width: 150px;\\" orgalign=\\"left\\" orgwidth=\\"150\\" orgtype=\\"text\\" type=\\"text\\"/>"},{"leipiplugins":"select","name":"data_2","title":"Days","size":"1","style":"width: 150px;","orgwidth":"150","value":"1,3,5,7","selected":"selected","content":"<span leipiplugins=\\"select\\"><select name=\\"data_2\\" title=\\"Days\\" leipiplugins=\\"select\\" size=\\"1\\" style=\\"width: 150px;\\" orgwidth=\\"150\\"><option value=\\"1\\">1</option><option value=\\"3\\" selected=\\"selected\\">3</option><option value=\\"5\\">5</option><option value=\\"7\\">7</option></select>&nbsp;&nbsp;</span>"},{"title":"Comment","name":"data_3","leipiplugins":"textarea","value":"","orgrich":"1","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width: 316px; height: 139px;","content":"<textarea title=\\"Comment\\" name=\\"data_3\\" leipiplugins=\\"textarea\\" value=\\"\\" orgrich=\\"1\\" orgfontsize=\\"\\" orgwidth=\\"300\\" orgheight=\\"80\\" style=\\"width: 316px; height: 139px;\\"></textarea>"}]', '<p><br/></p><p style="text-align: center;">姓名：{data_1}</p><p style="text-align: center;">天数：{data_2}</p><p style="text-align: center;">备注：{data_3}</p>', 'a4cffd58-7bac-498a-a327-58a644dfdd93', '', 0, '2018-04-14 14:47:48', '00000000-0000-0000-0000-000000000000', 'System', 0, '', 0, '1');

-- ----------------------------
-- Table structure for `flowinstanceoperationhistory`
-- ----------------------------
DROP TABLE IF EXISTS `flowinstanceoperationhistory`;
CREATE TABLE `flowinstanceoperationhistory` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '主键Id',
  `InstanceId` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '实例进程Id',
  `Content` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '操作内容',
  `CreateDate` datetime NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建用户',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作流实例操作记录';

-- ----------------------------
-- Records of flowinstanceoperationhistory
-- ----------------------------
INSERT INTO `flowinstanceoperationhistory` VALUES ('1419387b-22f0-4b67-bd51-5acdfb50a36c', '3e42b844-d5d1-4fda-a27c-942755a3bd54', '【所有人可审下】【2018-04-07 21:50】同意,备注：ok', '2018-04-07 21:50:29', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('3024727a-a422-4b68-b525-7e5f8723ab76', 'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', '【创建】超级管理员创建了一个流程进程【1523688313680/天气好，请个假】', '2018-04-14 14:46:01', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('6482670e-522e-418a-932b-b286395db758', 'd73e4412-9c49-4511-a30e-0d2f844afcee', '【所有人都可以审】【2018-04-06 16:22】同意,备注：自己处理一下', '2018-04-06 16:22:25', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('91404754-2d13-40f8-b2c8-dec8692bda92', '35f9d541-ef0f-4b9b-9ffd-dfe933d47d1f', '【所有人可审下】【2018-04-07 19:34】同意,备注：', '2018-04-07 19:34:40', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('97608015-8131-465b-b391-957ebd46ed62', '35f9d541-ef0f-4b9b-9ffd-dfe933d47d1f', '【创建】超级管理员创建了一个流程进程【1523002969474/再借个书】', '2018-04-06 16:23:32', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('aba0e717-69b8-4f37-9dde-1043a344dd0a', '35f9d541-ef0f-4b9b-9ffd-dfe933d47d1f', '【test审核】【2018-04-07 19:59】同意,备注：', '2018-04-07 19:48:36', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');
INSERT INTO `flowinstanceoperationhistory` VALUES ('ae8ab8e9-1efe-46d5-8362-152f4c9de091', '35f9d541-ef0f-4b9b-9ffd-dfe933d47d1f', '【admin审核】【2018-04-07 19:40】同意,备注：admin', '2018-04-07 19:36:41', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');
INSERT INTO `flowinstanceoperationhistory` VALUES ('b1a893fd-d282-4b22-914d-9f148b627d0d', '3e42b844-d5d1-4fda-a27c-942755a3bd54', '【admin审核】【2018-04-07 21:51】同意,备注：签一个', '2018-04-07 21:51:26', '49df1602-f5f3-4d52-afb7-3802da619558', 'admin');
INSERT INTO `flowinstanceoperationhistory` VALUES ('c05075e4-cd9c-4267-b960-1929019ed031', 'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', '【任何人可以审核】【2018-04-14 14:46】同意,备注：自己当然要通过啊', '2018-04-14 14:46:34', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('d3d8eb25-8d96-4fbd-b475-5dcc1569848b', 'e6566327-1a0e-4378-8f63-91acfa4722d2', '【创建】超级管理员创建了一个流程进程【1523688457002/不想上班请个假】', '2018-04-14 14:47:48', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('e08346e5-af15-4638-976b-9fe1081527d2', '3e42b844-d5d1-4fda-a27c-942755a3bd54', '【创建】超级管理员创建了一个流程进程【1523107997554/111111111111】', '2018-04-07 21:33:28', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('f7e387b5-caa0-4cc1-ab0e-b5f81cd030d8', 'd73e4412-9c49-4511-a30e-0d2f844afcee', '【创建】超级管理员创建了一个流程进程【1523002870978/我请个假】', '2018-04-06 16:21:35', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstanceoperationhistory` VALUES ('fa53a997-ef42-47da-8fd5-806a1a939471', '3e42b844-d5d1-4fda-a27c-942755a3bd54', '【test审核】【2018-04-07 21:52】同意,备注：1111', '2018-04-07 21:52:27', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');

-- ----------------------------
-- Table structure for `flowinstancetransitionhistory`
-- ----------------------------
DROP TABLE IF EXISTS `flowinstancetransitionhistory`;
CREATE TABLE `flowinstancetransitionhistory` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '主键Id',
  `InstanceId` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '实例Id',
  `FromNodeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '开始节点Id',
  `FromNodeType` int(11) DEFAULT NULL COMMENT '开始节点类型',
  `FromNodeName` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '开始节点名称',
  `ToNodeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '结束节点Id',
  `ToNodeType` int(11) DEFAULT NULL COMMENT '结束节点类型',
  `ToNodeName` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '结束节点名称',
  `TransitionSate` int(11) NOT NULL COMMENT '转化状态',
  `IsFinish` int(11) NOT NULL COMMENT '是否结束',
  `CreateDate` datetime NOT NULL COMMENT '转化时间',
  `CreateUserId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '操作人Id',
  `CreateUserName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '操作人名称',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作流实例流转历史记录';

-- ----------------------------
-- Records of flowinstancetransitionhistory
-- ----------------------------
INSERT INTO `flowinstancetransitionhistory` VALUES ('176ed6db-c9f8-4cae-8c5a-244b407d0c51', '3e42b844-d5d1-4fda-a27c-942755a3bd54', '1523002714678', '3', 'node_1', '1523002717150', '2', '所有人可审下', '0', '0', '2018-04-07 21:33:28', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('5c4cb1f3-9b09-4ac6-8e15-35c4adc8af9b', 'e6566327-1a0e-4378-8f63-91acfa4722d2', '1523688043300', '3', 'node_1', '1523688045356', '2', '任何人可以审核', '0', '0', '2018-04-14 14:47:48', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('736ef169-c9de-467a-80a8-9d1367459a1f', '3e42b844-d5d1-4fda-a27c-942755a3bd54', '1523002717150', '2', '所有人可审下', '1523002732796', '0', '开始会签', '0', '0', '2018-04-07 21:50:31', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('80754624-337e-45d9-9eb5-447439fe7785', 'd73e4412-9c49-4511-a30e-0d2f844afcee', '1523002636766', '2', '所有人都可以审', '1523002637238', '2', 'admin审核', '0', '0', '2018-04-06 16:22:25', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('d56d4393-3d77-4e15-bf74-1212087c0fc2', 'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', '1523688043300', '3', 'node_1', '1523688045356', '2', '任何人可以审核', '0', '0', '2018-04-14 14:46:01', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('dbe4963d-c102-4fd1-9a43-2a7b489cda37', 'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', '1523688045356', '2', '任何人可以审核', '1523688050220', '0', '会签开始（要包括所有会签节点的审核人）', '0', '0', '2018-04-14 14:46:34', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('e756f09d-a7de-45e5-a865-9ce25617b4e0', 'd73e4412-9c49-4511-a30e-0d2f844afcee', '1523002631942', '3', 'node_1', '1523002636766', '2', '所有人都可以审', '0', '0', '2018-04-06 16:21:35', '00000000-0000-0000-0000-000000000000', '超级管理员');
INSERT INTO `flowinstancetransitionhistory` VALUES ('f29bd77f-9d63-4f2b-ada7-6ca57bc1d422', '3e42b844-d5d1-4fda-a27c-942755a3bd54', '1523002732796', '0', '开始会签', '1523002726014', '4', 'node_5', '0', '1', '2018-04-07 21:52:27', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'test');

-- ----------------------------
-- Table structure for `flowscheme`
-- ----------------------------
DROP TABLE IF EXISTS `flowscheme`;
CREATE TABLE `flowscheme` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '主键Id',
  `SchemeCode` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '流程编号',
  `SchemeName` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '流程名称',
  `SchemeType` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '流程分类',
  `SchemeVersion` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '流程内容版本',
  `SchemeCanUser` longtext COLLATE utf8_bin COMMENT '流程模板使用者',
  `SchemeContent` longtext COLLATE utf8_bin COMMENT '流程内容',
  `FrmId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '表单ID',
  `FrmType` int(11) NOT NULL COMMENT '表单类型',
  `AuthorizeType` int(11) NOT NULL COMMENT '模板权限类型：0完全公开,1指定部门/人员',
  `SortCode` int(11) NOT NULL COMMENT '排序码',
  `DeleteMark` int(11) NOT NULL COMMENT '删除标记',
  `Disabled` int(11) NOT NULL COMMENT '有效',
  `Description` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `CreateDate` datetime NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建用户',
  `ModifyDate` datetime DEFAULT NULL COMMENT '修改时间',
  `ModifyUserId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '修改用户主键',
  `ModifyUserName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '修改用户',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作流模板信息表';

-- ----------------------------
-- Records of flowscheme
-- ----------------------------
INSERT INTO `flowscheme` VALUES ('cd93ef0c-9e09-461b-8599-719de8f2cf74', '1523688022354', '信息中心请假', '', '', '', '{"title":"newFlow_1","nodes":[{"name":"node_1","left":88,"top":84,"type":"start round mix","id":"1523688043300","width":26,"height":26,"alt":true},{"name":"任何人可以审核","left":201,"top":79,"type":"node","id":"1523688045356","width":148,"height":52,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"任何人可以审核","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER"}},{"name":"会签开始（要包括所有会签节点的审核人）","left":198,"top":165,"type":"fork","id":"1523688050220","width":162,"height":81,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558","6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeName":"会签开始（要包括所有会签节点的审核人）","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"admin审核","left":119,"top":283,"type":"node","id":"1523688053956","width":104,"height":39,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":[]},"NodeName":"admin审核","NodeCode":"node_4","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"test审核","left":337,"top":286,"type":"node","id":"1523688054452","width":104,"height":38,"alt":true,"setInfo":{"NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeName":"test审核","NodeCode":"node_5","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"会签结束","left":221,"top":362,"type":"join","id":"1523688063308","width":104,"height":46,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"会签结束","NodeCode":"node_7","NodeRejectType":"0","NodeDesignate":"ALL_USER"}},{"name":"node_8","left":261,"top":443,"type":"end round","id":"1523688066308","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1523688043300","to":"1523688045356","id":"1523688073290","name":"","dash":false,"alt":true},{"type":"sl","from":"1523688045356","to":"1523688050220","id":"1523688074210","name":"","dash":false,"alt":true},{"type":"sl","from":"1523688050220","to":"1523688053956","id":"1523688075338","name":"","dash":false,"alt":true},{"type":"sl","from":"1523688050220","to":"1523688054452","id":"1523688079394","name":"","dash":false,"alt":true},{"type":"sl","from":"1523688053956","to":"1523688063308","id":"1523688080746","name":"","dash":false,"alt":true},{"type":"sl","from":"1523688054452","to":"1523688063308","id":"1523688082204","name":"","dash":false,"alt":true},{"type":"sl","from":"1523688063308","to":"1523688066308","id":"1523688084522","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', 'a4cffd58-7bac-498a-a327-58a644dfdd93', 0, 0, 1, 0, 0, null, '2018-04-14 14:44:06', '', '', '2018-04-14 14:44:06', '', '');


-- ----------------------------
-- Table structure for `form`
-- ----------------------------
DROP TABLE IF EXISTS `form`;
CREATE TABLE `form` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '表单模板Id',
  `Name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '表单名称',
  `Fields` int(11) NOT NULL COMMENT '字段个数',
  `ContentData` longtext COLLATE utf8_bin COMMENT '表单中的控件属性描述',
  `ContentParse` longtext COLLATE utf8_bin COMMENT '表单控件位置模板',
  `Content` longtext COLLATE utf8_bin COMMENT '表单原html模板未经处理的',
  `SortCode` int(11) NOT NULL COMMENT '排序码',
  `Delete` int(11) NOT NULL COMMENT '删除标记',
  `DbName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '数据库名称',
  `Enabled` int(11) NOT NULL COMMENT '有效',
  `Description` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `CreateDate` datetime NOT NULL COMMENT '创建时间',
  `CreateUserId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建用户主键',
  `CreateUserName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建用户',
  `ModifyDate` datetime DEFAULT NULL COMMENT '修改时间',
  `ModifyUserId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '修改用户主键',
  `ModifyUserName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '修改用户',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='表单模板表';

-- ----------------------------
-- Records of form
-- ----------------------------
INSERT INTO `form` VALUES ('a4cffd58-7bac-498a-a327-58a644dfdd93', '请假条', 3, '[{"name":"data_1","title":"Name","value":"玉宝","leipiplugins":"text","orghide":"0","style":"text-align: left; width: 150px;","orgalign":"left","orgwidth":"150","orgtype":"text","type":"text","content":"<input name=\\"data_1\\" title=\\"Name\\" value=\\"玉宝\\" leipiplugins=\\"text\\" orghide=\\"0\\" style=\\"text-align: left; width: 150px;\\" orgalign=\\"left\\" orgwidth=\\"150\\" orgtype=\\"text\\" type=\\"text\\"/>"},{"leipiplugins":"select","name":"data_2","title":"Days","size":"1","style":"width: 150px;","orgwidth":"150","value":"1,3,5,7","selected":"selected","content":"<span leipiplugins=\\"select\\"><select name=\\"data_2\\" title=\\"Days\\" leipiplugins=\\"select\\" size=\\"1\\" style=\\"width: 150px;\\" orgwidth=\\"150\\"><option value=\\"1\\">1</option><option value=\\"3\\" selected=\\"selected\\">3</option><option value=\\"5\\">5</option><option value=\\"7\\">7</option></select>&nbsp;&nbsp;</span>"},{"title":"Comment","name":"data_3","leipiplugins":"textarea","value":"","orgrich":"1","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width: 316px; height: 139px;","content":"<textarea title=\\"Comment\\" name=\\"data_3\\" leipiplugins=\\"textarea\\" value=\\"\\" orgrich=\\"1\\" orgfontsize=\\"\\" orgwidth=\\"300\\" orgheight=\\"80\\" style=\\"width: 316px; height: 139px;\\"></textarea>"}]', '<p><br/></p><p style="text-align: center;">姓名：{data_1}</p><p style="text-align: center;">天数：{data_2}</p><p style="text-align: center;">备注：{data_3}</p>', '<p><br/></p><p style="text-align: center;">姓名：<input name="data_1" title="Name" value="玉宝" leipiplugins="text" orghide="0" style="text-align: left; width: 150px;" orgalign="left" orgwidth="150" orgtype="text" type="text"/></p><p style="text-align: center;">天数：{|-<span leipiplugins="select"><select name="data_2" title="Days" leipiplugins="select" size="1" style="width: 150px;" orgwidth="150"><option value="1">1</option><option value="3" selected="selected">3</option><option value="5">5</option><option value="7">7</option></select>&nbsp;&nbsp;</span>-|}</p><p style="text-align: center;">备注：<textarea title="Comment" name="data_3" leipiplugins="textarea" value="" orgrich="1" orgfontsize="" orgwidth="300" orgheight="80" style="width: 316px; height: 139px;"></textarea></p>', 1, 0, null, 0, null, '2018-04-06 16:16:40', '', '', '2018-04-06 16:16:40', '', '');

-- ----------------------------
-- Table structure for `module`
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '功能模块流水号',
  `CascadeId` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '节点语义ID',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '功能模块名称',
  `Url` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '主页面URL',
  `HotKey` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '热键',
  `IsLeaf` tinyint(4) NOT NULL COMMENT '是否叶子节点',
  `IsAutoExpand` tinyint(4) NOT NULL COMMENT '是否自动展开',
  `IconName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '节点图标文件名称',
  `Status` int(11) NOT NULL COMMENT '当前状态',
  `ParentName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '父节点名称',
  `Vector` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '矢量图标',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `ParentId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '父节点流水号',
  `Code` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='功能模块表';

-- ----------------------------
-- Records of module
-- ----------------------------
INSERT INTO `module` VALUES ('0031262c-689c-4b96-bae2-2c9d67076ade', '.0.1.2.', '流程设计', '/flowSchemes/index', '', '0', '0', '&#xe628;', '0', '基础配置', '', '0', '7580672f-a390-4bb6-982d-9a4570cb5199', 'FlowScheme');
INSERT INTO `module` VALUES ('069475e3-c997-487a-9f29-e6a864c5c1d4', '.0.2.', '流程中心', '/', '', '0', '0', '&#xe638;', '0', '根节点', '', '0', null, null);
INSERT INTO `module` VALUES ('37bb9414-19a0-4223-9056-71f8c758a930', '.0.2.3.', '已处理流程', '/flowinstances/disposed', '', '0', '0', '&#xe610;', '0', '流程中心', '', '1', '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstanceDisposed');
INSERT INTO `module` VALUES ('4abafc83-c8f5-452f-9882-e113a86e7a3e', '.0.2.2.', '待处理流程', '/flowinstances/wait', '', '0', '0', '&#xe641;', '0', '流程中心', '', '1', '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstanceWait');
INSERT INTO `module` VALUES ('6a9e1346-0c01-44d2-8eb1-f929fdab542a', '.0.1.8.', '部门管理', '/OrgManager/Index', '', '0', '0', '&#xe613;', '0', '基础配置', '', '0', '7580672f-a390-4bb6-982d-9a4570cb5199', 'Org');
INSERT INTO `module` VALUES ('7580672f-a390-4bb6-982d-9a4570cb5199', '.0.1.', '基础配置', ' ', ' ', '1', '0', '&#xe620;', '1', '根节点', ' ', '0', null, null);
INSERT INTO `module` VALUES ('92b00259-2d15-43e7-9321-adffb29e8bf2', '.0.1.5.', '表单设计', '/forms/index', '', '0', '0', '&#xe63c;', '0', '基础配置', '', '0', '7580672f-a390-4bb6-982d-9a4570cb5199', 'Form');
INSERT INTO `module` VALUES ('9486ff22-b696-4d7f-8093-8a3e53c45453', '.0.2.1.', '我的流程', '/flowInstances/Index', '', '0', '0', '&#xe618;', '0', '流程中心', '', '2', '069475e3-c997-487a-9f29-e6a864c5c1d4', 'FlowInstance');
INSERT INTO `module` VALUES ('a94d5648-c2a9-405e-ba6f-f1602ec9b807', '.0.1.7.', '分类管理', '/Categories/Index', '', '0', '0', '&#xe62a;', '0', '基础配置', '', '0', '7580672f-a390-4bb6-982d-9a4570cb5199', 'Category');
INSERT INTO `module` VALUES ('bc80478d-0547-4437-9cff-be4b40144bdf', '.0.1.6.', '模块管理', '/ModuleManager/Index', ' ', '1', '0', '&#xe630;', '0', '基础配置', ' ', '0', '7580672f-a390-4bb6-982d-9a4570cb5199', 'Module');
INSERT INTO `module` VALUES ('bedb41a2-f310-4775-af99-01be08adda93', '.0.1.1.', '角色管理', '/RoleManager/Index', '', '1', '0', '&#xe627;', '0', '基础配置', '', '0', '7580672f-a390-4bb6-982d-9a4570cb5199', 'Role');
INSERT INTO `module` VALUES ('e8dc5db6-4fc4-4795-a1cc-681cbcceec91', '.0.1.3.', '资源管理', '/Resources/Index', '', '0', '0', '&#xe64c;', '0', '基础配置', '', '0', '7580672f-a390-4bb6-982d-9a4570cb5199', 'Resource');
INSERT INTO `module` VALUES ('ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', '.0.1.4.', '用户管理', '/UserManager/Index', '', '0', '0', '&#xe612;', '0', '基础配置', '', '0', '7580672f-a390-4bb6-982d-9a4570cb5199', 'User');

-- ----------------------------
-- Table structure for `moduleelement`
-- ----------------------------
DROP TABLE IF EXISTS `moduleelement`;
CREATE TABLE `moduleelement` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '流水号',
  `DomId` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'DOM ID',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `Attr` text COLLATE utf8_bin NOT NULL COMMENT '元素附加属性',
  `Script` text COLLATE utf8_bin NOT NULL COMMENT '元素调用脚本',
  `Icon` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '元素图标',
  `Class` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '元素样式',
  `Remark` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '备注',
  `Sort` int(11) NOT NULL COMMENT '排序字段',
  `ModuleId` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '功能模块Id',
  `TypeName` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='模块元素表(需要权限控制的按钮)';

-- ----------------------------
-- Records of moduleelement
-- ----------------------------
INSERT INTO `moduleelement` VALUES ('0d25438e-1436-48e0-aedf-0f1690693282', 'btnAccessModule', '为角色分配模块', '', 0x61737369676E526F6C654D6F64756C65287468697329, '', 'layui-btn-normal', '为角色分配模块', '4', 'bedb41a2-f310-4775-af99-01be08adda93', null, null);
INSERT INTO `moduleelement` VALUES ('15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', 'btnAssignReource', '为角色分配资源', '', 0x6F70656E526F6C6552656F75726365416363657373287468697329, '', 'layui-btn-normal', '为角色分配资源', '3', 'bedb41a2-f310-4775-af99-01be08adda93', null, null);
INSERT INTO `moduleelement` VALUES ('17ae4fd4-ab4e-439e-ba1d-2a53b46d112b', 'btnDel', '删除', '', 0x64656C2829, '&#xe640;', 'layui-btn-danger', '', '2', '0031262c-689c-4b96-bae2-2c9d67076ade', null, null);
INSERT INTO `moduleelement` VALUES ('18cc3217-28a6-49b2-9a20-080230065984', 'btnEdit', '编辑', '', 0x656469742829, '&#xe642;', 'layui-btn-normal', '', '1', '0031262c-689c-4b96-bae2-2c9d67076ade', null, null);
INSERT INTO `moduleelement` VALUES ('1a473afd-cbd4-41e9-9471-81f9435aaabe', 'btnEdit', '编辑', 0x20, 0x656469742829, '&#xe642;', 'layui-btn-normal', '编辑分类', '0', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', null, null);
INSERT INTO `moduleelement` VALUES ('1c870438-4260-43a5-8996-a6e1dc8bbf6a', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '添加部门', '0', '6a9e1346-0c01-44d2-8eb1-f929fdab542a', null, null);
INSERT INTO `moduleelement` VALUES ('1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', 'btnEdit', '编辑', '', 0x656469742829, '&#xe642;', 'layui-btn-normal', '编辑角色', '1', 'bedb41a2-f310-4775-af99-01be08adda93', null, null);
INSERT INTO `moduleelement` VALUES ('2d595a2a-5de5-479e-a331-b53c799a6b10', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '添加分类', '0', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', null, null);
INSERT INTO `moduleelement` VALUES ('2feefce1-e3d8-42ac-b811-2352679628da', 'btnDel', '删除', '', 0x64656C2829, '&#xe640;', 'layui-btn-danger', '刪除用戶', '2', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', null, null);
INSERT INTO `moduleelement` VALUES ('34730f5a-d307-457b-9041-5f7de30abfa9', 'btnEdit', '编辑', '', 0x656469742829, '&#xe642;', 'layui-btn-normal', '编辑用户', '1', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', null, null);
INSERT INTO `moduleelement` VALUES ('362d1eda-c85e-4b14-a80a-b923291e08de', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '添加', '0', 'f0f06b8f-0a86-487c-8b0e-0a12573ccd46', null, null);
INSERT INTO `moduleelement` VALUES ('38109ca0-32ec-44bd-a243-017e591b532b', 'btnEditStock', '编辑', 0x20, 0x656469742829, '&#xe642;', 'layui-btn-normal', '编辑进出库', '0', '89c3bfbe-246f-4112-8eb1-b6789da54202', null, null);
INSERT INTO `moduleelement` VALUES ('3dc0ec4d-bf86-4bae-9ec0-1d6c2403fb99', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '', '1', '92b00259-2d15-43e7-9321-adffb29e8bf2', null, null);
INSERT INTO `moduleelement` VALUES ('44075557-496e-4dde-bb75-7b69f51ab4fe', 'btnEdit', '编辑', '', 0x656469742829, '&#xe642;', 'layui-btn-normal', '编辑模块', '2', 'bc80478d-0547-4437-9cff-be4b40144bdf', null, null);
INSERT INTO `moduleelement` VALUES ('4bfa8ea0-6b0d-426f-8687-b654575ca780', 'btnEdit', '编辑', '', 0x656469742829, '&#xe642;', 'layui-btn-normal', '编辑资源', '2', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', null, null);
INSERT INTO `moduleelement` VALUES ('4f2737db-633f-4946-8a71-b08b9885f151', 'btnEdit', '编辑', '', 0x656469742829, '&#xe642;', 'layui-btn-normal', '', '2', '92b00259-2d15-43e7-9321-adffb29e8bf2', null, null);
INSERT INTO `moduleelement` VALUES ('50c9df24-b233-42cb-9a0d-4ce158c75f86', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '添加用戶', '0', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', null, null);
INSERT INTO `moduleelement` VALUES ('584c7a3b-d28a-47b4-8648-7797d05d83d1', 'btnDel', '删除', '', 0x64656C2829, '&#xe640;', 'layui-btn-danger', '', '3', '9486ff22-b696-4d7f-8093-8a3e53c45453', null, null);
INSERT INTO `moduleelement` VALUES ('5ed1681c-13d2-4c87-8675-a8d95c0b40ae', 'btnAddMenu', '添加菜单', '', 0x61737369676E427574746F6E2829, '&#xe654;', 'layui-btn-normal', '为模块分配按钮', '4', 'bc80478d-0547-4437-9cff-be4b40144bdf', null, null);
INSERT INTO `moduleelement` VALUES ('5ed1681c-13d2-4c87-8676-a8d95c0b40ae', 'btnEditMenu', '编辑菜单', '', '', '&#xe642;', 'layui-btn-normal', '编辑菜单', '5', 'bc80478d-0547-4437-9cff-be4b40144bdf', null, null);
INSERT INTO `moduleelement` VALUES ('5ed1681c-13d2-4c87-8677-a8d95c0b40ae', 'btnDelMenu', '删除菜单', '', '', '', 'layui-btn-danger', '', '6', 'bc80478d-0547-4437-9cff-be4b40144bdf', '', '');
INSERT INTO `moduleelement` VALUES ('645b40ac-4223-44a7-aab4-66eb56cf9864', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '添加角色', '0', 'bedb41a2-f310-4775-af99-01be08adda93', null, null);
INSERT INTO `moduleelement` VALUES ('6839a297-350b-4215-b680-4e5dfdae5615', 'btnAssignReource', '为用户分配资源', '', 0x6F70656E5573657252656F75726365416363657373287468697329, '', 'layui-btn-normal', '为用户分配资源', '4', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', null, null);
INSERT INTO `moduleelement` VALUES ('68484265-7802-4f06-b024-33e8b2f2edcf', 'btnAdd', '新的申请', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '申请物品', '0', '9486ff22-b696-4d7f-8093-8a3e53c45453', null, null);
INSERT INTO `moduleelement` VALUES ('68fc793f-069f-43e1-a012-42ac2d7c585c', 'btnDel', '删除', '', 0x64656C2829, '&#xe640;', 'layui-btn-danger', '删除角色', '2', 'bedb41a2-f310-4775-af99-01be08adda93', null, null);
INSERT INTO `moduleelement` VALUES ('6c814946-db5c-48bd-84dd-b1c38196ad74', 'btnAdd', '添加模版', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '', '0', '0031262c-689c-4b96-bae2-2c9d67076ade', null, null);
INSERT INTO `moduleelement` VALUES ('6db928fe-93df-460f-9472-8bb0b6cae52c', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '添加进出库', '0', '89c3bfbe-246f-4112-8eb1-b6789da54202', null, null);
INSERT INTO `moduleelement` VALUES ('79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', 'btnVerification', '处理', '', 0x766572696669636174696F6E466F726D2829, '&#xe610;', 'layui-btn-normal', '', '5', '4abafc83-c8f5-452f-9882-e113a86e7a3e', null, null);
INSERT INTO `moduleelement` VALUES ('7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', 'btnDel', '删除', '', 0x64656C2829, '&#xe640;', 'layui-btn-danger', '删除部门', '0', '6a9e1346-0c01-44d2-8eb1-f929fdab542a', null, null);
INSERT INTO `moduleelement` VALUES ('7f071c63-1620-4486-9264-5806b2e63218', 'btnAccessRole', '为用户分配角色', '', 0x6F70656E55736572526F6C65416363657373287468697329, '', 'layui-btn-normal', '为用户分配角色', '5', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', null, null);
INSERT INTO `moduleelement` VALUES ('816b12b3-e916-446d-a2fa-329cfd13c831', 'btnDetail', '进度详情', '', '', '&#xe60a;', 'layui-btn-normal', '', '4', '9486ff22-b696-4d7f-8093-8a3e53c45453', null, null);
INSERT INTO `moduleelement` VALUES ('826b12b3-e916-446d-a2fa-329cfd13c831', 'btnDetail', '进度详情', '', '', '&#xe60a;', 'layui-btn-normal', '', '4', '4abafc83-c8f5-452f-9882-e113a86e7a3e', null, null);
INSERT INTO `moduleelement` VALUES ('84694ea5-d6e1-4a65-8a59-7b5b779688d4', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '添加模块', '1', 'bc80478d-0547-4437-9cff-be4b40144bdf', null, null);
INSERT INTO `moduleelement` VALUES ('84e38920-f6e5-499c-bf52-a3c6f8499ff7', 'btnDelStock', '删除', 0x20, 0x64656C2829, '&#xe640;', 'layui-btn-danger', '删除分类', '0', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', null, null);
INSERT INTO `moduleelement` VALUES ('8966b04f-8e26-4046-8b03-0c64f9f833dd', 'btnDel', '删除', '', 0x64656C2829, '&#xe640;', 'layui-btn-danger', '', '3', '92b00259-2d15-43e7-9321-adffb29e8bf2', null, null);
INSERT INTO `moduleelement` VALUES ('9c96e485-84a6-45f0-b6a7-f01dab94b0c6', 'btnPreview', '预览', '', 0x707265766965772829, '', 'layui-btn-normal', '', '4', '92b00259-2d15-43e7-9321-adffb29e8bf2', null, null);
INSERT INTO `moduleelement` VALUES ('9e2c6754-f258-4b14-96a0-b9d981196a65', 'btnAdd', '添加', '', 0x6164642829, '&#xe654;', 'layui-btn-normal', '添加资源', '0', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', null, null);
INSERT INTO `moduleelement` VALUES ('b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', 'btnDetail', '查看详情', '', '', '&#xe60a;', 'layui-btn-normal', '', '0', '37bb9414-19a0-4223-9056-71f8c758a930', '', '');
INSERT INTO `moduleelement` VALUES ('c3d7b478-21e9-4c1e-b866-a3c80be7909b', 'btnRefresh', '刷新', '', 0x726566726573682829, '&#xe615;', 'layui-btn-normal', '刷新分类', '0', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807', null, null);
INSERT INTO `moduleelement` VALUES ('c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', 'btnDel', '删除', '', 0x64656C2829, '&#xe640;', 'layui-btn-danger', '删除进出库', '0', '89c3bfbe-246f-4112-8eb1-b6789da54202', null, null);
INSERT INTO `moduleelement` VALUES ('c7d7daf0-3669-4a22-8bed-b092617deb9c', 'btnDel', '删除', '', 0x64656C2829, '&#xe640;', 'layui-btn-danger', '删除资源', '3', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', null, null);
INSERT INTO `moduleelement` VALUES ('d1ba6a72-ba14-44c0-baba-46d0ad96fe8a', 'btnRefresh', '刷新', '', 0x726566726573682829, '&#xe615;', 'layui-btn-normal', '刷新用户', '3', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', null, null);
INSERT INTO `moduleelement` VALUES ('d352c8ee-3dff-4d28-a0de-903ae68f2533', 'btnPreview', '预览', '', 0x707265766965772829, '', 'layui-btn-normal', '', '1', '0031262c-689c-4b96-bae2-2c9d67076ade', null, null);
INSERT INTO `moduleelement` VALUES ('daddf3b9-71b5-45ac-b85d-5a11c522f2f4', 'btnDel', '删除', 0x20, 0x64656C2829, '&#xe640;', 'layui-btn-danger', '删除模块', '3', 'bc80478d-0547-4437-9cff-be4b40144bdf', null, null);
INSERT INTO `moduleelement` VALUES ('ef42721f-d223-4a00-a1d9-80b81121f21a', 'btnEdit', '编辑', 0x20, 0x656469742829, '&#xe642;', 'layui-btn-normal', '编辑部门', '0', '6a9e1346-0c01-44d2-8eb1-f929fdab542a', null, null);
INSERT INTO `moduleelement` VALUES ('f8dde22a-2a37-47c4-8e67-70fb3af5303e', 'btnRefresh', '刷新', '', 0x726566726573682829, '&#xe615;', 'layui-btn-normal', '刷新部门', '0', '6a9e1346-0c01-44d2-8eb1-f929fdab542a', null, null);
INSERT INTO `moduleelement` VALUES ('fa816af1-a28d-47b5-9b8b-c46e18f902e9', 'btnAccessModule', '为用户分配模块', '', 0x6F70656E557365724D6F64756C65416363657373287468697329, '', 'layui-btn-normal', '为用户分配模块', '6', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', null, null);

-- ----------------------------
-- Table structure for `org`
-- ----------------------------
DROP TABLE IF EXISTS `org`;
CREATE TABLE `org` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '流水号',
  `CascadeId` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '节点语义ID',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '组织名称',
  `HotKey` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '热键',
  `ParentName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '父节点名称',
  `IsLeaf` tinyint(4) NOT NULL COMMENT '是否叶子节点',
  `IsAutoExpand` tinyint(4) NOT NULL COMMENT '是否自动展开',
  `IconName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '节点图标文件名称',
  `Status` int(11) NOT NULL COMMENT '当前状态',
  `BizCode` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '业务对照码',
  `CustomCode` text COLLATE utf8_bin NOT NULL COMMENT '自定义扩展码',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateId` int(11) NOT NULL COMMENT '创建人ID',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `ParentId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '父节点流水号',
  `TypeName` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='组织表';

-- ----------------------------
-- Records of org
-- ----------------------------
INSERT INTO `org` VALUES ('08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', '.0.1.3.1.', '研发小组', '', '研发部', '0', '0', '', '0', '0', '', '2016-10-14 11:40:31', '0', '1', '990cb229-cc18-41f3-8e2b-13f0f0110798', null, null);
INSERT INTO `org` VALUES ('543a9fcf-4770-4fd9-865f-030e562be238', '.0.1.', '集团总部', '', '根节点', '0', '0', '', '0', '0', '', '2016-10-14 11:37:13', '0', '0', null, null, null);
INSERT INTO `org` VALUES ('86449128-d5ac-44bf-b999-f7735b7458fd', '.0.2.1.', '汇丰软件部', '', '汇丰', '0', '0', '', '0', '0', '', '2016-05-26 15:11:02', '0', '1', 'c36e43df-3a99-45da-80d9-3ac5d24f4014', null, null);
INSERT INTO `org` VALUES ('990cb229-cc18-41f3-8e2b-13f0f0110798', '.0.1.3.', '研发部', '', '集团总部', '0', '1', '', '0', '0', '', '2016-04-16 13:03:41', '0', '0', '543a9fcf-4770-4fd9-865f-030e562be238', null, null);
INSERT INTO `org` VALUES ('c36e43df-3a99-45da-80d9-3ac5d24f4014', '.0.2.', '汇丰', '', '根节点', '0', '0', '', '0', '0', '', '2016-05-26 15:10:39', '0', '1', null, null, null);

-- ----------------------------
-- Table structure for `relevance`
-- ----------------------------
DROP TABLE IF EXISTS `relevance`;
CREATE TABLE `relevance` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '流水号',
  `Description` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '描述',
  `Key` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '映射标识',
  `Status` int(11) NOT NULL COMMENT '状态',
  `OperateTime` datetime NOT NULL COMMENT '授权时间',
  `OperatorId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '授权人',
  `FirstId` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '第一个表主键ID',
  `SecondId` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '第二个表主键ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多对多关系集中映射';

-- ----------------------------
-- Records of relevance
-- ----------------------------
INSERT INTO `relevance` VALUES ('03be9b5e-38b0-4525-8431-b26d35ce6ce3', '', 'UserElement', '0', '2016-09-07 15:30:42', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '816b12b3-e916-446d-a2fa-329cfd13c831');
INSERT INTO `relevance` VALUES ('06dfd97d-17e0-42b8-bde7-40006d8c8eb2', '', 'UserElement', '0', '2018-04-06 14:50:36', '', '49df1602-f5f3-4d52-afb7-3802da619558', '584c7a3b-d28a-47b4-8648-7797d05d83d1');
INSERT INTO `relevance` VALUES ('06f4c4a2-faa8-4bad-9184-50ceb517f30b', '', 'ProcessUser', '0', '2016-09-08 16:48:14', '0', '10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7');
INSERT INTO `relevance` VALUES ('08ff97f7-17fc-4072-b29a-287135898ece', '', 'RoleResource', '0', '2016-09-04 23:20:21', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'fdf3aac3-4507-40ad-aa2f-d7f0459de252');
INSERT INTO `relevance` VALUES ('0db8bc97-207f-439d-99b7-8a37f74bccbe', '', 'RoleOrg', '0', '2018-04-09 22:48:23', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('0e2316ba-8286-45a2-8767-0e01390a3ebb', '', 'UserOrg', '0', '2017-12-11 16:18:54', '', '49df1602-f5f3-4d52-afb7-3802da619558', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('0fd5b371-b010-4846-8833-95cc1e813a32', '', 'UserElement', '0', '2016-09-07 15:31:15', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '68484265-7802-4f06-b024-33e8b2f2edcf');
INSERT INTO `relevance` VALUES ('10a76196-ba0c-4294-bb8f-dcd063eb4aab', '', 'UserOrg', '0', '2017-10-12 09:13:37', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('10e58d75-dec1-4b85-882f-9dac79ad1210', '', 'RoleResource', '0', '2016-10-21 18:08:13', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', 'ec99f670-0eca-465c-9f64-d4d5dc510b83');
INSERT INTO `relevance` VALUES ('120d7a5d-203c-4261-95f5-0125757fb386', '', 'UserElement', '0', '2016-10-20 17:01:00', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '7f071c63-1620-4486-9264-5806b2e63218');
INSERT INTO `relevance` VALUES ('13433400-a32c-4539-b988-8b417c09bc0e', '', 'UserModule', '0', '2016-09-07 15:30:06', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '9486ff22-b696-4d7f-8093-8a3e53c45453');
INSERT INTO `relevance` VALUES ('13612a4c-b20c-4bd0-a2cd-0ae47576364d', '', 'UserElement', '0', '2016-10-20 16:34:12', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'c7d7daf0-3669-4a22-8bed-b092617deb9c');
INSERT INTO `relevance` VALUES ('1490edd4-9bd3-4e71-bfa4-56f6558c1d3f', '', 'UserElement', '0', '2018-04-06 09:48:24', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '79dcd3eb-3aaf-4e08-83c9-713d8ff446fe');
INSERT INTO `relevance` VALUES ('16154fc4-d18e-44a3-bcf2-5539b168aba7', '', 'RoleElement', '0', '2016-10-24 17:25:15', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '18cc3217-28a6-49b2-9a20-080230065984');
INSERT INTO `relevance` VALUES ('16782d9e-8cce-4ec1-a343-7ad7c83c5e25', '', 'RoleOrg', '0', '2018-04-09 22:48:23', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('1740ff26-a4d0-44cc-9fab-a0105c2c60b6', '', 'UserOrg', '0', '2017-10-12 13:59:48', '', '63c9c82a-e0d3-4bde-bbd2-057cda2f5283', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('1873ed85-a88a-4236-bd40-2c416aa2576c', '', 'RoleModule', '0', '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', '7580672f-a390-4bb6-982d-9a4570cb5199');
INSERT INTO `relevance` VALUES ('19c9621c-3d23-46b7-a841-54d5c82ec8e8', '', 'UserOrg', '0', '2016-09-02 13:56:52', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('1acec4c4-0136-4e2b-a839-8676dbd6594a', '', 'ProcessUser', '0', '2016-09-14 11:38:22', '0', '6c6afe3c-349c-4198-8710-cf19c90f3afd', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7');
INSERT INTO `relevance` VALUES ('1cb94cc4-a42a-4ee1-b129-6692a83aa85c', '', 'RoleOrg', '0', '2018-04-09 22:48:28', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('1ced1564-2fea-4c04-8aea-f071fa5bb293', '', 'UserModule', '0', '2016-09-05 16:24:54', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '069475e3-c997-487a-9f29-e6a864c5c1d4');
INSERT INTO `relevance` VALUES ('1cf19b35-e2c2-436f-99b9-03ac2b232cc6', '', 'RoleElement', '0', '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '44075557-496e-4dde-bb75-7b69f51ab4fe');
INSERT INTO `relevance` VALUES ('1f1262be-cadf-4959-997a-37d40bb36493', '', 'UserOrg', '0', '2017-12-11 16:19:00', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('2014027e-0cff-41cf-974b-56126d6eaa9a', '', 'RoleElement', '0', '2016-09-05 09:22:11', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', 'c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2');
INSERT INTO `relevance` VALUES ('242e9543-3343-41d4-8816-15ffeeaef551', '', 'UserElement', '0', '2016-09-07 15:31:15', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '584c7a3b-d28a-47b4-8648-7797d05d83d1');
INSERT INTO `relevance` VALUES ('27c4d50c-32da-4dbc-88a1-84b343cdd649', '', 'UserElement', '0', '2016-10-20 17:01:00', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '6839a297-350b-4215-b680-4e5dfdae5615');
INSERT INTO `relevance` VALUES ('29b06cd6-af0c-4c63-9aba-e5431c5d62ec', '', 'UserOrg', '0', '2017-10-12 09:13:37', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('2a36a2b7-41aa-4190-b88c-75d44a56ad6e', '', 'UserModule', '0', '2017-02-06 00:14:18', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '92b00259-2d15-43e7-9321-adffb29e8bf2');
INSERT INTO `relevance` VALUES ('2bb3fddb-0f51-442e-8dbf-236beb47d8a6', '', 'RoleOrg', '0', '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('2ca288a6-d222-4328-951e-c01c3e77a0c7', '', 'RoleElement', '0', '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7f071c63-1620-4486-9264-5806b2e63218');
INSERT INTO `relevance` VALUES ('2d0fcc88-a7c0-4d33-8a08-1d688e9dde83', '', 'RoleModule', '0', '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807');
INSERT INTO `relevance` VALUES ('2d15e438-cc3a-41e9-9b13-325bfd5c804a', '', 'RoleElement', '0', '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '84e38920-f6e5-499c-bf52-a3c6f8499ff7');
INSERT INTO `relevance` VALUES ('2ebff9a4-b2d5-4a35-a7dd-2cfa2f5b0522', '', 'ProcessUser', '0', '2016-09-07 17:33:38', '0', '52cc7933-a045-4dcc-8c17-1b618bfa772b', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7');
INSERT INTO `relevance` VALUES ('2f01f6e6-b9f3-44c1-86f4-e83f6e4ad676', '', 'RoleResource', '0', '2018-04-14 14:39:56', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'OPENAUTH_LOGIN');
INSERT INTO `relevance` VALUES ('30c82d18-7892-4e5f-9aee-e4f483a858c2', '', 'UserModule', '0', '2016-09-05 16:24:55', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '9486ff22-b696-4d7f-8093-8a3e53c45453');
INSERT INTO `relevance` VALUES ('332a373c-f485-4f85-9af9-7792f7462bf1', '', 'RoleModule', '0', '2016-09-02 17:03:46', '0', '648b04c4-4ac2-4d69-bef6-07081ef27871', '89c3bfbe-246f-4112-8eb1-b6789da54202');
INSERT INTO `relevance` VALUES ('340c60fe-8b95-474c-aa04-9197903998d2', '', 'RoleModule', '0', '2016-09-04 23:20:33', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7580672f-a390-4bb6-982d-9a4570cb5199');
INSERT INTO `relevance` VALUES ('361feb63-bde2-49c7-86ec-6df3ec6f0fe3', '', 'RoleElement', '0', '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '1c870438-4260-43a5-8996-a6e1dc8bbf6a');
INSERT INTO `relevance` VALUES ('3afb470e-968a-4c46-83a2-832a91da52a9', '', 'RoleOrg', '0', '2018-04-09 22:48:28', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '543a9fcf-4770-4fd9-865f-030e562be238');
INSERT INTO `relevance` VALUES ('3bcaab20-e096-480e-a9bb-0fdb70686714', '', 'RoleElement', '0', '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'cf7388be-2677-427c-ad78-8f00f1062b96');
INSERT INTO `relevance` VALUES ('3de0359b-6331-4dc7-a00e-751f71dbadb5', '', 'ProcessUser', '0', '2016-09-28 09:23:30', '0', '68295d2a-4dfd-4c5e-81e3-9c787e2603bc', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7');
INSERT INTO `relevance` VALUES ('460d1c98-2a68-43cf-8d38-d40ceb89916f', '', 'UserOrg', '0', '2017-10-12 09:13:37', '', '3eacdedd-e93a-4816-b49c-99ba3d5323c2', '86449128-d5ac-44bf-b999-f7735b7458fd');
INSERT INTO `relevance` VALUES ('4757bb30-e4bc-4c2d-a824-947ef151d341', '', 'UserRole', '0', '2016-09-07 20:21:15', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '4980a85b-e3db-4607-bc2c-0baf0140d7df');
INSERT INTO `relevance` VALUES ('4ba3982b-f0ae-4f9a-980e-1eaedc3b5f2e', '', 'UserElement', '0', '2016-09-07 17:48:33', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '584c7a3b-d28a-47b4-8648-7797d05d83d1');
INSERT INTO `relevance` VALUES ('4c2fb006-53d6-4041-8cf6-e5d74d788897', '', 'UserModule', '0', '2018-04-06 09:48:19', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '9486ff22-b696-4d7f-8093-8a3e53c45453');
INSERT INTO `relevance` VALUES ('4c69794b-9957-4f6b-b0fb-6455fe643565', '', 'UserElement', '0', '2018-04-06 14:50:41', '', '49df1602-f5f3-4d52-afb7-3802da619558', '826b12b3-e916-446d-a2fa-329cfd13c831');
INSERT INTO `relevance` VALUES ('4e613188-0387-4d17-a60d-703b4a606d75', '', 'RoleModule', '0', '2016-09-04 23:20:33', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'bc80478d-0547-4437-9cff-be4b40144bdf');
INSERT INTO `relevance` VALUES ('4ec39ee9-9ee9-4aa9-a0db-eb0fdf8d2f00', '', 'UserElement', '0', '2018-04-06 09:48:26', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', 'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a');
INSERT INTO `relevance` VALUES ('4fde1dc6-9d73-4c7c-9238-28981858c5a6', '', 'RoleModule', '0', '2016-09-05 09:21:56', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '89c3bfbe-246f-4112-8eb1-b6789da54202');
INSERT INTO `relevance` VALUES ('5167dbcd-3a32-4ae8-827e-6f381cc58fa2', '', 'RoleElement', '0', '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'fa816af1-a28d-47b5-9b8b-c46e18f902e9');
INSERT INTO `relevance` VALUES ('53a4be87-4fa8-415b-97b5-2298ce8b17c8', '', 'UserResource', '0', '2018-04-14 14:38:03', '', '49df1602-f5f3-4d52-afb7-3802da619558', 'XXX_LOGIN');
INSERT INTO `relevance` VALUES ('54b2e9b6-1f7c-4a39-92c9-98f58429c1fc', '', 'RoleModule', '0', '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'bc80478d-0547-4437-9cff-be4b40144bdf');
INSERT INTO `relevance` VALUES ('55b10ecc-3fb3-4127-b69e-e7a3467d7a1a', '', 'RoleElement', '0', '2016-09-05 09:22:11', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '6db928fe-93df-460f-9472-8bb0b6cae52c');
INSERT INTO `relevance` VALUES ('5725ff79-43c6-4778-bbff-131cf364dab6', '', 'UserElement', '0', '2016-10-20 17:01:01', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'cf7388be-2677-427c-ad78-8f00f1062b96');
INSERT INTO `relevance` VALUES ('5903cc95-17fc-423f-9439-bcdf1f808d7b', '', 'UserOrg', '0', '2017-12-12 14:07:05', '', '229f3a49-ab27-49ce-b383-9f10ca23a9d5', '86449128-d5ac-44bf-b999-f7735b7458fd');
INSERT INTO `relevance` VALUES ('5a20d59c-6ee6-4fe2-98fe-7b35b11026ae', '', 'UserElement', '0', '2016-09-07 15:30:19', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '68484265-7802-4f06-b024-33e8b2f2edcf');
INSERT INTO `relevance` VALUES ('5b2d5db8-d603-4be3-add2-c85ef3c53ddc', '', 'UserResource', '0', '2018-04-14 14:38:05', '', '49df1602-f5f3-4d52-afb7-3802da619558', 'OPENAUTH_LOGIN');
INSERT INTO `relevance` VALUES ('5ed71f83-0023-42c3-a77a-979d22d12fc7', '', 'RoleOrg', '0', '2018-04-09 22:48:28', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('620b368a-7b56-4c74-ab85-8bc91d08ddc9', '', 'RoleElement', '0', '2016-09-04 23:20:41', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '1c9acc3e-a40d-4d07-b495-6e60eb9b71b9');
INSERT INTO `relevance` VALUES ('6431a464-6f1f-4ffc-8157-89212b70f09a', '', 'RoleOrg', '0', '2016-09-05 00:00:00', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('648500cc-e1e6-426d-9f17-c6061ce606a1', '', 'UserOrg', '0', '2017-12-11 16:19:05', '', 'de8be521-f1ec-4483-b124-0be342890507', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('64e4f5aa-28ef-4690-9b20-5f0b543964f6', '', 'UserElement', '0', '2016-09-07 15:30:19', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '816b12b3-e916-446d-a2fa-329cfd13c831');
INSERT INTO `relevance` VALUES ('6645b6fb-efcf-4e48-9c13-84f79bc5be34', '', 'RoleOrg', '0', '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '86449128-d5ac-44bf-b999-f7735b7458fd');
INSERT INTO `relevance` VALUES ('66e25fc5-093d-42ab-85dc-a38f6600889b', '', 'UserOrg', '0', '2016-09-02 13:57:32', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', 'c36e43df-3a99-45da-80d9-3ac5d24f4014');
INSERT INTO `relevance` VALUES ('68912e65-256e-45b6-b48e-036382598d32', '', 'RoleOrg', '0', '2016-10-17 10:03:49', '0', '2eb423d6-6ad9-4efe-b423-872478a2a434', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('69dae19a-d92c-4fb6-b969-3c7560d999c4', '', 'UserOrg', '0', '2017-12-11 16:19:00', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('6b9c4789-042c-4f6f-a749-ee68ee87462d', '', 'ProcessUser', '0', '2016-10-27 16:47:51', '0', '054ff054-d8ae-4911-a596-8fb1f66b348f', '3a95e392-07d4-4af3-b30d-140ca93340f5');
INSERT INTO `relevance` VALUES ('6da6d662-8cef-47cd-80b3-fa885b2dca7a', '', 'RoleOrg', '0', '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('6db5666b-6f8c-4e83-bada-0b45054bd9a4', '', 'RoleElement', '0', '2016-09-04 23:20:41', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '0d25438e-1436-48e0-aedf-0f1690693282');
INSERT INTO `relevance` VALUES ('6fe52499-f800-47ce-96fc-a2b5b43505d5', '', 'UserElement', '0', '2018-04-06 09:48:22', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '584c7a3b-d28a-47b4-8648-7797d05d83d1');
INSERT INTO `relevance` VALUES ('715d017a-68b6-468d-aa3f-32ca4cfd4b9e', '', 'RoleModule', '0', '2016-09-04 23:20:33', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'bedb41a2-f310-4775-af99-01be08adda93');
INSERT INTO `relevance` VALUES ('72b2344b-c62a-470e-9c74-83f5b1cf68f1', '', 'RoleOrg', '0', '2018-04-09 22:48:42', '', '3e761e88-ddf7-4a62-b219-9a315b4564f2', 'c36e43df-3a99-45da-80d9-3ac5d24f4014');
INSERT INTO `relevance` VALUES ('72bf4729-af60-42f5-b0d7-717362ffad7f', '', 'RoleElement', '0', '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '2feefce1-e3d8-42ac-b811-2352679628da');
INSERT INTO `relevance` VALUES ('7475b0c3-f204-4f95-a22f-80591fe76bc7', '', 'ProcessUser', '0', '2016-10-31 11:52:39', '0', 'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7');
INSERT INTO `relevance` VALUES ('74f4a3a3-b84b-4ad7-bca1-c85494e01e8e', '', 'UserOrg', '0', '2017-12-11 16:18:54', '', '49df1602-f5f3-4d52-afb7-3802da619558', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('75340ad3-fb80-4646-b1de-ba801688ddc2', '', 'RoleElement', '0', '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '5ed1681c-13d2-4c87-8675-a8d95c0b40ae');
INSERT INTO `relevance` VALUES ('77bd93da-2c2b-4ba8-bf05-3a1382811a6a', '', 'RoleModule', '0', '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91');
INSERT INTO `relevance` VALUES ('77eec82a-f713-4584-872c-761fdbcdb456', '', 'UserElement', '0', '2018-04-06 14:50:37', '', '49df1602-f5f3-4d52-afb7-3802da619558', '68484265-7802-4f06-b024-33e8b2f2edcf');
INSERT INTO `relevance` VALUES ('77fc08e6-98ae-4d33-b294-bd9fed5b14ed', '', 'UserElement', '0', '2018-04-06 14:50:36', '', '49df1602-f5f3-4d52-afb7-3802da619558', '816b12b3-e916-446d-a2fa-329cfd13c831');
INSERT INTO `relevance` VALUES ('797c6e5f-7f3c-4891-89b9-a054e10f6c00', '', 'UserModule', '0', '2018-04-06 09:48:01', '', '49df1602-f5f3-4d52-afb7-3802da619558', '37bb9414-19a0-4223-9056-71f8c758a930');
INSERT INTO `relevance` VALUES ('7f25286f-246b-4143-98eb-c3e574fe7455', '', 'ProcessUser', '0', '2016-09-07 17:33:38', '0', '52cc7933-a045-4dcc-8c17-1b618bfa772b', '3a95e392-07d4-4af3-b30d-140ca93340f5');
INSERT INTO `relevance` VALUES ('7fd7f976-f10e-44aa-a7ba-7ca40d2e8f90', '', 'RoleOrg', '0', '2016-10-17 10:03:30', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('80310629-5e52-482c-9a0f-5c5bdfabcd9e', '', 'RoleOrg', '0', '2016-09-05 00:00:00', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('832f4a8f-7791-4aa6-bcd2-20dcb6f5ef37', '', 'UserElement', '0', '2016-09-02 14:53:04', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '15a4f88c-4fae-4cab-ba2f-0cbd2cca8736');
INSERT INTO `relevance` VALUES ('84a52091-08a0-4a46-b661-3cd206771c29', '', 'RoleModule', '0', '2016-09-04 23:20:33', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '0031262c-689c-4b96-bae2-2c9d67076ade');
INSERT INTO `relevance` VALUES ('854e0658-ab8a-4869-b157-9941955acdc6', '', 'RoleElement', '0', '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '1a473afd-cbd4-41e9-9471-81f9435aaabe');
INSERT INTO `relevance` VALUES ('88a4c966-d042-4a2e-b133-ff7eded1c5de', '', 'RoleElement', '0', '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '7b2b1ffb-398b-4f7b-83da-8f484e1bcea0');
INSERT INTO `relevance` VALUES ('8b633f3c-965b-4e35-8496-c364890d7760', '', 'RoleElement', '0', '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'c3d7b478-21e9-4c1e-b866-a3c80be7909b');
INSERT INTO `relevance` VALUES ('92f0b297-96c1-47d4-84dd-571374431bc0', '', 'RoleElement', '0', '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '84694ea5-d6e1-4a65-8a59-7b5b779688d4');
INSERT INTO `relevance` VALUES ('93bcac7a-0ff1-488c-8d1c-3da7e44cbefc', '', 'RoleElement', '0', '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a');
INSERT INTO `relevance` VALUES ('960224e6-5910-472b-a5ef-b2aa9a8b106f', '', 'UserRole', '0', '2016-09-06 17:06:15', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', 'db309d88-fd21-4b81-a4d9-ae6276a1d813');
INSERT INTO `relevance` VALUES ('962b278b-0894-4b36-b1a0-6c5c3d11d4c3', '', 'UserElement', '0', '2018-04-06 14:50:16', '', '49df1602-f5f3-4d52-afb7-3802da619558', 'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a');
INSERT INTO `relevance` VALUES ('965f010b-2fd6-4b34-ba23-3e44c1af2877', '', 'RoleOrg', '0', '2016-09-08 16:19:17', '0', '36094f5d-07e7-40d5-91dc-ff60f98b496a', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('9ad706e3-8e6b-4bc7-a502-371b298ef062', '', 'RoleElement', '0', '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'ef42721f-d223-4a00-a1d9-80b81121f21a');
INSERT INTO `relevance` VALUES ('9d568d6d-d78d-47d6-8fb6-b1327cdbe83a', '', 'RoleModule', '0', '2016-09-04 23:20:33', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'a94d5648-c2a9-405e-ba6f-f1602ec9b807');
INSERT INTO `relevance` VALUES ('9e46a946-6e81-4f61-bcba-21e4f7fac3df', '', 'RoleModule', '0', '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c');
INSERT INTO `relevance` VALUES ('9e57e1ff-e9cf-4600-a872-ac85f7845bb0', '', 'RoleOrg', '0', '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', 'c36e43df-3a99-45da-80d9-3ac5d24f4014');
INSERT INTO `relevance` VALUES ('9edc7b81-2b51-4193-8805-6062e596ccdc', '', 'UserOrg', '0', '2016-09-02 13:57:32', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('9fa50449-5d87-4579-9f1f-9cdcd876976b', '', 'RoleElement', '0', '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '6839a297-350b-4215-b680-4e5dfdae5615');
INSERT INTO `relevance` VALUES ('a051aa08-38da-4b6d-8d90-10b3c2485e4b', '', 'RoleOrg', '0', '2016-09-05 00:00:00', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '543a9fcf-4770-4fd9-865f-030e562be238');
INSERT INTO `relevance` VALUES ('a06fe8c6-3f5e-4085-9bbf-e366571a356c', '', 'RoleElement', '0', '2016-09-04 23:21:04', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'daddf3b9-71b5-45ac-b85d-5a11c522f2f4');
INSERT INTO `relevance` VALUES ('a0904102-e26a-4bc5-9c95-ed5ef977586b', '', 'RoleModule', '0', '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', '6a9e1346-0c01-44d2-8eb1-f929fdab542a');
INSERT INTO `relevance` VALUES ('a5bef7bf-ecdb-4480-ad64-b39a02269607', '', 'UserModule', '0', '2018-04-06 09:48:37', '', '49df1602-f5f3-4d52-afb7-3802da619558', '069475e3-c997-487a-9f29-e6a864c5c1d4');
INSERT INTO `relevance` VALUES ('a8094b46-de5a-40ea-a8ee-69ea905480ef', '', 'RoleModule', '0', '2016-09-05 09:21:56', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '069475e3-c997-487a-9f29-e6a864c5c1d4');
INSERT INTO `relevance` VALUES ('a8123b37-ba70-4aab-aef6-1938733b5210', '', 'RoleElement', '0', '2016-09-04 23:20:41', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'c0d8505c-061a-467d-862a-c94f27caa208');
INSERT INTO `relevance` VALUES ('a9821db0-49bd-49be-a554-afa811c99760', '', 'RoleResource', '0', '2016-09-04 23:20:21', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'ec99f670-0eca-465c-9f64-d4d5dc510b83');
INSERT INTO `relevance` VALUES ('aa051096-a23a-431d-9053-bb954f9453a7', '', 'RoleElement', '0', '2016-09-04 23:20:53', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '4bfa8ea0-6b0d-426f-8687-b654575ca780');
INSERT INTO `relevance` VALUES ('ab84b111-fb5d-4ddd-99d5-479954d9d521', '', 'RoleOrg', '0', '2016-09-08 16:19:18', '0', '36094f5d-07e7-40d5-91dc-ff60f98b496a', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('ab924ba7-8a74-4804-82b0-ecbbedf4c13e', '', 'RoleElement', '0', '2016-09-05 09:22:11', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '38109ca0-32ec-44bd-a243-017e591b532b');
INSERT INTO `relevance` VALUES ('ac184827-9899-4b40-8939-61fe9d2b187c', '', 'UserElement', '0', '2016-09-07 17:48:49', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '584c7a3b-d28a-47b4-8648-7797d05d83d1');
INSERT INTO `relevance` VALUES ('acb4d37f-8b45-4a99-b364-99f3881dfcda', '', 'RoleElement', '0', '2016-09-04 23:21:13', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'f8dde22a-2a37-47c4-8e67-70fb3af5303e');
INSERT INTO `relevance` VALUES ('acc51898-5335-4903-83b9-4701a782bc4d', '', 'UserElement', '0', '2016-10-20 17:01:01', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'fa816af1-a28d-47b5-9b8b-c46e18f902e9');
INSERT INTO `relevance` VALUES ('ad267296-5eba-4d59-b821-8148d8cfb3c6', '', 'RoleModule', '0', '2016-09-04 23:20:33', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'e8dc5db6-4fc4-4795-a1cc-681cbcceec91');
INSERT INTO `relevance` VALUES ('ad29467e-eeee-494c-ab82-f6be5d2619d5', '', 'RoleElement', '0', '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '50c9df24-b233-42cb-9a0d-4ce158c75f86');
INSERT INTO `relevance` VALUES ('ad5bc7a6-e307-4fa8-a4ef-ce9e09f7e21b', '', 'RoleModule', '0', '2016-09-05 09:21:56', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '9486ff22-b696-4d7f-8093-8a3e53c45453');
INSERT INTO `relevance` VALUES ('af263192-daa8-4f29-99b9-1efb96e31627', '', 'RoleElement', '0', '2016-09-04 23:20:41', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '645b40ac-4223-44a7-aab4-66eb56cf9864');
INSERT INTO `relevance` VALUES ('b08d7763-a725-406f-a7d5-d144f00d716e', '', 'UserOrg', '0', '2016-09-02 13:56:41', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '543a9fcf-4770-4fd9-865f-030e562be238');
INSERT INTO `relevance` VALUES ('b241dd3d-2965-44e4-929d-9dacb6444e09', '', 'RoleOrg', '0', '2018-04-14 13:16:45', '', '77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '543a9fcf-4770-4fd9-865f-030e562be238');
INSERT INTO `relevance` VALUES ('b2490ac0-ba16-48a2-b39d-49f6b87f9387', '', 'UserModule', '0', '2018-04-06 09:48:17', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '069475e3-c997-487a-9f29-e6a864c5c1d4');
INSERT INTO `relevance` VALUES ('b2edfee4-f980-4aa5-b547-492d677e0674', '', 'RoleModule', '0', '2016-09-04 23:20:33', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c');
INSERT INTO `relevance` VALUES ('b3b8f695-a179-489b-90b4-7814ab048a69', '', 'UserElement', '0', '2018-04-06 09:48:21', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '816b12b3-e916-446d-a2fa-329cfd13c831');
INSERT INTO `relevance` VALUES ('b672a830-c3a5-408b-a746-65608534b24c', '', 'UserModule', '0', '2017-12-15 17:07:05', '', '49df1602-f5f3-4d52-afb7-3802da619558', '9486ff22-b696-4d7f-8093-8a3e53c45453');
INSERT INTO `relevance` VALUES ('b9e63d17-35c8-4456-abab-8f43a1c99adc', '', 'UserModule', '0', '2018-04-06 09:47:59', '', '49df1602-f5f3-4d52-afb7-3802da619558', '4abafc83-c8f5-452f-9882-e113a86e7a3e');
INSERT INTO `relevance` VALUES ('bbdc3ea9-3f21-48b0-9d7a-39545d6183d0', '', 'UserElement', '0', '2018-04-06 09:48:24', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '826b12b3-e916-446d-a2fa-329cfd13c831');
INSERT INTO `relevance` VALUES ('bd783f53-23fa-41f4-8cec-7c61fab52072', '', 'UserOrg', '0', '2018-03-15 09:19:05', '', '0ceff0f8-f848-440c-bc26-d8605ac858cd', '86449128-d5ac-44bf-b999-f7735b7458fd');
INSERT INTO `relevance` VALUES ('bda5f089-64d6-4fb8-9012-d7f3ff36902a', '', 'UserOrg', '0', '2017-10-12 13:59:09', '', 'ffd92ed2-5330-4ec2-a42d-6e0e9005db3b', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('bee6572d-8fb8-4e0e-af15-93aafc989717', '', 'RoleElement', '0', '2016-09-04 23:20:41', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '68fc793f-069f-43e1-a012-42ac2d7c585c');
INSERT INTO `relevance` VALUES ('c14addeb-1812-4a78-9152-1f7115b22d89', '', 'UserRole', '0', '2016-09-05 00:00:47', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', 'db309d88-fd21-4b81-a4d9-ae6276a1d813');
INSERT INTO `relevance` VALUES ('c2d3b7d6-b47d-4bd8-9dc6-d9134d86713f', '', 'RoleOrg', '0', '2016-10-17 10:03:30', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '86449128-d5ac-44bf-b999-f7735b7458fd');
INSERT INTO `relevance` VALUES ('c3050d65-d26b-4e46-bece-a212b0cc00ec', '', 'RoleElement', '0', '2016-09-04 23:20:41', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '15a4f88c-4fae-4cab-ba2f-0cbd2cca8736');
INSERT INTO `relevance` VALUES ('c4771ac5-3375-4de9-adb8-a603398f0d62', '', 'RoleElement', '0', '2016-09-04 23:21:09', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '2d595a2a-5de5-479e-a331-b53c799a6b10');
INSERT INTO `relevance` VALUES ('c50fae2a-b36f-486f-9d53-e58406590101', '', 'ProcessUser', '0', '2016-10-27 16:47:51', '0', '054ff054-d8ae-4911-a596-8fb1f66b348f', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7');
INSERT INTO `relevance` VALUES ('c58cb482-6ab7-49eb-b5b0-e45424b6e502', '', 'RoleElement', '0', '2016-09-04 23:21:00', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '34730f5a-d307-457b-9041-5f7de30abfa9');
INSERT INTO `relevance` VALUES ('c733cfbe-2f71-41e4-92a6-4ff97cf88dc4', '', 'UserModule', '0', '2018-04-06 09:48:18', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '4abafc83-c8f5-452f-9882-e113a86e7a3e');
INSERT INTO `relevance` VALUES ('c81aaf5c-6bfa-4105-8b45-cb7959b62572', '', 'RoleOrg', '0', '2018-04-09 22:48:42', '', '3e761e88-ddf7-4a62-b219-9a315b4564f2', '86449128-d5ac-44bf-b999-f7735b7458fd');
INSERT INTO `relevance` VALUES ('c8dc4685-7beb-4e42-960c-96174da1b756', '', 'RoleOrg', '0', '2018-04-09 22:48:23', '', '09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '543a9fcf-4770-4fd9-865f-030e562be238');
INSERT INTO `relevance` VALUES ('c9099371-8d4e-4f5b-9686-2c60a2c1c641', '', 'ProcessUser', '0', '2016-09-08 16:48:14', '0', '10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', '3a95e392-07d4-4af3-b30d-140ca93340f5');
INSERT INTO `relevance` VALUES ('c98b3d02-a76b-4ecc-94a5-cfeffd5e29fb', '', 'RoleModule', '0', '2016-09-02 17:03:39', '0', '211e12c7-e466-496e-8d26-0660a38e24cc', 'bedb41a2-f310-4775-af99-01be08adda93');
INSERT INTO `relevance` VALUES ('ccae4f18-f33b-4656-9e59-93b9e29fc4b4', '', 'UserOrg', '0', '2017-12-12 14:07:11', '', '1df68dfd-3b6d-4491-872f-00a0fc6c5a64', '86449128-d5ac-44bf-b999-f7735b7458fd');
INSERT INTO `relevance` VALUES ('da6c0645-0bf9-4ade-9dd3-1b09e91e504c', '', 'RoleElement', '0', '2016-09-05 09:22:06', '0', '4980a85b-e3db-4607-bc2c-0baf0140d7df', '816b12b3-e916-446d-a2fa-329cfd13c831');
INSERT INTO `relevance` VALUES ('df2d90b3-4e2e-40e9-b406-220009726460', '', 'RoleModule', '0', '2016-09-04 23:20:33', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '6a9e1346-0c01-44d2-8eb1-f929fdab542a');
INSERT INTO `relevance` VALUES ('dfd5430b-3422-465a-be79-05a1e06deed2', '', 'RoleElement', '0', '2016-09-04 23:20:53', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', 'c7d7daf0-3669-4a22-8bed-b092617deb9c');
INSERT INTO `relevance` VALUES ('e12b77de-b7ce-4f38-b7a3-f3b2d285f33b', '', 'RoleOrg', '0', '2016-10-17 10:03:49', '0', '2eb423d6-6ad9-4efe-b423-872478a2a434', '08f41bf6-4388-4b1e-bd3e-2ff538b44b1b');
INSERT INTO `relevance` VALUES ('e28c0dcd-168a-4b60-a514-7b6eb8026709', '', 'RoleOrg', '0', '2016-10-17 10:03:30', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '990cb229-cc18-41f3-8e2b-13f0f0110798');
INSERT INTO `relevance` VALUES ('e619a82e-edfb-4542-94df-0b92850667ad', '', 'RoleResource', '0', '2018-04-14 14:39:55', '', '0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', 'OPENAUTH_MODIFYACCOUNT');
INSERT INTO `relevance` VALUES ('e785147c-f46b-474f-8fad-73b14fa69822', '', 'UserRole', '0', '2016-09-06 17:06:28', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '4980a85b-e3db-4607-bc2c-0baf0140d7df');
INSERT INTO `relevance` VALUES ('e84f6b9c-716d-4e94-a1aa-7fd0d1a2e23e', '', 'RoleModule', '0', '2016-09-02 17:03:46', '0', '648b04c4-4ac2-4d69-bef6-07081ef27871', '069475e3-c997-487a-9f29-e6a864c5c1d4');
INSERT INTO `relevance` VALUES ('e9cf3d63-6305-46c7-93b4-14053387c62c', '', 'UserModule', '0', '2018-04-06 09:48:18', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '37bb9414-19a0-4223-9056-71f8c758a930');
INSERT INTO `relevance` VALUES ('ec72f6ae-09ee-4db9-99a1-bf15c8e35dda', '', 'ProcessUser', '0', '2016-09-14 11:38:22', '0', '6c6afe3c-349c-4198-8710-cf19c90f3afd', '3a95e392-07d4-4af3-b30d-140ca93340f5');
INSERT INTO `relevance` VALUES ('ec9c80ce-dbdf-4ba5-9091-82f75392c3b0', '', 'UserElement', '0', '2016-09-07 15:30:42', '0', '3a95e392-07d4-4af3-b30d-140ca93340f5', '68484265-7802-4f06-b024-33e8b2f2edcf');
INSERT INTO `relevance` VALUES ('ee1986a0-24cc-4dec-b5f5-68ef959ab650', '', 'UserElement', '0', '2018-04-06 14:50:39', '', '49df1602-f5f3-4d52-afb7-3802da619558', '79dcd3eb-3aaf-4e08-83c9-713d8ff446fe');
INSERT INTO `relevance` VALUES ('ee4f39fd-4fbf-4f68-9a70-d6c7d7db9723', '', 'ProcessUser', '0', '2016-10-31 11:52:39', '0', 'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', '3a95e392-07d4-4af3-b30d-140ca93340f5');
INSERT INTO `relevance` VALUES ('eec41fcb-61c0-4e56-a5c0-a9f8be6e6fdc', '', 'UserModule', '0', '2016-09-07 15:30:06', '0', '3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', '069475e3-c997-487a-9f29-e6a864c5c1d4');
INSERT INTO `relevance` VALUES ('f4ba636a-9002-43e6-93eb-95132a3e68c5', '', 'ProcessUser', '0', '2016-09-28 09:23:30', '0', '68295d2a-4dfd-4c5e-81e3-9c787e2603bc', '3a95e392-07d4-4af3-b30d-140ca93340f5');
INSERT INTO `relevance` VALUES ('f579a427-a9ed-4ebe-8411-72e8e6abd01d', '', 'UserElement', '0', '2016-09-05 16:25:26', '0', 'ea25646b-964b-4d41-ab03-d8964e1494fb', '816b12b3-e916-446d-a2fa-329cfd13c831');
INSERT INTO `relevance` VALUES ('f61ee29b-7988-404d-b692-5a8f667684be', '', 'UserElement', '0', '2018-04-06 09:48:22', '', '6ba79766-faa0-4259-8139-a4a6d35784e0', '68484265-7802-4f06-b024-33e8b2f2edcf');
INSERT INTO `relevance` VALUES ('f6367ca1-0486-46a4-b9c6-65c00936a516', '', 'RoleElement', '0', '2016-09-04 23:20:53', '0', 'db309d88-fd21-4b81-a4d9-ae6276a1d813', '9e2c6754-f258-4b14-96a0-b9d981196a65');
INSERT INTO `relevance` VALUES ('fa7c4d39-b31a-4668-8716-d40a62aa722b', '', 'UserOrg', '0', '2017-10-12 13:59:48', '', '63c9c82a-e0d3-4bde-bbd2-057cda2f5283', '990cb229-cc18-41f3-8e2b-13f0f0110798');

-- ----------------------------
-- Table structure for `resource`
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '资源标识',
  `CascadeId` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '节点语义ID',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `Description` text COLLATE utf8_bin NOT NULL COMMENT '描述',
  `ParentName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '父节点名称',
  `ParentId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '父节点流ID',
  `AppId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '资源所属应用ID',
  `AppName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '所属应用名称',
  `TypeName` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '分类ID',
  `Disable` tinyint(4) NOT NULL COMMENT '是否可用',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='资源表';

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('OPENAUTH_DELETEACCOUNT', '', '注销账号', '0', 0x6F70656E617574682E6E6574E6B3A8E99480E8B4A6E58FB7E79A84E69D83E99990, '', '', '110', 'OpenAuth.Net', '', '', '0');
INSERT INTO `resource` VALUES ('OPENAUTH_LOGIN', '', '登陆', '0', 0x6F70656E617574682E6E6574E799BBE99986E79A84E69D83E99990, '', '', '110', 'OpenAuth.Net', '', '', '0');
INSERT INTO `resource` VALUES ('OPENAUTH_MODIFYACCOUNT', '', '修改账号', '0', 0x6F70656E617574682E6E6574E4BFAEE694B9E8B4A6E58FB7E79A84E69D83E99990, '', '', '110', 'OpenAuth.Net', '', '', '0');
INSERT INTO `resource` VALUES ('XXX_LOGIN', '', '登陆', '0', 0xE799BBE99986787878E5B9B3E58FB0E79A84E69D83E99990, '', '', '119', 'XXX管理平台', '', '', '0');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Id',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `Status` int(11) NOT NULL COMMENT '当前状态',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人ID',
  `TypeName` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', '管理员', '1', '2018-04-09 22:48:23', '', '', '');
INSERT INTO `role` VALUES ('0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', '测试', '1', '2018-04-09 22:48:28', '', '', '');
INSERT INTO `role` VALUES ('3e761e88-ddf7-4a62-b219-9a315b4564f2', '汇丰测试', '1', '2018-04-09 22:48:42', '', '', '');
INSERT INTO `role` VALUES ('77e6d0c3-f9e1-4933-92c3-c1c6eef75593', '神', '1', '2018-04-14 13:16:45', '', '', '');

-- ----------------------------
-- Table structure for `stock`
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '数据ID',
  `Name` text COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `Number` int(11) NOT NULL COMMENT '产品数量',
  `Price` decimal(10,1) NOT NULL COMMENT '产品单价',
  `Status` int(11) NOT NULL COMMENT '出库/入库',
  `Viewable` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '可见范围',
  `User` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '操作人',
  `Time` datetime NOT NULL COMMENT '操作时间',
  `OrgId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '组织ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出入库信息表';

-- ----------------------------
-- Records of stock
-- ----------------------------

-- ----------------------------
-- Table structure for `test`
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL,
  `data_1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `data_2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `data_3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `checkboxs_0` int(11) NOT NULL,
  `data_7` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `data_8` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `data_9` longtext COLLATE utf8_bin,
  `data_10` longtext COLLATE utf8_bin,
  `data_11` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of test
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `Id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '流水号',
  `Account` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '用户登录帐号',
  `Password` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '用户姓名',
  `Sex` int(11) NOT NULL COMMENT '性别',
  `Status` int(11) NOT NULL COMMENT '用户状态',
  `BizCode` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '业务对照码',
  `CreateTime` datetime NOT NULL COMMENT '经办时间',
  `CrateId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `TypeName` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户基本信息表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('0ceff0f8-f848-440c-bc26-d8605ac858cd', 'test5', 'test5', 'test5', '1', '1', '', '2018-03-15 09:19:04', '', '', '');
INSERT INTO `user` VALUES ('1df68dfd-3b6d-4491-872f-00a0fc6c5a64', 'test4', 'test4', 'test4', '1', '0', '', '2017-12-12 14:07:11', '', '', '');
INSERT INTO `user` VALUES ('229f3a49-ab27-49ce-b383-9f10ca23a9d5', 'test3', 'test3', 'test3', '1', '0', '', '2017-12-12 14:07:04', '', '', '');
INSERT INTO `user` VALUES ('49df1602-f5f3-4d52-afb7-3802da619558', 'admin', 'admin', 'admin', '1', '1', '', '2017-12-11 16:18:53', '', '', '');
INSERT INTO `user` VALUES ('6ba79766-faa0-4259-8139-a4a6d35784e0', 'test', 'test', 'test', '1', '1', '', '2017-12-11 16:19:00', '', '', '');
INSERT INTO `user` VALUES ('de8be521-f1ec-4483-b124-0be342890507', 'test2', 'test2', 'test2', '1', '1', '', '2017-12-11 16:19:05', '', '', '');
