/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : SQL Server
 Source Server Version : 11003000
 Source Host           : .:1433
 Source Catalog        : OpenAuthDB
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 11003000
 File Encoding         : 65001

 Date: 29/10/2019 23:00:51
*/


-- ----------------------------
-- Table structure for Application
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Application]') AND type IN ('U'))
	DROP TABLE [dbo].[Application]
GO

CREATE TABLE [dbo].[Application] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [AppSecret] varchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [Description] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [Icon] varchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [Disable] bit DEFAULT ((0)) NOT NULL,
  [CreateTime] date DEFAULT (getdate()) NOT NULL,
  [CreateUser] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[Application] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'AppId',
'SCHEMA', N'dbo',
'TABLE', N'Application',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用名称',
'SCHEMA', N'dbo',
'TABLE', N'Application',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用密钥',
'SCHEMA', N'dbo',
'TABLE', N'Application',
'COLUMN', N'AppSecret'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用描述',
'SCHEMA', N'dbo',
'TABLE', N'Application',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用图标',
'SCHEMA', N'dbo',
'TABLE', N'Application',
'COLUMN', N'Icon'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否可用',
'SCHEMA', N'dbo',
'TABLE', N'Application',
'COLUMN', N'Disable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建日期',
'SCHEMA', N'dbo',
'TABLE', N'Application',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'Application',
'COLUMN', N'CreateUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用',
'SCHEMA', N'dbo',
'TABLE', N'Application'
GO


-- ----------------------------
-- Records of [Application]
-- ----------------------------
INSERT INTO [dbo].[Application]  VALUES (N'110', N'OpenAuth.Net', N'openauthdotnetyubaolee', N'最好用的.NET权限工作流框架', NULL, N'0', N'2018-04-14', NULL)
GO

INSERT INTO [dbo].[Application]  VALUES (N'119', N'XXX管理平台', N'manageryubaolee', N'这是一个第三的平台', NULL, N'0', N'2018-04-14', NULL)
GO


-- ----------------------------
-- Table structure for Category
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type IN ('U'))
	DROP TABLE [dbo].[Category]
GO

CREATE TABLE [dbo].[Category] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Name] varchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [DtCode] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [DtValue] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Enable] tinyint NOT NULL,
  [SortNo] int NOT NULL,
  [Description] varchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[Category] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称或描述',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类标识',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'DtCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'通常与分类标识一致，但万一有不一样的情况呢？',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'DtValue'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序号',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'SortNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类表，也可用作数据字典。表示一个全集，比如：男、女、未知。关联的分类类型表示按什么进行的分类，如：按照性别对人类对象集',
'SCHEMA', N'dbo',
'TABLE', N'Category'
GO


-- ----------------------------
-- Records of [Category]
-- ----------------------------
INSERT INTO [dbo].[Category]  VALUES (N'01a2736c-cebe-43a2-8068-7e3f88fa7c23', N'审核', N'SYS_ORDERSTATUS_CHECK', N'SYS_ORDERSTATUS_CHECK', N'1', N'0', N'', N'SYS_ORDERSTATUS', N'2019-10-29 21:20:40.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:20:40.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'07d21d6d-3bce-4b73-8273-c9f948f468fe', N'释放', N'PICKSTATUS_RELEASE', N'PICKSTATUS_RELEASE', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:29:35.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:29:35.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'2615b6bf-7fc3-46e1-8105-708dda0e6c42', N'发货完成', N'PICKSTATUS_OUTSTOCK', N'PICKSTATUS_OUTSTOCK', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:32:02.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:32:02.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'354f50b7-0d93-43d6-a721-a4931c650ea3', N'创建', N'SYS_ORDERSTATUS_CREATE', N'SYS_ORDERSTATUS_CREATE', N'1', N'0', N'', N'SYS_ORDERSTATUS', N'2019-10-29 21:20:02.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:20:02.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'74f7bcc8-50a3-4c02-9a25-ee2fa4575e25', N'集货完成', N'PICKSTATUS_STAGED', N'PICKSTATUS_STAGED', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:31:11.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:31:11.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'8641c594-e43e-4469-a5b5-5da06a53eaf9', N'打包完成', N'PICKSTATUS_PACK', N'PICKSTATUS_PACK', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:31:50.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:31:50.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'86b8d963-63b6-4936-87b1-af248cd26c44', N'已完成', N'SYS_ORDERSTATUS_FINISHED', N'SYS_ORDERSTATUS_FINISHED', N'1', N'0', N'', N'SYS_ORDERSTATUS', N'2019-10-29 21:27:32.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:27:32.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'9bddbcfd-f41e-429f-b112-76db0c1bf0f3', N'复核完成', N'PICKSTATUS_CHECKED', N'PICKSTATUS_CHECKED', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:30:37.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:30:37.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'b1d4301b-2378-4598-9b96-8592afbb64d1', N'缓存完成', N'PICKSTATUS_CACHE', N'PICKSTATUS_CACHE', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:30:53.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:30:53.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'd2dd6a7f-797e-4ff2-96cc-56bf9fbfc24b', N'装车完成', N'PICKSTATUS_CAR', N'PICKSTATUS_CAR', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:31:27.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:31:27.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'd8152952-cf55-40ba-af81-0d4863247d6a', N'拣选完成', N'PICKSTATUS_PICKFINISH', N'PICKSTATUS_PICKFINISH', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:30:16.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:30:16.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'de4ccb7b-19e4-4203-a092-b2d8bafe3131', N'拣选执行中', N'PICKSTATUS_PICKEXECUTE', N'PICKSTATUS_PICKEXECUTE', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:29:55.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:29:55.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'e6292744-a6e8-4a6f-b077-14bd35e31a27', N'创建', N'PICKSTATUS_CREATE', N'PICKSTATUS_CREATE', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:29:18.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:29:18.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'faef67e8-48e4-44e5-981c-eebb78d79a0f', N'已处理', N'SYS_ORDERSTATUS_DISPOSED', N'SYS_ORDERSTATUS_DISPOSED', N'1', N'0', N'', N'SYS_ORDERSTATUS', N'2019-10-29 21:27:05.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:27:05.0000000', N'', N'')
GO


-- ----------------------------
-- Table structure for CategoryType
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryType]') AND type IN ('U'))
	DROP TABLE [dbo].[CategoryType]
GO

CREATE TABLE [dbo].[CategoryType] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL
)
GO

ALTER TABLE [dbo].[CategoryType] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类表ID',
'SCHEMA', N'dbo',
'TABLE', N'CategoryType',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'名称',
'SCHEMA', N'dbo',
'TABLE', N'CategoryType',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'CategoryType',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类类型',
'SCHEMA', N'dbo',
'TABLE', N'CategoryType'
GO


-- ----------------------------
-- Records of [CategoryType]
-- ----------------------------
INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_ORDERSTATUS', N'订单状态', N'2019-10-29 21:18:56.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_ORDERTYPE', N'订单类型', N'2019-10-29 21:18:32.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_PICKSTATUS', N'拣选任务状态', N'2019-10-29 21:28:50.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'USERTYPE', N'按用户类型分类', N'2017-11-29 21:27:42.000')
GO


-- ----------------------------
-- Table structure for DataPrivilegeRule
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[DataPrivilegeRule]') AND type IN ('U'))
	DROP TABLE [dbo].[DataPrivilegeRule]
GO

CREATE TABLE [dbo].[DataPrivilegeRule] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SourceCode] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SubSourceCode] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Description] varchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SortNo] int NOT NULL,
  [PrivilegeRules] varchar(1000) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Enable] tinyint NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[DataPrivilegeRule] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据ID',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'资源标识（模块编号）',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'SourceCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'二级资源标识',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'SubSourceCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'权限描述',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序号',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'SortNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'权限规则',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'PrivilegeRules'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否可用',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统授权规制表',
'SCHEMA', N'dbo',
'TABLE', N'DataPrivilegeRule'
GO


-- ----------------------------
-- Records of [DataPrivilegeRule]
-- ----------------------------
INSERT INTO [dbo].[DataPrivilegeRule]  VALUES (N'e7c95fb1-91f7-422e-a11a-73cea0c404b9', N'Resource', NULL, N'资源数据规则', N'0', N'{"Operation":"or","Filters":[{"Key":"AppId","Value":"110","Contrast":"=="},{"Key":"Name","Value":"登陆","Contrast":"=="}],"Children":[{"Operation":"and","Filters":[{"Key":"Name","Value":"注销账号","Contrast":"=="},{"Key":"AppId","Value":"119","Contrast":"=="}],"Children":null}]}', N'0', N'2019-10-29 11:05:02.0000000', N'00000000-0000-0000-0000-000000000000', N'', N'2019-10-29 11:05:02.0000000', N'', N'')
GO


-- ----------------------------
-- Table structure for FlowInstance
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FlowInstance]') AND type IN ('U'))
	DROP TABLE [dbo].[FlowInstance]
GO

