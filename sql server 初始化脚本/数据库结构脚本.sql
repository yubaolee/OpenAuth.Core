/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : SQL Server
 Source Server Version : 14001000
 Source Host           : .:1433
 Source Catalog        : OpenAuthDB
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 14001000
 File Encoding         : 65001

 Date: 14/03/2019 21:17:16
*/


create type PrimaryKey from varchar(50)
go

-- ----------------------------
-- Table structure for Application
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Application]') AND type IN ('U'))
	DROP TABLE [dbo].[Application]
GO

CREATE TABLE [dbo].[Application] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] varchar(255) DEFAULT (' ') NOT NULL,
  [AppSecret] varchar(255) NULL,
  [Description] nvarchar(255) NULL,
  [Icon] varchar(255) NULL,
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
-- Table structure for Category
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type IN ('U'))
	DROP TABLE [dbo].[Category]
GO

CREATE TABLE [dbo].[Category] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] nvarchar(255) DEFAULT (' ') NOT NULL,
  [Disabled] bit DEFAULT ((0)) NOT NULL,
  [SortNo] int DEFAULT ((0)) NOT NULL,
  [Icon] varchar(255) NULL,
  [Description] nvarchar(500) NULL,
  [TypeId] [dbo].[PrimaryKey] NULL
)
GO

ALTER TABLE [dbo].[Category] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类表ID（可作为分类的标识）',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'名称',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否可用',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'Disabled'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序号',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'SortNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类图标',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'Icon'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类描述',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类类型ID',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'TypeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类表，表示一个全集，比如：男、女、未知。关联的分类类型表示按什么进行的分类，如：按照性别对人类对象集进行分类',
'SCHEMA', N'dbo',
'TABLE', N'Category'
GO


-- ----------------------------
-- Table structure for CategoryType
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryType]') AND type IN ('U'))
	DROP TABLE [dbo].[CategoryType]
GO

CREATE TABLE [dbo].[CategoryType] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] nvarchar(255) DEFAULT (' ') NOT NULL,
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
-- Table structure for FlowInstance
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FlowInstance]') AND type IN ('U'))
	DROP TABLE [dbo].[FlowInstance]
GO

CREATE TABLE [dbo].[FlowInstance] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [InstanceSchemeId] [dbo].[PrimaryKey] NOT NULL,
  [Code] varchar(200) NULL,
  [CustomName] varchar(200) NULL,
  [ActivityId] [dbo].[PrimaryKey] NULL,
  [ActivityType] int NULL,
  [ActivityName] varchar(200) NULL,
  [PreviousId] [dbo].[PrimaryKey] NULL,
  [SchemeContent] varchar(max) NULL,
  [SchemeId] [dbo].[PrimaryKey] NULL,
  [DbName] varchar(50) NULL,
  [FrmData] text NULL,
  [FrmType] int DEFAULT ((0)) NOT NULL,
  [FrmContentData] text NULL,
  [FrmContentParse] text NULL,
  [FrmId] [dbo].[PrimaryKey] NULL,
  [SchemeType] varchar(50) NULL,
  [Disabled] int DEFAULT ((0)) NOT NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) NULL,
  [FlowLevel] int DEFAULT ((0)) NOT NULL,
  [Description] varchar(200) NULL,
  [IsFinish] int DEFAULT ((0)) NOT NULL,
  [MakerList] varchar(1000) NULL
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
-- Table structure for FlowInstanceOperationHistory
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FlowInstanceOperationHistory]') AND type IN ('U'))
	DROP TABLE [dbo].[FlowInstanceOperationHistory]
GO

CREATE TABLE [dbo].[FlowInstanceOperationHistory] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [InstanceId] [dbo].[PrimaryKey] NOT NULL,
  [Content] nvarchar(200) NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) NULL
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
  [FromNodeName] varchar(200) NULL,
  [ToNodeId] [dbo].[PrimaryKey] NULL,
  [ToNodeType] int NULL,
  [ToNodeName] varchar(200) NULL,
  [TransitionSate] int DEFAULT ((0)) NOT NULL,
  [IsFinish] int DEFAULT ((0)) NOT NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) NULL
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
-- Table structure for FlowScheme
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FlowScheme]') AND type IN ('U'))
	DROP TABLE [dbo].[FlowScheme]
GO

CREATE TABLE [dbo].[FlowScheme] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [SchemeCode] varchar(50) NULL,
  [SchemeName] varchar(200) NULL,
  [SchemeType] varchar(50) NULL,
  [SchemeVersion] varchar(50) NULL,
  [SchemeCanUser] varchar(max) NULL,
  [SchemeContent] varchar(max) NULL,
  [FrmId] [dbo].[PrimaryKey] NULL,
  [FrmType] int DEFAULT ((0)) NOT NULL,
  [AuthorizeType] int DEFAULT ((0)) NOT NULL,
  [SortCode] int DEFAULT ((0)) NOT NULL,
  [DeleteMark] int DEFAULT ((0)) NOT NULL,
  [Disabled] int DEFAULT ((0)) NOT NULL,
  [Description] varchar(200) NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) NULL,
  [ModifyDate] datetime NULL,
  [ModifyUserId] [dbo].[PrimaryKey] NULL,
  [ModifyUserName] varchar(50) NULL
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
-- Table structure for Form
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Form]') AND type IN ('U'))
	DROP TABLE [dbo].[Form]
