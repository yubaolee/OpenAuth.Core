
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
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类表ID（可作为分类的标识）',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `Disabled` tinyint(4) NOT NULL COMMENT '是否可用',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `Icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类图标',
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '分类描述',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类类型ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表，表示一个全集，比如：男、女、未知。关联的分类类型表示按什么进行的分类，如：按照性别对人类对象集进行分类' ROW_FORMAT = Compact;

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
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资源标识',
  `CascadeId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '节点语义ID',
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `ParentName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父节点名称',
  `ParentId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父节点流ID',
  `AppId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '资源所属应用ID',
  `AppName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属应用名称',
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类ID',
  `Disable` tinyint(4) NOT NULL COMMENT '是否可用',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源表' ROW_FORMAT = Compact;

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
  `CrateId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `TypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',
  `TypeId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户基本信息表' ROW_FORMAT = Compact;