CREATE TABLE [dbo].[FlowInstance] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [InstanceSchemeId] [dbo].[PrimaryKey] NOT NULL,
  [Code] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [CustomName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [ActivityId] [dbo].[PrimaryKey] NULL,
  [ActivityType] int NULL,
  [ActivityName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [PreviousId] [dbo].[PrimaryKey] NULL,
  [SchemeContent] varchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [SchemeId] [dbo].[PrimaryKey] NULL,
  [DbName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [FrmData] text COLLATE Chinese_PRC_CI_AS NULL,
  [FrmType] int DEFAULT ((0)) NOT NULL,
  [FrmContentData] text COLLATE Chinese_PRC_CI_AS NULL,
  [FrmContentParse] text COLLATE Chinese_PRC_CI_AS NULL,
  [FrmId] [dbo].[PrimaryKey] NULL,
  [SchemeType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Disabled] int DEFAULT ((0)) NOT NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [FlowLevel] int DEFAULT ((0)) NOT NULL,
  [Description] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [IsFinish] int DEFAULT ((0)) NOT NULL,
  [MakerList] varchar(1000) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[FlowInstance] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程实例模板Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'InstanceSchemeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例编号',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'Code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义名称',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'CustomName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前节点ID',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'ActivityId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前节点类型（0会签节点）',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'ActivityType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前节点名称',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'ActivityName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'前一个ID',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'PreviousId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程模板内容',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'SchemeContent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程模板ID',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'SchemeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据库名称',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'DbName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单数据',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'FrmData'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单类型',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'FrmType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单中的控件属性描述',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'FrmContentData'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单控件位置模板',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'FrmContentParse'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单ID',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'FrmId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程类型',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'SchemeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'Disabled'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'CreateDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'等级',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'FlowLevel'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例备注',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否完成',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'IsFinish'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行人',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'MakerList'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流流程实例表',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance'
GO


-- ----------------------------
-- Records of [FlowInstance]
-- ----------------------------
INSERT INTO [dbo].[FlowInstance]  VALUES (N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'', N'1564334796391', N'会签2019-07-29 01:26:40', N'1564334444885', N'4', N'node_7', N'1564334437844', N'{"title":"newFlow_1","initNum":16,"lines":[{"id":"1564334446774","type":"sl","from":"1564334430924","to":"1564334435460","name":"","dash":false,"Compares":null},{"id":"1564334447796","type":"sl","from":"1564334435460","to":"1564334437844","name":"","dash":false,"Compares":null},{"id":"1564334448572","type":"sl","from":"1564334437844","to":"1564334439828","name":"","dash":false,"Compares":null},{"id":"1564334449628","type":"sl","from":"1564334437844","to":"1564334440404","name":"","dash":false,"Compares":null},{"id":"1564334450572","type":"sl","from":"1564334439828","to":"1564334441965","name":"","dash":false,"Compares":null},{"id":"1564334451684","type":"sl","from":"1564334440404","to":"1564334441965","name":"","dash":false,"Compares":null},{"id":"1564334453900","type":"sl","from":"1564334441965","to":"1564334444885","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334430924","name":"node_1","type":"start round mix","left":17,"top":12,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334435460","name":"node_2","type":"node","left":141,"top":49,"width":104,"height":26,"alt":true,"setInfo":{"NodeDesignate":null,"NodeDesignateData":null,"NodeCode":null,"NodeName":null,"ThirdPartyUrl":null,"NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-29 01:28","NodeConfluenceType":null,"ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334437844","name":"会签入口，设置会签类型","type":"fork","left":141,"top":138,"width":104,"height":76,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"","TagedTime":"2019-07-29 01:30","NodeConfluenceType":"all","ConfluenceOk":1,"ConfluenceNo":null}},{"id":"1564334439828","name":"admin","type":"node","left":23,"top":272,"width":104,"height":36,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"","TagedTime":"2019-07-29 01:30","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334440404","name":"test","type":"node","left":234,"top":265,"width":104,"height":36,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334441965","name":"默认所有人","type":"join","left":140,"top":406,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"","TagedTime":"2019-07-29 01:30","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334444885","name":"node_7","type":"end round","left":351,"top":420,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'73819920-f085-4003-8874-4361b6461c92', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:26:45.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'1', N'')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'0ae5abe6-f571-4e08-b264-667dc27c5025', N'', N'1564334583446', N'带复杂表单的2019-07-29 01:23:03', N'1564334557205', N'2', N'node_2', N'1564334555981', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":66,"top":46,"type":"start round mix","id":"1564334555981","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":145,"type":"node","id":"1564334557205","width":104,"height":26,"alt":true},{"name":"node_3","left":56,"top":206,"type":"node","id":"1564334557764","width":104,"height":26,"alt":true},{"name":"node_4","left":66,"top":294,"type":"end round","id":"1564334559716","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334555981","to":"1564334557205","id":"1564334561500","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334557205","to":"1564334557764","id":"1564334562229","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334557764","to":"1564334559716","id":"1564334563268","name":"","dash":false,"alt":true}],"areas":[],"initNum":8}', N'989bd1f3-29f0-43cd-ad01-b55654907dbb', N'FrmLeaveReq', N'{"id":"","userName":"李玉宝","requestType":"事假","startDate":"2019-07-08T16:00:00.000Z","startTime":"2019-07-28T17:23:14.000Z","endDate":"2019-07-24T16:00:00.000Z","endTime":"2019-07-28T17:23:18.000Z","requestComment":"太累了，就是想休息一下","attachment":"","files":[],"extendInfo":""}', N'1', N'', N'', N'8faff4e5-b729-44d2-ac26-e899a228f63d', N'', N'0', N'2019-07-29 01:23:57.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'这种结构只能企业版使用', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'', N'1564334742060', N'带分支条件的请假2019-07-29 01:25:44', N'1564334139783', N'4', N'node_2', N'1564334156607', N'{"title":"newFlow_1","initNum":16,"lines":[{"id":"1564334158551","type":"sl","from":"1564334138399","to":"1564334153687","name":"","dash":false,"Compares":null},{"id":"1564334159304","type":"sl","from":"1564334153687","to":"1564334154471","name":"","dash":false,"Compares":[{"Operation":"<","FieldName":"DAYS","FieldType":null,"Value":"3"}]},{"id":"1564334160383","type":"sl","from":"1564334153687","to":"1564334155295","name":"","dash":false,"Compares":[{"Operation":">=","FieldName":"DAYS","FieldType":null,"Value":"3"}]},{"id":"1564334161911","type":"sl","from":"1564334154471","to":"1564334156607","name":"","dash":false,"Compares":null},{"id":"1564334163959","type":"sl","from":"1564334155295","to":"1564334156607","name":"","dash":false,"Compares":null},{"id":"1564334165255","type":"sl","from":"1564334156607","to":"1564334139783","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334138399","name":"node_1","type":"start round mix","left":44,"top":27,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334139783","name":"node_2","type":"end round","left":50,"top":295,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334153687","name":"所有人可以审批","type":"node","left":163,"top":43,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"","TagedTime":"2019-07-29 01:26","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334154471","name":"小于3的test可以审批","type":"node","left":23,"top":141,"width":167,"height":76,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-29 01:28","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334155295","name":"大于3的admin可以审批","type":"node","left":288,"top":146,"width":143,"height":56,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334156607","name":"默认","type":"node","left":171,"top":291,"width":104,"height":36,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"","TagedTime":"2019-07-29 01:30","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}}],"areas":[]}', N'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:25:56.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'这个时执行完成的', N'1', N'')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'20be4e87-0e9e-467c-9011-3c6ccd650931', N'', N'1564334643592', N'会签2019-07-29 01:24:05', N'1564334435460', N'2', N'node_2', N'1564334430924', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":17,"top":12,"type":"start round mix","id":"1564334430924","width":26,"height":26,"alt":true},{"name":"node_2","left":141,"top":49,"type":"node","id":"1564334435460","width":104,"height":26,"alt":true},{"name":"会签入口，设置会签类型","left":141,"top":138,"type":"fork","id":"1564334437844","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"admin","left":23,"top":272,"type":"node","id":"1564334439828","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"test","left":234,"top":265,"type":"node","id":"1564334440404","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"默认所有人","left":140,"top":406,"type":"join","id":"1564334441965","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_7","left":351,"top":420,"type":"end round","id":"1564334444885","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334430924","to":"1564334435460","id":"1564334446774","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334435460","to":"1564334437844","id":"1564334447796","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334439828","id":"1564334448572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334440404","id":"1564334449628","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334439828","to":"1564334441965","id":"1564334450572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334440404","to":"1564334441965","id":"1564334451684","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334441965","to":"1564334444885","id":"1564334453900","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'73819920-f085-4003-8874-4361b6461c92', N'', N'{"REASON":"身体原因","DAYS":"3","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:24:14.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'61959fe9-377a-4e6c-9f5d-6b7018a80bca', N'', N'1564334700493', N'带分支条件的请假2019-07-29 01:25:02', N'1564334154471', N'2', N'小于3的test可以审批', N'1564334153687', N'{"title":"newFlow_1","initNum":16,"lines":[{"id":"1564334158551","type":"sl","from":"1564334138399","to":"1564334153687","name":"","dash":false,"Compares":null},{"id":"1564334159304","type":"sl","from":"1564334153687","to":"1564334154471","name":"","dash":false,"Compares":[{"Operation":"<","FieldName":"DAYS","FieldType":null,"Value":"3"}]},{"id":"1564334160383","type":"sl","from":"1564334153687","to":"1564334155295","name":"","dash":false,"Compares":[{"Operation":">=","FieldName":"DAYS","FieldType":null,"Value":"3"}]},{"id":"1564334161911","type":"sl","from":"1564334154471","to":"1564334156607","name":"","dash":false,"Compares":null},{"id":"1564334163959","type":"sl","from":"1564334155295","to":"1564334156607","name":"","dash":false,"Compares":null},{"id":"1564334165255","type":"sl","from":"1564334156607","to":"1564334139783","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334138399","name":"node_1","type":"start round mix","left":44,"top":27,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334139783","name":"node_2","type":"end round","left":50,"top":295,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334153687","name":"所有人可以审批","type":"node","left":163,"top":43,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-29 01:29","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334154471","name":"小于3的test可以审批","type":"node","left":23,"top":141,"width":167,"height":76,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334155295","name":"大于3的admin可以审批","type":"node","left":288,"top":146,"width":143,"height":56,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334156607","name":"默认","type":"node","left":171,"top":291,"width":104,"height":36,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}}],"areas":[]}', N'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:25:16.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'这是个天数比较少的分支', N'0', N'6ba79766-faa0-4259-8139-a4a6d35784e0')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'7a1fb1a4-06a6-49d5-a311-b988aed776e1', N'', N'1564334976909', N'admin的会签2019-07-29 01:29:39', N'1564334435460', N'2', N'node_2', N'1564334430924', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":17,"top":12,"type":"start round mix","id":"1564334430924","width":26,"height":26,"alt":true},{"name":"node_2","left":141,"top":49,"type":"node","id":"1564334435460","width":104,"height":26,"alt":true},{"name":"会签入口，设置会签类型","left":141,"top":138,"type":"fork","id":"1564334437844","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"admin","left":23,"top":272,"type":"node","id":"1564334439828","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"test","left":234,"top":265,"type":"node","id":"1564334440404","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"默认所有人","left":140,"top":406,"type":"join","id":"1564334441965","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_7","left":351,"top":420,"type":"end round","id":"1564334444885","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334430924","to":"1564334435460","id":"1564334446774","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334435460","to":"1564334437844","id":"1564334447796","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334439828","id":"1564334448572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334440404","id":"1564334449628","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334439828","to":"1564334441965","id":"1564334450572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334440404","to":"1564334441965","id":"1564334451684","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334441965","to":"1564334444885","id":"1564334453900","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'73819920-f085-4003-8874-4361b6461c92', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:29:47.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'0', N'', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'7c8ffe55-13fd-4236-9816-63eb7e22aa68', N'', N'1572350961242', N'按角色执行2019-10-29 20:09:25', N'1564334332325', N'2', N'管理员', N'1564334327861', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":99,"top":32,"type":"start round mix","id":"1564334327861","width":26,"height":26,"alt":true},{"name":"node_2","left":70,"top":295,"type":"end round","id":"1564334330157","width":26,"height":26,"alt":true},{"name":"管理员","left":43,"top":131,"type":"node","id":"1564334332325","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"测试人员","left":185,"top":226,"type":"node","id":"1564334333133","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}}],"lines":[{"type":"sl","from":"1564334327861","to":"1564334332325","id":"1564334335789","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334332325","to":"1564334333133","id":"1564334336629","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334333133","to":"1564334330157","id":"1564334337805","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'0b21f59c-7809-4275-acb4-8e8c08e0167e', N'', N'{"REASON":"身体原因","DAYS":"5","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-10-29 20:10:45.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'预约好突然', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558,1df68dfd-3b6d-4491-872f-00a0fc6c5a64')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', N'', N'1564334869743', N'test的普通请假2019-07-29 01:27:53', N'1564334038904', N'4', N'node_4', N'1564334036152', N'{"title":"newFlow_1","initNum":9,"lines":[{"id":"1564334041040","type":"sl","from":"1564334032785","to":"1564334035352","name":"","dash":false,"Compares":null},{"id":"1564334041720","type":"sl","from":"1564334035352","to":"1564334036152","name":"","dash":false,"Compares":null},{"id":"1564334042927","type":"sl","from":"1564334036152","to":"1564334038904","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334032785","name":"node_1","type":"start round mix","left":19,"top":36,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334035352","name":"所有人可以审批","type":"node","left":133,"top":50,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"http://xxxx.com/api/workflow/callback","NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"","TagedTime":"2019-10-29 14:44","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334036152","name":"所有人可以审批","type":"node","left":139,"top":123,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"","TagedTime":"2019-10-29 14:44","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334038904","name":"node_4","type":"end round","left":47,"top":193,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'61806396-9498-492b-bc22-9f9e95a389bc', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:28:05.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'0', N'', N'1', N'')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'be9b74cf-2e74-40f3-9ebf-3508f6e79bde', N'', N'1564334669608', N'带分支条件的请假（很多天数）', N'1564334153687', N'2', N'所有人可以审批', N'1564334138399', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":44,"top":27,"type":"start round mix","id":"1564334138399","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":295,"type":"end round","id":"1564334139783","width":26,"height":26,"alt":true},{"name":"所有人可以审批","left":163,"top":43,"type":"node","id":"1564334153687","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"小于3的test可以审批","left":23,"top":141,"type":"node","id":"1564334154471","width":167,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"大于3的admin可以审批","left":288,"top":146,"type":"node","id":"1564334155295","width":143,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"默认","left":171,"top":291,"type":"node","id":"1564334156607","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}}],"lines":[{"type":"sl","from":"1564334138399","to":"1564334153687","id":"1564334158551","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334153687","to":"1564334154471","id":"1564334159304","name":"","dash":false,"alt":true,"Compares":[{"FieldName":"DAYS","Operation":"<","Value":"3"}]},{"type":"sl","from":"1564334153687","to":"1564334155295","id":"1564334160383","name":"","dash":false,"alt":true,"Compares":[{"FieldName":"DAYS","Operation":">=","Value":"3"}]},{"type":"sl","from":"1564334154471","to":"1564334156607","id":"1564334161911","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334155295","to":"1564334156607","id":"1564334163959","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334156607","to":"1564334139783","id":"1564334165255","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', N'', N'{"REASON":"身体原因","DAYS":"5","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:24:52.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'd4f8d2b9-6374-4c10-8d3c-1ca540bc309b', N'', N'1572341191142', N'带复杂表单的2019-10-29 17:26:42', N'1564334557205', N'2', N'node_2', N'1564334555981', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":66,"top":46,"type":"start round mix","id":"1564334555981","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":145,"type":"node","id":"1564334557205","width":104,"height":26,"alt":true},{"name":"node_3","left":56,"top":206,"type":"node","id":"1564334557764","width":104,"height":26,"alt":true},{"name":"node_4","left":66,"top":294,"type":"end round","id":"1564334559716","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334555981","to":"1564334557205","id":"1564334561500","name":"","dash":false},{"type":"sl","from":"1564334557205","to":"1564334557764","id":"1564334562229","name":"","dash":false},{"type":"sl","from":"1564334557764","to":"1564334559716","id":"1564334563268","name":"","dash":false}],"areas":[],"initNum":8}', N'989bd1f3-29f0-43cd-ad01-b55654907dbb', N'FrmLeaveReq', N'{"id":"","userName":"1","requestType":"病假","startDate":"2019-10-07T16:00:00.000Z","startTime":"2019-10-29T09:26:52.000Z","endDate":"2019-10-27T16:00:00.000Z","endTime":"2019-10-29T09:26:54.000Z","requestComment":"111","attachment":"","files":[],"extendInfo":""}', N'1', N'', N'', N'8faff4e5-b729-44d2-ac26-e899a228f63d', N'', N'0', N'2019-10-29 17:27:06.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'11', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'df6df6b5-53f7-4db4-931b-12e3352ef413', N'', N'1564334658879', N'按角色执行2019-07-29 01:24:21', N'1564334332325', N'2', N'管理员', N'1564334327861', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":99,"top":32,"type":"start round mix","id":"1564334327861","width":26,"height":26,"alt":true},{"name":"node_2","left":70,"top":295,"type":"end round","id":"1564334330157","width":26,"height":26,"alt":true},{"name":"管理员","left":43,"top":131,"type":"node","id":"1564334332325","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"测试人员","left":185,"top":226,"type":"node","id":"1564334333133","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}}],"lines":[{"type":"sl","from":"1564334327861","to":"1564334332325","id":"1564334335789","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334332325","to":"1564334333133","id":"1564334336629","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334333133","to":"1564334330157","id":"1564334337805","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'0b21f59c-7809-4275-acb4-8e8c08e0167e', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:24:26.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'ee589689-3ae0-4037-abec-ba70e566da16', N'', N'1564334720434', N'普通的请假2019-07-29 01:25:24', N'1564334035352', N'2', N'所有人可以审批', N'1564334032785', N'{"title":"newFlow_1","initNum":9,"lines":[{"id":"1564334041040","type":"sl","from":"1564334032785","to":"1564334035352","name":"","dash":false,"Compares":null},{"id":"1564334041720","type":"sl","from":"1564334035352","to":"1564334036152","name":"","dash":false,"Compares":null},{"id":"1564334042927","type":"sl","from":"1564334036152","to":"1564334038904","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334032785","name":"node_1","type":"start round mix","left":19,"top":36,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334035352","name":"所有人可以审批","type":"node","left":133,"top":50,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"http://xxxx.com/api/workflow/callback","NodeRejectType":null,"Taged":2,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"最近有很多事情要处理","TagedTime":"2019-07-29 01:28","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334036152","name":"所有人可以审批","type":"node","left":139,"top":123,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334038904","name":"node_4","type":"end round","left":47,"top":193,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'61806396-9498-492b-bc22-9f9e95a389bc', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:25:30.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'3', N'1')
GO


-- ----------------------------
-- Table structure for FlowInstanceOperationHistory
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FlowInstanceOperationHistory]') AND type IN ('U'))
	DROP TABLE [dbo].[FlowInstanceOperationHistory]
GO

CREATE TABLE [dbo].[FlowInstanceOperationHistory] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [InstanceId] [dbo].[PrimaryKey] NOT NULL,
  [Content] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[FlowInstanceOperationHistory] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceOperationHistory',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例进程Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceOperationHistory',
'COLUMN', N'InstanceId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作内容',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceOperationHistory',
'COLUMN', N'Content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceOperationHistory',
'COLUMN', N'CreateDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceOperationHistory',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceOperationHistory',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流实例操作记录',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceOperationHistory'
GO


-- ----------------------------
-- Records of [FlowInstanceOperationHistory]
-- ----------------------------
INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'07ebabd9-7880-4d9a-b365-4a1dc608a82a', N'be9b74cf-2e74-40f3-9ebf-3508f6e79bde', N'【创建】超级管理员创建了一个流程进程【1564334669608/带分支条件的请假（很多天数）】', N'2019-07-29 01:24:52.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'0b39f449-3369-41d7-b053-00487c2fafbe', N'ee589689-3ae0-4037-abec-ba70e566da16', N'【创建】超级管理员创建了一个流程进程【1564334720434/普通的请假2019-07-29 01:25:24】', N'2019-07-29 01:25:30.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'1fa6c074-8ec0-4a5a-8c39-2dc62d0140eb', N'0ae5abe6-f571-4e08-b264-667dc27c5025', N'【创建】超级管理员创建了一个流程进程【1564334583446/带复杂表单的2019-07-29 01:23:03】', N'2019-07-29 01:23:58.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'250181cb-f242-47cf-bc16-fcc307443727', N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'【创建】超级管理员创建了一个流程进程【1564334796391/会签2019-07-29 01:26:40】', N'2019-07-29 01:26:45.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'299d30e1-41d2-4f9f-a330-593fc7b87c20', N'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', N'【创建】test创建了一个流程进程【1564334869743/test的普通请假2019-07-29 01:27:53】', N'2019-07-29 01:28:05.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'318f827b-316d-4230-841b-990b0e1aab37', N'df6df6b5-53f7-4db4-931b-12e3352ef413', N'【创建】超级管理员创建了一个流程进程【1564334658879/按角色执行2019-07-29 01:24:21】', N'2019-07-29 01:24:26.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'3d49913b-e389-4c7d-9f35-237e3abafa58', N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'【admin】【2019-07-29 01:30】同意,备注：', N'2019-07-29 01:30:46.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'41aac141-92c6-400d-a58f-3950b1f05e44', N'7c8ffe55-13fd-4236-9816-63eb7e22aa68', N'【创建】超级管理员创建了一个流程进程【1572350961242/按角色执行2019-10-29 20:09:25】', N'2019-10-29 20:10:45.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'41dc5606-9b46-4a2f-9a99-b7d439327cc9', N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'【默认】【2019-07-29 01:30】同意,备注：', N'2019-07-29 01:30:13.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'4564baf4-2f5a-4268-82ae-bb587c1a7a64', N'ee589689-3ae0-4037-abec-ba70e566da16', N'【所有人可以审批】【2019-07-29 01:28】不同意,备注：最近有很多事情要处理', N'2019-07-29 01:28:55.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'624ed4bf-b2c1-4624-82f5-415ebffeecdb', N'd4f8d2b9-6374-4c10-8d3c-1ca540bc309b', N'【创建】超级管理员创建了一个流程进程【1572341191142/带复杂表单的2019-10-29 17:26:42】', N'2019-10-29 17:27:06.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'81d18fa5-f843-4d29-bf08-1423ed7df968', N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'【小于3的test可以审批】【2019-07-29 01:28】同意,备注：', N'2019-07-29 01:28:31.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'92b7c75f-3dd3-4cdb-96ef-09d393005d85', N'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', N'【所有人可以审批】【2019-10-29 14:44】同意,备注：', N'2019-10-29 14:44:20.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'97643f81-40b4-4941-8cd9-ec35b517da5b', N'20be4e87-0e9e-467c-9011-3c6ccd650931', N'【创建】超级管理员创建了一个流程进程【1564334643592/会签2019-07-29 01:24:05】', N'2019-07-29 01:24:14.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'9c375436-d2a1-4edd-9123-737ec337f2a4', N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'【admin】【2019-07-29 01:30】同意,备注：', N'2019-07-29 01:30:30.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'b2594853-41a7-4c4f-bcd1-3fdf63036e9b', N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'【所有人可以审批】【2019-07-29 01:26】同意,备注：', N'2019-07-29 01:26:15.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'b304569d-e14a-4411-ad10-780bf5eaf3a0', N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'【创建】超级管理员创建了一个流程进程【1564334742060/带分支条件的请假2019-07-29 01:25:44】', N'2019-07-29 01:25:56.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'de782bfd-1320-4c6e-9e18-f7c92ad64173', N'61959fe9-377a-4e6c-9f5d-6b7018a80bca', N'【所有人可以审批】【2019-07-29 01:29】同意,备注：', N'2019-07-29 01:29:14.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'e633903e-4969-46eb-b194-c7de5c27cb8d', N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'【node_2】【2019-07-29 01:28】同意,备注：', N'2019-07-29 01:28:22.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'ecd380ab-3f22-4a8b-a341-4a8ff70eefff', N'61959fe9-377a-4e6c-9f5d-6b7018a80bca', N'【创建】超级管理员创建了一个流程进程【1564334700493/带分支条件的请假2019-07-29 01:25:02】', N'2019-07-29 01:25:16.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'ee6147cc-f897-4284-b295-8e20b7c94dd0', N'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', N'【所有人可以审批】【2019-10-29 14:44】同意,备注：', N'2019-10-29 14:44:24.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'efa37871-2d37-4bae-8e0d-5bf98ff44241', N'7a1fb1a4-06a6-49d5-a311-b988aed776e1', N'【创建】admin创建了一个流程进程【1564334976909/admin的会签2019-07-29 01:29:39】', N'2019-07-29 01:29:47.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO


-- ----------------------------
-- Table structure for FlowInstanceTransitionHistory
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FlowInstanceTransitionHistory]') AND type IN ('U'))
	DROP TABLE [dbo].[FlowInstanceTransitionHistory]
GO

CREATE TABLE [dbo].[FlowInstanceTransitionHistory] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [InstanceId] [dbo].[PrimaryKey] NOT NULL,
  [FromNodeId] [dbo].[PrimaryKey] NULL,
  [FromNodeType] int NULL,
  [FromNodeName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [ToNodeId] [dbo].[PrimaryKey] NULL,
  [ToNodeType] int NULL,
  [ToNodeName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [TransitionSate] int DEFAULT ((0)) NOT NULL,
  [IsFinish] int DEFAULT ((0)) NOT NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[FlowInstanceTransitionHistory] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'InstanceId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始节点Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'FromNodeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始节点类型',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'FromNodeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始节点名称',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'FromNodeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束节点Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'ToNodeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束节点类型',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'ToNodeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束节点名称',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'ToNodeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'转化状态',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'TransitionSate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否结束',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'IsFinish'
GO

EXEC sp_addextendedproperty
'MS_Description', N'转化时间',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'CreateDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人名称',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流实例流转历史记录',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstanceTransitionHistory'
GO


-- ----------------------------
-- Records of [FlowInstanceTransitionHistory]
-- ----------------------------
INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'0a8aff1c-572b-4db4-9906-a3954a1d0288', N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'1564334435460', N'2', N'node_2', N'1564334437844', N'0', N'会签入口，设置会签类型', N'0', N'0', N'2019-07-29 01:28:22.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'0b11504f-9231-4cdb-862a-4d4546b9a4bd', N'0ae5abe6-f571-4e08-b264-667dc27c5025', N'1564334555981', N'3', N'node_1', N'1564334557205', N'2', N'node_2', N'0', N'0', N'2019-07-29 01:23:58.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'10efe1e8-6424-4d88-bc30-8b6722002e56', N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'1564334153687', N'2', N'所有人可以审批', N'1564334154471', N'2', N'小于3的test可以审批', N'0', N'0', N'2019-07-29 01:26:15.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'121c3968-8532-43ae-b46a-dcae0973567a', N'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', N'1564334032785', N'3', N'node_1', N'1564334035352', N'2', N'所有人可以审批', N'0', N'0', N'2019-07-29 01:28:05.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'19eada42-ade5-4cb1-a65b-a5d75243fe10', N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'1564334437844', N'0', N'会签入口，设置会签类型', N'1564334444885', N'4', N'node_7', N'0', N'1', N'2019-07-29 01:30:46.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'3ac494f7-66c9-4d77-a86d-bfe93d4e1bd2', N'df6df6b5-53f7-4db4-931b-12e3352ef413', N'1564334327861', N'3', N'node_1', N'1564334332325', N'2', N'管理员', N'0', N'0', N'2019-07-29 01:24:26.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'3c9db424-34b8-43cb-b571-ca8a3102fa78', N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'1564334430924', N'3', N'node_1', N'1564334435460', N'2', N'node_2', N'0', N'0', N'2019-07-29 01:26:45.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'41eee5d1-e98b-46f0-99d6-fa35781059e3', N'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', N'1564334036152', N'2', N'所有人可以审批', N'1564334038904', N'4', N'node_4', N'0', N'1', N'2019-10-29 14:44:24.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'7951ef7e-7457-4d31-b661-3e7c57cbac3a', N'd4f8d2b9-6374-4c10-8d3c-1ca540bc309b', N'1564334555981', N'3', N'node_1', N'1564334557205', N'2', N'node_2', N'0', N'0', N'2019-10-29 17:27:06.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'8fc96020-e719-4c5c-bc2f-88ad8b8361ad', N'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', N'1564334035352', N'2', N'所有人可以审批', N'1564334036152', N'2', N'所有人可以审批', N'0', N'0', N'2019-10-29 14:44:20.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'9ed0cdc3-0f57-4381-bb86-f41537556832', N'61959fe9-377a-4e6c-9f5d-6b7018a80bca', N'1564334153687', N'2', N'所有人可以审批', N'1564334154471', N'2', N'小于3的test可以审批', N'0', N'0', N'2019-07-29 01:29:14.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'b53cd6a4-0aa9-4de5-83e8-3966423e537a', N'20be4e87-0e9e-467c-9011-3c6ccd650931', N'1564334430924', N'3', N'node_1', N'1564334435460', N'2', N'node_2', N'0', N'0', N'2019-07-29 01:24:14.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'b7770b94-16ad-49cb-b2f8-b94ed032388a', N'7a1fb1a4-06a6-49d5-a311-b988aed776e1', N'1564334430924', N'3', N'node_1', N'1564334435460', N'2', N'node_2', N'0', N'0', N'2019-07-29 01:29:47.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'c13213e0-af27-4665-b8bc-4c73a7f2df23', N'7c8ffe55-13fd-4236-9816-63eb7e22aa68', N'1564334327861', N'3', N'node_1', N'1564334332325', N'2', N'管理员', N'0', N'0', N'2019-10-29 20:10:45.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'c2128257-6b49-43a5-ac93-7b00d2e1b342', N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'1564334138399', N'3', N'node_1', N'1564334153687', N'2', N'所有人可以审批', N'0', N'0', N'2019-07-29 01:25:56.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'ca236899-b327-4e8b-85d4-8668c9ae5d89', N'ee589689-3ae0-4037-abec-ba70e566da16', N'1564334032785', N'3', N'node_1', N'1564334035352', N'2', N'所有人可以审批', N'0', N'0', N'2019-07-29 01:25:30.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'd2c558c2-4f31-4dea-8f2e-5fa3ac9748a0', N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'1564334154471', N'2', N'小于3的test可以审批', N'1564334156607', N'2', N'默认', N'0', N'0', N'2019-07-29 01:28:31.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'e22a49a2-5065-47f2-ba95-79d7174a308e', N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'1564334156607', N'2', N'默认', N'1564334139783', N'4', N'node_2', N'0', N'1', N'2019-07-29 01:30:13.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'e34b5d5e-aae4-4de0-9b31-6bd514ffe92f', N'be9b74cf-2e74-40f3-9ebf-3508f6e79bde', N'1564334138399', N'3', N'node_1', N'1564334153687', N'2', N'所有人可以审批', N'0', N'0', N'2019-07-29 01:24:52.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'f7f86afc-be9d-4521-b346-3e36355758b0', N'61959fe9-377a-4e6c-9f5d-6b7018a80bca', N'1564334138399', N'3', N'node_1', N'1564334153687', N'2', N'所有人可以审批', N'0', N'0', N'2019-07-29 01:25:16.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO


-- ----------------------------
-- Table structure for FlowScheme
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FlowScheme]') AND type IN ('U'))
	DROP TABLE [dbo].[FlowScheme]
GO

CREATE TABLE [dbo].[FlowScheme] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [SchemeCode] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [SchemeName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [SchemeType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [SchemeVersion] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [SchemeCanUser] varchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [SchemeContent] varchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [FrmId] [dbo].[PrimaryKey] NULL,
  [FrmType] int DEFAULT ((0)) NOT NULL,
  [AuthorizeType] int DEFAULT ((0)) NOT NULL,
  [SortCode] int DEFAULT ((0)) NOT NULL,
  [DeleteMark] int DEFAULT ((0)) NOT NULL,
  [Disabled] int DEFAULT ((0)) NOT NULL,
  [Description] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ModifyDate] datetime NULL,
  [ModifyUserId] [dbo].[PrimaryKey] NULL,
  [ModifyUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[FlowScheme] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程编号',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'SchemeCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程名称',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'SchemeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程分类',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'SchemeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程内容版本',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'SchemeVersion'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程模板使用者',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'SchemeCanUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程内容',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'SchemeContent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单ID',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'FrmId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单类型',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'FrmType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板权限类型：0完全公开,1指定部门/人员',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'AuthorizeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序码',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'SortCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标记',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'DeleteMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'Disabled'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'CreateDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改时间',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'ModifyDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改用户主键',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'ModifyUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改用户',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'ModifyUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流模板信息表',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme'
GO


-- ----------------------------
-- Records of [FlowScheme]
-- ----------------------------
INSERT INTO [dbo].[FlowScheme]  VALUES (N'0b21f59c-7809-4275-acb4-8e8c08e0167e', N'1564334009729', N'按角色执行', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":99,"top":32,"type":"start round mix","id":"1564334327861","width":26,"height":26,"alt":true},{"name":"node_2","left":70,"top":295,"type":"end round","id":"1564334330157","width":26,"height":26,"alt":true},{"name":"管理员","left":43,"top":131,"type":"node","id":"1564334332325","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"测试人员","left":185,"top":226,"type":"node","id":"1564334333133","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}}],"lines":[{"type":"sl","from":"1564334327861","to":"1564334332325","id":"1564334335789","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334332325","to":"1564334333133","id":"1564334336629","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334333133","to":"1564334330157","id":"1564334337805","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'0', N'0', N'0', N'0', N'0', N'节点按指定的角色执行而不是指定的人', N'2019-07-29 01:19:25.000', N'', N'', N'2019-07-29 01:19:25.000', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'61806396-9498-492b-bc22-9f9e95a389bc', N'1564334009729', N'普通的请假', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":19,"top":36,"type":"start round mix","id":"1564334032785","width":26,"height":26,"alt":true},{"name":"所有人可以审批","left":133,"top":50,"type":"node","id":"1564334035352","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"http://xxxx.com/api/workflow/callback","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"所有人可以审批","left":139,"top":123,"type":"node","id":"1564334036152","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_4","left":47,"top":193,"type":"end round","id":"1564334038904","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334032785","to":"1564334035352","id":"1564334041040","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334035352","to":"1564334036152","id":"1564334041720","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334036152","to":"1564334038904","id":"1564334042927","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'0', N'0', N'0', N'0', N'0', N'非常简单的请假流程', N'2019-07-29 01:14:48.000', N'', N'', N'2019-07-29 01:14:48.000', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'73819920-f085-4003-8874-4361b6461c92', N'1564334009729', N'会签', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":17,"top":12,"type":"start round mix","id":"1564334430924","width":26,"height":26,"alt":true},{"name":"node_2","left":141,"top":49,"type":"node","id":"1564334435460","width":104,"height":26,"alt":true},{"name":"会签入口，设置会签类型","left":141,"top":138,"type":"fork","id":"1564334437844","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"admin","left":23,"top":272,"type":"node","id":"1564334439828","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"test","left":234,"top":265,"type":"node","id":"1564334440404","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"默认所有人","left":140,"top":406,"type":"join","id":"1564334441965","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_7","left":351,"top":420,"type":"end round","id":"1564334444885","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334430924","to":"1564334435460","id":"1564334446774","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334435460","to":"1564334437844","id":"1564334447796","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334439828","id":"1564334448572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334440404","id":"1564334449628","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334439828","to":"1564334441965","id":"1564334450572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334440404","to":"1564334441965","id":"1564334451684","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334441965","to":"1564334444885","id":"1564334453900","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'0', N'0', N'0', N'0', N'0', N'需要多人审批的流程，比如需要多人全部批准该步骤才能通过，或至少有一个通过', N'2019-07-29 01:22:03.000', N'', N'', N'2019-07-29 01:22:03.000', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'989bd1f3-29f0-43cd-ad01-b55654907dbb', N'1564334009729', N'带复杂表单的', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":66,"top":46,"type":"start round mix","id":"1564334555981","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":145,"type":"node","id":"1564334557205","width":104,"height":26,"alt":true},{"name":"node_3","left":56,"top":206,"type":"node","id":"1564334557764","width":104,"height":26,"alt":true},{"name":"node_4","left":66,"top":294,"type":"end round","id":"1564334559716","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334555981","to":"1564334557205","id":"1564334561500","name":"","dash":false},{"type":"sl","from":"1564334557205","to":"1564334557764","id":"1564334562229","name":"","dash":false},{"type":"sl","from":"1564334557764","to":"1564334559716","id":"1564334563268","name":"","dash":false}],"areas":[],"initNum":8}', N'8faff4e5-b729-44d2-ac26-e899a228f63d', N'1', N'0', N'0', N'0', N'0', N'这是一个带有复杂表单的流程，比如需要上传文件', N'2019-07-29 01:22:45.000', N'', N'', N'2019-10-29 17:25:20.000', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', N'1564334009729', N'带分支条件的请假', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":44,"top":27,"type":"start round mix","id":"1564334138399","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":295,"type":"end round","id":"1564334139783","width":26,"height":26,"alt":true},{"name":"所有人可以审批","left":163,"top":43,"type":"node","id":"1564334153687","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"小于3的test可以审批","left":23,"top":141,"type":"node","id":"1564334154471","width":167,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"大于3的admin可以审批","left":288,"top":146,"type":"node","id":"1564334155295","width":143,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"默认","left":171,"top":291,"type":"node","id":"1564334156607","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}}],"lines":[{"type":"sl","from":"1564334138399","to":"1564334153687","id":"1564334158551","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334153687","to":"1564334154471","id":"1564334159304","name":"","dash":false,"alt":true,"Compares":[{"FieldName":"DAYS","Operation":"<","Value":"3"}]},{"type":"sl","from":"1564334153687","to":"1564334155295","id":"1564334160383","name":"","dash":false,"alt":true,"Compares":[{"FieldName":"DAYS","Operation":">=","Value":"3"}]},{"type":"sl","from":"1564334154471","to":"1564334156607","id":"1564334161911","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334155295","to":"1564334156607","id":"1564334163959","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334156607","to":"1564334139783","id":"1564334165255","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'0', N'0', N'0', N'0', N'0', N'在连接线上可以设置分支条件', N'2019-07-29 01:17:46.000', N'', N'', N'2019-07-29 01:17:46.000', N'', N'')
GO


-- ----------------------------
-- Table structure for Form
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Form]') AND type IN ('U'))
	DROP TABLE [dbo].[Form]
GO

CREATE TABLE [dbo].[Form] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [FrmType] int DEFAULT ((0)) NOT NULL,
  [WebId] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [Fields] int DEFAULT ((0)) NOT NULL,
  [ContentData] text COLLATE Chinese_PRC_CI_AS NULL,
  [ContentParse] text COLLATE Chinese_PRC_CI_AS NULL,
  [Content] text COLLATE Chinese_PRC_CI_AS NULL,
  [SortCode] int DEFAULT ((0)) NOT NULL,
  [DeleteMark] int DEFAULT ((0)) NOT NULL,
  [DbName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Disabled] int DEFAULT ((0)) NOT NULL,
  [Description] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ModifyDate] datetime NULL,
  [ModifyUserId] [dbo].[PrimaryKey] NULL,
  [ModifyUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[Form] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单模板Id',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单名称',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单类型，0：默认动态表单；1：Web自定义表单',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'FrmType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统页面标识，当表单类型为用Web自定义的表单时，需要标识加载哪个页面',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'WebId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段个数',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'Fields'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单中的控件属性描述',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'ContentData'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单控件位置模板',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'ContentParse'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单原html模板未经处理的',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'Content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序码',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'SortCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标记',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'DeleteMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据库名称',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'DbName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'Disabled'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'CreateDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改时间',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'ModifyDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改用户主键',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'ModifyUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改用户',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'ModifyUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单模板表',
'SCHEMA', N'dbo',
'TABLE', N'Form'
GO


-- ----------------------------
-- Records of [Form]
-- ----------------------------
INSERT INTO [dbo].[Form]  VALUES (N'8faff4e5-b729-44d2-ac26-e899a228f63d', N'系统内置的复杂请假条表单', N'1', N'FrmLeaveReq', N'0', N'', N'', N'', N'0', N'0', N'', N'0', N'企业版内置的复杂请假条表单', N'2019-07-29 01:03:36.000', N'', N'', N'2019-07-29 01:03:36.000', N'', N'')
GO

INSERT INTO [dbo].[Form]  VALUES (N'b08bb00f-e1df-44f8-904f-58ee5b1f4eb4', N'领料单', N'0', N'', N'0', N'[{"leipiplugins":"select","name":"TOOLS","title":"TOOLS","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机,签字笔","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option><option value=\"签字笔\">签字笔</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"},{"name":"APPLY_REASON","title":"APPLY_REASON","leipiplugins":"textarea","value":"","orgrich":"0","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width:300px;height:80px;","content":"<textarea title=\"APPLY_REASON\" name=\"leipiNewField\" leipiplugins=\"textarea\" value=\"\" orgrich=\"0\" orgfontsize=\"\" orgwidth=\"300\" orgheight=\"80\" style=\"width:300px;height:80px;\"></textarea>"},{"leipiplugins":"checkboxs","name":"","title":"NEEDRETURN","parse_name":"checkboxs_0","value":"归还,无需归还","content":"<span leipiplugins=\"checkboxs\"  title=\"NEEDRETURN\"><input type=\"checkbox\" name=\"leipiNewField\" value=\"归还\"  checked=\"checked\"/>归还&nbsp;<input type=\"checkbox\" name=\"leipiNewField\" value=\"无需归还\"  />无需归还&nbsp;</span>","options":[{"name":"leipiNewField","value":"归还","checked":"checked","type":"checkbox"},{"name":"leipiNewField","value":"无需归还","type":"checkbox"}]}]', N'<p style="text-align: center;"><span style="font-size: 36px;">领料单</span></p><p><span style="font-size: 36px;"><br/></span></p><table data-sort="sortDisabled"><tbody><tr class="firstRow"><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">名目</span></td><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">数量</span></td><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">说明</span></td></tr><tr><td width="534" valign="top">{TOOLS}</td><td width="534" valign="top">{NUMBERS}</td><td width="534" valign="top">{APPLY_REASON}</td></tr><tr><td valign="top" rowspan="1" colspan="3" style="word-break: break-all;">{checkboxs_0}</td></tr></tbody></table><p style="text-align: center;"><br/></p>', N'<p style="text-align: center;"><span style="font-size: 36px;">领料单</span></p><p><span style="font-size: 36px;"><br/></span></p><table data-sort="sortDisabled"><tbody><tr class="firstRow"><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">名目</span></td><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">数量</span></td><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">说明</span></td></tr><tr><td width="534" valign="top">{|-<span leipiplugins="select"><select name="leipiNewField" title="TOOLS" leipiplugins="select" size="1" orgwidth="150" style="width: 150px;"><option value="电脑" selected="selected">电脑</option><option value="平板">平板</option><option value="手机">手机</option><option value="签字笔">签字笔</option></select>&nbsp;&nbsp;</span>-|}</td><td width="534" valign="top"><input name="leipiNewField" type="text" title="NUMBERS" value="1" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="int" style="text-align: left; width: 150px;"/></td><td width="534" valign="top"><textarea title="APPLY_REASON" name="leipiNewField" leipiplugins="textarea" value="" orgrich="0" orgfontsize="" orgwidth="300" orgheight="80" style="width:300px;height:80px;"></textarea></td></tr><tr><td valign="top" rowspan="1" colspan="3" style="word-break: break-all;">{|-<span leipiplugins="checkboxs"  title="NEEDRETURN"><input type="checkbox" name="leipiNewField" value="归还"  checked="checked"/>归还&nbsp;<input type="checkbox" name="leipiNewField" value="无需归还"  />无需归还&nbsp;</span>-|}</td></tr></tbody></table><p style="text-align: center;"><br/></p>', N'0', N'0', N'', N'0', N'带有选择框文本框复选框等的领料单据', N'2019-07-29 01:13:02.000', N'', N'', N'2019-07-29 01:13:02.000', N'', N'')
GO

INSERT INTO [dbo].[Form]  VALUES (N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'请假条表单', N'0', N'', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因<input name="leipiNewField" type="text" title="REASON" value="身体原因" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="text" style="text-align: left; width: 150px;"/>，本人想请假{|-<span leipiplugins="select"><select name="leipiNewField" title="DAYS" leipiplugins="select" size="1" orgwidth="150" style="width: 150px;"><option value="1" selected="selected">1</option><option value="3">3</option><option value="5">5</option><option value="10">10</option></select>&nbsp;&nbsp;</span>-|}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：<input name="leipiNewField" type="text" title="CUSTOME_NAME" value="玉宝" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="text" style="text-align: left; width: 150px;"/></p>', N'0', N'0', N'', N'0', N'带有选择框文本框的请假条', N'2019-07-29 01:07:03.000', N'', N'', N'2019-07-29 01:07:03.000', N'', N'')
GO

INSERT INTO [dbo].[Form]  VALUES (N'febe218d-21a6-44b6-b7ce-b83e73556ad9', N'审批流程', N'0', N'FrmLeaveReq', N'0', N'[{"type":"text","name":"姓名","title":"姓名","value":"","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"姓名\" value=\"\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p>{姓名}</p>', N'<p><input name="leipiNewField" type="text" title="姓名" value="" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="text" style="text-align: left; width: 150px;"/></p>', N'0', N'0', N'', N'0', N'', N'2019-10-29 13:57:35.000', N'', N'', N'2019-10-29 13:57:35.000', N'', N'')
GO


-- ----------------------------
-- Table structure for FrmLeaveReq
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FrmLeaveReq]') AND type IN ('U'))
	DROP TABLE [dbo].[FrmLeaveReq]
GO

CREATE TABLE [dbo].[FrmLeaveReq] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [UserName] nvarchar(10) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [RequestType] nvarchar(20) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StartDate] date NOT NULL,
  [StartTime] datetime NULL,
  [EndDate] date NOT NULL,
  [EndTime] datetime NULL,
  [RequestComment] nvarchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [Attachment] varchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [FlowInstanceId] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[FrmLeaveReq] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'ID',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请假人姓名',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'UserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请假分类，病假，事假，公休等',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'RequestType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始日期',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'StartDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始时间',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'StartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束日期',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'EndDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束时间',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'EndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请假说明',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'RequestComment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'附件，用于提交病假证据等',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'Attachment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'CreateDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属流程实例',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq',
'COLUMN', N'FlowInstanceId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模拟一个自定页面的表单，该数据会关联到流程实例FrmData，可用于复杂页面的设计及后期的数据分析',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq'
GO


-- ----------------------------
-- Records of [FrmLeaveReq]
-- ----------------------------
INSERT INTO [dbo].[FrmLeaveReq]  VALUES (N'06307008-1dd9-48ad-a516-bcf4714cc9a7', N'1', N'病假', N'2019-10-07', N'2019-10-29 09:26:52.000', N'2019-10-27', N'2019-10-29 09:26:54.000', N'111', N'', N'2019-10-29 17:27:06.000', N'', N'', N'd4f8d2b9-6374-4c10-8d3c-1ca540bc309b')
GO

INSERT INTO [dbo].[FrmLeaveReq]  VALUES (N'59b5b72f-b8fb-44d4-bb24-319d02b2ab80', N'李玉宝', N'事假', N'2019-07-08', N'2019-07-28 17:23:14.000', N'2019-07-24', N'2019-07-28 17:23:18.000', N'太累了，就是想休息一下', N'', N'2019-07-29 01:23:58.000', N'', N'', N'0ae5abe6-f571-4e08-b264-667dc27c5025')
GO


-- ----------------------------
-- Table structure for Module
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Module]') AND type IN ('U'))
	DROP TABLE [dbo].[Module]
GO

CREATE TABLE [dbo].[Module] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [CascadeId] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Name] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Url] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [HotKey] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [IsLeaf] bit DEFAULT ((1)) NOT NULL,
  [IsAutoExpand] bit DEFAULT ((0)) NOT NULL,
  [IconName] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Status] int DEFAULT ((1)) NOT NULL,
  [ParentName] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Vector] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [SortNo] int DEFAULT ((0)) NOT NULL,
  [ParentId] [dbo].[PrimaryKey] NULL,
  [Code] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [IsSys] bit DEFAULT ((0)) NOT NULL
)
GO

ALTER TABLE [dbo].[Module] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'功能模块流水号',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'节点语义ID',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'CascadeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'功能模块名称',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'主页面URL',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'Url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'热键',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'HotKey'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否叶子节点',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'IsLeaf'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否自动展开',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'IsAutoExpand'
GO

EXEC sp_addextendedproperty
'MS_Description', N'节点图标文件名称',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'IconName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前状态',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父节点名称',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'ParentName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'矢量图标',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'Vector'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序号',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'SortNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父节点流水号',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'ParentId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否为系统模块',
'SCHEMA', N'dbo',
'TABLE', N'Module',
'COLUMN', N'IsSys'
GO

EXEC sp_addextendedproperty
'MS_Description', N'功能模块表',
'SCHEMA', N'dbo',
'TABLE', N'Module'
GO


-- ----------------------------
-- Records of [Module]
-- ----------------------------
INSERT INTO [dbo].[Module]  VALUES (N'0031262c-689c-4b96-bae2-2c9d67076ade', N'.0.1.9.', N'流程设计', N'/flowSchemes/index', N'', N'0', N'0', N'layui-icon-engine', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'FlowScheme', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'.0.2.', N'流程中心', N'/', N'', N'0', N'0', N'layui-icon-senior', N'0', N'根节点', N'', N'0', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'37bb9414-19a0-4223-9056-71f8c758a930', N'.0.2.5.', N'已处理流程', N'/flowinstances/disposed', N'', N'0', N'0', N'layui-icon-ok-circle', N'0', N'流程中心', N'', N'0', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstanceDisposed', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'.0.2.6.', N'待处理流程', N'/flowinstances/wait', N'', N'0', N'0', N'layui-icon-help', N'0', N'流程中心', N'', N'0', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstanceWait', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', N'.0.1.10.', N'部门管理', N'/OrgManager/Index', N'', N'0', N'0', N'layui-icon-group', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Org', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'7580672f-a390-4bb6-982d-9a4570cb5199', N'.0.1.', N'基础配置', N' /', N'', N'0', N'0', N'layui-icon-set-fill', N'0', N'根节点', N'', N'0', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'7bc7e527-478d-49fd-868d-5f31951586f5', N'.0.3.1.', N'系统日志', N'/SysLogs/Index', N'', N'0', N'0', N'layui-icon-theme', N'0', N'消息日志', N'', N'0', N'b19bce90-5508-43b6-93ed-cd9ff9e356a9', N'SysLog', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'7bc7e527-478d-49fd-868d-5f31951586f6', N'.0.3.2.', N'我的消息', N'/SysMessages/Index', N'', N'0', N'0', N'layui-icon-theme', N'0', N'消息日志', N'', N'0', N'b19bce90-5508-43b6-93ed-cd9ff9e356a9', N'SysMessage', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'92b00259-2d15-43e7-9321-adffb29e8bf2', N'.0.1.11.', N'表单设计', N'/forms/index', N'', N'0', N'0', N'layui-icon-theme', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Form', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'.0.2.7.', N'我的流程', N'/flowInstances/Index', N'', N'0', N'0', N'layui-icon-share', N'0', N'流程中心', N'', N'0', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstance', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'9a87c0fa-9172-42a1-9505-7492433dcb8e', N'.0.1.16.', N'数据权限', N'/dataprivilegerules/index', N'', N'0', N'0', N'layui-icon-auz', N'0', N'基础配置', N'', N'1', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'DataPrivilegeRule', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'.0.1.12.', N'字典分类', N'/Categories/Index', N'', N'0', N'0', N'layui-icon-app', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Category', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'b19bce90-5508-43b6-93ed-cd9ff9e356a9', N'.0.3.', N'消息日志', N' /', N'', N'0', N'0', N'layui-icon-set-fill', N'0', N'根节点', N'', N'0', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'bc80478d-0547-4437-9cff-be4b40144bdf', N'.0.1.13.', N'模块管理', N'/ModuleManager/Index', N'', N'0', N'0', N'layui-icon-tabs', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Module', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'bedb41a2-f310-4775-af99-01be08adda93', N'.0.1.14.', N'角色管理', N'/RoleManager/Index', N'', N'0', N'0', N'layui-icon-user', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Role', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', N'.0.1.3.', N'资源管理', N'/Resources/Index', N'', N'0', N'0', N'layui-icon-cellphone', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Resource', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', N'.0.1.15.', N'用户管理', N'/UserManager/Index', N'', N'0', N'0', N'layui-icon-friends', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'User', N'1')
GO


-- ----------------------------
-- Table structure for ModuleElement
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[ModuleElement]') AND type IN ('U'))
	DROP TABLE [dbo].[ModuleElement]
GO

CREATE TABLE [dbo].[ModuleElement] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [DomId] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Name] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Attr] varchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Script] varchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Icon] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Class] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Remark] varchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Sort] int DEFAULT ((0)) NOT NULL,
  [ModuleId] [dbo].[PrimaryKey] NOT NULL,
  [TypeName] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeId] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[ModuleElement] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'流水号',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'DOM ID',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'DomId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'名称',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'元素附加属性',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'Attr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'元素调用脚本',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'Script'