GO

CREATE TABLE [dbo].[Form] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] varchar(200) NULL,
  [FrmType] int DEFAULT ((0)) NOT NULL,
  [WebId] varchar(200) NULL,
  [Fields] int DEFAULT ((0)) NOT NULL,
  [ContentData] text NULL,
  [ContentParse] text NULL,
  [Content] text NULL,
  [SortCode] int DEFAULT ((0)) NOT NULL,
  [DeleteMark] int DEFAULT ((0)) NOT NULL,
  [DbName] varchar(50) NULL,
  [Disabled] int DEFAULT ((0)) NOT NULL,
  [Description] nvarchar(200) NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) NULL,
  [ModifyDate] datetime NULL,
  [ModifyUserId] [dbo].[PrimaryKey] NULL,
  [ModifyUserName] varchar(50) NULL
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
-- Table structure for FrmLeaveReq
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[FrmLeaveReq]') AND type IN ('U'))
	DROP TABLE [dbo].[FrmLeaveReq]
GO

CREATE TABLE [dbo].[FrmLeaveReq] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [UserName] nvarchar(10) NOT NULL,
  [RequestType] nvarchar(20) NOT NULL,
  [StartDate] date NOT NULL,
  [StartTime] datetime NULL,
  [EndDate] date NOT NULL,
  [EndTime] datetime NULL,
  [RequestComment] nvarchar(500) NULL,
  [Attachment] varchar(500) NULL,
  [CreateDate] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] [dbo].[PrimaryKey] NULL,
  [CreateUserName] varchar(50) NULL
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
'MS_Description', N'模拟一个自定页面的表单，该数据会关联到流程实例FrmData，可用于复杂页面的设计及后期的数据分析',
'SCHEMA', N'dbo',
'TABLE', N'FrmLeaveReq'
GO


-- ----------------------------
-- Table structure for Module
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Module]') AND type IN ('U'))
	DROP TABLE [dbo].[Module]
GO

CREATE TABLE [dbo].[Module] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [CascadeId] varchar(255) DEFAULT (' ') NOT NULL,
  [Name] varchar(255) DEFAULT (' ') NOT NULL,
  [Url] varchar(255) DEFAULT (' ') NOT NULL,
  [HotKey] varchar(255) DEFAULT (' ') NOT NULL,
  [IsLeaf] bit DEFAULT ((1)) NOT NULL,
  [IsAutoExpand] bit DEFAULT ((0)) NOT NULL,
  [IconName] varchar(255) DEFAULT (' ') NOT NULL,
  [Status] int DEFAULT ((1)) NOT NULL,
  [ParentName] varchar(255) DEFAULT (' ') NOT NULL,
  [Vector] varchar(255) DEFAULT (' ') NOT NULL,
  [SortNo] int DEFAULT ((0)) NOT NULL,
  [ParentId] [dbo].[PrimaryKey] NULL,
  [Code] varchar(50) NULL,
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
-- Table structure for ModuleElement
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[ModuleElement]') AND type IN ('U'))
	DROP TABLE [dbo].[ModuleElement]
GO

CREATE TABLE [dbo].[ModuleElement] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [DomId] varchar(255) DEFAULT (' ') NOT NULL,
  [Name] varchar(255) DEFAULT (' ') NOT NULL,
  [Attr] varchar(500) DEFAULT (' ') NOT NULL,
  [Script] varchar(500) DEFAULT (' ') NOT NULL,
  [Icon] varchar(255) DEFAULT (' ') NOT NULL,
  [Class] varchar(255) DEFAULT (' ') NOT NULL,
  [Remark] varchar(200) DEFAULT (' ') NOT NULL,
  [Sort] int DEFAULT ((0)) NOT NULL,
  [ModuleId] [dbo].[PrimaryKey] NOT NULL,
  [TypeName] nvarchar(20) NULL,
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
-- Table structure for Org
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Org]') AND type IN ('U'))
	DROP TABLE [dbo].[Org]
GO

CREATE TABLE [dbo].[Org] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [CascadeId] varchar(255) DEFAULT (' ') NOT NULL,
  [Name] varchar(255) DEFAULT (' ') NOT NULL,
  [HotKey] varchar(255) DEFAULT (' ') NOT NULL,
  [ParentName] varchar(255) DEFAULT (' ') NOT NULL,
  [IsLeaf] bit DEFAULT ((1)) NOT NULL,
  [IsAutoExpand] bit DEFAULT ((0)) NOT NULL,
  [IconName] varchar(255) DEFAULT (' ') NOT NULL,
  [Status] int DEFAULT ((1)) NOT NULL,
  [BizCode] varchar(255) DEFAULT (' ') NOT NULL,
  [CustomCode] varchar(4000) DEFAULT (' ') NOT NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CreateId] int DEFAULT ((0)) NOT NULL,
  [SortNo] int DEFAULT ((0)) NOT NULL,
  [ParentId] [dbo].[PrimaryKey] NULL,
  [TypeName] nvarchar(20) NULL,
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
-- Table structure for Relevance
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Relevance]') AND type IN ('U'))
	DROP TABLE [dbo].[Relevance]