GO

EXEC sp_addextendedproperty
'MS_Description', N'元素图标',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'Icon'
GO

EXEC sp_addextendedproperty
'MS_Description', N'元素样式',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'Class'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序字段',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'Sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'功能模块Id',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'ModuleId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'TypeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement',
'COLUMN', N'TypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块元素表(需要权限控制的按钮)',
'SCHEMA', N'dbo',
'TABLE', N'ModuleElement'
GO


-- ----------------------------
-- Records of [ModuleElement]
-- ----------------------------
INSERT INTO [dbo].[ModuleElement]  VALUES (N'0d25438e-1436-48e0-aedf-0f1690693282', N'btnAccessModule', N'为角色分配模块', N'', N'assignRoleModule(this)', N'layui-icon-search', N'layui-btn-normal', N'为角色分配模块', N'4', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'13617796-049c-4ae4-a62b-1ca84002b273', N'btnDelCategory', N'删除分类', N'', N'', N'layui-icon-delete', N'layui-btn-danger', N'', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', N'btnAssignReource', N'为角色分配资源', N'', N'openRoleReourceAccess(this)', N'layui-icon-search', N'layui-btn-normal', N'为角色分配资源', N'3', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'17ae4fd4-ab4e-439e-ba1d-2a53b46d112b', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'', N'2', N'0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'18cc3217-28a6-49b2-9a20-080230065984', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'', N'1', N'0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1a473afd-cbd4-41e9-9471-81f9435aaabe', N'btnEdit', N'编辑', N' ', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1c870438-4260-43a5-8996-a6e1dc8bbf6a', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加部门', N'0', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑角色', N'1', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'2feefce1-e3d8-42ac-b811-2352679628da', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'刪除用戶', N'2', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'34730f5a-d307-457b-9041-5f7de30abfa9', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑用户', N'1', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'362d1eda-c85e-4b14-a80a-b923291e08de', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加', N'0', N'f0f06b8f-0a86-487c-8b0e-0a12573ccd46', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'38109ca0-32ec-44bd-a243-017e591b532b', N'btnEditStock', N'编辑', N' ', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑进出库', N'0', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'3dc0ec4d-bf86-4bae-9ec0-1d6c2403fb99', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'', N'1', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'44075557-496e-4dde-bb75-7b69f51ab4fe', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑模块', N'2', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'4bfa8ea0-6b0d-426f-8687-b654575ca780', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑资源', N'2', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'4f2737db-633f-4946-8a71-b08b9885f151', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'', N'2', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'50c9df24-b233-42cb-9a0d-4ce158c75f86', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加用戶', N'0', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'584c7a3b-d28a-47b4-8648-7797d05d83d1', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'', N'3', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'5ed1681c-13d2-4c87-8675-a8d95c0b40ae', N'btnAddMenu', N'添加菜单', N'', N'assignButton()', N'layui-icon-add-1', N'layui-btn-normal', N'为模块分配按钮', N'4', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'5ed1681c-13d2-4c87-8676-a8d95c0b40ae', N'btnEditMenu', N'编辑菜单', N'', N'', N'layui-icon-add-1', N'layui-btn-normal', N'编辑菜单', N'5', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'5ed1681c-13d2-4c87-8677-a8d95c0b40ae', N'btnDelMenu', N'删除菜单', N'', N'', N'layui-icon-delete', N'layui-btn-danger', N'', N'6', N'bc80478d-0547-4437-9cff-be4b40144bdf', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'645b40ac-4223-44a7-aab4-66eb56cf9864', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加角色', N'0', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'68484265-7802-4f06-b024-33e8b2f2edcf', N'btnAdd', N'新的申请', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'申请物品', N'0', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'68fc793f-069f-43e1-a012-42ac2d7c585c', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除角色', N'2', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'6c814946-db5c-48bd-84dd-b1c38196ad74', N'btnAdd', N'添加模版', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'', N'0', N'0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'6db928fe-93df-460f-9472-8bb0b6cae52c', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加进出库', N'0', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'btnVerification', N'处理', N'', N'verificationForm()', N'layui-icon-triangle-r', N'layui-btn-normal', N'', N'5', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除部门', N'2', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'7f071c63-1620-4486-9264-5806b2e63218', N'btnAccessRole', N'为用户分配角色', N'', N'openUserRoleAccess(this)', N'layui-icon-search', N'layui-btn-normal', N'为用户分配角色', N'5', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'816b12b3-e916-446d-a2fa-329cfd13c831', N'btnDetail', N'进度详情', N'', N'', N'layui-icon-search', N'layui-btn-normal', N'', N'4', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'81ce1abe-209d-4e4c-a8d2-efbc6a3b45ba', N'btnAdd', N'添加', N'', N'', N'layui-icon-add-1', N'layui-btn-normal', N'', N'1', N'9a87c0fa-9172-42a1-9505-7492433dcb8e', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'826b12b3-e916-446d-a2fa-329cfd13c831', N'btnDetail', N'进度详情', N'', N'', N'layui-icon-search', N'layui-btn-normal', N'', N'4', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'84694ea5-d6e1-4a65-8a59-7b5b779688d4', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加模块', N'1', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', N'btnDelStock', N'删除', N' ', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'8966b04f-8e26-4046-8b03-0c64f9f833dd', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'', N'3', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'95c2dde0-f2a7-4474-8aa7-c7eaa7c4c87f', N'btnDel', N'删除', N'', N'', N'layui-icon-delete', N'layui-btn-danger', N'', N'1', N'9a87c0fa-9172-42a1-9505-7492433dcb8e', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'9c96e485-84a6-45f0-b6a7-f01dab94b0c6', N'btnPreview', N'预览', N'', N'preview()', N'layui-icon-search', N'layui-btn-normal', N'', N'4', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'9e2c6754-f258-4b14-96a0-b9d981196a65', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加资源', N'0', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'a7eea5dc-3b10-4550-9cf3-0dba9b9fc32c', N'btnAddCategory', N'添加分类', N'', N'', N'layui-icon-add-1', N'layui-btn-normal', N'', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', N'btnDetail', N'查看详情', N'', N'', N'layui-icon-search', N'layui-btn-normal', N'', N'0', N'37bb9414-19a0-4223-9056-71f8c758a930', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'btnRefresh', N'刷新', N'', N'refresh()', N'layui-icon-refresh', N'layui-btn-normal', N'刷新分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除进出库', N'0', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c7d7daf0-3669-4a22-8bed-b092617deb9c', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除资源', N'3', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a', N'btnRefresh', N'刷新', N'', N'refresh()', N'layui-icon-refresh', N'layui-btn-normal', N'刷新用户', N'3', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'd352c8ee-3dff-4d28-a0de-903ae68f2533', N'btnPreview', N'预览', N'', N'preview()', N'layui-icon-cellphone', N'layui-btn-normal', N'', N'1', N'0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'daddf3b9-71b5-45ac-b85d-5a11c522f2f4', N'btnDel', N'删除', N' ', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除模块', N'3', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'ef42721f-d223-4a00-a1d9-80b81121f21a', N'btnEdit', N'编辑', N' ', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑部门', N'0', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'f8dde22a-2a37-47c4-8e67-70fb3af5303e', N'btnRefresh', N'刷新', N'', N'refresh()', N'layui-icon-refresh', N'layui-btn-normal', N'刷新部门', N'0', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO


-- ----------------------------
-- Table structure for Org
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Org]') AND type IN ('U'))
	DROP TABLE [dbo].[Org]
GO

CREATE TABLE [dbo].[Org] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [CascadeId] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Name] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [HotKey] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [ParentName] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [IsLeaf] bit DEFAULT ((1)) NOT NULL,
  [IsAutoExpand] bit DEFAULT ((0)) NOT NULL,
  [IconName] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Status] int DEFAULT ((1)) NOT NULL,
  [BizCode] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [CustomCode] varchar(4000) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CreateId] int DEFAULT ((0)) NOT NULL,
  [SortNo] int DEFAULT ((0)) NOT NULL,
  [ParentId] [dbo].[PrimaryKey] NULL,
  [TypeName] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeId] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[Org] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'流水号',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'节点语义ID',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'CascadeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'组织名称',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'热键',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'HotKey'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父节点名称',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'ParentName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否叶子节点',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'IsLeaf'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否自动展开',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'IsAutoExpand'
GO

EXEC sp_addextendedproperty
'MS_Description', N'节点图标文件名称',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'IconName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前状态',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'业务对照码',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'BizCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义扩展码',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'CustomCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'CreateId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序号',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'SortNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父节点流水号',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'ParentId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'TypeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'Org',
'COLUMN', N'TypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'组织表',
'SCHEMA', N'dbo',
'TABLE', N'Org'
GO


-- ----------------------------
-- Records of [Org]
-- ----------------------------
INSERT INTO [dbo].[Org]  VALUES (N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'.0.4.', N'研发小组', N'', N'根节点', N'0', N'0', N'', N'0', N'0', N'', N'2016-10-14 11:40:31.000', N'0', N'1', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'543a9fcf-4770-4fd9-865f-030e562be238', N'.0.1.', N'集团总部', N'', N'根节点', N'0', N'0', N'', N'0', N'0', N'', N'2016-10-14 11:37:13.000', N'0', N'0', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'86449128-d5ac-44bf-b999-f7735b7458fd', N'.0.2.1.', N'汇丰软件部', N'', N'汇丰', N'0', N'0', N'', N'1', N'0', N'', N'2016-05-26 15:11:03.000', N'0', N'1', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'c36e43df-3a99-45da-80d9-3ac5d24f4014', N'.0.2.', N'汇丰', N'', N'根节点', N'0', N'0', N'', N'0', N'0', N'', N'2016-05-26 15:10:40.000', N'0', N'1', NULL, NULL, NULL)
GO


-- ----------------------------
-- Table structure for Relevance
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Relevance]') AND type IN ('U'))
	DROP TABLE [dbo].[Relevance]
GO

CREATE TABLE [dbo].[Relevance] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Description] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Key] varchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Status] int DEFAULT ((0)) NOT NULL,
  [OperateTime] datetime DEFAULT (getdate()) NOT NULL,
  [OperatorId] [dbo].[PrimaryKey] NULL,
  [FirstId] [dbo].[PrimaryKey] NOT NULL,
  [SecondId] [dbo].[PrimaryKey] NOT NULL,
  [ThirdId] [dbo].[PrimaryKey] NULL,
  [ExtendInfo] varchar(100) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[Relevance] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'流水号',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'描述',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'映射标识',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'Key'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'授权时间',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'OperateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'授权人',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'OperatorId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第一个表主键ID',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'FirstId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第二个表主键ID',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'SecondId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三个表主键ID',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'ThirdId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'扩展信息',
'SCHEMA', N'dbo',
'TABLE', N'Relevance',
'COLUMN', N'ExtendInfo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'多对多关系集中映射',
'SCHEMA', N'dbo',
'TABLE', N'Relevance'
GO


-- ----------------------------
-- Records of [Relevance]
-- ----------------------------
INSERT INTO [dbo].[Relevance]  VALUES (N'023c001e-d7be-4e1d-b5dc-8c14535a2cf9', N'', N'RoleElement', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'03b55a9e-a44f-44fa-9383-4117bf8aba60', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'03be9b5e-38b0-4525-8431-b26d35ce6ce3', N'', N'UserElement', N'0', N'2016-09-07 15:30:43.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'06dfd97d-17e0-42b8-bde7-40006d8c8eb2', N'', N'UserElement', N'0', N'2018-04-06 14:50:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'06f4c4a2-faa8-4bad-9184-50ceb517f30b', N'', N'ProcessUser', N'0', N'2016-09-08 16:48:14.000', N'0', N'10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'077e24ab-4c48-4a5e-bfa9-90ea00449136', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:47.000', N'', N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'08ff97f7-17fc-4072-b29a-287135898ece', N'', N'RoleResource', N'0', N'2016-09-04 23:20:22.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'fdf3aac3-4507-40ad-aa2f-d7f0459de252', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0a9bcd14-0e27-474a-8c0e-0d023d6013eb', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0b3d3a9b-8a96-43d4-918c-fa7e3ea5f5ca', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:37.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0b729611-c225-4fb6-8584-404a58373ff0', N'', N'UserOrg', N'0', N'2018-09-12 00:10:31.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0fd5b371-b010-4846-8833-95cc1e813a32', N'', N'UserElement', N'0', N'2016-09-07 15:31:16.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'10a76196-ba0c-4294-bb8f-dcd063eb4aab', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'10e58d75-dec1-4b85-882f-9dac79ad1210', N'', N'RoleResource', N'0', N'2016-10-21 18:08:13.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1196cfff-9a57-4ef2-a3ee-abd438871264', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'AppId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'120d7a5d-203c-4261-95f5-0125757fb386', N'', N'UserElement', N'0', N'2016-10-20 17:01:01.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'13433400-a32c-4539-b988-8b417c09bc0e', N'', N'UserModule', N'0', N'2016-09-07 15:30:07.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'13612a4c-b20c-4bd0-a2cd-0ae47576364d', N'', N'UserElement', N'0', N'2016-10-20 16:34:12.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'13f1fd43-b36f-4cd9-9870-952645e0c23a', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'142584e6-7770-4b9a-863d-740577597ee5', N'', N'UserOrg', N'0', N'2019-10-29 20:18:23.000', N'', N'de8be521-f1ec-4483-b124-0be342890507', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1490edd4-9bd3-4e71-bfa4-56f6558c1d3f', N'', N'UserElement', N'0', N'2018-04-06 09:48:24.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'16154fc4-d18e-44a3-bcf2-5539b168aba7', N'', N'RoleElement', N'0', N'2016-10-24 17:25:15.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'18cc3217-28a6-49b2-9a20-080230065984', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1729e26b-ad34-4726-b6fa-8fc0dbd4ee6c', N'', N'UserOrg', N'0', N'2019-10-29 17:05:03.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'543a9fcf-4770-4fd9-865f-030e562be238', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1740ff26-a4d0-44cc-9fab-a0105c2c60b6', N'', N'UserOrg', N'0', N'2017-10-12 13:59:49.000', N'', N'63c9c82a-e0d3-4bde-bbd2-057cda2f5283', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1873ed85-a88a-4236-bd40-2c416aa2576c', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'19c9621c-3d23-46b7-a841-54d5c82ec8e8', N'', N'UserOrg', N'0', N'2016-09-02 13:56:53.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1acec4c4-0136-4e2b-a839-8676dbd6594a', N'', N'ProcessUser', N'0', N'2016-09-14 11:38:23.000', N'0', N'6c6afe3c-349c-4198-8710-cf19c90f3afd', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1b52e0cb-2df1-41e2-90ab-fc051be1d983', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1ced1564-2fea-4c04-8aea-f071fa5bb293', N'', N'UserModule', N'0', N'2016-09-05 16:24:55.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1cf19b35-e2c2-436f-99b9-03ac2b232cc6', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'44075557-496e-4dde-bb75-7b69f51ab4fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2014027e-0cff-41cf-974b-56126d6eaa9a', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'20f03189-18c8-4d2d-b924-85375f4b6c26', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'21b6a747-c573-4990-9327-ec3d1323127c', N'', N'RoleElement', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'22ccf653-9972-4611-ba0e-384c28c51f0f', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'242e9543-3343-41d4-8816-15ffeeaef551', N'', N'UserElement', N'0', N'2016-09-07 15:31:16.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'27c4d50c-32da-4dbc-88a1-84b343cdd649', N'', N'UserElement', N'0', N'2016-10-20 17:01:00.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'6839a297-350b-4215-b680-4e5dfdae5615', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'29b06cd6-af0c-4c63-9aba-e5431c5d62ec', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2a1b833c-dc81-46e2-b308-e22e0f112f77', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2a36a2b7-41aa-4190-b88c-75d44a56ad6e', N'', N'UserModule', N'0', N'2017-02-06 00:14:18.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2ab3e3b4-cdcc-4f8b-86f1-aa9c2d51d1dd', N'', N'UserOrg', N'0', N'2018-09-12 00:10:43.000', N'', N'229f3a49-ab27-49ce-b383-9f10ca23a9d5', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2bb3fddb-0f51-442e-8dbf-236beb47d8a6', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2ca288a6-d222-4328-951e-c01c3e77a0c7', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2d0fcc88-a7c0-4d33-8a08-1d688e9dde83', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2d15e438-cc3a-41e9-9b13-325bfd5c804a', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2ebff9a4-b2d5-4a35-a7dd-2cfa2f5b0522', N'', N'ProcessUser', N'0', N'2016-09-07 17:33:39.000', N'0', N'52cc7933-a045-4dcc-8c17-1b618bfa772b', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'30c82d18-7892-4e5f-9aee-e4f483a858c2', N'', N'UserModule', N'0', N'2016-09-05 16:24:55.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'332a373c-f485-4f85-9af9-7792f7462bf1', N'', N'RoleModule', N'0', N'2016-09-02 17:03:47.000', N'0', N'648b04c4-4ac2-4d69-bef6-07081ef27871', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'340c60fe-8b95-474c-aa04-9197903998d2', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'361feb63-bde2-49c7-86ec-6df3ec6f0fe3', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1c870438-4260-43a5-8996-a6e1dc8bbf6a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'386d6cb7-c465-422c-974f-3250b0e4888f', N'', N'UserOrg', N'0', N'2018-09-12 00:10:35.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'392dc41e-7186-4efb-a8e5-b5317e4122fb', N'', N'RoleResource', N'0', N'2018-09-10 12:54:14.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3bcaab20-e096-480e-a9bb-0fdb70686714', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3de0359b-6331-4dc7-a00e-751f71dbadb5', N'', N'ProcessUser', N'0', N'2016-09-28 09:23:30.000', N'0', N'68295d2a-4dfd-4c5e-81e3-9c787e2603bc', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3e9b3e79-c972-4c50-a36d-ab179d2ad09d', N'', N'RoleModule', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4190f00a-11a0-4814-849b-cc5232fa4dd4', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'OPENAUTH_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'45fcbc8b-2951-40a1-8329-4bdf3c8f70e4', N'', N'UserOrg', N'0', N'2018-09-12 00:10:35.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'460d1c98-2a68-43cf-8d38-d40ceb89916f', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4757bb30-e4bc-4c2d-a824-947ef151d341', N'', N'UserRole', N'0', N'2016-09-07 20:21:16.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4ba3982b-f0ae-4f9a-980e-1eaedc3b5f2e', N'', N'UserElement', N'0', N'2016-09-07 17:48:34.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4c2fb006-53d6-4041-8cf6-e5d74d788897', N'', N'UserModule', N'0', N'2018-04-06 09:48:19.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4c69794b-9957-4f6b-b0fb-6455fe643565', N'', N'UserElement', N'0', N'2018-04-06 14:50:41.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4daccce5-cb7b-46aa-8bed-3c85c72436be', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:37.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4e613188-0387-4d17-a60d-703b4a606d75', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4e665304-9f05-410e-b68f-44d45281b788', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:47.000', N'', N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4e6c69a6-eeba-45d9-923d-16a7c002ac3e', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4ec39ee9-9ee9-4aa9-a0db-eb0fdf8d2f00', N'', N'UserElement', N'0', N'2018-04-06 09:48:27.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4ee89c07-55e2-4ca6-9ef1-449cfe0a2c3c', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4fde1dc6-9d73-4c7c-9238-28981858c5a6', N'', N'RoleModule', N'0', N'2016-09-05 09:21:56.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5167dbcd-3a32-4ae8-827e-6f381cc58fa2', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'fa816af1-a28d-47b5-9b8b-c46e18f902e9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'53a4be87-4fa8-415b-97b5-2298ce8b17c8', N'', N'UserResource', N'0', N'2018-04-14 14:38:04.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'XXX_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'54a8edde-af09-48e1-adb5-5ffc90b02c4d', N'', N'RoleModule', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'54b2e9b6-1f7c-4a39-92c9-98f58429c1fc', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'54d8d1b8-2b5b-498d-9c0d-33e8bad86572', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'826b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'55b10ecc-3fb3-4127-b69e-e7a3467d7a1a', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'6db928fe-93df-460f-9472-8bb0b6cae52c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5725ff79-43c6-4778-bbff-131cf364dab6', N'', N'UserElement', N'0', N'2016-10-20 17:01:01.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5a20d59c-6ee6-4fe2-98fe-7b35b11026ae', N'', N'UserElement', N'0', N'2016-09-07 15:30:20.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5a86259a-9555-4aa7-be8d-a874f88b66a8', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5b0ec87e-3465-48c2-98da-e4c28a6f8f34', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5b2d5db8-d603-4be3-add2-c85ef3c53ddc', N'', N'UserResource', N'0', N'2018-04-14 14:38:05.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5ccce632-f8f0-452b-8faf-4a5372004e85', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_CHECKUSER', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'620b368a-7b56-4c74-ab85-8bc91d08ddc9', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'62fc2363-2a9a-48cb-b455-aa43d0cf978a', N'', N'RoleModule', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'63a22a27-c8bd-4bdf-a3bb-6ffeae19484e', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6431a464-6f1f-4ffc-8157-89212b70f09a', N'', N'RoleOrg', N'0', N'2016-09-05 00:00:00.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'64879608-334c-48c7-bd80-a562d9619d95', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'64e4f5aa-28ef-4690-9b20-5f0b543964f6', N'', N'UserElement', N'0', N'2016-09-07 15:30:20.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6645b6fb-efcf-4e48-9c13-84f79bc5be34', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'66e25fc5-093d-42ab-85dc-a38f6600889b', N'', N'UserOrg', N'0', N'2016-09-02 13:57:32.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'68912e65-256e-45b6-b48e-036382598d32', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:49.000', N'0', N'2eb423d6-6ad9-4efe-b423-872478a2a434', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6b9c4789-042c-4f6f-a749-ee68ee87462d', N'', N'ProcessUser', N'0', N'2016-10-27 16:47:52.000', N'0', N'054ff054-d8ae-4911-a596-8fb1f66b348f', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6da6d662-8cef-47cd-80b3-fa885b2dca7a', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6db5666b-6f8c-4e83-bada-0b45054bd9a4', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'0d25438e-1436-48e0-aedf-0f1690693282', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6f0ed92f-f2b9-4e7b-a965-3cd3d38abe2e', N'', N'RoleModule', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6f563fe2-21f0-441f-8b43-9afd92b53356', N'', N'RoleModule', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6fe52499-f800-47ce-96fc-a2b5b43505d5', N'', N'UserElement', N'0', N'2018-04-06 09:48:22.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'70c89239-dc86-4ac9-9779-7dcbb4dfe685', N'', N'RoleElement', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'715d017a-68b6-468d-aa3f-32ca4cfd4b9e', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'72bf4729-af60-42f5-b0d7-717362ffad7f', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'2feefce1-e3d8-42ac-b811-2352679628da', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'72d150c7-60a5-428e-8a7e-d484d2c97cd8', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'736e90f7-3747-472e-816d-dbb7fdf3b0bb', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:42.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7475b0c3-f204-4f95-a22f-80591fe76bc7', N'', N'ProcessUser', N'0', N'2016-10-31 11:52:39.000', N'0', N'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'75340ad3-fb80-4646-b1de-ba801688ddc2', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'5ed1681c-13d2-4c87-8675-a8d95c0b40ae', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77bd93da-2c2b-4ba8-bf05-3a1382811a6a', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77eec82a-f713-4584-872c-761fdbcdb456', N'', N'UserElement', N'0', N'2018-04-06 14:50:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77fc08e6-98ae-4d33-b294-bd9fed5b14ed', N'', N'UserElement', N'0', N'2018-04-06 14:50:36.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'797c6e5f-7f3c-4891-89b9-a054e10f6c00', N'', N'UserModule', N'0', N'2018-04-06 09:48:01.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'37bb9414-19a0-4223-9056-71f8c758a930', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7f25286f-246b-4143-98eb-c3e574fe7455', N'', N'ProcessUser', N'0', N'2016-09-07 17:33:39.000', N'0', N'52cc7933-a045-4dcc-8c17-1b618bfa772b', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7fd7f976-f10e-44aa-a7ba-7ca40d2e8f90', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'80310629-5e52-482c-9a0f-5c5bdfabcd9e', N'', N'RoleOrg', N'0', N'2016-09-05 00:00:00.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8203d3db-c0d6-44b1-96c9-6e78e714657e', N'', N'UserOrg', N'0', N'2019-10-29 20:18:23.000', N'', N'de8be521-f1ec-4483-b124-0be342890507', N'86449128-d5ac-44bf-b999-f7735b7458fd', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'832f4a8f-7791-4aa6-bcd2-20dcb6f5ef37', N'', N'UserElement', N'0', N'2016-09-02 14:53:04.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'84a52091-08a0-4a46-b661-3cd206771c29', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'854e0658-ab8a-4869-b157-9941955acdc6', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1a473afd-cbd4-41e9-9471-81f9435aaabe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'85ab02d8-995f-4f66-9828-e53f04af09b9', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'88a4c966-d042-4a2e-b133-ff7eded1c5de', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'89e5dd60-0981-4cd9-b9ad-577b7b817556', N'', N'RoleDataProperty', N'0', N'2019-10-29 15:28:12.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8b633f3c-965b-4e35-8496-c364890d7760', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8fa4a52f-9c0a-43c9-9b7e-b378efb4e1df', N'', N'RoleResource', N'0', N'2018-09-10 12:54:14.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9043a72d-862f-49b4-bfe3-51d9bd289f14', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'816b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9210adfa-b783-4368-8c8d-86c30ec9cdd1', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'37bb9414-19a0-4223-9056-71f8c758a930', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'92f0b297-96c1-47d4-84dd-571374431bc0', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'84694ea5-d6e1-4a65-8a59-7b5b779688d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'93bcac7a-0ff1-488c-8d1c-3da7e44cbefc', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'95cd06bd-7cad-4790-b5f8-15738360da95', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'960224e6-5910-472b-a5ef-b2aa9a8b106f', N'', N'UserRole', N'0', N'2016-09-06 17:06:15.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'962b278b-0894-4b36-b1a0-6c5c3d11d4c3', N'', N'UserElement', N'0', N'2018-04-06 14:50:17.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'965f010b-2fd6-4b34-ba23-3e44c1af2877', N'', N'RoleOrg', N'0', N'2016-09-08 16:19:18.000', N'0', N'36094f5d-07e7-40d5-91dc-ff60f98b496a', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'966531b6-584c-4f0a-b934-c33aab795f1c', N'', N'RoleElement', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9ad706e3-8e6b-4bc7-a502-371b298ef062', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'ef42721f-d223-4a00-a1d9-80b81121f21a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9d568d6d-d78d-47d6-8fb6-b1327cdbe83a', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9e46a946-6e81-4f61-bcba-21e4f7fac3df', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9e57e1ff-e9cf-4600-a872-ac85f7845bb0', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9ea4add6-9fdf-4046-8b6f-84f0a1cb2967', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'1a473afd-cbd4-41e9-9471-81f9435aaabe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9edc7b81-2b51-4193-8805-6062e596ccdc', N'', N'UserOrg', N'0', N'2016-09-02 13:57:32.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9fa50449-5d87-4579-9f1f-9cdcd876976b', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'6839a297-350b-4215-b680-4e5dfdae5615', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a051aa08-38da-4b6d-8d90-10b3c2485e4b', N'', N'RoleOrg', N'0', N'2016-09-05 00:00:00.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a06fe8c6-3f5e-4085-9bbf-e366571a356c', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'daddf3b9-71b5-45ac-b85d-5a11c522f2f4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a0904102-e26a-4bc5-9c95-ed5ef977586b', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a4df5a15-fd77-40fb-84cd-3b7844bd0147', N'', N'RoleElement', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'1a473afd-cbd4-41e9-9471-81f9435aaabe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a57900b2-caf1-4cbd-8ac2-f8dd9a40199d', N'', N'UserRole', N'0', N'2018-09-12 00:10:24.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a5bef7bf-ecdb-4480-ad64-b39a02269607', N'', N'UserModule', N'0', N'2018-04-06 09:48:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a72c1bc6-1fe1-4186-86e9-d1d9afc6b0eb', N'', N'UserOrg', N'0', N'2019-10-29 17:05:03.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'2b1d982f-d8e5-4fff-aaf5-4400fd9e204f', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a8094b46-de5a-40ea-a8ee-69ea905480ef', N'', N'RoleModule', N'0', N'2016-09-05 09:21:56.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a8123b37-ba70-4aab-aef6-1938733b5210', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c0d8505c-061a-467d-862a-c94f27caa208', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a9821db0-49bd-49be-a554-afa811c99760', N'', N'RoleResource', N'0', N'2016-09-04 23:20:22.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'aa051096-a23a-431d-9053-bb954f9453a7', N'', N'RoleElement', N'0', N'2016-09-04 23:20:54.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'4bfa8ea0-6b0d-426f-8687-b654575ca780', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'aa72812e-b3de-4466-bd6c-2391450bbdbc', N'', N'UserOrg', N'0', N'2019-10-29 17:05:03.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ab190397-32a8-4b0f-bf34-2d648d6fe974', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ab84b111-fb5d-4ddd-99d5-479954d9d521', N'', N'RoleOrg', N'0', N'2016-09-08 16:19:18.000', N'0', N'36094f5d-07e7-40d5-91dc-ff60f98b496a', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ab924ba7-8a74-4804-82b0-ecbbedf4c13e', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'38109ca0-32ec-44bd-a243-017e591b532b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ac184827-9899-4b40-8939-61fe9d2b187c', N'', N'UserElement', N'0', N'2016-09-07 17:48:49.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'acb4d37f-8b45-4a99-b364-99f3881dfcda', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'f8dde22a-2a37-47c4-8e67-70fb3af5303e', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'acc51898-5335-4903-83b9-4701a782bc4d', N'', N'UserElement', N'0', N'2016-10-20 17:01:02.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'fa816af1-a28d-47b5-9b8b-c46e18f902e9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad267296-5eba-4d59-b821-8148d8cfb3c6', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad29467e-eeee-494c-ab82-f6be5d2619d5', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'50c9df24-b233-42cb-9a0d-4ce158c75f86', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad30e13e-6b75-48f9-97e3-c723d3e36a28', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'OPENAUTH_MODIFYACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad5bc7a6-e307-4fa8-a4ef-ce9e09f7e21b', N'', N'RoleModule', N'0', N'2016-09-05 09:21:56.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad905aa6-d3d8-4fe9-99b4-5f8be7891d1e', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_ADMIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ae619801-1959-44fd-a75b-a8cca4d559b4', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:37.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'af263192-daa8-4f29-99b9-1efb96e31627', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'645b40ac-4223-44a7-aab4-66eb56cf9864', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b08d7763-a725-406f-a7d5-d144f00d716e', N'', N'UserOrg', N'0', N'2016-09-02 13:56:41.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b241dd3d-2965-44e4-929d-9dacb6444e09', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b246cd89-548c-4471-a43b-6f10b40c26b1', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:42.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b2490ac0-ba16-48a2-b39d-49f6b87f9387', N'', N'UserModule', N'0', N'2018-04-06 09:48:17.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b2edfee4-f980-4aa5-b547-492d677e0674', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b3b8f695-a179-489b-90b4-7814ab048a69', N'', N'UserElement', N'0', N'2018-04-06 09:48:21.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b4c2a294-125c-4768-9214-cea3ccf39a1c', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:42.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b672a830-c3a5-408b-a746-65608534b24c', N'', N'UserModule', N'0', N'2017-12-15 17:07:05.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b8606463-4957-424f-bcab-1ea27c15c2c5', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b9e63d17-35c8-4456-abab-8f43a1c99adc', N'', N'UserModule', N'0', N'2018-04-06 09:47:59.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ba41a404-f203-4467-baf5-a179563b1cf2', N'', N'UserOrg', N'0', N'2019-10-29 17:05:03.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bbdc3ea9-3f21-48b0-9d7a-39545d6183d0', N'', N'UserElement', N'0', N'2018-04-06 09:48:25.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bc869e2f-4417-4db5-92ac-611a0caf918d', N'', N'RoleElement', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'816b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bd783f53-23fa-41f4-8cec-7c61fab52072', N'', N'UserOrg', N'0', N'2018-03-15 09:19:06.000', N'', N'0ceff0f8-f848-440c-bc26-d8605ac858cd', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bda5f089-64d6-4fb8-9012-d7f3ff36902a', N'', N'UserOrg', N'0', N'2017-10-12 13:59:09.000', N'', N'ffd92ed2-5330-4ec2-a42d-6e0e9005db3b', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bed2842a-e9ff-4598-889f-2889033f8e67', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'4bfa8ea0-6b0d-426f-8687-b654575ca780', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bee6572d-8fb8-4e0e-af15-93aafc989717', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'68fc793f-069f-43e1-a012-42ac2d7c585c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bf096b00-8793-43ea-b56b-f72e4e8444a9', N'', N'RoleElement', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'68484265-7802-4f06-b024-33e8b2f2edcf', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c14addeb-1812-4a78-9152-1f7115b22d89', N'', N'UserRole', N'0', N'2016-09-05 00:00:47.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c2d3b7d6-b47d-4bd8-9dc6-d9134d86713f', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c3050d65-d26b-4e46-bece-a212b0cc00ec', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c4771ac5-3375-4de9-adb8-a603398f0d62', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'2d595a2a-5de5-479e-a331-b53c799a6b10', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c50fae2a-b36f-486f-9d53-e58406590101', N'', N'ProcessUser', N'0', N'2016-10-27 16:47:52.000', N'0', N'054ff054-d8ae-4911-a596-8fb1f66b348f', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c58cb482-6ab7-49eb-b5b0-e45424b6e502', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'34730f5a-d307-457b-9041-5f7de30abfa9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c68dccbb-b7c5-4db1-b426-b58a19f42145', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'9e2c6754-f258-4b14-96a0-b9d981196a65', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c733cfbe-2f71-41e4-92a6-4ff97cf88dc4', N'', N'UserModule', N'0', N'2018-04-06 09:48:19.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c8e31bf2-183c-486e-8898-064ba745e501', N'', N'RoleDataProperty', N'0', N'2019-10-29 15:28:12.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c9099371-8d4e-4f5b-9686-2c60a2c1c641', N'', N'ProcessUser', N'0', N'2016-09-08 16:48:14.000', N'0', N'10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c98b3d02-a76b-4ecc-94a5-cfeffd5e29fb', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd22b89f8-50d1-4816-9bb2-576ea49d9245', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'68484265-7802-4f06-b024-33e8b2f2edcf', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd97f0ff6-3a34-42cf-91c5-3f2ce81061e8', N'', N'UserOrg', N'0', N'2019-10-29 17:05:03.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'86449128-d5ac-44bf-b999-f7735b7458fd', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'da6c0645-0bf9-4ade-9dd3-1b09e91e504c', N'', N'RoleElement', N'0', N'2016-09-05 09:22:07.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'db9a5462-8f52-4755-afd7-39887dff55b5', N'', N'RoleDataProperty', N'0', N'2019-10-29 15:28:12.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'df2d90b3-4e2e-40e9-b406-220009726460', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'dfbcc1cb-4103-46ac-8f4f-ce8bb3402392', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'dfd5430b-3422-465a-be79-05a1e06deed2', N'', N'RoleElement', N'0', N'2016-09-04 23:20:54.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e12b77de-b7ce-4f38-b7a3-f3b2d285f33b', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:49.000', N'0', N'2eb423d6-6ad9-4efe-b423-872478a2a434', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e28c0dcd-168a-4b60-a514-7b6eb8026709', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e5689793-8dd7-4d07-bf2e-4977eba430f4', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e619a82e-edfb-4542-94df-0b92850667ad', N'', N'RoleResource', N'0', N'2018-04-14 14:39:56.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_MODIFYACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e785147c-f46b-474f-8fad-73b14fa69822', N'', N'UserRole', N'0', N'2016-09-06 17:06:29.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e84f6b9c-716d-4e94-a1aa-7fd0d1a2e23e', N'', N'RoleModule', N'0', N'2016-09-02 17:03:47.000', N'0', N'648b04c4-4ac2-4d69-bef6-07081ef27871', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e9cf3d63-6305-46c7-93b4-14053387c62c', N'', N'UserModule', N'0', N'2018-04-06 09:48:18.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'37bb9414-19a0-4223-9056-71f8c758a930', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ec72f6ae-09ee-4db9-99a1-bf15c8e35dda', N'', N'ProcessUser', N'0', N'2016-09-14 11:38:23.000', N'0', N'6c6afe3c-349c-4198-8710-cf19c90f3afd', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ec9c80ce-dbdf-4ba5-9091-82f75392c3b0', N'', N'UserElement', N'0', N'2016-09-07 15:30:43.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ee1986a0-24cc-4dec-b5f5-68ef959ab650', N'', N'UserElement', N'0', N'2018-04-06 14:50:40.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ee4f39fd-4fbf-4f68-9a70-d6c7d7db9723', N'', N'ProcessUser', N'0', N'2016-10-31 11:52:39.000', N'0', N'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'eec41fcb-61c0-4e56-a5c0-a9f8be6e6fdc', N'', N'UserModule', N'0', N'2016-09-07 15:30:06.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f03f503b-3898-44a0-a588-3ba4e27b72d5', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f0ab6f79-a9b6-4ddf-9a0c-c28330f029dd', N'', N'UserRole', N'0', N'2019-10-29 21:13:04.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f41de4d2-369d-46e1-b84d-4bd2c37b8c20', N'', N'UserOrg', N'0', N'2018-09-12 00:10:31.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f42343b9-adc2-4368-9028-7ed2f76fba68', N'', N'UserRole', N'0', N'2019-10-29 17:00:19.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f4ba636a-9002-43e6-93eb-95132a3e68c5', N'', N'ProcessUser', N'0', N'2016-09-28 09:23:30.000', N'0', N'68295d2a-4dfd-4c5e-81e3-9c787e2603bc', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f579a427-a9ed-4ebe-8411-72e8e6abd01d', N'', N'UserElement', N'0', N'2016-09-05 16:25:26.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f61ee29b-7988-404d-b692-5a8f667684be', N'', N'UserElement', N'0', N'2018-04-06 09:48:23.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f6367ca1-0486-46a4-b9c6-65c00936a516', N'', N'RoleElement', N'0', N'2016-09-04 23:20:54.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'9e2c6754-f258-4b14-96a0-b9d981196a65', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f671f582-9111-4000-aadd-660449d0d4b0', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f6a9cdf7-50c1-48b4-ae29-f999691f3a1d', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'TypeId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f6e2b76f-8cce-42de-af8e-b379e22b12c8', N'', N'UserOrg', N'0', N'2019-10-29 20:18:23.000', N'', N'de8be521-f1ec-4483-b124-0be342890507', N'543a9fcf-4770-4fd9-865f-030e562be238', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fa7c4d39-b31a-4668-8716-d40a62aa722b', N'', N'UserOrg', N'0', N'2017-10-12 13:59:49.000', N'', N'63c9c82a-e0d3-4bde-bbd2-057cda2f5283', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fffb23bb-4b47-4a4d-bf93-9d7c8755b6f0', N'', N'RoleElement', N'0', N'2019-10-29 15:28:04.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', N'', N'')
GO


-- ----------------------------
-- Table structure for Resource
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Resource]') AND type IN ('U'))
	DROP TABLE [dbo].[Resource]