GO

CREATE TABLE [dbo].[Relevance] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Description] nvarchar(100) DEFAULT (' ') NOT NULL,
  [Key] varchar(100) DEFAULT (' ') NOT NULL,
  [Status] int DEFAULT ((0)) NOT NULL,
  [OperateTime] datetime DEFAULT (getdate()) NOT NULL,
  [OperatorId] [dbo].[PrimaryKey] NULL,
  [FirstId] [dbo].[PrimaryKey] NOT NULL,
  [SecondId] [dbo].[PrimaryKey] NOT NULL,
  [ThirdId] [dbo].[PrimaryKey] NULL,
  [ExtendInfo] varchar(100) NULL
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
-- Table structure for Resource
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Resource]') AND type IN ('U'))
	DROP TABLE [dbo].[Resource]
GO

CREATE TABLE [dbo].[Resource] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [CascadeId] varchar(255) DEFAULT (' ') NOT NULL,
  [Name] varchar(255) DEFAULT (' ') NOT NULL,
  [SortNo] int DEFAULT ((0)) NOT NULL,
  [Description] nvarchar(500) DEFAULT (' ') NOT NULL,
  [ParentName] nvarchar(50) NULL,
  [ParentId] [dbo].[PrimaryKey] NULL,
  [AppId] [dbo].[PrimaryKey] NULL,
  [AppName] nvarchar(50) NULL,
  [TypeName] nvarchar(20) NULL,
  [TypeId] [dbo].[PrimaryKey] NULL,
  [Disable] bit DEFAULT ((0)) NOT NULL
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
  [Name] varchar(255) DEFAULT (' ') NOT NULL,
  [Status] int DEFAULT ((1)) NOT NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CreateId] [dbo].[PrimaryKey] NULL,
  [TypeName] nvarchar(20) NULL,
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
-- Table structure for Stock
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Stock]') AND type IN ('U'))
	DROP TABLE [dbo].[Stock]
GO

CREATE TABLE [dbo].[Stock] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [Name] nvarchar(500) DEFAULT (' ') NOT NULL,
  [Number] int DEFAULT ((0)) NOT NULL,
  [Price] decimal(10,1) DEFAULT ((0)) NOT NULL,
  [Status] int DEFAULT ((0)) NOT NULL,
  [Viewable] varchar(50) DEFAULT (' ') NOT NULL,
  [User] varchar(50) DEFAULT (' ') NOT NULL,
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
-- Table structure for UploadFile
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[UploadFile]') AND type IN ('U'))
	DROP TABLE [dbo].[UploadFile]
GO

CREATE TABLE [dbo].[UploadFile] (
  [Id] [dbo].[PrimaryKey] NOT NULL,
  [FileName] nvarchar(200) NOT NULL,
  [FilePath] nvarchar(500) NOT NULL,
  [Description] nvarchar(200) NULL,
  [FileType] varchar(20) NULL,
  [FileSize] int NULL,
  [Extension] varchar(20) NULL,
  [Enable] bit DEFAULT ((1)) NOT NULL,
  [SortCode] int DEFAULT ((0)) NOT NULL,
  [DeleteMark] bit DEFAULT ((0)) NOT NULL,
  [CreateUserId] uniqueidentifier NULL,
  [CreateUserName] nvarchar(50) NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [Thumbnail] nvarchar(500) NULL,
  [BelongApp] varchar(200) NULL,
  [BelongAppId] varchar(50) NULL
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
  [Account] varchar(255) DEFAULT (' ') NOT NULL,
  [Password] varchar(255) DEFAULT (' ') NOT NULL,
  [Name] varchar(255) DEFAULT (' ') NOT NULL,
  [Sex] int DEFAULT ((0)) NOT NULL,
  [Status] int DEFAULT ((0)) NOT NULL,
  [BizCode] varchar(255) DEFAULT (' ') NOT NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CrateId] [dbo].[PrimaryKey] NULL,
  [TypeName] nvarchar(20) NULL,
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
'COLUMN', N'CrateId'
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
-- Primary Key structure for table Application
-- ----------------------------
ALTER TABLE [dbo].[Application] ADD CONSTRAINT [PK_APPLICATION] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Category
-- ----------------------------
ALTER TABLE [dbo].[Category] ADD CONSTRAINT [PK_CATEGORY] PRIMARY KEY NONCLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
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
ALTER TABLE [dbo].[Resource] ADD CONSTRAINT [PK_RESOURCE] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
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