GO

CREATE TABLE [dbo].[Resource] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CascadeId] varchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Name] varchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SortNo] int NOT NULL,
  [Description] varchar(500) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ParentName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ParentId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [AppId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [AppName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeName] varchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Disable] tinyint NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[Resource] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'资源标识',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'节点语义ID',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'CascadeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'名称',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序号',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'SortNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'描述',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父节点名称',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'ParentName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父节点流ID',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'ParentId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'资源所属应用ID',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'AppId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属应用名称',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'AppName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'TypeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'TypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否可用',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'Disable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'Resource',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'资源表',
'SCHEMA', N'dbo',
'TABLE', N'Resource'
GO


-- ----------------------------
-- Table structure for Role
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Role]') AND type IN ('U'))
	DROP TABLE [dbo].[Role]
GO

CREATE TABLE [dbo].[Role] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Status] int DEFAULT ((1)) NOT NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CreateId] [dbo].[PrimaryKey] NULL,
  [TypeName] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeId] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[Role] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'Id',
'SCHEMA', N'dbo',
'TABLE', N'Role',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色名称',
'SCHEMA', N'dbo',
'TABLE', N'Role',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前状态',
'SCHEMA', N'dbo',
'TABLE', N'Role',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'Role',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'Role',
'COLUMN', N'CreateId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'Role',
'COLUMN', N'TypeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'Role',
'COLUMN', N'TypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色表',
'SCHEMA', N'dbo',
'TABLE', N'Role'
GO


-- ----------------------------
-- Records of [Role]
-- ----------------------------
INSERT INTO [dbo].[Role]  VALUES (N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'管理员', N'0', N'2018-04-09 22:48:24.000', N'', N'', N'')
GO

INSERT INTO [dbo].[Role]  VALUES (N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'测试', N'0', N'2018-04-09 22:48:29.000', N'', N'', N'')
GO

INSERT INTO [dbo].[Role]  VALUES (N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'汇丰测试', N'0', N'2018-04-09 22:48:42.000', N'', N'', N'')
GO

INSERT INTO [dbo].[Role]  VALUES (N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'神', N'0', N'2018-04-14 13:16:45.000', N'', N'', N'')
GO


-- ----------------------------
-- Table structure for Stock
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Stock]') AND type IN ('U'))
	DROP TABLE [dbo].[Stock]
GO

CREATE TABLE [dbo].[Stock] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Number] int DEFAULT ((0)) NOT NULL,
  [Price] decimal(10,1) DEFAULT ((0)) NOT NULL,
  [Status] int DEFAULT ((0)) NOT NULL,
  [Viewable] varchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [User] varchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Time] datetime DEFAULT (getdate()) NOT NULL,
  [OrgId] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[Stock] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据ID',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品数量',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'Number'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品单价',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'Price'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库/入库',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'可见范围',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'Viewable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'User'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作时间',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'Time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'组织ID',
'SCHEMA', N'dbo',
'TABLE', N'Stock',
'COLUMN', N'OrgId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出入库信息表',
'SCHEMA', N'dbo',
'TABLE', N'Stock'
GO


-- ----------------------------
-- Table structure for SysLog
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysLog]') AND type IN ('U'))
	DROP TABLE [dbo].[SysLog]
GO

CREATE TABLE [dbo].[SysLog] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Content] nvarchar(1000) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeName] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeId] [dbo].[PrimaryKey] NULL,
  [Href] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CreateId] [dbo].[PrimaryKey] NOT NULL,
  [CreateName] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [Ip] varchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [Result] int DEFAULT ((0)) NOT NULL,
  [Application] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[SysLog] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'Id',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日志内容',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'Content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'TypeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'TypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作所属模块地址',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'Href'
GO

EXEC sp_addextendedproperty
'MS_Description', N'记录时间',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人ID',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'CreateId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'CreateName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作机器的IP地址',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'Ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作的结果：0：成功；1：失败；',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'Result'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属应用',
'SCHEMA', N'dbo',
'TABLE', N'SysLog',
'COLUMN', N'Application'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统日志',
'SCHEMA', N'dbo',
'TABLE', N'SysLog'
GO


-- ----------------------------
-- Table structure for SysMessage
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysMessage]') AND type IN ('U'))
	DROP TABLE [dbo].[SysMessage]
GO

CREATE TABLE [dbo].[SysMessage] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [TypeName] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeId] [dbo].[PrimaryKey] NULL,
  [FromId] [dbo].[PrimaryKey] NULL,
  [ToId] [dbo].[PrimaryKey] NOT NULL,
  [FromName] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ToName] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [FromStatus] int DEFAULT ((0)) NOT NULL,
  [ToStatus] int DEFAULT ((0)) NOT NULL,
  [Href] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [Title] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [Content] nvarchar(1000) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CreateId] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[SysMessage] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'Id',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'TypeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'TypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'消息源头',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'FromId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到达',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'ToId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'消息源头名称',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'FromName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'消息到达名称',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'ToName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'-1:已删除；0:默认',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'FromStatus'
GO

EXEC sp_addextendedproperty
'MS_Description', N'-1:已删除；0:默认未读；1：已读',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'ToStatus'
GO

EXEC sp_addextendedproperty
'MS_Description', N'点击消息跳转的页面等',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'Href'
GO

EXEC sp_addextendedproperty
'MS_Description', N'消息标题',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'Title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'消息内容',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'Content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage',
'COLUMN', N'CreateId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统消息表',
'SCHEMA', N'dbo',
'TABLE', N'SysMessage'
GO


-- ----------------------------
-- Table structure for UploadFile
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[UploadFile]') AND type IN ('U'))
	DROP TABLE [dbo].[UploadFile]
GO

CREATE TABLE [dbo].[UploadFile] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [FileName] nvarchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [FilePath] nvarchar(500) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Description] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [FileType] varchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [FileSize] int NULL,
  [Extension] varchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [Enable] bit DEFAULT ((1)) NOT NULL,
  [SortCode] int DEFAULT ((0)) NOT NULL,
  [DeleteMark] bit DEFAULT ((0)) NOT NULL,
  [CreateUserId] uniqueidentifier NULL,
  [CreateUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [Thumbnail] nvarchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [BelongApp] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [BelongAppId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[UploadFile] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'Id',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件名称',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'FileName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件路径',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'FilePath'
GO

EXEC sp_addextendedproperty
'MS_Description', N'描述',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件类型',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'FileType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件大小',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'FileSize'
GO

EXEC sp_addextendedproperty
'MS_Description', N'扩展名称',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'Extension'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否可用',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'SortCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标识',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'DeleteMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上传人',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上传人姓名',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上传时间',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缩略图',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'Thumbnail'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属应用',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'BelongApp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属应用ID',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile',
'COLUMN', N'BelongAppId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件',
'SCHEMA', N'dbo',
'TABLE', N'UploadFile'
GO


-- ----------------------------
-- Table structure for User
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type IN ('U'))
	DROP TABLE [dbo].[User]
GO

CREATE TABLE [dbo].[User] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Account] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Password] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Name] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [Sex] int DEFAULT ((0)) NOT NULL,
  [Status] int DEFAULT ((0)) NOT NULL,
  [BizCode] varchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (' ') NOT NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CreateId] [dbo].[PrimaryKey] NULL,
  [TypeName] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [TypeId] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[User] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'流水号',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户登录帐号',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'Account'
GO

EXEC sp_addextendedproperty
'MS_Description', N'密码',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'Password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户姓名',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'性别',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'Sex'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户状态',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'业务对照码',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'BizCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'经办时间',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'CreateId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'TypeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'User',
'COLUMN', N'TypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户基本信息表',
'SCHEMA', N'dbo',
'TABLE', N'User'
GO


-- ----------------------------
-- Records of [User]
-- ----------------------------
INSERT INTO [dbo].[User]  VALUES (N'0ceff0f8-f848-440c-bc26-d8605ac858cd', N'test5', N'test5', N'test5', N'1', N'1', N'', N'2018-03-15 09:19:05.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'test4', N'test4', N'test4', N'1', N'1', N'', N'2017-12-12 14:07:11.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'229f3a49-ab27-49ce-b383-9f10ca23a9d5', N'test3', N'test3', N'test3', N'1', N'1', N'', N'2017-12-12 14:07:05.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'admin', N'admin', N'1', N'0', N'', N'2017-12-11 16:18:54.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'test', N'test', N'1', N'0', N'', N'2017-12-11 16:19:00.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'de8be521-f1ec-4483-b124-0be342890507', N'test2', N'test2', N'test2', N'1', N'0', N'', N'2017-12-11 16:19:06.000', N'', N'', N'')
GO


-- ----------------------------
-- Table structure for WmsCustomerMst
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsCustomerMst]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsCustomerMst]
GO

CREATE TABLE [dbo].[WmsCustomerMst] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Name] varchar(100) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SName] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Telephone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Fax] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Email] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [Address] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [ContactPhone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ContactUser] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CustType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Shipper] varchar(64) COLLATE Chinese_PRC_CI_AS NULL,
  [TransferType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [DeliverArea] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [DeliverRoute] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [DeliverId] decimal(32) NULL,
  [DeliveAddr] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [CUSTLOCATION] varchar(2) COLLATE Chinese_PRC_CI_AS NULL,
  [IsFactory] tinyint NOT NULL,
  [DeliverRemark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [IsOwner] tinyint NOT NULL,
  [IsPurchaser] tinyint NOT NULL,
  [CustProperty] tinyint NOT NULL,
  [CustCorrCode] varchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [ShippingAddress] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [IsColdDeliver] tinyint NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsCustomerMst] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公司全称',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公司简称',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'SName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'Telephone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'传真号',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'Fax'
GO

EXEC sp_addextendedproperty
'MS_Description', N'电子邮件',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'Email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'详细地址',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'Address'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系人电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'ContactPhone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系人',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'ContactUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户类型(SYS_CUSTOMERTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'CustType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'Shipper'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运方式(SYS_TRANCFERTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'TransferType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送区域',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'DeliverArea'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送路线',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'DeliverRoute'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送序号',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'DeliverId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送地址',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'DeliveAddr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户范围',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'CUSTLOCATION'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否厂家',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'IsFactory'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'DeliverRemark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'IsOwner'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否供应商',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'IsPurchaser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户性质区分',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'CustProperty'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户对应码',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'CustCorrCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'证照地址',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'ShippingAddress'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否冷链配送(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'IsColdDeliver'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户主表',
'SCHEMA', N'dbo',
'TABLE', N'WmsCustomerMst'
GO


-- ----------------------------
-- Table structure for WmsDeliverTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsDeliverTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsDeliverTbl]
GO

CREATE TABLE [dbo].[WmsDeliverTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OutBoundOrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [DeliverAreaId] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [DeliverRouteId] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [DeliverSortId] decimal(32) NULL,
  [DelvierRemark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [RequestArrivalDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [DeliverAddr] varchar(520) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Contactor] varchar(40) COLLATE Chinese_PRC_CI_AS NULL,
  [ContactPhone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ShipperContactor] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [ShipType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ShipperPhone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ShipperId] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [CustomerFax] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ShipperFax] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CustPickFlg] tinyint NOT NULL,
  [LicenseAddr] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsDeliverTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据Id',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'OutBoundOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送区域',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'DeliverAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送支线',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'DeliverRouteId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送序号',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'DeliverSortId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'DelvierRemark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'要求到货日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'RequestArrivalDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送地址',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'DeliverAddr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户联系人',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'Contactor'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户联系电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'ContactPhone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人联系人',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'ShipperContactor'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运方式',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'ShipType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人联系电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'ShipperPhone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'ShipperId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户传真',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'CustomerFax'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人传真',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'ShipperFax'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自提标识',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'CustPickFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'证照地址',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'LicenseAddr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配送信息表',
'SCHEMA', N'dbo',
'TABLE', N'WmsDeliverTbl'
GO


-- ----------------------------
-- Table structure for WmsGoodsAreaMst
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsGoodsAreaMst]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsGoodsAreaMst]
GO

CREATE TABLE [dbo].[WmsGoodsAreaMst] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaType] varchar(2) COLLATE Chinese_PRC_CI_AS NULL,
  [Name] varchar(64) COLLATE Chinese_PRC_CI_AS NULL,
  [SName] varchar(40) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [QualityFlg] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [GoodsTopCategory] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [GoodsCategory] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UnitAttri] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ContainerType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [AllowedQty] decimal(18,2) NULL,
  [AllowedQtyFlg] decimal(8) NULL,
  [AreaNo] decimal(32) NOT NULL,
  [StagingType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [SorterNo] varchar(2) COLLATE Chinese_PRC_CI_AS NULL,
  [LotMixtureFlg] tinyint NOT NULL,
  [Enable] tinyint NOT NULL,
  [NumFlg] tinyint NOT NULL,
  [ManagerId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [OperMode] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [BlockId] varchar(3) COLLATE Chinese_PRC_CI_AS NULL,
  [OwnerId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerMixtureFlg] tinyint NOT NULL,
  [TempTypeId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [PutAwayType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [BusinessType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ShareFlg] tinyint NOT NULL,
  [PickType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [TransferType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CustType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [GoodsReceType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsGoodsAreaMst] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区类型',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'GoodsAreaType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区名称',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区简称',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'SName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质区分(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品类别(SYS_GOODSTOPCATEGORY)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'GoodsTopCategory'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转类型(SYS_GOODSCATEGORY)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'GoodsCategory'
GO

EXEC sp_addextendedproperty
'MS_Description', N'整零区分(SYS_UNITATTRI)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'UnitAttri'
GO

EXEC sp_addextendedproperty
'MS_Description', N'保管类型(SYS_CONTAINERTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'ContainerType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'每个货位允许存放的最大货容',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'AllowedQty'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否启用货容标识(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'AllowedQtyFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选序号',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'AreaNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'集货类型(SYS_STAGINGTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'StagingType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'SORTER编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'SorterNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许混批',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'LotMixtureFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量启用标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'NumFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'ManagerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选方式(SYS_OPERMODE整品箱、零品箱、清单)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'OperMode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'作业区号',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'BlockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否允许混货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'OwnerMixtureFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'温控条件(SYS_TEMPTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'TempTypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架类型(SYS_GOODSAREAPUTAWAYTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'PutAwayType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'业务区分(SYS_REGIONBUSTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'BusinessType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'共享标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'ShareFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区拣选类型',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'PickType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运方式(SYS_TRANCFERTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'TransferType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户类型(SYS_CUSTOMERTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'CustType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货方式(SYS_FULLBOXINTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'GoodsReceType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区主表',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsAreaMst'
GO


-- ----------------------------
-- Table structure for WmsGoodsBatchMst
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsGoodsBatchMst]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsGoodsBatchMst]
GO

CREATE TABLE [dbo].[WmsGoodsBatchMst] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ProductDate] varchar(25) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ExpireDate] varchar(25) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Length] decimal(18,2) NULL,
  [Width] decimal(18,2) NULL,
  [Height] decimal(18,2) NULL,
  [BigNetWeight] decimal(18,4) NULL,
  [BigUnitCap] decimal(18,4) NULL,
  [BigPerNum] decimal(18,2) NULL,
  [MidUnitNetWeight] decimal(18,4) NULL,
  [MidUnitCap] decimal(18,4) NULL,
  [MidPerNum] decimal(18,2) NULL,
  [StandNetWeight] decimal(18,4) NULL,
  [StandCap] decimal(18,4) NULL,
  [FirstTime] datetime2(7) NULL,
  [Certificate] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [AvaType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [WidthCode] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [HeightCode] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ProdSite] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [StandLength] decimal(18,2) NULL,
  [StandWidth] decimal(18,2) NULL,
  [StandHeight] decimal(18,2) NULL,
  [RecType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsGoodsBatchMst] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'批号序列号',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品SKU',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生产日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'ProductDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'失效日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'ExpireDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'长,去掉了商品主表的长宽高，新增批号时默认的长宽高取批号主表里面的',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'Length'
GO

EXEC sp_addextendedproperty
'MS_Description', N'宽',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'Width'
GO

EXEC sp_addextendedproperty
'MS_Description', N'高',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'Height'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大包装重量',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'BigNetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大包装体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'BigUnitCap'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大包装数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'BigPerNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中包装重量',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'MidUnitNetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中包装体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'MidUnitCap'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中包装数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'MidPerNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准包装重量',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'StandNetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准包装体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'StandCap'
GO

EXEC sp_addextendedproperty
'MS_Description', N'首次入库时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'FirstTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'注册证',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'Certificate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'效期类别(SYS_EXPIREDFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'AvaType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品宽度代码(SYS_WIDTHCODE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'WidthCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品高度代码(SYS_HEIGHTCODE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'HeightCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产地',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'ProdSite'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位长',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'StandLength'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位宽',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'StandWidth'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位高',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'StandHeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货方式(SYS_RECETYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'RecType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批号主表',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsBatchMst'
GO


-- ----------------------------
-- Table structure for WmsGoodsMst
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsGoodsMst]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsGoodsMst]
GO

CREATE TABLE [dbo].[WmsGoodsMst] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsTypeId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [SpellCode] varchar(300) COLLATE Chinese_PRC_CI_AS NULL,
  [Name] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [TradeMark] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [Model] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [LicenseNumber] varchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [BatchFlg] tinyint NOT NULL,
  [HoldDays] decimal(16) NULL,
  [PrintFlg] tinyint NOT NULL,
  [SkuBarCode] varchar(40) COLLATE Chinese_PRC_CI_AS NULL,
  [StyleId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [ProdArea] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [ChemicalName] varchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [SName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [EnglishName] varchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [BigUnit] varchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [BigPerNum] decimal(18,2) NOT NULL,
  [MidUnit] varchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [MidPerNum] decimal(18,2) NOT NULL,
  [StandUnit] varchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [IsBig] tinyint NOT NULL,
  [IsMid] tinyint NOT NULL,
  [IsStand] tinyint NOT NULL,
  [StandGrossWeight] decimal(18,4) NULL,
  [StandNetWeight] decimal(18,4) NULL,
  [StandCap] decimal(18,4) NULL,
  [StaticStock] decimal(18,2) NULL,
  [SafeStock] decimal(18,2) NULL,
  [UpperStock] decimal(18,2) NULL,
  [DownStock] decimal(18,2) NULL,
  [PriceType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ListPrice] decimal(18,2) NULL,
  [RetailPrice] decimal(18,2) NULL,
  [BuyPrice] decimal(18,2) NULL,
  [CustPrice] decimal(18,2) NULL,
  [StockPrice] decimal(18,2) NULL,
  [SalePrice] decimal(18,2) NULL,
  [HoldDayType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [DockLayer] decimal(18,2) NULL,
  [DockQty] decimal(18,2) NULL,
  [DockSum] decimal(18,2) NULL,
  [Enable] tinyint NOT NULL,
  [AttriStockArea] char(1) COLLATE Chinese_PRC_CI_AS NULL,
  [TempTypeId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [IsBigUnit] tinyint NOT NULL,
  [TransType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [TaxRate] decimal(10,4) NULL,
  [FullMark] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [Width] decimal(18,2) NULL,
  [Length] decimal(18,2) NULL,
  [Height] decimal(18,2) NULL,
  [InboxFlg] tinyint NOT NULL,
  [InCacheFlg] tinyint NOT NULL,
  [BusinessScope] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [IsSkuBarCode] tinyint NOT NULL,
  [ImportFlg] tinyint NOT NULL,
  [TemperatureArea] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [TopTemp] decimal(5,1) NULL,
  [LowerTemp] decimal(5,1) NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsGoodsMst] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品SKU',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品分类',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'GoodsTypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拼音码',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'SpellCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品名称',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'厂牌',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'TradeMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'规格',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'Model'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批准文号',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'LicenseNumber'
GO

EXEC sp_addextendedproperty
'MS_Description', N'同批标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'BatchFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'保质天数',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'HoldDays'
GO

EXEC sp_addextendedproperty
'MS_Description', N'打印标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'PrintFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'条形码',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'SkuBarCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'外形特征',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'StyleId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'原产地',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'ProdArea'
GO

EXEC sp_addextendedproperty
'MS_Description', N'化学名',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'ChemicalName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品简称',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'SName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品英文名',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'EnglishName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大包装单位',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'BigUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大包装数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'BigPerNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中包装单位',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'MidUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中包装数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'MidPerNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准包装单位',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'StandUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位启用',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'IsBig'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位启用',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'IsMid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位启用',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'IsStand'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位净重(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'StandGrossWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位净重',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'StandNetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'StandCap'
GO

EXEC sp_addextendedproperty
'MS_Description', N'固定补足点',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'StaticStock'
GO

EXEC sp_addextendedproperty
'MS_Description', N'安全库存',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'SafeStock'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最高库存',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'UpperStock'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最低库存',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'DownStock'
GO

EXEC sp_addextendedproperty
'MS_Description', N'价格类型',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'PriceType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'国家牌价',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'ListPrice'
GO

EXEC sp_addextendedproperty
'MS_Description', N'零售价',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'RetailPrice'
GO

EXEC sp_addextendedproperty
'MS_Description', N'买入价',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'BuyPrice'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批发价',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'CustPrice'
GO

EXEC sp_addextendedproperty
'MS_Description', N'寄托价',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'StockPrice'
GO

EXEC sp_addextendedproperty
'MS_Description', N'销售价',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'SalePrice'
GO

EXEC sp_addextendedproperty
'MS_Description', N'保质天数方式',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'HoldDayType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'码垛层数',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'DockLayer'
GO

EXEC sp_addextendedproperty
'MS_Description', N'码垛箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'DockQty'
GO

EXEC sp_addextendedproperty
'MS_Description', N'码垛总箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'DockSum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'区域储备类型',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'AttriStockArea'
GO

EXEC sp_addextendedproperty
'MS_Description', N'保管温度条件(SYS_TEMPTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'TempTypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否大单位核算',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'IsBigUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'运输类型(SYS_TRANSTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'TransType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'税率(单据里面下传税率)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'TaxRate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'厂牌全称',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'FullMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'宽',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'Width'
GO

EXEC sp_addextendedproperty
'MS_Description', N'长',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'Length'
GO

EXEC sp_addextendedproperty
'MS_Description', N'高',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'Height'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否进箱式立体库',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'InboxFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否进缓存',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'InCacheFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'经营范围(SYS_JYFW)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'BusinessScope'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否有条形码',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'IsSkuBarCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'进口标识',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'ImportFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'温度区间(SYS_TEMPERATURE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'TemperatureArea'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最高温度',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'TopTemp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最低温度',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'LowerTemp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品主表',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsMst'
GO


-- ----------------------------
-- Table structure for WmsGoodsPosMst
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsGoodsPosMst]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsGoodsPosMst]
GO

CREATE TABLE [dbo].[WmsGoodsPosMst] (
  [GoodsPosId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Name] varchar(64) COLLATE Chinese_PRC_CI_AS NULL,
  [SName] varchar(40) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BarCode] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [PosLayer] decimal(18,2) NULL,
  [PosRow] decimal(18,2) NULL,
  [Length] decimal(18,2) NULL,
  [Width] decimal(18,2) NULL,
  [Height] decimal(18,2) NULL,
  [Weight] decimal(18,4) NULL,
  [Volumn] decimal(18,4) NULL,
  [UsedVolumn] decimal(18,4) NULL,
  [ContainNum] decimal(18,4) NULL,
  [InRoad] decimal(32) NULL,
  [OutRoad] decimal(32) NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [UsedFlg] decimal(8) NULL,
  [LotMixtureFlg] decimal(8) NULL,
  [Enable] tinyint NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SubBayNo] decimal(3) NOT NULL,
  [WidthCode] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [HeightCode] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [PutAwayRestricted] tinyint NOT NULL,
  [RetrievalRestricted] tinyint NOT NULL,
  [SubBayRestricted] tinyint NOT NULL,
  [Empty] tinyint NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsGoodsPosMst] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'GoodsPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'GoodsAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位名称',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位简称',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'SName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'条形码',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'BarCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'层',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'PosLayer'
GO

EXEC sp_addextendedproperty
'MS_Description', N'列',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'PosRow'
GO

EXEC sp_addextendedproperty
'MS_Description', N'长',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Length'
GO

EXEC sp_addextendedproperty
'MS_Description', N'宽',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Width'
GO

EXEC sp_addextendedproperty
'MS_Description', N'高',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Height'
GO

EXEC sp_addextendedproperty
'MS_Description', N'可存放重量',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Weight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'可存放体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Volumn'
GO

EXEC sp_addextendedproperty
'MS_Description', N'使用体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'UsedVolumn'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许托盘数',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'ContainNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'进货线路',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'InRoad'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出货线路',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'OutRoad'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'占用标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'UsedFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许混批',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'LotMixtureFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'子货位号',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'SubBayNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货架宽度代码(SYS_WIDTHCODE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'WidthCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货架高度代码(SYS_HEIGHTCODE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'HeightCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库禁用(0:未禁用,1:禁用)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'PutAwayRestricted'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库禁用(0:未禁用,1:禁用)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'RetrievalRestricted'
GO

EXEC sp_addextendedproperty
'MS_Description', N'子货位禁用(0:未禁用,1:禁用)',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'SubBayRestricted'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否空货位',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'Empty'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位主表',
'SCHEMA', N'dbo',
'TABLE', N'WmsGoodsPosMst'
GO


-- ----------------------------
-- Table structure for WmsInboundArrivalDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsInboundArrivalDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsInboundArrivalDtbl]
GO

CREATE TABLE [dbo].[WmsInboundArrivalDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [AsnNo] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InboundOrderId] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [GoodsBatch] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InboundOrderDtId] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsId] varchar(40) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CustGoodsId] varchar(40) COLLATE Chinese_PRC_CI_AS NULL,
  [Volume] decimal(18,4) NULL,
  [NetWeight] decimal(18,4) NULL,
  [GrossWeight] decimal(18,4) NULL,
  [BigUnitNum] decimal(18,2) NOT NULL,
  [MidUnitNum] decimal(18,2) NOT NULL,
  [StandUnitNum] decimal(18,2) NOT NULL,
  [ArrivalNum] decimal(18,2) NOT NULL,
  [InBigUnitNum] decimal(18,2) NOT NULL,
  [InMidUnitNum] decimal(18,2) NOT NULL,
  [InStandUnitNum] decimal(18,2) NOT NULL,
  [InNum] decimal(18,2) NOT NULL,
  [PickNum] decimal(18,2) NOT NULL,
  [PurchaseNo] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [StockId] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsInboundArrivalDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货通知单明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'AsnNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'InboundOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'InboundOrderDtId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'CustGoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'Volume'
GO

EXEC sp_addextendedproperty
'MS_Description', N'净重',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'NetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'毛重',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'GrossWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际入库数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'ArrivalNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已入大单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'InBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已入中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'InMidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已入标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'InStandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已入数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'InNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已上架数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'PickNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'PurchaseNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主编号(固定值CQM)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货通知单明细',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalDtbl'
GO


-- ----------------------------
-- Table structure for WmsInboundArrivalTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsInboundArrivalTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsInboundArrivalTbl]
GO

CREATE TABLE [dbo].[WmsInboundArrivalTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [AsnStatus] int NOT NULL,
  [InstockType] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ShipperId] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [SupplierId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [OwnerId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [ScheduledDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [ActualDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [Enable] tinyint NOT NULL,
  [IsBatch] tinyint NULL,
  [Treator] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [BlindReason] varchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [ReportNum] int NULL,
  [NoReportRemark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsInboundArrivalTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货通知单状态(SYS_ASNSTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'AsnStatus'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库类型(SYS_INSTCTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'InstockType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'ShipperId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'供应商编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'SupplierId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预定入库日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'ScheduledDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际入库日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'ActualDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否整批处理',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'IsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'经办人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'Treator'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盲收原因',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'BlindReason'
GO

EXEC sp_addextendedproperty
'MS_Description', N'送货清单数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'ReportNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缺送货清单原因',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'NoReportRemark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货通知单',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundArrivalTbl'
GO


-- ----------------------------
-- Table structure for WmsInboundOrderDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsInboundOrderDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsInboundOrderDtbl]
GO

CREATE TABLE [dbo].[WmsInboundOrderDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Price] decimal(18,6) NULL,
  [PriceNoTax] decimal(18,6) NULL,
  [InStockStatus] tinyint NOT NULL,
  [AsnStatus] int NOT NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderNum] decimal(18,2) NOT NULL,
  [InNum] decimal(18,2) NOT NULL,
  [LeaveNum] decimal(18,2) NOT NULL,
  [HoldNum] decimal(18,2) NOT NULL,
  [ProdDate] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [ExpireDate] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [TaxRate] decimal(10,2) NULL,
  [OwnerId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsInboundOrderDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'OrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'含税单价',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'Price'
GO

EXEC sp_addextendedproperty
'MS_Description', N'无税单价',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'PriceNoTax'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否收货中(0:非收货中,1:收货中)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'InStockStatus'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货状况(SYS_GOODSARRIVESTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'AsnStatus'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'通知数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'OrderNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'InNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'剩余数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'LeaveNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'占用数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'HoldNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生产日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'ProdDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'失效日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'ExpireDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'税率',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'TaxRate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单明细',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderDtbl'
GO


-- ----------------------------
-- Table structure for WmsInboundOrderTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsInboundOrderTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsInboundOrderTbl]
GO

CREATE TABLE [dbo].[WmsInboundOrderTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ExternalNo] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ExternalType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Status] int NOT NULL,
  [OrderType] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [PurchaseNo] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [StockId] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ShipperId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [SupplierId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ScheduledInboundTime] datetime2(7) NULL,
  [Remark] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [Enable] tinyint NOT NULL,
  [TransferType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [InBondedArea] tinyint NOT NULL,
  [ReturnBoxNum] decimal(8) NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsInboundOrderTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'相关单据号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'ExternalNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'相关单据类型',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'ExternalType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单状态(SYS_INSTCINFORMSTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库类型(SYS_INSTCTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'OrderType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品类别',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'GoodsType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'PurchaseNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主编号(固定值CQM)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'ShipperId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'供应商编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'SupplierId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预定入库时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'ScheduledInboundTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运方式',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'TransferType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否入保税库(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'InBondedArea'
GO

EXEC sp_addextendedproperty
'MS_Description', N'销退箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'ReturnBoxNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单（入库订单）',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl'
GO


-- ----------------------------
-- Table structure for WmsInstockPickDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsInstockPickDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsInstockPickDtbl]
GO

CREATE TABLE [dbo].[WmsInstockPickDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InstockPickId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InstockRecvId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InstockRecvDtId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BigUnitNum] decimal(18,2) NOT NULL,
  [MidUnitNum] decimal(18,2) NOT NULL,
  [StandUnitNum] decimal(18,2) NOT NULL,
  [Num] decimal(18,2) NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [PurchaseNo] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [QualityReasonCode] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ContainerType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ContainerId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsPosId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PickUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [PickBeginTime] datetime2(7) NULL,
  [PickEndTime] datetime2(7) NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [IsAllowOut] tinyint NULL,
  [SortId] decimal(32) NULL,
  [Volume] decimal(18,4) NULL,
  [Weight] decimal(18,4) NULL,
  [InStockDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsInstockPickDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架单明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'InstockPickId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'InstockRecvId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货单明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'InstockRecvDtId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架任务状态(SYS_INSTOCKPICKSTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'PurchaseNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质原因代码(SYS_QUALITYREASON)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'QualityReasonCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'容器类别(SYS_PIKCRELATYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'ContainerType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'容器编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'ContainerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'GoodsAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'GoodsPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'PickUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架开始时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'PickBeginTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架结束时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'PickEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许出库标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'IsAllowOut'
GO

EXEC sp_addextendedproperty
'MS_Description', N'顺序号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'SortId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'Volume'
GO

EXEC sp_addextendedproperty
'MS_Description', N'重量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'Weight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'InStockDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架任务明细',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickDtbl'
GO


-- ----------------------------
-- Table structure for WmsInstockPickTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsInstockPickTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsInstockPickTbl]
GO

CREATE TABLE [dbo].[WmsInstockPickTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [Enable] tinyint NOT NULL,
  [PickStatus] int NOT NULL,
  [PickDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [Operator] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [PutawayType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [InstockType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsInstockPickTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'确认人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'ConfirmUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'确认时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'ConfirmTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架单状态(SYS_INSTOCKPICKSTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'PickStatus'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'PickDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架操作员',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'Operator'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架类型(SYS_GOODSAREAPUTAWAYTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'PutawayType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库类型(SYS_INSTCTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'InstockType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上架任务',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockPickTbl'
GO


-- ----------------------------
-- Table structure for WmsInstockRecDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsInstockRecDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsInstockRecDtbl]
GO

CREATE TABLE [dbo].[WmsInstockRecDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InstockRecvId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InboundOrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [InboundOrderDtId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PurchaseId] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [OwnerId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Volume] decimal(18,4) NULL,
  [NetWeight] decimal(18,4) NULL,
  [BigUnitNum] decimal(18,2) NOT NULL,
  [MidUnitNum] decimal(18,2) NOT NULL,
  [StandUnitNum] decimal(18,2) NOT NULL,
  [ApplyNum] decimal(18,2) NOT NULL,
  [InBigUnitNum] decimal(18,2) NOT NULL,
  [InMidUnitNum] decimal(18,2) NOT NULL,
  [InStandUnitNum] decimal(18,2) NOT NULL,
  [InNum] decimal(18,2) NOT NULL,
  [PickNum] decimal(18,2) NOT NULL,
  [GrossWeight] decimal(18,4) NULL,
  [ContainerNo] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [UnusualFlg] tinyint NULL,
  [CheckBigUnitNum] decimal(18,2) NULL,
  [CheckStandUnitNum] decimal(18,2) NULL,
  [RecvUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [RecvDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [Checkuser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [LastInNum] decimal(18,2) NULL,
  [NoReportRemark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsInstockRecDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货单明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'InstockRecvId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'InboundOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'InboundOrderDtId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'PurchaseId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'Volume'
GO

EXEC sp_addextendedproperty
'MS_Description', N'净重',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'NetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'申请数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'ApplyNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已入大单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'InBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已入中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'InMidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已入标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'InStandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已入库数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'InNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已上架数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'PickNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'毛重',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'GrossWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'容器编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'ContainerNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'异常标识',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'UnusualFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'抽样件数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'CheckBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'抽样个数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'CheckStandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'RecvUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'RecvDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'验收人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'Checkuser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'验收日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'CheckDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上次入库数',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'LastInNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缺送货清单原因',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'NoReportRemark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货单明细',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecDtbl'
GO


-- ----------------------------
-- Table structure for WmsInstockRecTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsInstockRecTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsInstockRecTbl]
GO

CREATE TABLE [dbo].[WmsInstockRecTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [AsnNo] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [InstockType] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ShipperId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [SupplierId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ScheduledDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [ActualDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [PlatformNo] nvarchar(3) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [Enable] tinyint NOT NULL,
  [IsBatch] tinyint NOT NULL,
  [Treator] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [InvoiceNo] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [AsnDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsInstockRecTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'AsnNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货单状态(SYS_INSTOCKTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库类型(SYS_INSTCTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'InstockType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'ShipperId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'供应商',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'SupplierId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预定入库日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'ScheduledDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际入库日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'ActualDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'月台号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'PlatformNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否整批处理',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'IsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'经办人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'Treator'
GO

EXEC sp_addextendedproperty
'MS_Description', N'发票号',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'InvoiceNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'AsnDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收货单',
'SCHEMA', N'dbo',
'TABLE', N'WmsInstockRecTbl'
GO


-- ----------------------------
-- Table structure for WmsLoadingDocDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsLoadingDocDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsLoadingDocDtbl]
GO

CREATE TABLE [dbo].[WmsLoadingDocDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [LoadingDocId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderDetailId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [LoadBigUnitNum] decimal(18,2) NOT NULL,
  [LoadMidUnitNum] decimal(18,2) NOT NULL,
  [LoadStandUnitNum] decimal(18,2) NOT NULL,
  [LoadNum] decimal(18,2) NOT NULL,
  [ArriveBigUnitNum] decimal(18,2) NOT NULL,
  [ArriveMidUnitNum] decimal(18,2) NOT NULL,
  [ArriveStandUnitNum] decimal(18,2) NOT NULL,
  [ArriveNum] decimal(18,2) NOT NULL,
  [Status] int NOT NULL,
  [SendDocId] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [BackNum] decimal(18,2) NULL,
  [BackReason] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [BackFlg] tinyint NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(600) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsLoadingDocDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车单明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'LoadingDocId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库指示单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'OrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库指示明细号码',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'OrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车大单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'LoadBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'LoadMidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'LoadStandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'LoadNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货大单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'ArriveBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'ArriveMidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'ArriveStandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'ArriveNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货状态',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'发货单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'SendDocId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'退回数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'BackNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'退回原因',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'BackReason'
GO

EXEC sp_addextendedproperty
'MS_Description', N'退回标示',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'BackFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注，拒收照片',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车单明细表',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocDtbl'
GO


-- ----------------------------
-- Table structure for WmsLoadingDocTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsLoadingDocTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsLoadingDocTbl]
GO

CREATE TABLE [dbo].[WmsLoadingDocTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [LoadingNoticeId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [VehicleLicense] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [DriverName] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [Telphone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ShipperId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [TransportationMode] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SendUser] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [TotalItemCaseQty] decimal(18,2) NOT NULL,
  [UnloadingPointNumber] decimal(18,2) NOT NULL,
  [Route] varchar(256) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Miles] decimal(18,2) NULL,
  [TransferPoint] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [PlatformId] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [BillNos] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [LoadingConfirmUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [LoadingConfirmTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [ShippingConfirmUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [ShippingConfirmTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [ActionFlg] tinyint NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [StockId] varchar(4) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsLoadingDocTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车单状态(SYS_LOADINGDOC_STATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车指示单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'LoadingNoticeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车牌号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'VehicleLicense'
GO

EXEC sp_addextendedproperty
'MS_Description', N'司机名',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'DriverName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'Telphone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'ShipperId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运方式',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'TransportationMode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'送货员',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'SendUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'总计箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'TotalItemCaseQty'
GO

EXEC sp_addextendedproperty
'MS_Description', N'卸货点数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'UnloadingPointNumber'
GO

EXEC sp_addextendedproperty
'MS_Description', N'起止路线',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'Route'
GO

EXEC sp_addextendedproperty
'MS_Description', N'行驶里程',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'Miles'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中转单位',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'TransferPoint'
GO

EXEC sp_addextendedproperty
'MS_Description', N'月台',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'PlatformId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'随车单据',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'BillNos'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装货完毕确认人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'LoadingConfirmUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装货完毕时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'LoadingConfirmTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'发货确认人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'ShippingConfirmUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'发货时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'ShippingConfirmTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标识',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'ActionFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车单表',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingDocTbl'
GO


-- ----------------------------
-- Table structure for WmsLoadingNoticeDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsLoadingNoticeDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsLoadingNoticeDtbl]
GO

CREATE TABLE [dbo].[WmsLoadingNoticeDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [LoadingNoticeId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [LoadingTurnNum] decimal(18,2) NOT NULL,
  [LoadingCoopNum] decimal(18,2) NOT NULL,
  [LoadingSalverNum] decimal(18,2) NOT NULL,
  [LoadingBigUnitNum] decimal(18,2) NOT NULL,
  [LoadingTolBigUnitNum] decimal(18,2) NOT NULL,
  [UnionNum] decimal(18,2) NULL,
  [MultiCustUnionNum] decimal(18,2) NULL,
  [TotalItemWeightPlan] decimal(18,4) NULL,
  [TotalItemVolumPlan] decimal(18,4) NULL
)
GO

ALTER TABLE [dbo].[WmsLoadingNoticeDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车指示号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'LoadingNoticeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'OrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车周转箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'LoadingTurnNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车笼车数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'LoadingCoopNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车托盘数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'LoadingSalverNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'LoadingBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车总箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'LoadingTolBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拼箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'UnionNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'多客户拼箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'MultiCustUnionNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车重量',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'TotalItemWeightPlan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl',
'COLUMN', N'TotalItemVolumPlan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配载单、预装车单明细表
',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeDtbl'
GO


-- ----------------------------
-- Table structure for WmsLoadingNoticeTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsLoadingNoticeTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsLoadingNoticeTbl]
GO

CREATE TABLE [dbo].[WmsLoadingNoticeTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ShipperId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PlatformId] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [PermittedTonnage] decimal(18,4) NULL,
  [PermittedCap] decimal(18,4) NULL,
  [PermittedContainVechile] decimal(18,2) NULL,
  [PermittedPallet] decimal(18,2) NULL,
  [UnloadingPointNumber] decimal(18,2) NOT NULL,
  [TotalItemWeightPlan] decimal(18,4) NOT NULL,
  [TotalItemVolumPlan] decimal(18,4) NOT NULL,
  [TotalUnitNum] decimal(18,2) NULL,
  [TransformType] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [VehicleLicense] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [CustGroup] varchar(1280) COLLATE Chinese_PRC_CI_AS NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [VechileType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [VechileFee] tinyint NOT NULL,
  [OutCacheUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [OutCacheTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsLoadingNoticeTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车指示号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车状态(SYS_LOADINGNOTICE_STATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'ShipperId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'月台号',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'PlatformId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车辆准载吨位',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'PermittedTonnage'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车辆准载体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'PermittedCap'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车辆准载笼车',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'PermittedContainVechile'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车辆准载托盘',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'PermittedPallet'
GO

EXEC sp_addextendedproperty
'MS_Description', N'卸货点数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'UnloadingPointNumber'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车重量',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'TotalItemWeightPlan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'TotalItemVolumPlan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预装车箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'TotalUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运方式',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'TransformType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车牌',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'VehicleLicense'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户组',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'CustGroup'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车辆类型(SYS_VECHILETYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'VechileType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'特殊收费 ',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'VechileFee'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缓存出库人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'OutCacheUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缓存出库时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'OutCacheTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'配载单、预装车单表',
'SCHEMA', N'dbo',
'TABLE', N'WmsLoadingNoticeTbl'
GO


-- ----------------------------
-- Table structure for WmsMoveTaskDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsMoveTaskDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsMoveTaskDtbl]
GO

CREATE TABLE [dbo].[WmsMoveTaskDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [MoveTaskId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsPosId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PurchaseNo] varchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InBatchCode] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [IsAllowOut] tinyint NOT NULL,
  [BillId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BigUnitNum] decimal(18,2) NOT NULL,
  [MidUnitNum] decimal(18,2) NOT NULL,
  [StandUnitNum] decimal(18,2) NOT NULL,
  [Num] decimal(18,2) NOT NULL,
  [ActBigUnitNum] decimal(18,2) NOT NULL,
  [ActMidUnitNum] decimal(18,2) NOT NULL,
  [ActStandUnitNum] decimal(18,2) NOT NULL,
  [ActNum] decimal(18,2) NOT NULL,
  [Volume] decimal(18,4) NULL,
  [NetWeight] decimal(18,4) NULL,
  [GrossWeight] decimal(18,4) NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [Operator] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [OperateDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsMoveTaskDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'明细编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'MoveTaskId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移动仓库',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移动货区',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'GoodsAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移动货位',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'GoodsPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'PurchaseNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库批次',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'InBatchCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许出库标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'IsAllowOut'
GO

EXEC sp_addextendedproperty
'MS_Description', N'内部单据号(下架的任务号)',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'BillId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'ActBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际中单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'ActMidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际标准数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'ActStandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'ActNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'Volume'
GO

EXEC sp_addextendedproperty
'MS_Description', N'净重',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'NetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'毛重',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'GrossWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'说明',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'Operator'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'OperateDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移库任务明细',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskDtbl'
GO


-- ----------------------------
-- Table structure for WmsMoveTaskGroupTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsMoveTaskGroupTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsMoveTaskGroupTbl]
GO

CREATE TABLE [dbo].[WmsMoveTaskGroupTbl] (
  [MoveTaskGroupId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [TaskId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsMoveTaskGroupTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'移库单编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl',
'COLUMN', N'MoveTaskGroupId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移库任务编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl',
'COLUMN', N'TaskId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移库任务组',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskGroupTbl'
GO


-- ----------------------------
-- Table structure for WmsMoveTaskTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsMoveTaskTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsMoveTaskTbl]
GO

CREATE TABLE [dbo].[WmsMoveTaskTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [MoveIndicationId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [MoveIndicationDetailId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [MoveType] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [MoveReason] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [InOutType] tinyint NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsMoveTaskTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移库指示编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'MoveIndicationId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'明细编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'MoveIndicationDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移入仓库',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移库类型',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'MoveType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移动原因',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'MoveReason'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移入移出类型（1移入，2移出）',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'InOutType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移库任务',
'SCHEMA', N'dbo',
'TABLE', N'WmsMoveTaskTbl'
GO


-- ----------------------------
-- Table structure for WmsOutboundArrivalTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsOutboundArrivalTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsOutboundArrivalTbl]
GO

CREATE TABLE [dbo].[WmsOutboundArrivalTbl] (
  [LoadingDocId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OutBoundOrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SendDocId] varchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OutStockNum] decimal(18,2) NULL,
  [ArrivalNum] decimal(18,2) NULL,
  [ArrivalStatus] int NOT NULL,
  [ArrivalDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [SigUser] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [ArrivalRemark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmTime] datetime2(7) NULL
)
GO

ALTER TABLE [dbo].[WmsOutboundArrivalTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'LoadingDocId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库指示单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'OutBoundOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'发货单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'SendDocId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'OutStockNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'ArrivalNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货状态(SYS_ARRIVAL_STATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'ArrivalStatus'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'ArrivalDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'签收人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'SigUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'ArrivalRemark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货确认人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'ConfirmUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货确认时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl',
'COLUMN', N'ConfirmTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'到货信息表',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundArrivalTbl'
GO


-- ----------------------------
-- Table structure for WmsOutboundOrderDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsOutboundOrderDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsOutboundOrderDtbl]
GO

CREATE TABLE [dbo].[WmsOutboundOrderDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsId] varchar(40) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Price] decimal(18,6) NOT NULL,
  [PriceNoTax] decimal(18,6) NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BoxId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [BigUnitNum] decimal(18,2) NOT NULL,
  [MidUnitNum] decimal(18,2) NOT NULL,
  [StandUnitNum] decimal(18,2) NOT NULL,
  [Num] decimal(18,2) NOT NULL,
  [Amount] decimal(18,2) NOT NULL,
  [Volume] decimal(18,4) NULL,
  [NetWeight] decimal(18,4) NULL,
  [GrossWeight] decimal(18,4) NULL,
  [TaxRate] decimal(10,2) NULL
)
GO

ALTER TABLE [dbo].[WmsOutboundOrderDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'OrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'含税单价',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'Price'
GO

EXEC sp_addextendedproperty
'MS_Description', N'不含税单价',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'PriceNoTax'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'箱号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'BoxId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库金额',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'Amount'
GO

EXEC sp_addextendedproperty
'MS_Description', N'体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'Volume'
GO

EXEC sp_addextendedproperty
'MS_Description', N'净重',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'NetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'毛重',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'GrossWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'税率',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl',
'COLUMN', N'TaxRate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单明细表',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderDtbl'
GO


-- ----------------------------
-- Table structure for WmsOutboundOrderTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsOutboundOrderTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsOutboundOrderTbl]
GO

CREATE TABLE [dbo].[WmsOutboundOrderTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [StockId] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderNo] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [OutStockType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CustId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [IsUrgency] tinyint NOT NULL,
  [IsPayNeed] tinyint NOT NULL,
  [IsOrderMerged] tinyint NOT NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmDate] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [Treator] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [IsBatch] tinyint NOT NULL,
  [Enable] tinyint NOT NULL,
  [RequireDate] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [ErpAddressFlg] tinyint NOT NULL,
  [ExternalPoId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsOutboundOrderTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单状态(SYS_ORDERSTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'订单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'OrderNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库类型(SYS_OUTSTCTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'OutStockType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'CustId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'加急否(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'IsUrgency'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否需要收款(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'IsPayNeed'
GO

EXEC sp_addextendedproperty
'MS_Description', N'订单合并标识(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'IsOrderMerged'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'审核人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'ConfirmUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'审核时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'ConfirmDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'经办人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'Treator'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否整批处理(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'IsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'要求到货日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'RequireDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否指定地址(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'ErpAddressFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'三方相关单据号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'ExternalPoId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单表',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundOrderTbl'
GO


-- ----------------------------
-- Table structure for WmsOutboundPickTaskDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsOutboundPickTaskDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsOutboundPickTaskDtbl]
GO

CREATE TABLE [dbo].[WmsOutboundPickTaskDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PickTaskId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [OrderDetailId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Status] int NOT NULL,
  [GoodsId] varchar(40) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BigUnitNum] decimal(18,2) NOT NULL,
  [MidUnitNum] decimal(18,2) NOT NULL,
  [StandUnitNum] decimal(18,2) NOT NULL,
  [Num] decimal(18,2) NOT NULL,
  [ActBigUnitNum] decimal(18,2) NOT NULL,
  [ActMidUnitNum] decimal(18,2) NOT NULL,
  [ActStandUnitNum] decimal(18,2) NOT NULL,
  [ActNum] decimal(18,2) NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PickAreaId] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PickPosId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CheckFlg] tinyint NOT NULL,
  [CheckUser] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckNum] decimal(18,2) NULL,
  [CheckError] tinyint NOT NULL,
  [CheckErrorReason] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [BusinessType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [PickingUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [PickingStartTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [PickingEndTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [UnionNum] decimal(18,2) NULL,
  [MultiUnionNum] decimal(18,2) NULL,
  [BoxNum] decimal(18,2) NULL,
  [StagingNum] decimal(18,2) NULL,
  [PickingNum] decimal(18,2) NULL,
  [CheckEndTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [RepTaskFlg] tinyint NOT NULL,
  [BufferPosId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [OutLabelNo] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [TransferType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsOutboundPickTaskDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选任务支号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选任务号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'PickTaskId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'OrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库指示明细号码',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'OrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选任务状态(SYS_PICKSTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'ActBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际中单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'ActMidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际标准数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'ActStandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'ActNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选货区',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'PickAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选货位',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'PickPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'CheckFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'CheckUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'CheckNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核异常',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'CheckError'
GO

EXEC sp_addextendedproperty
'MS_Description', N'异常原因',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'CheckErrorReason'
GO

EXEC sp_addextendedproperty
'MS_Description', N'业务区分(SYS_REGIONBUSTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'BusinessType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'PickingUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选项开始时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'PickingStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选项结束时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'PickingEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拼箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'UnionNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'多客户拼箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'MultiUnionNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'零品箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'BoxNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'集货拼箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'StagingNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选人拣选数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'PickingNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核结束时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'CheckEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'补货标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'RepTaskFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缓存货位',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'BufferPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库标签号（打印号）',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'OutLabelNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运方式(SYS_TRANCFERTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl',
'COLUMN', N'TransferType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选任务明细表',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskDtbl'
GO


-- ----------------------------
-- Table structure for WmsOutboundPickTaskTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsOutboundPickTaskTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsOutboundPickTaskTbl]
GO

CREATE TABLE [dbo].[WmsOutboundPickTaskTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PickwaveId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [StagingZoneId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StagingLocationId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StagingUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [StagingTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [PickUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [PickTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [RELEASEGROUPID] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [RepTaskFlg] tinyint NOT NULL,
  [MultiCustJoinFlg] tinyint NOT NULL,
  [MultiCustJoinBoxNo] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckUser] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckStartTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckEndTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckFlg] tinyint NOT NULL,
  [BoxNum] decimal(18,2) NULL,
  [PackUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [PackTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [PackFlg] varchar(1) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OutlabelNo] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [BufferPosId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [LoadingDocId] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [StockId] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [OwnerId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [BufferFlg] tinyint NOT NULL,
  [LoadingUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [LoadingTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [Priority] decimal(8) NULL,
  [FillFlg] tinyint NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsOutboundPickTaskTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选任务号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分拣波次号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'PickwaveId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选状态(SYS_PICKSTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'集货区',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'StagingZoneId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'集货货位',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'StagingLocationId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'集货人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'StagingUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'集货时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'StagingTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'PickUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'PickTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'释放组号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'RELEASEGROUPID'
GO

EXEC sp_addextendedproperty
'MS_Description', N'补货标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'RepTaskFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'多客户拼箱标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'MultiCustJoinFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'多客户拼箱号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'MultiCustJoinBoxNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'CheckUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核开始时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'CheckStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核结束时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'CheckEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'复核标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'CheckFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'箱数',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'BoxNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'打包人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'PackUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'打包时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'PackTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'打包标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'PackFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库标签号(打印号)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'OutlabelNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缓存货位',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'BufferPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'LoadingDocId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否进缓存标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'BufferFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'LoadingUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装车时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'LoadingTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'优先级',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'Priority'
GO

EXEC sp_addextendedproperty
'MS_Description', N'补流程标记(0:否,1:是)',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'FillFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拣选任务表',
'SCHEMA', N'dbo',
'TABLE', N'WmsOutboundPickTaskTbl'
GO


-- ----------------------------
-- Table structure for WmsOwnerMst
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsOwnerMst]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsOwnerMst]
GO

CREATE TABLE [dbo].[WmsOwnerMst] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Name] varchar(100) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SName] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Telephone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Fax] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Email] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [Address] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [ContactPhone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ContactUser] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [TaxNum] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [BankNum] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [PrintOrder] tinyint NOT NULL,
  [ShowPrice] tinyint NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsOwnerMst] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公司全称',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公司简称',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'SName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'Telephone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'传真号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'Fax'
GO

EXEC sp_addextendedproperty
'MS_Description', N'电子邮件',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'Email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'详细地址',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'Address'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系人电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'ContactPhone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'ContactUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'税号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'TaxNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'银行账号',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'BankNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否打印随货通行单',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'PrintOrder'
GO

EXEC sp_addextendedproperty
'MS_Description', N'发货单是否显示价格',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'ShowPrice'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主主表',
'SCHEMA', N'dbo',
'TABLE', N'WmsOwnerMst'
GO


-- ----------------------------
-- Table structure for WmsPickwaveDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsPickwaveDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsPickwaveDtbl]
GO

CREATE TABLE [dbo].[WmsPickwaveDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PickwaveId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OrderId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StagingZoneId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateTime] datetime2(7) NULL
)
GO

ALTER TABLE [dbo].[WmsPickwaveDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'波次明细号',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'波次号',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveDtbl',
'COLUMN', N'PickwaveId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库通知单单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveDtbl',
'COLUMN', N'OrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'集货区',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveDtbl',
'COLUMN', N'StagingZoneId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库波次明细表(分拣波次明细表)',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveDtbl'
GO


-- ----------------------------
-- Table structure for WmsPickwaveTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsPickwaveTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsPickwaveTbl]
GO

CREATE TABLE [dbo].[WmsPickwaveTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [Harry] varchar(1) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ReleaseUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ReleaseUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [ReleaseTime] datetime2(7) NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsPickwaveTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'分拣波次号',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分拣波次状态(SYS_PICKWAVESTATUS)',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否加急',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'Harry'
GO

EXEC sp_addextendedproperty
'MS_Description', N'释放人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'ReleaseUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'释放人',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'ReleaseUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'释放时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'ReleaseTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分拣波次表',
'SCHEMA', N'dbo',
'TABLE', N'WmsPickwaveTbl'
GO


-- ----------------------------
-- Table structure for WmsShipperMst
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsShipperMst]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsShipperMst]
GO

CREATE TABLE [dbo].[WmsShipperMst] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [SpellCode] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [IsBarcodePrint] tinyint NOT NULL,
  [Enable] tinyint NOT NULL,
  [TransferType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Telephone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [Email] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [Addres] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [SName] varchar(40) COLLATE Chinese_PRC_CI_AS NULL,
  [Name] varchar(64) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ContactUser] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsShipperMst] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拼音码',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'SpellCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否打印条码标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'IsBarcodePrint'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运类型(SYS_TRANCFERTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'TransferType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'Telephone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'电子邮件',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'Email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'地址',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'Addres'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人简称',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'SName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人名称',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系人',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'ContactUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'承运人主表',
'SCHEMA', N'dbo',
'TABLE', N'WmsShipperMst'
GO


-- ----------------------------
-- Table structure for WmsStockAdjDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsStockAdjDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsStockAdjDtbl]
GO

CREATE TABLE [dbo].[WmsStockAdjDtbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [AdjId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsPosId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckTaskTime] decimal(18) NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BigUnitNum] decimal(18,2) NOT NULL,
  [MidUnitNum] decimal(18,2) NOT NULL,
  [StandUnitNum] decimal(18,2) NOT NULL,
  [Num] decimal(18,2) NOT NULL,
  [AdjReason] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [PurchaseNo] varchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [CheckStartTime] datetime2(7) NULL,
  [CheckEndTime] datetime2(7) NULL,
  [ProductTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [BoxId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [InBatchCode] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [AllowOut] tinyint NULL,
  [Price] decimal(18,2) NULL,
  [Amount] decimal(18,2) NULL,
  [Volume] decimal(18,4) NULL,
  [NetWeight] decimal(18,4) NULL,
  [GrossWeight] decimal(18,4) NULL,
  [BillId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsStockAdjDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'明细编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整单编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'AdjId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'GoodsAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'GoodsPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点次数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'CheckTaskTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整原因',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'AdjReason'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'PurchaseNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点任务状态',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点开始时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'CheckStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点结束时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'CheckEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生产日期(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'ProductTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'箱号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'BoxId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库批次(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'InBatchCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许出库标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'AllowOut'
GO

EXEC sp_addextendedproperty
'MS_Description', N'单价(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'Price'
GO

EXEC sp_addextendedproperty
'MS_Description', N'金额(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'Amount'
GO

EXEC sp_addextendedproperty
'MS_Description', N'体积(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'Volume'
GO

EXEC sp_addextendedproperty
'MS_Description', N'净重(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'NetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'毛重(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'GrossWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'相关单据号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'BillId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整单明细',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjDtbl'
GO


-- ----------------------------
-- Table structure for WmsStockAdjTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsStockAdjTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsStockAdjTbl]
GO

CREATE TABLE [dbo].[WmsStockAdjTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockCheckId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [AdjType] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [AdjReason] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [Status] int NOT NULL,
  [AdjUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [AdjUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [AdjTime] datetime2(7) NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmUser] datetime2(7) NULL,
  [ConfirmDate] datetime2(7) NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsStockAdjTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整单编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点指示编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'StockCheckId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整仓库',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整类型(SYS_ADJTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'AdjType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整原因(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'AdjReason'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'AdjUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'AdjUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'AdjTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'审核人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'ConfirmUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'审核人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'ConfirmUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'审核时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'ConfirmDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调整单',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockAdjTbl'
GO


-- ----------------------------
-- Table structure for WmsStockChangeLogTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsStockChangeLogTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsStockChangeLogTbl]
GO

CREATE TABLE [dbo].[WmsStockChangeLogTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsPosId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BoxId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ProductDate] varchar(25) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsTypeId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [PurchaseNo] varchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InbatchCode] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [IsAllowOut] tinyint NOT NULL,
  [OperateType] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [InFlg] tinyint NOT NULL,
  [BigUnitNum] decimal(18,2) NULL,
  [MidUnitNum] decimal(18,2) NULL,
  [StandUnitNum] decimal(18,2) NULL,
  [InAmount] decimal(18,2) NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL
)
GO

ALTER TABLE [dbo].[WmsStockChangeLogTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'GoodsAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'GoodsPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'托盘号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'BoxId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生产日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'ProductDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户商品大类',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'GoodsTypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'PurchaseNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库批次',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'InbatchCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许出库标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'IsAllowOut'
GO

EXEC sp_addextendedproperty
'MS_Description', N'交易类型(SYS_STOCKOPTION)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'OperateType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'进出标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'InFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'交易大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'交易中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'交易标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'交易金额',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'InAmount'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库存履历表',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockChangeLogTbl'
GO


-- ----------------------------
-- Table structure for WmsStockCheckDtbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsStockCheckDtbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsStockCheckDtbl]
GO

CREATE TABLE [dbo].[WmsStockCheckDtbl] (
  [Id] varchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockCheckId] varchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsPosId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckTaskTime] decimal(18) NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BigUnitNum] decimal(18,2) NOT NULL,
  [MidUnitNum] decimal(18,2) NOT NULL,
  [StandUnitNum] decimal(18,2) NOT NULL,
  [Num] decimal(18,2) NOT NULL,
  [PurchaseNo] varchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [CheckStartTime] datetime2(7) NULL,
  [CheckEndTime] datetime2(7) NULL,
  [ProductTime] varchar(25) COLLATE Chinese_PRC_CI_AS NULL,
  [BoxId] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [InBatchCode] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [AllowOut] tinyint NULL,
  [Price] decimal(18,2) NULL,
  [Amount] decimal(18,2) NULL,
  [Volume] decimal(18,4) NULL,
  [NetWeight] decimal(18,4) NULL,
  [GrossWeight] decimal(18,4) NULL,
  [BillId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsStockCheckDtbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点指示明细编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点指示编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'StockCheckId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'GoodsAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'GoodsPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点次数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'CheckTaskTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标准单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'StandUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'PurchaseNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点任务状态',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点开始时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'CheckStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点结束时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'CheckEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生产日期(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'ProductTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'箱号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'BoxId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库批次(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'InBatchCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许出库标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'AllowOut'
GO

EXEC sp_addextendedproperty
'MS_Description', N'单价(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'Price'
GO

EXEC sp_addextendedproperty
'MS_Description', N'金额(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'Amount'
GO

EXEC sp_addextendedproperty
'MS_Description', N'体积(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'Volume'
GO

EXEC sp_addextendedproperty
'MS_Description', N'净重(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'NetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'毛重(*)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'GrossWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'相关单据号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'BillId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点指示明细',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckDtbl'
GO


-- ----------------------------
-- Table structure for WmsStockCheckTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsStockCheckTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsStockCheckTbl]
GO

CREATE TABLE [dbo].[WmsStockCheckTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsPosId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int NOT NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckUser] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [CheckTime] datetime2(7) NULL,
  [ConfirmUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ConfirmUser] datetime2(7) NULL,
  [ConfirmDate] datetime2(7) NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsStockCheckTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点指示编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点仓库',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'GoodsAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'GoodsPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点类型(SYS_CHECKTYPE)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'CheckType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'CheckUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'CheckUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'CheckTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'审核人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'ConfirmUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'审核人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'ConfirmUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'审核时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'ConfirmDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点指示',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockCheckTbl'
GO


-- ----------------------------
-- Table structure for WmsStockGoodsTbl
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsStockGoodsTbl]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsStockGoodsTbl]
GO

CREATE TABLE [dbo].[WmsStockGoodsTbl] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [OwnerId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsBatch] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ContainerId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [PurchseNo] varchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [InBatchCode] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [IsAllowOut] tinyint NOT NULL,
  [QualityFlg] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [StockId] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsAreaId] varchar(12) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [GoodsPosId] varchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [ProductDate] varchar(25) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [BigUnitNum] decimal(18,2) NULL,
  [MidUnitNum] decimal(18,2) NULL,
  [StandardUnitNum] decimal(18,2) NULL,
  [LockedStandardUnitNum] decimal(18,2) NULL,
  [LockedMidUnitNum] decimal(18,2) NULL,
  [LockedBigUnitNum] decimal(18,2) NULL,
  [Volume] decimal(18,4) NULL,
  [GrossWeight] decimal(18,4) NULL,
  [NetWeight] decimal(18,4) NULL,
  [Amount] decimal(18,2) NULL,
  [InStockDate] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsStockGoodsTbl] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货主编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'OwnerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'GoodsId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'商品批号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'GoodsBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'托盘号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'ContainerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采购单号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'PurchseNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库批次',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'InBatchCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'允许出库标记',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'IsAllowOut'
GO

EXEC sp_addextendedproperty
'MS_Description', N'品质(SYS_QUALITYFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'QualityFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'StockId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货区编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'GoodsAreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'货位编号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'GoodsPosId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生产日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'ProductDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'存储大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'BigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'存储中单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'MidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'存储标准单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'StandardUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'被锁标准单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'LockedStandardUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'被锁中单位数',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'LockedMidUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'被锁大单位数量',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'LockedBigUnitNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'体积',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'Volume'
GO

EXEC sp_addextendedproperty
'MS_Description', N'毛重',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'GrossWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'净重',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'NetWeight'
GO

EXEC sp_addextendedproperty
'MS_Description', N'金额',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'Amount'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库日期',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'InStockDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'在库库存表',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockGoodsTbl'
GO


-- ----------------------------
-- Table structure for WmsStockMst
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[WmsStockMst]') AND type IN ('U'))
	DROP TABLE [dbo].[WmsStockMst]
GO

CREATE TABLE [dbo].[WmsStockMst] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Name] varchar(64) COLLATE Chinese_PRC_CI_AS NULL,
  [ManagerId] varchar(12) COLLATE Chinese_PRC_CI_AS NULL,
  [SName] varchar(64) COLLATE Chinese_PRC_CI_AS NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [Enable] tinyint NOT NULL,
  [PrintFlg] tinyint NOT NULL,
  [Fax] varchar(32) COLLATE Chinese_PRC_CI_AS NULL,
  [Address] varchar(256) COLLATE Chinese_PRC_CI_AS NULL,
  [Telephone] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [ManagerTel] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[WmsStockMst] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库名称',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'ManagerId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示名称',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'SName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效标志(SYS_ACTIONFLAG)',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'Enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'打印标志',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'PrintFlg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'传真号',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'Fax'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库地址',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'Address'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'Telephone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员电话',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'ManagerTel'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'仓库主表',
'SCHEMA', N'dbo',
'TABLE', N'WmsStockMst'
GO


-- ----------------------------
-- Primary Key structure for table Application
-- ----------------------------
ALTER TABLE [dbo].[Application] ADD CONSTRAINT [PK_APPLICATION] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Category
-- ----------------------------
ALTER TABLE [dbo].[Category] ADD CONSTRAINT [PK__Category__3214EC0757425361] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table CategoryType
-- ----------------------------
ALTER TABLE [dbo].[CategoryType] ADD CONSTRAINT [PK_CATEGORYTYPE] PRIMARY KEY NONCLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table DataPrivilegeRule
-- ----------------------------
ALTER TABLE [dbo].[DataPrivilegeRule] ADD CONSTRAINT [PK__DataPriv__3214EC0782473638] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table FlowInstance
-- ----------------------------
ALTER TABLE [dbo].[FlowInstance] ADD CONSTRAINT [PK_FLOWINSTANCE] PRIMARY KEY NONCLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table FlowInstanceOperationHistory
-- ----------------------------
ALTER TABLE [dbo].[FlowInstanceOperationHistory] ADD CONSTRAINT [PK_FLOWINSTANCEOPERATIONHISTOR] PRIMARY KEY NONCLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table FlowInstanceTransitionHistory
-- ----------------------------
ALTER TABLE [dbo].[FlowInstanceTransitionHistory] ADD CONSTRAINT [PK_FLOWINSTANCETRANSITIONHISTO] PRIMARY KEY NONCLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table FlowScheme
-- ----------------------------
ALTER TABLE [dbo].[FlowScheme] ADD CONSTRAINT [PK_FLOWSCHEME] PRIMARY KEY NONCLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Form
-- ----------------------------
ALTER TABLE [dbo].[Form] ADD CONSTRAINT [PK_FORM] PRIMARY KEY NONCLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table FrmLeaveReq
-- ----------------------------
ALTER TABLE [dbo].[FrmLeaveReq] ADD CONSTRAINT [PK_FRMLEAVEREQ] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Module
-- ----------------------------
ALTER TABLE [dbo].[Module] ADD CONSTRAINT [PK_MODULE] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table ModuleElement
-- ----------------------------
ALTER TABLE [dbo].[ModuleElement] ADD CONSTRAINT [PK_MODULEELEMENT] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Org
-- ----------------------------
ALTER TABLE [dbo].[Org] ADD CONSTRAINT [PK_ORG] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Relevance
-- ----------------------------
ALTER TABLE [dbo].[Relevance] ADD CONSTRAINT [PK_RELEVANCE] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Resource
-- ----------------------------
ALTER TABLE [dbo].[Resource] ADD CONSTRAINT [PK__Resource__3214EC07A3FEAC15] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Role
-- ----------------------------
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [PK_ROLE] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Stock
-- ----------------------------
ALTER TABLE [dbo].[Stock] ADD CONSTRAINT [PK_STOCK] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table SysLog
-- ----------------------------
ALTER TABLE [dbo].[SysLog] ADD CONSTRAINT [PK_SYSLOG] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table SysMessage
-- ----------------------------
ALTER TABLE [dbo].[SysMessage] ADD CONSTRAINT [PK_SYSMESSAGE] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table UploadFile
-- ----------------------------
ALTER TABLE [dbo].[UploadFile] ADD CONSTRAINT [PK_FILE] PRIMARY KEY NONCLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table User
-- ----------------------------
ALTER TABLE [dbo].[User] ADD CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsCustomerMst
-- ----------------------------
ALTER TABLE [dbo].[WmsCustomerMst] ADD CONSTRAINT [PK__WmsCusto__3214EC07802B21CE] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsDeliverTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsDeliverTbl] ADD CONSTRAINT [PK__WmsDeliv__3214EC074F7CE91B] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsGoodsAreaMst
-- ----------------------------
ALTER TABLE [dbo].[WmsGoodsAreaMst] ADD CONSTRAINT [PK__WmsGoods__00DCD69B2D4B60E2] PRIMARY KEY CLUSTERED ([Id], [StockId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table WmsGoodsBatchMst
-- ----------------------------
CREATE NONCLUSTERED INDEX [AK_GOODSBATCHMST]
ON [dbo].[WmsGoodsBatchMst] (
  [Id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table WmsGoodsBatchMst
-- ----------------------------
ALTER TABLE [dbo].[WmsGoodsBatchMst] ADD CONSTRAINT [PK__WmsGoods__B008324E0A8F074D] PRIMARY KEY CLUSTERED ([Id], [GoodsBatch], [GoodsId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsGoodsMst
-- ----------------------------
ALTER TABLE [dbo].[WmsGoodsMst] ADD CONSTRAINT [PK__WmsGoods__3214EC07AFE05372] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsGoodsPosMst
-- ----------------------------
ALTER TABLE [dbo].[WmsGoodsPosMst] ADD CONSTRAINT [PK__WmsGoods__59C4EF9160FEDD14] PRIMARY KEY CLUSTERED ([GoodsPosId], [StockId], [GoodsAreaId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsInboundArrivalDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsInboundArrivalDtbl] ADD CONSTRAINT [PK__WmsInbou__864B8F7F9FBCA5C1] PRIMARY KEY CLUSTERED ([Id], [AsnNo])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsInboundArrivalTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsInboundArrivalTbl] ADD CONSTRAINT [PK__WmsInbou__3214EC07119853E6] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsInboundOrderDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsInboundOrderDtbl] ADD CONSTRAINT [PK__WmsInbou__DE2DE9BB34BC7C0B] PRIMARY KEY CLUSTERED ([Id], [OrderId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsInboundOrderTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsInboundOrderTbl] ADD CONSTRAINT [PK__WmsInbou__3214EC070A6E292B] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsInstockPickDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsInstockPickDtbl] ADD CONSTRAINT [PK__WmsInsto__E975F0186AF191E6] PRIMARY KEY CLUSTERED ([InstockPickId], [Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsInstockPickTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsInstockPickTbl] ADD CONSTRAINT [PK__WmsInsto__3214EC0782AC9DC2] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsInstockRecDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsInstockRecDtbl] ADD CONSTRAINT [PK__WmsInsto__01D9A64A239DBC77] PRIMARY KEY CLUSTERED ([InstockRecvId], [Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsInstockRecTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsInstockRecTbl] ADD CONSTRAINT [PK__WmsInsto__3214EC078A0F20F7] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsLoadingDocDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsLoadingDocDtbl] ADD CONSTRAINT [PK__WmsLoadi__57CB5E673A30D267] PRIMARY KEY CLUSTERED ([Id], [LoadingDocId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsLoadingDocTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsLoadingDocTbl] ADD CONSTRAINT [PK__WmsLoadi__3214EC07649A9036] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsLoadingNoticeDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsLoadingNoticeDtbl] ADD CONSTRAINT [PK__WmsLoadi__732A531591E1734A] PRIMARY KEY CLUSTERED ([Id], [LoadingNoticeId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsLoadingNoticeTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsLoadingNoticeTbl] ADD CONSTRAINT [PK__WmsLoadi__3214EC07F35A90ED] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsMoveTaskDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsMoveTaskDtbl] ADD CONSTRAINT [PK__WmsMoveT__DE83A981B7868A74] PRIMARY KEY CLUSTERED ([Id], [MoveTaskId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsMoveTaskGroupTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsMoveTaskGroupTbl] ADD CONSTRAINT [PK__WmsMoveT__17E76CD091E36944] PRIMARY KEY CLUSTERED ([MoveTaskGroupId], [TaskId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsMoveTaskTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsMoveTaskTbl] ADD CONSTRAINT [PK__WmsMoveT__3214EC07DD06CF89] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsOutboundArrivalTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsOutboundArrivalTbl] ADD CONSTRAINT [PK__WmsOutbo__9F50E9164CF2B7EF] PRIMARY KEY CLUSTERED ([LoadingDocId], [OutBoundOrderId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsOutboundOrderDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsOutboundOrderDtbl] ADD CONSTRAINT [PK__WmsOutbo__DE2DE9BBCD1834C3] PRIMARY KEY CLUSTERED ([Id], [OrderId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsOutboundOrderTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsOutboundOrderTbl] ADD CONSTRAINT [PK__WmsOutbo__3214EC077AC8C178] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsOutboundPickTaskDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsOutboundPickTaskDtbl] ADD CONSTRAINT [PK__WmsOutbo__685D2B055F9158A3] PRIMARY KEY CLUSTERED ([Id], [PickTaskId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsOutboundPickTaskTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsOutboundPickTaskTbl] ADD CONSTRAINT [PK__WmsOutbo__3214EC07FBA3C0F1] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsOwnerMst
-- ----------------------------
ALTER TABLE [dbo].[WmsOwnerMst] ADD CONSTRAINT [PK__WmsOwner__3214EC072ED8F943] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsPickwaveDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsPickwaveDtbl] ADD CONSTRAINT [PK__WmsPickw__6861126D51C7905B] PRIMARY KEY CLUSTERED ([Id], [PickwaveId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsPickwaveTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsPickwaveTbl] ADD CONSTRAINT [PK__WmsPickw__3214EC078EC629C8] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsShipperMst
-- ----------------------------
ALTER TABLE [dbo].[WmsShipperMst] ADD CONSTRAINT [PK__WmsShipp__3214EC0738FA9B8C] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsStockAdjDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsStockAdjDtbl] ADD CONSTRAINT [PK__WmsStock__C344E6B291F1EC29] PRIMARY KEY CLUSTERED ([AdjId], [Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsStockAdjTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsStockAdjTbl] ADD CONSTRAINT [PK__WmsStock__3214EC0725E22AD3] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsStockChangeLogTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsStockChangeLogTbl] ADD CONSTRAINT [PK__WmsStock__3214EC07174FB994] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsStockCheckDtbl
-- ----------------------------
ALTER TABLE [dbo].[WmsStockCheckDtbl] ADD CONSTRAINT [PK__WmsStock__05137627043E9164] PRIMARY KEY CLUSTERED ([Id], [StockCheckId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsStockCheckTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsStockCheckTbl] ADD CONSTRAINT [PK__WmsStock__3214EC078CFCF156] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsStockGoodsTbl
-- ----------------------------
ALTER TABLE [dbo].[WmsStockGoodsTbl] ADD CONSTRAINT [PK__WmsStock__3214EC07241814D4] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table WmsStockMst
-- ----------------------------
ALTER TABLE [dbo].[WmsStockMst] ADD CONSTRAINT [PK__WmsStock__3214EC07AB2C2C33] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO

