/*需要先创建一个名字为OpenAuthDB的数据库*/
use [OpenAuthDB]

create type [dbo].[PrimaryKey] from varchar(50)
go
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
  [Enable] bit NOT NULL,
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

INSERT INTO [dbo].[Category]  VALUES (N'08776116-d1bf-40d1-b7ff-78b7392f4aef', N'自提', N'SYS_SHIPTYPE_NORMAL', N'SYS_SHIPTYPE_NORMAL', N'1', N'0', N'', N'SYS_SHIPTYPE', N'2019-11-07 01:19:12.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:19:12.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'1979955b-901d-4394-8a3c-f81c32970365', N'中药材', N'SYS_GOODSTYPE_TCM', N'SYS_GOODSTYPE_TCM', N'1', N'0', N'', N'SYS_GOODSTYPE', N'2019-11-07 01:17:36.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:17:36.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'2615b6bf-7fc3-46e1-8105-708dda0e6c42', N'发货完成', N'PICKSTATUS_OUTSTOCK', N'PICKSTATUS_OUTSTOCK', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:32:02.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:32:02.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'354f50b7-0d93-43d6-a721-a4931c650ea3', N'创建', N'SYS_ORDERSTATUS_CREATE', N'SYS_ORDERSTATUS_CREATE', N'1', N'0', N'', N'SYS_ORDERSTATUS', N'2019-10-29 21:20:02.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:20:02.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'43303bfb-11e3-4e12-8cdd-2ef090017e4c', N'样品入库', N'SYS_INBOUNDTYPE_SAMPLE', N'SYS_INBOUNDTYPE_SAMPLE', N'1', N'0', N'', N'SYS_INBOUNDTYPE', N'2019-11-07 00:51:26.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 00:51:26.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'4de1cf0d-b1f5-44f7-a329-4b5fcff73ca6', N'普药', N'SYS_GOODSTYPE_COMMON', N'SYS_GOODSTYPE_COMMON', N'1', N'0', N'', N'SYS_GOODSTYPE', N'2019-11-07 01:15:35.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:15:35.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'52f662c3-39bc-4f5a-9730-107cf26b12f0', N'直送', N'SYS_SHIPTYPE_DIRECT', N'SYS_SHIPTYPE_DIRECT', N'1', N'0', N'', N'SYS_SHIPTYPE', N'2019-11-07 01:19:41.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:19:41.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'74f7bcc8-50a3-4c02-9a25-ee2fa4575e25', N'集货完成', N'PICKSTATUS_STAGED', N'PICKSTATUS_STAGED', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:31:11.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:31:11.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'77a7f565-cb5c-4876-a139-7901e54b5dde', N'正常', N'SYS_STATUS_OK', N'0', N'0', N'0', N'', N'SYS_STATUS', N'2019-11-06 10:38:46.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-06 10:38:46.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'7fbeb155-8fbb-44ce-a726-2a6fea7920d5', N'异常', N'SYS_STATUS_ERROR', N'1', N'1', N'0', N'', N'SYS_STATUS', N'2019-11-06 10:39:24.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-06 10:39:24.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'845ef9f2-4d33-4887-acf0-6d45fdf5e05c', N'EMS', N'SYS_SHIPTYPE_EMS', N'SYS_SHIPTYPE_EMS', N'1', N'0', N'', N'SYS_SHIPTYPE', N'2019-11-07 01:20:45.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:20:45.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'8641c594-e43e-4469-a5b5-5da06a53eaf9', N'打包完成', N'PICKSTATUS_PACK', N'PICKSTATUS_PACK', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:31:50.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:31:50.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'86b8d963-63b6-4936-87b1-af248cd26c44', N'已完成', N'SYS_ORDERSTATUS_FINISHED', N'SYS_ORDERSTATUS_FINISHED', N'1', N'0', N'', N'SYS_ORDERSTATUS', N'2019-10-29 21:27:32.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:27:32.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'8dcbc59a-c045-4e06-ad13-095cfe9a3209', N'销退入库', N'SYS_INBOUNDTYPE_RETURN', N'SYS_INBOUNDTYPE_RETURN', N'1', N'0', N'', N'SYS_INBOUNDTYPE', N'2019-11-07 00:52:04.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 00:52:04.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'9bddbcfd-f41e-429f-b112-76db0c1bf0f3', N'复核完成', N'PICKSTATUS_CHECKED', N'PICKSTATUS_CHECKED', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:30:37.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:30:37.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'a4017f4d-c113-4ec9-bdcb-d9c49019a916', N'生物制品', N'SYS_GOODSTYPE_BIOLPROD', N'SYS_GOODSTYPE_BIOLPROD', N'1', N'0', N'', N'SYS_GOODSTYPE', N'2019-11-07 01:16:59.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:16:59.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'b1d4301b-2378-4598-9b96-8592afbb64d1', N'缓存完成', N'PICKSTATUS_CACHE', N'PICKSTATUS_CACHE', N'1', N'0', N'', N'SYS_PICKSTATUS', N'2019-10-29 21:30:53.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-10-29 21:30:53.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'b44bb9f4-166c-4c59-a693-baacd01d2db4', N'4+7集中采购', N'SYS_SHIPTYPE_FREIGHT', N'SYS_SHIPTYPE_FREIGHT', N'1', N'0', N'', N'SYS_SHIPTYPE', N'2019-11-07 01:20:21.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:20:21.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'b77f4a7d-0d22-47dd-97d1-7f8ccd9e5f77', N'采购入库', N'SYS_INBOUNDTYPE_PURCHASE', N'SYS_INBOUNDTYPE_PURCHASE', N'1', N'0', N'', N'SYS_INBOUNDTYPE', N'2019-11-07 00:50:51.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 00:50:51.0000000', N'', N'')
GO

INSERT INTO [dbo].[Category]  VALUES (N'c3ce85b1-0115-47d4-b562-1bbcc51105e2', N'食品', N'SYS_GOODSTYPE_FOOD', N'SYS_GOODSTYPE_FOOD', N'1', N'0', N'', N'SYS_GOODSTYPE', N'2019-11-07 01:17:58.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:17:58.0000000', N'', N'')
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

INSERT INTO [dbo].[Category]  VALUES (N'fe1f7181-d3d0-4b0e-b9b3-5d05b503ff0e', N'医疗器械', N'SYS_GOODSTYPE_MEDINSTR', N'SYS_GOODSTYPE_MEDINSTR', N'1', N'0', N'', N'SYS_GOODSTYPE', N'2019-11-07 01:16:02.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:16:02.0000000', N'', N'')
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
INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_CUSTTYPE', N'客户类型', N'2019-11-07 00:49:50.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_GOODSTYPE', N'商品类别', N'2019-11-07 00:48:47.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_INBOUNDTYPE', N'入库类型', N'2019-11-07 00:48:08.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_ORDERSTATUS', N'订单状态', N'2019-10-29 21:18:56.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_ORDERTYPE', N'订单类型', N'2019-10-29 21:18:32.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_PICKSTATUS', N'拣选任务状态', N'2019-10-29 21:28:50.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_SHIPTYPE', N'承运方式', N'2019-11-07 00:47:36.000')
GO

INSERT INTO [dbo].[CategoryType]  VALUES (N'SYS_STATUS', N'系统状态', N'2019-11-06 10:38:17.000')
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
  [Enable] bit NOT NULL,
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
INSERT INTO [dbo].[DataPrivilegeRule]  VALUES (N'5098523e-f038-4bc8-850f-9629cac3e4f6', N'Form', N'', N'只能看到用户自己对应部门的表单,System可以看到所有', N'0', N'{"Operation":"or","Filters":[{"Key":"OrgId","Value":"{loginOrg}","Contrast":"in","names":"","Text":""}]}', N'1', N'2020-03-18 23:36:04.5174848', N'00000000-0000-0000-0000-000000000000', N'', N'2020-03-19 21:14:34.2847499', N'00000000-0000-0000-0000-000000000000', N'')
GO

INSERT INTO [dbo].[DataPrivilegeRule]  VALUES (N'6a96c5d9-a226-459d-a4e1-aefcbefc6915', N'WmsInboundOrderTbl', N'', N'【管理员】角色可以看所有人的订单，【测试】只能看自己创建的订单', N'0', N'{"Operation":"or","Filters":[{"Key":"{loginRole}","Value":"09ee2ffa-7463-4938-ae0b-1cb4e80c7c13,77e6d0c3-f9e1-4933-92c3-c1c6eef75593","Contrast":"contains","names":"","Text":"管理员,神"}],"Children":[{"Operation":"and","Filters":[{"Key":"{loginRole}","Value":"0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d","Contrast":"contains","Text":"测试"},{"Key":"CreateUserId","Value":"{loginUser}","Contrast":"==","Text":""}]}]}', N'1', N'2019-11-23 01:02:32.0000000', N'00000000-0000-0000-0000-000000000000', N'', N'2019-11-23 01:02:32.0000000', N'', N'')
GO

INSERT INTO [dbo].[DataPrivilegeRule]  VALUES (N'ab177ea0-89f3-429e-8f0f-7a00819d8ef3', N'FlowScheme', N'', N'System可以看到所有流程设计，【管理员】可以看到部门的，其他人只能看到自己的', N'0', N'{"Operation":"or","Filters":[{"Key":"CreateUserId","Value":"{loginUser}","Contrast":"==","Text":""}],"Children":[{"Operation":"and","Filters":[{"Key":"OrgId","Value":"{loginOrg}","Contrast":"in","Text":""},{"Key":"{loginRole}","Value":"09ee2ffa-7463-4938-ae0b-1cb4e80c7c13","Contrast":"contains","Text":"管理员"}]}]}', N'1', N'2020-03-19 21:17:30.4542319', N'00000000-0000-0000-0000-000000000000', N'', N'2020-03-19 21:57:46.7338764', N'00000000-0000-0000-0000-000000000000', N'')
GO

INSERT INTO [dbo].[DataPrivilegeRule]  VALUES (N'e7c95fb1-91f7-422e-a11a-73cea0c404b9', N'Resource', NULL, N'【管理员】角色可以看所有人的资源，【测试】只能看自己创建的资源，账号test3/test4只能看属于（XXX管理平台）的资源', N'0', N'{"Operation":"or","Filters":[{"Key":"{loginRole}","Value":"09ee2ffa-7463-4938-ae0b-1cb4e80c7c13","Contrast":"contains","Text":"管理员"}],"Children":[{"Operation":"and","Filters":[{"Key":"{loginRole}","Value":"0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d","Contrast":"contains","Text":"测试"},{"Key":"CreateUserId","Value":"{loginUser}","Contrast":"==","Text":""}]},{"Operation":"and","Filters":[{"Key":"AppName","Value":"XXX管理平台","Contrast":"==","Text":""},{"Key":"{loginUser}","Value":"229f3a49-ab27-49ce-b383-9f10ca23a9d5,1df68dfd-3b6d-4491-872f-00a0fc6c5a64","Contrast":"in","Text":"test3,test4"}]}]}', N'1', N'2019-10-29 11:05:02.0000000', N'00000000-0000-0000-0000-000000000000', N'', N'2019-11-23 01:00:19.0000000', N'00000000-0000-0000-0000-000000000000', N'')
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
  [MakerList] varchar(1000) COLLATE Chinese_PRC_CI_AS NULL,
  [OrgId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
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
'MS_Description', N'所属部门',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance',
'COLUMN', N'OrgId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流流程实例表',
'SCHEMA', N'dbo',
'TABLE', N'FlowInstance'
GO


-- ----------------------------
-- Records of [FlowInstance]
-- ----------------------------
INSERT INTO [dbo].[FlowInstance]  VALUES (N'034ad4f0-95e6-40bf-b3c5-38bd60b542d9', N'', N'1564334796391', N'会签2019-07-29 01:26:40', N'1564334444885', N'4', N'node_7', N'1564334437844', N'{"title":"newFlow_1","initNum":16,"lines":[{"id":"1564334446774","type":"sl","from":"1564334430924","to":"1564334435460","name":"","dash":false,"Compares":null},{"id":"1564334447796","type":"sl","from":"1564334435460","to":"1564334437844","name":"","dash":false,"Compares":null},{"id":"1564334448572","type":"sl","from":"1564334437844","to":"1564334439828","name":"","dash":false,"Compares":null},{"id":"1564334449628","type":"sl","from":"1564334437844","to":"1564334440404","name":"","dash":false,"Compares":null},{"id":"1564334450572","type":"sl","from":"1564334439828","to":"1564334441965","name":"","dash":false,"Compares":null},{"id":"1564334451684","type":"sl","from":"1564334440404","to":"1564334441965","name":"","dash":false,"Compares":null},{"id":"1564334453900","type":"sl","from":"1564334441965","to":"1564334444885","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334430924","name":"node_1","type":"start round mix","left":17,"top":12,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334435460","name":"node_2","type":"node","left":141,"top":49,"width":104,"height":26,"alt":true,"setInfo":{"NodeDesignate":null,"NodeDesignateData":null,"NodeCode":null,"NodeName":null,"ThirdPartyUrl":null,"NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-29 01:28","NodeConfluenceType":null,"ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334437844","name":"会签入口，设置会签类型","type":"fork","left":141,"top":138,"width":104,"height":76,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"","TagedTime":"2019-07-29 01:30","NodeConfluenceType":"all","ConfluenceOk":1,"ConfluenceNo":null}},{"id":"1564334439828","name":"admin","type":"node","left":23,"top":272,"width":104,"height":36,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"","TagedTime":"2019-07-29 01:30","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334440404","name":"test","type":"node","left":234,"top":265,"width":104,"height":36,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334441965","name":"默认所有人","type":"join","left":140,"top":406,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"","TagedTime":"2019-07-29 01:30","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334444885","name":"node_7","type":"end round","left":351,"top":420,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'73819920-f085-4003-8874-4361b6461c92', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:26:45.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'1', N'', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'0ae5abe6-f571-4e08-b264-667dc27c5025', N'', N'1564334583446', N'带复杂表单的2019-07-29 01:23:03', N'1564334557205', N'2', N'node_2', N'1564334555981', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":66,"top":46,"type":"start round mix","id":"1564334555981","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":145,"type":"node","id":"1564334557205","width":104,"height":26,"alt":true},{"name":"node_3","left":56,"top":206,"type":"node","id":"1564334557764","width":104,"height":26,"alt":true},{"name":"node_4","left":66,"top":294,"type":"end round","id":"1564334559716","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334555981","to":"1564334557205","id":"1564334561500","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334557205","to":"1564334557764","id":"1564334562229","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334557764","to":"1564334559716","id":"1564334563268","name":"","dash":false,"alt":true}],"areas":[],"initNum":8}', N'989bd1f3-29f0-43cd-ad01-b55654907dbb', N'FrmLeaveReq', N'{"id":"","userName":"李玉宝","requestType":"事假","startDate":"2019-07-08T16:00:00.000Z","startTime":"2019-07-28T17:23:14.000Z","endDate":"2019-07-24T16:00:00.000Z","endTime":"2019-07-28T17:23:18.000Z","requestComment":"太累了，就是想休息一下","attachment":"","files":[],"extendInfo":""}', N'1', N'', N'', N'8faff4e5-b729-44d2-ac26-e899a228f63d', N'', N'0', N'2019-07-29 01:23:57.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'这种结构只能企业版使用', N'0', N'1', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'88156170-41a6-45d1-99dc-40dc37a82bc9', N'', N'1573007376219', N'按角色执行2019-11-06 10:31:28', N'1564334332325', N'2', N'管理员', N'1564334327861', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":99,"top":32,"type":"start round mix","id":"1564334327861","width":26,"height":26,"alt":true},{"name":"node_2","left":70,"top":295,"type":"end round","id":"1564334330157","width":26,"height":26,"alt":true},{"name":"管理员","left":43,"top":131,"type":"node","id":"1564334332325","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"测试人员","left":185,"top":226,"type":"node","id":"1564334333133","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}}],"lines":[{"type":"sl","from":"1564334327861","to":"1564334332325","id":"1564334335789","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334332325","to":"1564334333133","id":"1564334336629","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334333133","to":"1564334330157","id":"1564334337805","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'0b21f59c-7809-4275-acb4-8e8c08e0167e', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-11-06 10:31:35.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64,49df1602-f5f3-4d52-afb7-3802da619558', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'0ee22872-f120-4c5a-84ec-7f4e36bd0141', N'', N'1564334742060', N'带分支条件的请假2019-07-29 01:25:44', N'1564334139783', N'4', N'node_2', N'1564334156607', N'{"title":"newFlow_1","initNum":16,"lines":[{"id":"1564334158551","type":"sl","from":"1564334138399","to":"1564334153687","name":"","dash":false,"Compares":null},{"id":"1564334159304","type":"sl","from":"1564334153687","to":"1564334154471","name":"","dash":false,"Compares":[{"Operation":"<","FieldName":"DAYS","FieldType":null,"Value":"3"}]},{"id":"1564334160383","type":"sl","from":"1564334153687","to":"1564334155295","name":"","dash":false,"Compares":[{"Operation":">=","FieldName":"DAYS","FieldType":null,"Value":"3"}]},{"id":"1564334161911","type":"sl","from":"1564334154471","to":"1564334156607","name":"","dash":false,"Compares":null},{"id":"1564334163959","type":"sl","from":"1564334155295","to":"1564334156607","name":"","dash":false,"Compares":null},{"id":"1564334165255","type":"sl","from":"1564334156607","to":"1564334139783","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334138399","name":"node_1","type":"start round mix","left":44,"top":27,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334139783","name":"node_2","type":"end round","left":50,"top":295,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334153687","name":"所有人可以审批","type":"node","left":163,"top":43,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"","TagedTime":"2019-07-29 01:26","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334154471","name":"小于3的test可以审批","type":"node","left":23,"top":141,"width":167,"height":76,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-29 01:28","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334155295","name":"大于3的admin可以审批","type":"node","left":288,"top":146,"width":143,"height":56,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334156607","name":"默认","type":"node","left":171,"top":291,"width":104,"height":36,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"","TagedTime":"2019-07-29 01:30","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}}],"areas":[]}', N'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:25:56.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'这个时执行完成的', N'1', N'', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'20be4e87-0e9e-467c-9011-3c6ccd650931', N'', N'1564334643592', N'会签2019-07-29 01:24:05', N'1564334435460', N'2', N'node_2', N'1564334430924', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":17,"top":12,"type":"start round mix","id":"1564334430924","width":26,"height":26,"alt":true},{"name":"node_2","left":141,"top":49,"type":"node","id":"1564334435460","width":104,"height":26,"alt":true},{"name":"会签入口，设置会签类型","left":141,"top":138,"type":"fork","id":"1564334437844","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"admin","left":23,"top":272,"type":"node","id":"1564334439828","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"test","left":234,"top":265,"type":"node","id":"1564334440404","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"默认所有人","left":140,"top":406,"type":"join","id":"1564334441965","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_7","left":351,"top":420,"type":"end round","id":"1564334444885","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334430924","to":"1564334435460","id":"1564334446774","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334435460","to":"1564334437844","id":"1564334447796","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334439828","id":"1564334448572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334440404","id":"1564334449628","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334439828","to":"1564334441965","id":"1564334450572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334440404","to":"1564334441965","id":"1564334451684","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334441965","to":"1564334444885","id":"1564334453900","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'73819920-f085-4003-8874-4361b6461c92', N'', N'{"REASON":"身体原因","DAYS":"3","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:24:14.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'1', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'd4f8d2b9-6374-4c10-8d3c-1ca540bc309b', N'', N'1572341191142', N'带复杂表单的2019-10-29 17:26:42', N'1564334557205', N'2', N'node_2', N'1564334555981', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":66,"top":46,"type":"start round mix","id":"1564334555981","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":145,"type":"node","id":"1564334557205","width":104,"height":26,"alt":true},{"name":"node_3","left":56,"top":206,"type":"node","id":"1564334557764","width":104,"height":26,"alt":true},{"name":"node_4","left":66,"top":294,"type":"end round","id":"1564334559716","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334555981","to":"1564334557205","id":"1564334561500","name":"","dash":false},{"type":"sl","from":"1564334557205","to":"1564334557764","id":"1564334562229","name":"","dash":false},{"type":"sl","from":"1564334557764","to":"1564334559716","id":"1564334563268","name":"","dash":false}],"areas":[],"initNum":8}', N'989bd1f3-29f0-43cd-ad01-b55654907dbb', N'FrmLeaveReq', N'{"id":"","userName":"1","requestType":"病假","startDate":"2019-10-07T16:00:00.000Z","startTime":"2019-10-29T09:26:52.000Z","endDate":"2019-10-27T16:00:00.000Z","endTime":"2019-10-29T09:26:54.000Z","requestComment":"111","attachment":"","files":[],"extendInfo":""}', N'1', N'', N'', N'8faff4e5-b729-44d2-ac26-e899a228f63d', N'', N'0', N'2019-10-29 17:27:06.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'11', N'0', N'1', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'61959fe9-377a-4e6c-9f5d-6b7018a80bca', N'', N'1564334700493', N'带分支条件的请假2019-07-29 01:25:02', N'1564334154471', N'2', N'小于3的test可以审批', N'1564334153687', N'{"title":"newFlow_1","initNum":16,"lines":[{"id":"1564334158551","type":"sl","from":"1564334138399","to":"1564334153687","name":"","dash":false,"Compares":null},{"id":"1564334159304","type":"sl","from":"1564334153687","to":"1564334154471","name":"","dash":false,"Compares":[{"Operation":"<","FieldName":"DAYS","FieldType":null,"Value":"3"}]},{"id":"1564334160383","type":"sl","from":"1564334153687","to":"1564334155295","name":"","dash":false,"Compares":[{"Operation":">=","FieldName":"DAYS","FieldType":null,"Value":"3"}]},{"id":"1564334161911","type":"sl","from":"1564334154471","to":"1564334156607","name":"","dash":false,"Compares":null},{"id":"1564334163959","type":"sl","from":"1564334155295","to":"1564334156607","name":"","dash":false,"Compares":null},{"id":"1564334165255","type":"sl","from":"1564334156607","to":"1564334139783","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334138399","name":"node_1","type":"start round mix","left":44,"top":27,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334139783","name":"node_2","type":"end round","left":50,"top":295,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334153687","name":"所有人可以审批","type":"node","left":163,"top":43,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-29 01:29","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334154471","name":"小于3的test可以审批","type":"node","left":23,"top":141,"width":167,"height":76,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334155295","name":"大于3的admin可以审批","type":"node","left":288,"top":146,"width":143,"height":56,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334156607","name":"默认","type":"node","left":171,"top":291,"width":104,"height":36,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}}],"areas":[]}', N'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:25:16.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'这是个天数比较少的分支', N'0', N'6ba79766-faa0-4259-8139-a4a6d35784e0', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'7a1fb1a4-06a6-49d5-a311-b988aed776e1', N'', N'1564334976909', N'admin的会签2019-07-29 01:29:39', N'1564334435460', N'2', N'node_2', N'1564334430924', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":17,"top":12,"type":"start round mix","id":"1564334430924","width":26,"height":26,"alt":true},{"name":"node_2","left":141,"top":49,"type":"node","id":"1564334435460","width":104,"height":26,"alt":true},{"name":"会签入口，设置会签类型","left":141,"top":138,"type":"fork","id":"1564334437844","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"admin","left":23,"top":272,"type":"node","id":"1564334439828","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"test","left":234,"top":265,"type":"node","id":"1564334440404","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"默认所有人","left":140,"top":406,"type":"join","id":"1564334441965","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_7","left":351,"top":420,"type":"end round","id":"1564334444885","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334430924","to":"1564334435460","id":"1564334446774","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334435460","to":"1564334437844","id":"1564334447796","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334439828","id":"1564334448572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334440404","id":"1564334449628","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334439828","to":"1564334441965","id":"1564334450572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334440404","to":"1564334441965","id":"1564334451684","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334441965","to":"1564334444885","id":"1564334453900","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'73819920-f085-4003-8874-4361b6461c92', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:29:47.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'0', N'', N'0', N'1', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'df6df6b5-53f7-4db4-931b-12e3352ef413', N'', N'1564334658879', N'按角色执行2019-07-29 01:24:21', N'1564334332325', N'2', N'管理员', N'1564334327861', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":99,"top":32,"type":"start round mix","id":"1564334327861","width":26,"height":26,"alt":true},{"name":"node_2","left":70,"top":295,"type":"end round","id":"1564334330157","width":26,"height":26,"alt":true},{"name":"管理员","left":43,"top":131,"type":"node","id":"1564334332325","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"测试人员","left":185,"top":226,"type":"node","id":"1564334333133","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}}],"lines":[{"type":"sl","from":"1564334327861","to":"1564334332325","id":"1564334335789","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334332325","to":"1564334333133","id":"1564334336629","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334333133","to":"1564334330157","id":"1564334337805","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'0b21f59c-7809-4275-acb4-8e8c08e0167e', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:24:26.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'7c8ffe55-13fd-4236-9816-63eb7e22aa68', N'', N'1572350961242', N'按角色执行2019-10-29 20:09:25', N'1564334332325', N'2', N'管理员', N'1564334327861', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":99,"top":32,"type":"start round mix","id":"1564334327861","width":26,"height":26,"alt":true},{"name":"node_2","left":70,"top":295,"type":"end round","id":"1564334330157","width":26,"height":26,"alt":true},{"name":"管理员","left":43,"top":131,"type":"node","id":"1564334332325","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"测试人员","left":185,"top":226,"type":"node","id":"1564334333133","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}}],"lines":[{"type":"sl","from":"1564334327861","to":"1564334332325","id":"1564334335789","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334332325","to":"1564334333133","id":"1564334336629","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334333133","to":"1564334330157","id":"1564334337805","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'0b21f59c-7809-4275-acb4-8e8c08e0167e', N'', N'{"REASON":"身体原因","DAYS":"5","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-10-29 20:10:45.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'预约好突然', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558,1df68dfd-3b6d-4491-872f-00a0fc6c5a64', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'b918eb3a-0fd4-4df9-a3a3-0bbf2aa5746d', N'', N'1564334869743', N'test的普通请假2019-07-29 01:27:53', N'1564334038904', N'4', N'node_4', N'1564334036152', N'{"title":"newFlow_1","initNum":9,"lines":[{"id":"1564334041040","type":"sl","from":"1564334032785","to":"1564334035352","name":"","dash":false,"Compares":null},{"id":"1564334041720","type":"sl","from":"1564334035352","to":"1564334036152","name":"","dash":false,"Compares":null},{"id":"1564334042927","type":"sl","from":"1564334036152","to":"1564334038904","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334032785","name":"node_1","type":"start round mix","left":19,"top":36,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334035352","name":"所有人可以审批","type":"node","left":133,"top":50,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"http://xxxx.com/api/workflow/callback","NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"","TagedTime":"2019-10-29 14:44","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334036152","name":"所有人可以审批","type":"node","left":139,"top":123,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"","TagedTime":"2019-10-29 14:44","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334038904","name":"node_4","type":"end round","left":47,"top":193,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'61806396-9498-492b-bc22-9f9e95a389bc', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:28:05.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'0', N'', N'1', N'', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'be9b74cf-2e74-40f3-9ebf-3508f6e79bde', N'', N'1564334669608', N'带分支条件的请假（很多天数）', N'1564334153687', N'2', N'所有人可以审批', N'1564334138399', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":44,"top":27,"type":"start round mix","id":"1564334138399","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":295,"type":"end round","id":"1564334139783","width":26,"height":26,"alt":true},{"name":"所有人可以审批","left":163,"top":43,"type":"node","id":"1564334153687","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"小于3的test可以审批","left":23,"top":141,"type":"node","id":"1564334154471","width":167,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"大于3的admin可以审批","left":288,"top":146,"type":"node","id":"1564334155295","width":143,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"默认","left":171,"top":291,"type":"node","id":"1564334156607","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}}],"lines":[{"type":"sl","from":"1564334138399","to":"1564334153687","id":"1564334158551","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334153687","to":"1564334154471","id":"1564334159304","name":"","dash":false,"alt":true,"Compares":[{"FieldName":"DAYS","Operation":"<","Value":"3"}]},{"type":"sl","from":"1564334153687","to":"1564334155295","id":"1564334160383","name":"","dash":false,"alt":true,"Compares":[{"FieldName":"DAYS","Operation":">=","Value":"3"}]},{"type":"sl","from":"1564334154471","to":"1564334156607","id":"1564334161911","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334155295","to":"1564334156607","id":"1564334163959","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334156607","to":"1564334139783","id":"1564334165255","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', N'', N'{"REASON":"身体原因","DAYS":"5","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:24:52.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'1', NULL)
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'ee589689-3ae0-4037-abec-ba70e566da16', N'', N'1564334720434', N'普通的请假2019-07-29 01:25:24', N'1564334035352', N'2', N'所有人可以审批', N'1564334032785', N'{"title":"newFlow_1","initNum":9,"lines":[{"id":"1564334041040","type":"sl","from":"1564334032785","to":"1564334035352","name":"","dash":false,"Compares":null},{"id":"1564334041720","type":"sl","from":"1564334035352","to":"1564334036152","name":"","dash":false,"Compares":null},{"id":"1564334042927","type":"sl","from":"1564334036152","to":"1564334038904","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564334032785","name":"node_1","type":"start round mix","left":19,"top":36,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564334035352","name":"所有人可以审批","type":"node","left":133,"top":50,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"http://xxxx.com/api/workflow/callback","NodeRejectType":null,"Taged":2,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"最近有很多事情要处理","TagedTime":"2019-07-29 01:28","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334036152","name":"所有人可以审批","type":"node","left":139,"top":123,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"ThirdPartyUrl":"","NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564334038904","name":"node_4","type":"end round","left":47,"top":193,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'61806396-9498-492b-bc22-9f9e95a389bc', N'', N'{"REASON":"身体原因","DAYS":"1","CUSTOME_NAME":"玉宝"}', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'', N'0', N'2019-07-29 01:25:30.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'3', N'1', NULL)
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

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'1ec9b89e-d909-430a-bb0f-2fcc2351d103', N'88156170-41a6-45d1-99dc-40dc37a82bc9', N'【创建】超级管理员创建了一个流程进程【1573007376219/按角色执行2019-11-06 10:31:28】', N'2019-11-06 10:31:35.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
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

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'1c4166e6-b981-465b-8feb-a5ff2c0fbebe', N'88156170-41a6-45d1-99dc-40dc37a82bc9', N'1564334327861', N'3', N'node_1', N'1564334332325', N'2', N'管理员', N'0', N'0', N'2019-11-06 10:31:35.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
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
  [ModifyUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [OrgId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
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
'MS_Description', N'所属部门',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme',
'COLUMN', N'OrgId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流模板信息表',
'SCHEMA', N'dbo',
'TABLE', N'FlowScheme'
GO


-- ----------------------------
-- Records of [FlowScheme]
-- ----------------------------
INSERT INTO [dbo].[FlowScheme]  VALUES (N'0b21f59c-7809-4275-acb4-8e8c08e0167e', N'1564334009729', N'按角色执行', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":99,"top":32,"type":"start round mix","id":"1564334327861","width":26,"height":26,"alt":true},{"name":"node_2","left":70,"top":295,"type":"end round","id":"1564334330157","width":26,"height":26,"alt":true},{"name":"管理员","left":43,"top":131,"type":"node","id":"1564334332325","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"测试人员","left":185,"top":226,"type":"node","id":"1564334333133","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":["0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}}],"lines":[{"type":"sl","from":"1564334327861","to":"1564334332325","id":"1564334335789","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334332325","to":"1564334333133","id":"1564334336629","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334333133","to":"1564334330157","id":"1564334337805","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'0', N'0', N'0', N'0', N'0', N'节点按指定的角色执行而不是指定的人', N'2019-07-29 01:19:25.000', N'', N'', N'2019-07-29 01:19:25.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'61806396-9498-492b-bc22-9f9e95a389bc', N'1564334009729', N'普通的请假', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":19,"top":36,"type":"start round mix","id":"1564334032785","width":26,"height":26,"alt":true},{"name":"所有人可以审批","left":133,"top":50,"type":"node","id":"1564334035352","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"http://xxxx.com/api/workflow/callback","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"所有人可以审批","left":139,"top":123,"type":"node","id":"1564334036152","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_4","left":47,"top":193,"type":"end round","id":"1564334038904","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334032785","to":"1564334035352","id":"1564334041040","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334035352","to":"1564334036152","id":"1564334041720","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334036152","to":"1564334038904","id":"1564334042927","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'0', N'0', N'0', N'0', N'0', N'非常简单的请假流程', N'2019-07-29 01:14:48.000', N'', N'', N'2019-07-29 01:14:48.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'73819920-f085-4003-8874-4361b6461c92', N'1564334009729', N'会签', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":17,"top":12,"type":"start round mix","id":"1564334430924","width":26,"height":26,"alt":true},{"name":"node_2","left":141,"top":49,"type":"node","id":"1564334435460","width":104,"height":26,"alt":true},{"name":"会签入口，设置会签类型","left":141,"top":138,"type":"fork","id":"1564334437844","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"admin","left":23,"top":272,"type":"node","id":"1564334439828","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"test","left":234,"top":265,"type":"node","id":"1564334440404","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"默认所有人","left":140,"top":406,"type":"join","id":"1564334441965","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_7","left":351,"top":420,"type":"end round","id":"1564334444885","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334430924","to":"1564334435460","id":"1564334446774","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334435460","to":"1564334437844","id":"1564334447796","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334439828","id":"1564334448572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334437844","to":"1564334440404","id":"1564334449628","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334439828","to":"1564334441965","id":"1564334450572","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334440404","to":"1564334441965","id":"1564334451684","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334441965","to":"1564334444885","id":"1564334453900","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'0', N'0', N'0', N'0', N'0', N'需要多人审批的流程，比如需要多人全部批准该步骤才能通过，或至少有一个通过', N'2019-07-29 01:22:03.000', N'', N'', N'2019-07-29 01:22:03.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'989bd1f3-29f0-43cd-ad01-b55654907dbb', N'1564334009729', N'带复杂表单的', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":66,"top":46,"type":"start round mix","id":"1564334555981","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":145,"type":"node","id":"1564334557205","width":104,"height":26,"alt":true},{"name":"node_3","left":56,"top":206,"type":"node","id":"1564334557764","width":104,"height":26,"alt":true},{"name":"node_4","left":66,"top":294,"type":"end round","id":"1564334559716","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564334555981","to":"1564334557205","id":"1564334561500","name":"","dash":false},{"type":"sl","from":"1564334557205","to":"1564334557764","id":"1564334562229","name":"","dash":false},{"type":"sl","from":"1564334557764","to":"1564334559716","id":"1564334563268","name":"","dash":false}],"areas":[],"initNum":8}', N'8faff4e5-b729-44d2-ac26-e899a228f63d', N'1', N'0', N'0', N'0', N'0', N'这是一个带有复杂表单的流程，比如需要上传文件', N'2019-07-29 01:22:45.000', N'', N'', N'2019-10-29 17:25:20.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'f11b7ef6-6da4-4cef-9e71-5e4e1454f30a', N'1584630699021', N'【研发小组】考核表', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":116,"top":70,"type":"start round mix","id":"1584630766237","width":26,"height":26,"alt":true},{"name":"node_2","left":118,"top":148,"type":"node","id":"1584630767445","width":104,"height":26,"alt":true,"setInfo":{"NodeName":"node_2","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","NodeConfluenceType":"all","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[],"orgs":[]}}},{"name":"node_3","left":69,"top":223,"type":"end round","id":"1584630769587","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1584630766237","to":"1584630767445","id":"1584630772227","name":"","dash":false,"alt":true},{"type":"sl","from":"1584630767445","to":"1584630769587","id":"1584630773305","name":"","dash":false,"alt":true}],"areas":[],"initNum":7}', N'0411376a-18fd-4f52-bffb-22ae0d3fa21d', N'0', N'0', N'1', N'0', N'0', N'只有可以看到【研发小组】的【管理员】才能看到', N'2020-03-19 23:13:03.027', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'2020-03-19 23:13:03.027', N'', N'', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'bfd4f0f9-6f61-4af9-977e-cbcf7c30dd35', N'1564334009729', N'带分支条件的请假', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":44,"top":27,"type":"start round mix","id":"1564334138399","width":26,"height":26,"alt":true},{"name":"node_2","left":50,"top":295,"type":"end round","id":"1564334139783","width":26,"height":26,"alt":true},{"name":"所有人可以审批","left":163,"top":43,"type":"node","id":"1564334153687","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"小于3的test可以审批","left":23,"top":141,"type":"node","id":"1564334154471","width":167,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"大于3的admin可以审批","left":288,"top":146,"type":"node","id":"1564334155295","width":143,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"默认","left":171,"top":291,"type":"node","id":"1564334156607","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[]}}}],"lines":[{"type":"sl","from":"1564334138399","to":"1564334153687","id":"1564334158551","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334153687","to":"1564334154471","id":"1564334159304","name":"","dash":false,"alt":true,"Compares":[{"FieldName":"DAYS","Operation":"<","Value":"3"}]},{"type":"sl","from":"1564334153687","to":"1564334155295","id":"1564334160383","name":"","dash":false,"alt":true,"Compares":[{"FieldName":"DAYS","Operation":">=","Value":"3"}]},{"type":"sl","from":"1564334154471","to":"1564334156607","id":"1564334161911","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334155295","to":"1564334156607","id":"1564334163959","name":"","dash":false,"alt":true},{"type":"sl","from":"1564334156607","to":"1564334139783","id":"1564334165255","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'0', N'0', N'0', N'0', N'0', N'在连接线上可以设置分支条件', N'2019-07-29 01:17:46.000', N'', N'', N'2019-07-29 01:17:46.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'7831e5d0-0ecf-4539-99bc-cd7ecfc8f88f', N'1584630806811', N'【研发小组】爱好调研', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":47,"top":23,"type":"start round mix","id":"1584630842462","width":26,"height":26,"alt":true},{"name":"node_2","left":74,"top":102,"type":"node","id":"1584630843608","width":104,"height":26,"alt":true,"setInfo":{"NodeName":"node_2","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","NodeConfluenceType":"all","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[],"orgs":[]}}},{"name":"node_3","left":41,"top":179,"type":"end round","id":"1584630845368","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1584630842462","to":"1584630843608","id":"1584630846980","name":"","dash":false,"alt":true},{"type":"sl","from":"1584630843608","to":"1584630845368","id":"1584630847962","name":"","dash":false,"alt":true}],"areas":[],"initNum":7}', N'0411376a-18fd-4f52-bffb-22ae0d3fa21d', N'0', N'0', N'1', N'0', N'0', N'只有【test】账号或可以看到【研发小组】的【管理员】才能看到', N'2020-03-19 23:14:13.657', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2020-03-19 23:14:13.657', N'', N'', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'fb1f3cac-a259-4969-9171-addbe22ab102', N'1584631233711', N'【研发小组】高层汇报', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":52,"top":43,"type":"start round mix","id":"1584631275414","width":26,"height":26,"alt":true},{"name":"node_2","left":57,"top":113,"type":"node","id":"1584631276803","width":104,"height":26,"alt":true,"setInfo":{"NodeName":"node_2","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","NodeConfluenceType":"all","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[],"orgs":[]}}},{"name":"node_3","left":60,"top":192,"type":"end round","id":"1584631278737","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1584631275414","to":"1584631276803","id":"1584631280569","name":"","dash":false,"alt":true},{"type":"sl","from":"1584631276803","to":"1584631278737","id":"1584631281701","name":"","dash":false,"alt":true}],"areas":[],"initNum":7}', N'0411376a-18fd-4f52-bffb-22ae0d3fa21d', N'0', N'0', N'1', N'0', N'0', N'只有可以看到【研发小组】的【管理员】才能看到', N'2020-03-19 23:21:43.270', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'2020-03-19 23:21:43.270', N'', N'', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'1648a05b-013c-4dd0-8ecb-5695d08fb8f4', N'1584630870659', N'【研发小组】测试申请', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":44,"top":49,"type":"start round mix","id":"1584630893821","width":26,"height":26,"alt":true},{"name":"node_2","left":58,"top":120,"type":"node","id":"1584630895194","width":104,"height":26,"alt":true,"setInfo":{"NodeName":"node_2","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","NodeConfluenceType":"all","ThirdPartyUrl":"","NodeDesignateData":{"users":[],"roles":[],"orgs":[]}}},{"name":"node_3","left":42,"top":219,"type":"end round","id":"1584630896886","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1584630893821","to":"1584630895194","id":"1584630898567","name":"","dash":false,"alt":true},{"type":"sl","from":"1584630895194","to":"1584630896886","id":"1584630899588","name":"","dash":false,"alt":true}],"areas":[],"initNum":7}', N'0411376a-18fd-4f52-bffb-22ae0d3fa21d', N'0', N'0', N'1', N'0', N'0', N'只有【test3】账号或可以看到【研发小组】的【管理员】才能看到', N'2020-03-19 23:15:03.490', N'229f3a49-ab27-49ce-b383-9f10ca23a9d5', N'test3', N'2020-03-19 23:15:03.490', N'', N'', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b')
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
  [ModifyUserName] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [OrgId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
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
'MS_Description', N'所属部门',
'SCHEMA', N'dbo',
'TABLE', N'Form',
'COLUMN', N'OrgId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单模板表',
'SCHEMA', N'dbo',
'TABLE', N'Form'
GO


-- ----------------------------
-- Records of [Form]
-- ----------------------------
INSERT INTO [dbo].[Form]  VALUES (N'8faff4e5-b729-44d2-ac26-e899a228f63d', N'系统内置的复杂请假条表单', N'1', N'FrmLeaveReq', N'0', N'', N'', N'', N'0', N'0', N'', N'0', N'企业版内置的复杂请假条表单', N'2019-07-29 01:03:36.000', N'', N'', N'2019-07-29 01:03:36.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[Form]  VALUES (N'b08bb00f-e1df-44f8-904f-58ee5b1f4eb4', N'领料单', N'0', N'', N'0', N'[{"leipiplugins":"select","name":"TOOLS","title":"TOOLS","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机,签字笔","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option><option value=\"签字笔\">签字笔</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"},{"name":"APPLY_REASON","title":"APPLY_REASON","leipiplugins":"textarea","value":"","orgrich":"0","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width:300px;height:80px;","content":"<textarea title=\"APPLY_REASON\" name=\"leipiNewField\" leipiplugins=\"textarea\" value=\"\" orgrich=\"0\" orgfontsize=\"\" orgwidth=\"300\" orgheight=\"80\" style=\"width:300px;height:80px;\"></textarea>"},{"leipiplugins":"checkboxs","name":"","title":"NEEDRETURN","parse_name":"checkboxs_0","value":"归还,无需归还","content":"<span leipiplugins=\"checkboxs\"  title=\"NEEDRETURN\"><input type=\"checkbox\" name=\"leipiNewField\" value=\"归还\"  checked=\"checked\"/>归还&nbsp;<input type=\"checkbox\" name=\"leipiNewField\" value=\"无需归还\"  />无需归还&nbsp;</span>","options":[{"name":"leipiNewField","value":"归还","checked":"checked","type":"checkbox"},{"name":"leipiNewField","value":"无需归还","type":"checkbox"}]}]', N'<p style="text-align: center;"><span style="font-size: 36px;">领料单</span></p><p><span style="font-size: 36px;"><br/></span></p><table data-sort="sortDisabled"><tbody><tr class="firstRow"><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">名目</span></td><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">数量</span></td><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">说明</span></td></tr><tr><td width="534" valign="top">{TOOLS}</td><td width="534" valign="top">{NUMBERS}</td><td width="534" valign="top">{APPLY_REASON}</td></tr><tr><td valign="top" rowspan="1" colspan="3" style="word-break: break-all;">{checkboxs_0}</td></tr></tbody></table><p style="text-align: center;"><br/></p>', N'<p style="text-align: center;"><span style="font-size: 36px;">领料单</span></p><p><span style="font-size: 36px;"><br/></span></p><table data-sort="sortDisabled"><tbody><tr class="firstRow"><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">名目</span></td><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">数量</span></td><td width="534" valign="top" style="word-break: break-all;"><span style="font-size: 24px;">说明</span></td></tr><tr><td width="534" valign="top">{|-<span leipiplugins="select"><select name="leipiNewField" title="TOOLS" leipiplugins="select" size="1" orgwidth="150" style="width: 150px;"><option value="电脑" selected="selected">电脑</option><option value="平板">平板</option><option value="手机">手机</option><option value="签字笔">签字笔</option></select>&nbsp;&nbsp;</span>-|}</td><td width="534" valign="top"><input name="leipiNewField" type="text" title="NUMBERS" value="1" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="int" style="text-align: left; width: 150px;"/></td><td width="534" valign="top"><textarea title="APPLY_REASON" name="leipiNewField" leipiplugins="textarea" value="" orgrich="0" orgfontsize="" orgwidth="300" orgheight="80" style="width:300px;height:80px;"></textarea></td></tr><tr><td valign="top" rowspan="1" colspan="3" style="word-break: break-all;">{|-<span leipiplugins="checkboxs"  title="NEEDRETURN"><input type="checkbox" name="leipiNewField" value="归还"  checked="checked"/>归还&nbsp;<input type="checkbox" name="leipiNewField" value="无需归还"  />无需归还&nbsp;</span>-|}</td></tr></tbody></table><p style="text-align: center;"><br/></p>', N'0', N'0', N'', N'0', N'带有选择框文本框复选框等的领料单据', N'2019-07-29 01:13:02.000', N'', N'', N'2019-07-29 01:13:02.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[Form]  VALUES (N'ef89f96a-af33-407c-b02e-897faf46ecf0', N'请假条表单', N'0', N'', N'0', N'[{"type":"text","name":"REASON","title":"REASON","value":"身体原因","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"REASON\" value=\"身体原因\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"leipiplugins":"select","name":"DAYS","title":"DAYS","size":"1","orgwidth":"150","style":"width: 150px;","value":"1,3,5,10","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"leipiNewField\" title=\"DAYS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"1\" selected=\"selected\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"type":"text","name":"CUSTOME_NAME","title":"CUSTOME_NAME","value":"玉宝","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"CUSTOME_NAME\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因{REASON}，本人想请假{DAYS}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：{CUSTOME_NAME}</p>', N'<p style="text-align: center;"><span style="font-size: 36px;">请假条</span></p><p><span style="font-size: 36px;"><br/></span></p><p style="text-align: center;">因<input name="leipiNewField" type="text" title="REASON" value="身体原因" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="text" style="text-align: left; width: 150px;"/>，本人想请假{|-<span leipiplugins="select"><select name="leipiNewField" title="DAYS" leipiplugins="select" size="1" orgwidth="150" style="width: 150px;"><option value="1" selected="selected">1</option><option value="3">3</option><option value="5">5</option><option value="10">10</option></select>&nbsp;&nbsp;</span>-|}天，望领导批准！</p><p><br/></p><p style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;谢谢！</p><p><br/></p><p style="text-align: right;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 申请人：<input name="leipiNewField" type="text" title="CUSTOME_NAME" value="玉宝" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="text" style="text-align: left; width: 150px;"/></p>', N'0', N'0', N'', N'0', N'带有选择框文本框的请假条', N'2019-07-29 01:07:03.000', N'', N'', N'2019-07-29 01:07:03.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[Form]  VALUES (N'febe218d-21a6-44b6-b7ce-b83e73556ad9', N'审批流程', N'0', N'FrmLeaveReq', N'0', N'[{"type":"text","name":"姓名","title":"姓名","value":"","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"姓名\" value=\"\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p>{姓名}</p>', N'<p><input name="leipiNewField" type="text" title="姓名" value="" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="text" style="text-align: left; width: 150px;"/></p>', N'0', N'0', N'', N'0', N'', N'2019-10-29 13:57:35.000', N'', N'', N'2019-10-29 13:57:35.000', N'', N'', NULL)
GO

INSERT INTO [dbo].[Form]  VALUES (N'0411376a-18fd-4f52-bffb-22ae0d3fa21d', N'【研发小组】新人报到', N'0', N'', N'0', N'[{"type":"text","name":"USERNAME","title":"USERNAME","value":"","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"USERNAME\" value=\"\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p>你的姓名：{USERNAME}</p>', N'<p>你的姓名：<input name="leipiNewField" type="text" title="USERNAME" value="" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="text" style="text-align: left; width: 150px;"/></p>', N'1', N'0', NULL, N'0', N'这个表单只有【研发小组】权限的人可以看到', N'2020-03-18 22:56:01.550', N'', N'', N'2020-03-18 22:56:44.100', N'', N'', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b')
GO

INSERT INTO [dbo].[Form]  VALUES (N'318bb233-c9df-4374-9937-e55b71fbcf99', N'【西南片区】报道', N'0', N'', N'0', N'[{"type":"text","name":"USERNAME","title":"USERNAME","value":"","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"USERNAME\" value=\"\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p>{USERNAME}，欢迎来到西南大区</p>', N'<p><input name="leipiNewField" type="text" title="USERNAME" value="" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="text" style="text-align: left; width: 150px;"/>，欢迎来到西南大区</p>', N'1', N'0', NULL, N'0', N'只有可以访问【西南片区】的用户可以看到', N'2020-03-18 22:58:43.990', N'', N'', N'2020-03-18 22:58:43.990', N'', N'', N'60620558-89a2-4b28-8637-52f514773725')
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
INSERT INTO [dbo].[Module]  VALUES (N'0031262c-689c-4b96-bae2-2c9d67076ade', N'.0.1.9.', N'流程设计', N'/flowSchemes/index', N'', N'0', N'0', N'layui-icon-engine', N'0', N'基础配置', N'', N'6', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'FlowScheme', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'.0.2.', N'流程中心', N'/', N'', N'0', N'0', N'layui-icon-senior', N'0', N'根节点', N'', N'3', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9', N'.0.4.', N'仓储中心', N'/', N'', N'0', N'0', N'', N'0', N'根节点', N'', N'2', NULL, N'', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'37bb9414-19a0-4223-9056-71f8c758a930', N'.0.2.5.', N'已处理流程', N'/flowinstances/disposed', N'', N'0', N'0', N'layui-icon-ok-circle', N'0', N'流程中心', N'', N'3', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstanceDisposed', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'.0.2.6.', N'待处理流程', N'/flowinstances/wait', N'', N'0', N'0', N'layui-icon-help', N'0', N'流程中心', N'', N'1', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstanceWait', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', N'.0.1.10.', N'部门管理', N'/OrgManager/Index', N'', N'0', N'0', N'layui-icon-group', N'0', N'基础配置', N'', N'4', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Org', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'7580672f-a390-4bb6-982d-9a4570cb5199', N'.0.1.', N'基础配置', N' /', N'', N'0', N'0', N'layui-icon-set-fill', N'0', N'根节点', N'', N'1', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'7bc7e527-478d-49fd-868d-5f31951586f5', N'.0.3.1.', N'系统日志', N'/SysLogs/Index', N'', N'0', N'0', N'layui-icon-theme', N'0', N'消息日志', N'', N'1', N'b19bce90-5508-43b6-93ed-cd9ff9e356a9', N'SysLog', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'7bc7e527-478d-49fd-868d-5f31951586f6', N'.0.3.2.', N'我的消息', N'/SysMessages/Index', N'', N'0', N'0', N'layui-icon-theme', N'0', N'消息日志', N'', N'2', N'b19bce90-5508-43b6-93ed-cd9ff9e356a9', N'SysMessage', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'907a24c6-3c95-4073-8f90-ea7ec42c63f7', N'.0.1.19.', N'定时任务', N'/OpenJobs/Index', N'', N'0', N'0', N'layui-icon-time', N'0', N'基础配置', N'', N'2', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'OpenJob', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'92b00259-2d15-43e7-9321-adffb29e8bf2', N'.0.1.11.', N'表单设计', N'/forms/index', N'', N'0', N'0', N'layui-icon-theme', N'0', N'基础配置', N'', N'5', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Form', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'.0.2.7.', N'我的流程', N'/flowInstances/Index', N'', N'0', N'0', N'layui-icon-share', N'0', N'流程中心', N'', N'2', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstance', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'98a949e8-8704-40a7-b9a1-c0e8801e4057', N'.0.4.1.', N'入库订单', N'/wmsinboundordertbls/index', N'', N'0', N'0', N'', N'0', N'仓储中心', N'', N'1', N'15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9', N'WmsInboundOrderTbl', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'9a87c0fa-9172-42a1-9505-7492433dcb8e', N'.0.1.16.', N'数据权限', N'/dataprivilegerules/index', N'', N'0', N'0', N'layui-icon-auz', N'0', N'基础配置', N'', N'1', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'DataPrivilegeRule', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'.0.1.17.', N'字典分类', N'/Categories/Index', N'', N'0', N'0', N'', N'0', N'基础配置', N'', N'7', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Category', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'b19bce90-5508-43b6-93ed-cd9ff9e356a9', N'.0.3.', N'消息日志', N' /', N'', N'0', N'0', N'layui-icon-set-fill', N'0', N'根节点', N'', N'4', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'bc80478d-0547-4437-9cff-be4b40144bdf', N'.0.1.13.', N'模块管理', N'/ModuleManager/Index', N'', N'0', N'0', N'layui-icon-tabs', N'0', N'基础配置', N'', N'1', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Module', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'bedb41a2-f310-4775-af99-01be08adda93', N'.0.1.14.', N'角色管理', N'/RoleManager/Index', N'', N'0', N'0', N'layui-icon-user', N'0', N'基础配置', N'', N'2', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Role', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', N'.0.1.3.', N'资源管理', N'/Resources/Index', N'', N'0', N'0', N'layui-icon-cellphone', N'0', N'基础配置', N'', N'8', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Resource', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', N'.0.1.15.', N'用户管理', N'/UserManager/Index', N'', N'0', N'0', N'layui-icon-friends', N'0', N'基础配置', N'', N'3', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'User', N'1')
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
INSERT INTO [dbo].[ModuleElement]  VALUES (N'054e9699-7828-4b8b-a28b-d7ae45ed3306', N'btnEdit', N'编辑', N'', N'', N'layui-icon-edit', N'layui-btn-normal', N'', N'2', N'98a949e8-8704-40a7-b9a1-c0e8801e4057', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'06fe4738-b4f4-4ecf-b9da-07dd3bb26cb3', N'btnDel', N'撤销订单', N'', N'', N'layui-icon-delete', N'layui-btn-danger', N'', N'3', N'98a949e8-8704-40a7-b9a1-c0e8801e4057', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'0d25438e-1436-48e0-aedf-0f1690693281', N'btnRoleAccessUser', N'添加角色用户', N'', N'assignRoleUser(this)', N'layui-icon-search', N'layui-btn-normal', N'添加角色用户', N'4', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

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

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1a473afd-cbd4-41e9-9471-81f9435aaabe', N'btnEdit', N'编辑', N' ', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑分类', N'2', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1c870438-4260-43a5-8996-a6e1dc8bbf6a', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加部门', N'0', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1c870438-4260-43a5-8996-a6e1dc8bbf6b', N'btnAssignOrgUser', N'分配用户', N'', N'assignOrgUser(this)', N'layui-icon-add-1', N'layui-btn-normal', N'分配用户', N'0', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑角色', N'1', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加分类', N'1', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'2d595a2a-5de5-479e-a331-b53c799a6b11', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加定时任务', N'1', N'907a24c6-3c95-4073-8f90-ea7ec42c63f7', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'2feefce1-e3d8-42ac-b811-2352679628da', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'刪除用戶', N'2', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'2feefce1-e3d8-42ac-b811-2352679628dd', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'刪除定时任务', N'3', N'907a24c6-3c95-4073-8f90-ea7ec42c63f7', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'34730f5a-d307-457b-9041-5f7de30abfa9', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑用户', N'1', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'34730f5a-d307-457b-9041-5f7de30abfaa', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑定时任务', N'2', N'907a24c6-3c95-4073-8f90-ea7ec42c63f7', NULL, NULL)
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

INSERT INTO [dbo].[ModuleElement]  VALUES (N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'btnVerification', N'处理', N'', N'verificationForm()', N'layui-icon-triangle-r', N'layui-btn-normal', N'', N'1', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除部门', N'2', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'7f071c63-1620-4486-9264-5806b2e63218', N'btnAccessRole', N'为用户分配角色', N'', N'openUserRoleAccess(this)', N'layui-icon-search', N'layui-btn-normal', N'为用户分配角色', N'5', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'816b12b3-e916-446d-a2fa-329cfd13c831', N'btnDetail', N'进度详情', N'', N'', N'layui-icon-search', N'layui-btn-normal', N'', N'4', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'81ce1abe-209d-4e4c-a8d2-efbc6a3b45ba', N'btnAdd', N'添加', N'', N'', N'layui-icon-add-1', N'layui-btn-normal', N'', N'1', N'9a87c0fa-9172-42a1-9505-7492433dcb8e', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'826b12b3-e916-446d-a2fa-329cfd13c831', N'btnDetail', N'进度详情', N'', N'', N'layui-icon-search', N'layui-btn-normal', N'', N'2', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'84694ea5-d6e1-4a65-8a59-7b5b779688d4', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加模块', N'1', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', N'btnDel', N'删除', N' ', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除分类', N'3', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
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

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c35d8f5b-0d38-4f31-84f9-39e476eeab08', N'btnAdd', N'新订单', N'', N'', N'layui-icon-add-1', N'layui-btn-normal', N'', N'1', N'98a949e8-8704-40a7-b9a1-c0e8801e4057', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'btnRefresh', N'刷新', N'', N'refresh()', N'layui-icon-refresh', N'layui-btn-normal', N'刷新分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除进出库', N'0', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c7d7daf0-3669-4a22-8bed-b092617deb9c', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除资源', N'3', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a', N'btnRefresh', N'刷新', N'', N'refresh()', N'layui-icon-refresh', N'layui-btn-normal', N'刷新用户', N'3', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'd352c8ee-3dff-4d28-a0de-903ae68f2533', N'btnPreview', N'预览', N'', N'preview()', N'layui-icon-cellphone', N'layui-btn-normal', N'', N'3', N'0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'daddf3b9-71b5-45ac-b85d-5a11c522f2f4', N'btnDel', N'删除', N' ', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除模块', N'3', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'ef42721f-d223-4a00-a1d9-80b81121f21a', N'btnEdit', N'编辑', N' ', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑部门', N'1', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'f8dde22a-2a37-47c4-8e67-70fb3af5303e', N'btnRefresh', N'刷新', N'', N'refresh()', N'layui-icon-refresh', N'layui-btn-normal', N'刷新部门', N'3', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO


-- ----------------------------
-- Table structure for OpenJob
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenJob]') AND type IN ('U'))
	DROP TABLE [dbo].[OpenJob]
GO

CREATE TABLE [dbo].[OpenJob] (
  [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [JobName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [RunCount] int DEFAULT ((0)) NOT NULL,
  [ErrorCount] int DEFAULT ((0)) NOT NULL,
  [NextRunTime] datetime NULL,
  [LastRunTime] datetime NULL,
  [LastErrorTime] datetime NULL,
  [JobType] int DEFAULT ((0)) NOT NULL,
  [JobCall] varchar(500) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [JobCallParams] varchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [Cron] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [Status] int DEFAULT ((0)) NOT NULL,
  [Remark] varchar(128) COLLATE Chinese_PRC_CI_AS NULL,
  [CreateTime] datetime DEFAULT (getdate()) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [OrgId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[OpenJob] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'Id',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'JobName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务执行次数',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'RunCount'
GO

EXEC sp_addextendedproperty
'MS_Description', N'异常次数',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'ErrorCount'
GO

EXEC sp_addextendedproperty
'MS_Description', N'下次执行时间',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'NextRunTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后一次执行时间',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'LastRunTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后一次失败时间',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'LastErrorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务执行方式0：本地任务；1：外部接口任务',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'JobType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务地址',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'JobCall'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务参数，JSON格式',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'JobCallParams'
GO

EXEC sp_addextendedproperty
'MS_Description', N'CRON表达式',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'Cron'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务运行状态（0：停止，1：正在运行，2：暂停）',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'Remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'CreateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人ID',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'CreateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'CreateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'UpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人ID',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'UpdateUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新人',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'UpdateUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属部门',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob',
'COLUMN', N'OrgId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'定时任务',
'SCHEMA', N'dbo',
'TABLE', N'OpenJob'
GO


-- ----------------------------
-- Records of [OpenJob]
-- ----------------------------
INSERT INTO [dbo].[OpenJob]  VALUES (N'f40fe48d-71a4-4f47-b324-6178d97abfb9', N'定时日志任务', N'0', N'0', N'2020-04-25 12:16:19.767', N'2020-04-25 12:16:19.767', N'2020-04-25 12:16:19.767', N'0', N'OpenAuth.App.Jobs.SysLogJob', N'null', N'0/10 * * * * ?', N'0', N'这是个每10秒运行一次的任务，可以在系统日志中查看运行结果', N'2020-04-25 12:16:19.770', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2020-04-25 19:31:37.503', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'')
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
INSERT INTO [dbo].[Org]  VALUES (N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'.0.1.4.1.', N'研发小组', N'', N'汇丰软件部', N'0', N'0', N'', N'0', N'0', N'', N'2016-10-14 11:40:31.000', N'0', N'1', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'182dac38-64a0-414c-990c-7c9b7558a367', N'.0.4.', N'中部片区', N'', N'根节点', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:52:38.000', N'0', N'0', NULL, N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'1b965fff-3dcd-42ff-9624-2c8eb4f9b1c6', N'.0.5.1.', N'广州营销中心', N'', N'华南片区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:56:39.000', N'0', N'0', N'8e31553c-cab8-4eb3-90b5-5f8ff1d21801', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'2089637b-403d-4d4d-91ff-c8a554973f96', N'.0.4.1.', N'海外市场部', N'', N'中部片区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:53:54.000', N'0', N'0', N'182dac38-64a0-414c-990c-7c9b7558a367', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'3d2ad14c-2c56-4a90-a2db-6bde26b0b8b3', N'.0.3.1.', N'成都营销中心', N'', N'西南片区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:55:42.000', N'0', N'0', N'60620558-89a2-4b28-8637-52f514773725', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'4a3920f1-1470-477e-97ec-0996eb83b638', N'.0.1.6.', N'市场2部', N'', N'总部大区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:55:07.000', N'0', N'0', N'543a9fcf-4770-4fd9-865f-030e562be238', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'543a9fcf-4770-4fd9-865f-030e562be238', N'.0.1.', N'总部大区', N'', N'根节点', N'0', N'0', N'', N'0', N'0', N'', N'2016-10-14 11:37:13.000', N'0', N'0', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'60620558-89a2-4b28-8637-52f514773725', N'.0.3.', N'西南片区', N'', N'根节点', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:52:30.000', N'0', N'0', NULL, N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'66386671-0494-4e83-8346-fbcf73283f7b', N'.0.2.', N'华东片区', N'', N'根节点', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:52:19.000', N'0', N'0', NULL, N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'8047e605-c54a-48bd-81da-daa9c1fc9091', N'.0.4.2.', N'郑州营销中心', N'', N'中部片区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:54:50.000', N'0', N'0', N'182dac38-64a0-414c-990c-7c9b7558a367', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'86449128-d5ac-44bf-b999-f7735b7458fd', N'.0.1.4.', N'软件部', N'', N'总部大区', N'0', N'0', N'', N'1', N'0', N'', N'2016-05-26 15:11:03.000', N'0', N'1', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'8e31553c-cab8-4eb3-90b5-5f8ff1d21801', N'.0.5.', N'华南片区', N'', N'根节点', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:52:55.000', N'0', N'0', NULL, N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'9cd918bf-28bc-44de-8e07-23cacbb67f42', N'.0.1.7.', N'总经办', N'', N'总部大区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:57:40.000', N'0', N'0', N'543a9fcf-4770-4fd9-865f-030e562be238', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'b2083488-64e5-44cc-b8f4-929ffa6f2f72', N'.0.2.1.', N'上海VIP中心', N'', N'华东片区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:56:25.000', N'0', N'0', N'66386671-0494-4e83-8346-fbcf73283f7b', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'c36e43df-3a99-45da-80d9-3ac5d24f4014', N'.0.1.5.', N'市场1部', N'', N'总部大区', N'0', N'0', N'', N'0', N'0', N'', N'2016-05-26 15:10:40.000', N'0', N'1', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'c455d009-12d7-4c78-953f-264f0ca67a3d', N'.0.6.1.', N'天津营销中心', N'', N'华北片区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:56:54.000', N'0', N'0', N'eed8756d-587b-46de-96c7-0a400e3d80fa', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'ced1b2f0-4b53-44b8-9c42-a5d607ccc9c9', N'.0.1.8.', N'上市办', N'', N'总部大区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:57:53.000', N'0', N'0', N'543a9fcf-4770-4fd9-865f-030e562be238', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'df442c27-68a0-428e-a309-cba23a994a9d', N'.0.3.2.', N'重庆营销中心', N'', N'西南片区', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:56:06.000', N'0', N'0', N'60620558-89a2-4b28-8637-52f514773725', N'', N'')
GO

INSERT INTO [dbo].[Org]  VALUES (N'eed8756d-587b-46de-96c7-0a400e3d80fa', N'.0.6.', N'华北片区', N'', N'根节点', N'0', N'0', N'', N'0', N'', N'', N'2019-10-31 21:53:04.000', N'0', N'0', NULL, N'', N'')
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
INSERT INTO [dbo].[Relevance]  VALUES (N'00ae6b5c-21fa-4dc9-8ca4-7df669253255', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'01ba383d-fe81-473a-84a1-f64ce8a5aae5', N'', N'UserOrg', N'0', N'2019-10-31 21:50:42.000', N'', N'229f3a49-ab27-49ce-b383-9f10ca23a9d5', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'026ffa48-8cdf-4452-9ac7-b1b55e58e02a', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'c35d8f5b-0d38-4f31-84f9-39e476eeab08', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'032e20b6-7273-49f9-9b84-0040323114c0', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'CreateUserId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'03b55a9e-a44f-44fa-9383-4117bf8aba60', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'03be9b5e-38b0-4525-8431-b26d35ce6ce3', N'', N'UserElement', N'0', N'2016-09-07 15:30:43.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'054a8347-a62c-4e62-b9b2-0b2d14e9ff94', N'', N'RoleModule', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'06dfd97d-17e0-42b8-bde7-40006d8c8eb2', N'', N'UserElement', N'0', N'2018-04-06 14:50:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'06f4c4a2-faa8-4bad-9184-50ceb517f30b', N'', N'ProcessUser', N'0', N'2016-09-08 16:48:14.000', N'0', N'10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'077e24ab-4c48-4a5e-bfa9-90ea00449136', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:47.000', N'', N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'08ff97f7-17fc-4072-b29a-287135898ece', N'', N'RoleResource', N'0', N'2016-09-04 23:20:22.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'fdf3aac3-4507-40ad-aa2f-d7f0459de252', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0b3d3a9b-8a96-43d4-918c-fa7e3ea5f5ca', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:37.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0fd5b371-b010-4846-8833-95cc1e813a32', N'', N'UserElement', N'0', N'2016-09-07 15:31:16.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'10669494-70e2-4583-b5fd-191d7219b792', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:51:40.000', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'Resource', N'AppId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'109dcd85-9f50-4b7b-8615-c107496986ba', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'10a76196-ba0c-4294-bb8f-dcd063eb4aab', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'10e58d75-dec1-4b85-882f-9dac79ad1210', N'', N'RoleResource', N'0', N'2016-10-21 18:08:13.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'120d7a5d-203c-4261-95f5-0125757fb386', N'', N'UserElement', N'0', N'2016-10-20 17:01:01.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'12f282b5-e87f-416e-8a7c-f9830d115b9a', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'UpdateUserId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'13433400-a32c-4539-b988-8b417c09bc0e', N'', N'UserModule', N'0', N'2016-09-07 15:30:07.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'13612a4c-b20c-4bd0-a2cd-0ae47576364d', N'', N'UserElement', N'0', N'2016-10-20 16:34:12.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'148e317e-dacf-44b4-b3b8-7f68af74acdd', N'', N'RoleModule', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1490edd4-9bd3-4e71-bfa4-56f6558c1d3f', N'', N'UserElement', N'0', N'2018-04-06 09:48:24.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'15705855-3e8d-4404-98f4-59af683f20ce', N'', N'RoleModule', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'98a949e8-8704-40a7-b9a1-c0e8801e4057', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'15e66b55-cdce-47a1-9c08-21d5525524e8', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'0031262c-689c-4b96-bae2-2c9d67076ade', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'16154fc4-d18e-44a3-bcf2-5539b168aba7', N'', N'RoleElement', N'0', N'2016-10-24 17:25:15.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'18cc3217-28a6-49b2-9a20-080230065984', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1740ff26-a4d0-44cc-9fab-a0105c2c60b6', N'', N'UserOrg', N'0', N'2017-10-12 13:59:49.000', N'', N'63c9c82a-e0d3-4bde-bbd2-057cda2f5283', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'18389d29-c82d-4181-8ea0-1440ca1c2093', N'', N'RoleElement', N'0', N'2020-03-19 22:31:02.460', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'9e2c6754-f258-4b14-96a0-b9d981196a65', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'183905f3-620c-4995-aead-1e80c5899517', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:19:30.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1873ed85-a88a-4236-bd40-2c416aa2576c', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'18aa904d-6625-430d-9475-ec84d8c8e605', N'', N'RoleModule', N'0', N'2020-03-19 22:31:02.443', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'19c9621c-3d23-46b7-a841-54d5c82ec8e8', N'', N'UserOrg', N'0', N'2016-09-02 13:56:53.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1aaa04f0-bd9f-44a0-8bc2-3f7a74684c42', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:19:30.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'DtCode', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1acec4c4-0136-4e2b-a839-8676dbd6594a', N'', N'ProcessUser', N'0', N'2016-09-14 11:38:23.000', N'0', N'6c6afe3c-349c-4198-8710-cf19c90f3afd', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1ced1564-2fea-4c04-8aea-f071fa5bb293', N'', N'UserModule', N'0', N'2016-09-05 16:24:55.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1cf19b35-e2c2-436f-99b9-03ac2b232cc6', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'44075557-496e-4dde-bb75-7b69f51ab4fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1dca9a35-06e8-4275-8902-13c619880357', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'ScheduledInboundTime', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1e84dafd-3f4d-4b13-a738-2cf0c98e2351', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'AppId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1fb6b802-2a1f-49a8-b2fa-c5d223a8538c', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:51:40.000', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'Resource', N'UpdateTime', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2014027e-0cff-41cf-974b-56126d6eaa9a', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'224fa0b0-cdd6-47cf-89c5-45ad2a64bfd5', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'OrderType', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'23339fa0-94f4-4d35-a775-bda84d152841', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'242e9543-3343-41d4-8816-15ffeeaef551', N'', N'UserElement', N'0', N'2016-09-07 15:31:16.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'24dbc2ce-8474-463f-871b-96cb5edb9800', N'', N'RoleElement', N'0', N'2020-04-25 11:49:36.490', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'4770af29-1375-4d27-ab0c-fdbeab87b710', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'27c4d50c-32da-4dbc-88a1-84b343cdd649', N'', N'UserElement', N'0', N'2016-10-20 17:01:00.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'6839a297-350b-4215-b680-4e5dfdae5615', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'29b06cd6-af0c-4c63-9aba-e5431c5d62ec', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2a36a2b7-41aa-4190-b88c-75d44a56ad6e', N'', N'UserModule', N'0', N'2017-02-06 00:14:18.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2a818d22-1ca8-48e2-a2ed-3dbc3d05cc8b', N'', N'RoleElement', N'0', N'2020-04-25 11:49:11.127', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'5fba6316-5599-4245-822c-48ff33299868', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2a8a790f-0b9a-4ab3-8e4f-aae4bfddc609', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'PurchaseNo', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2bb3fddb-0f51-442e-8dbf-236beb47d8a6', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2c67ac44-5b67-4942-b457-2212e9a5dbf9', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2ca288a6-d222-4328-951e-c01c3e77a0c7', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2d0fcc88-a7c0-4d33-8a08-1d688e9dde83', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2d15e438-cc3a-41e9-9b13-325bfd5c804a', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2e1d286c-b771-43b0-947e-eeab185cc014', N'', N'RoleModule', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2ebff9a4-b2d5-4a35-a7dd-2cfa2f5b0522', N'', N'ProcessUser', N'0', N'2016-09-07 17:33:39.000', N'0', N'52cc7933-a045-4dcc-8c17-1b618bfa772b', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'30c82d18-7892-4e5f-9aee-e4f483a858c2', N'', N'UserModule', N'0', N'2016-09-05 16:24:55.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3225a4dc-c988-410c-8bcd-9afbccbafc09', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'332a373c-f485-4f85-9af9-7792f7462bf1', N'', N'RoleModule', N'0', N'2016-09-02 17:03:47.000', N'0', N'648b04c4-4ac2-4d69-bef6-07081ef27871', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'333771cf-7eab-4d57-988a-8bd934575558', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'OwnerId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'336b16ba-8313-4cb3-87d7-4370ff175c14', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Resource', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'33fa12d8-8e48-4d1c-9c84-50f533b682ec', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'CreateTime', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'340c60fe-8b95-474c-aa04-9197903998d2', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'361feb63-bde2-49c7-86ec-6df3ec6f0fe3', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1c870438-4260-43a5-8996-a6e1dc8bbf6a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'388f792e-dbd1-40a1-8374-9339e7e60d9e', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'UpdateTime', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3905b8a3-ed7e-4fe0-9e6d-747f6bc79235', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'TypeName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'392dc41e-7186-4efb-a8e5-b5317e4122fb', N'', N'RoleResource', N'0', N'2018-09-10 12:54:14.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3931d5b7-dde2-4530-bb2d-79b73f76e19b', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:19:30.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3aa0cdcb-ec57-420e-b1b0-eb4d77b8a8d5', N'', N'UserOrg', N'0', N'2020-03-19 21:20:04.110', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'86449128-d5ac-44bf-b999-f7735b7458fd', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3b4845a5-d7a2-4da7-b95c-43ad03980fda', N'', N'UserOrg', N'0', N'2020-03-19 21:20:04.110', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3bcaab20-e096-480e-a9bb-0fdb70686714', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3de0359b-6331-4dc7-a00e-751f71dbadb5', N'', N'ProcessUser', N'0', N'2016-09-28 09:23:30.000', N'0', N'68295d2a-4dfd-4c5e-81e3-9c787e2603bc', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4190f00a-11a0-4814-849b-cc5232fa4dd4', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'OPENAUTH_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'42ba8a59-5493-4e11-b61b-d87000092767', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4459ffd7-446b-456b-aee5-48e67ca000f8', N'', N'UserOrg', N'0', N'2019-10-31 21:51:45.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'456ddfed-6607-41e9-9c46-0d4c7c9c38d4', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'Status', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'45744773-1b85-4913-bc1b-2f00b95a8198', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'9e2c6754-f258-4b14-96a0-b9d981196a65', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'45dee058-6b62-4005-a134-dcf7c2781851', N'', N'RoleElement', N'0', N'2020-04-25 11:50:18.427', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'a6b61073-9e76-40ef-88ad-15c8789e2033', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'45e97612-46d8-4c36-b89e-ce6572ed7988', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'460d1c98-2a68-43cf-8d38-d40ceb89916f', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'465b8bc0-b817-410d-849e-55f66b2a3211', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'98a949e8-8704-40a7-b9a1-c0e8801e4057', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'471e98ee-9cc5-4dc7-8762-a452e855dbd5', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'CreateTime', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'4e693bbd-8ddb-42af-b888-30885612c154', N'', N'UserOrg', N'0', N'2019-10-31 21:58:43.000', N'', N'96f63f9d-e8c8-4258-963e-3327ed7d6f56', N'3d2ad14c-2c56-4a90-a2db-6bde26b0b8b3', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4ec39ee9-9ee9-4aa9-a0db-eb0fdf8d2f00', N'', N'UserElement', N'0', N'2018-04-06 09:48:27.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4ee89c07-55e2-4ca6-9ef1-449cfe0a2c3c', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4fde1dc6-9d73-4c7c-9238-28981858c5a6', N'', N'RoleModule', N'0', N'2016-09-05 09:21:56.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5167dbcd-3a32-4ae8-827e-6f381cc58fa2', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'fa816af1-a28d-47b5-9b8b-c46e18f902e9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'51c56567-bbf8-466e-8678-9b6bfb38c493', N'', N'RoleElement', N'0', N'2020-04-25 11:49:11.130', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'5fba6316-5599-4245-822c-48ff33299868', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'526d6f39-e75a-402b-8ba6-9bb08731da1e', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'CreateTime', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'53a4be87-4fa8-415b-97b5-2298ce8b17c8', N'', N'UserResource', N'0', N'2018-04-14 14:38:04.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'XXX_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'54b2e9b6-1f7c-4a39-92c9-98f58429c1fc', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'54eadc62-a77e-4baa-aa6d-34f5af2d6774', N'', N'RoleElement', N'0', N'2020-04-25 11:49:36.490', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'4770af29-1375-4d27-ab0c-fdbeab87b710', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'55b10ecc-3fb3-4127-b69e-e7a3467d7a1a', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'6db928fe-93df-460f-9472-8bb0b6cae52c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5725ff79-43c6-4778-bbff-131cf364dab6', N'', N'UserElement', N'0', N'2016-10-20 17:01:01.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'575221eb-0e4d-4cfa-9cd8-59607784d43d', N'', N'UserRole', N'0', N'2019-10-31 21:59:41.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5965ae4d-c718-421f-9895-fdf6255a002e', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'ReturnBoxNum', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'59c8b633-167e-47c1-bb63-837780ea93dc', N'', N'RoleModule', N'0', N'2020-04-25 11:48:19.567', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'5c55f7eb-4552-4610-a584-d72685f8d064', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5a20d59c-6ee6-4fe2-98fe-7b35b11026ae', N'', N'UserElement', N'0', N'2016-09-07 15:30:20.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5aa8ae27-e5b1-4f46-9342-73f1ba11c14c', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'826b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5b2d5db8-d603-4be3-add2-c85ef3c53ddc', N'', N'UserResource', N'0', N'2018-04-14 14:38:05.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5ccce632-f8f0-452b-8faf-4a5372004e85', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_CHECKUSER', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5f616264-84f0-42de-a84a-61d11f2f4786', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'4bfa8ea0-6b0d-426f-8687-b654575ca780', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5f8ac964-c87d-44c0-b780-c4c1382800ea', N'', N'RoleElement', N'0', N'2020-03-19 22:31:02.460', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'6c814946-db5c-48bd-84dd-b1c38196ad74', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'620b368a-7b56-4c74-ab85-8bc91d08ddc9', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'635779b1-f223-41f2-b9a4-7f35633008d7', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'18cc3217-28a6-49b2-9a20-080230065984', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6431a464-6f1f-4ffc-8157-89212b70f09a', N'', N'RoleOrg', N'0', N'2016-09-05 00:00:00.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'64e4f5aa-28ef-4690-9b20-5f0b543964f6', N'', N'UserElement', N'0', N'2016-09-07 15:30:20.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6532f9c1-3067-4952-b008-e766f833050e', N'', N'UserRole', N'0', N'2019-11-23 00:48:41.000', N'', N'96f63f9d-e8c8-4258-963e-3327ed7d6f56', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6552d053-69b3-4ae9-b1f2-497582dcb8aa', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6645b6fb-efcf-4e48-9c13-84f79bc5be34', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'66e25fc5-093d-42ab-85dc-a38f6600889b', N'', N'UserOrg', N'0', N'2016-09-02 13:57:32.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'67c502cf-c9bf-4ad3-b749-eda1c7f388e7', N'', N'RoleElement', N'0', N'2020-04-25 11:50:18.430', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'a6b61073-9e76-40ef-88ad-15c8789e2033', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'68912e65-256e-45b6-b48e-036382598d32', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:49.000', N'0', N'2eb423d6-6ad9-4efe-b423-872478a2a434', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'68984a83-ce96-4144-9e23-0e0f2249fb45', N'', N'UserOrg', N'0', N'2019-10-31 21:51:30.000', N'', N'de8be521-f1ec-4483-b124-0be342890507', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6a0d3b61-67d0-4090-a622-08d5643e1af8', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6a427baa-c54c-4830-a2fe-34e206f471c5', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6b9c4789-042c-4f6f-a749-ee68ee87462d', N'', N'ProcessUser', N'0', N'2016-10-27 16:47:52.000', N'0', N'054ff054-d8ae-4911-a596-8fb1f66b348f', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6d6eb70e-0caf-485f-943c-671be021a588', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'AppName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6da6d662-8cef-47cd-80b3-fa885b2dca7a', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6db5666b-6f8c-4e83-bada-0b45054bd9a4', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'0d25438e-1436-48e0-aedf-0f1690693282', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6fe52499-f800-47ce-96fc-a2b5b43505d5', N'', N'UserElement', N'0', N'2018-04-06 09:48:22.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7024c6fa-28d2-494f-93af-0651c690e063', N'', N'RoleModule', N'0', N'2020-04-25 11:48:19.567', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'5c55f7eb-4552-4610-a584-d72685f8d064', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7082bc48-535e-4b92-9dc0-c58340a8239d', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Resource', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'715d017a-68b6-468d-aa3f-32ca4cfd4b9e', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'71fa1d0c-1928-4a16-aa94-c92e6f671581', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:51:40.000', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'Resource', N'AppName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'72bf4729-af60-42f5-b0d7-717362ffad7f', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'2feefce1-e3d8-42ac-b811-2352679628da', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'736141c8-330b-4600-a781-8d0e7cdc01e5', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'SupplierId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'736e90f7-3747-472e-816d-dbb7fdf3b0bb', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:42.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'744da0ee-6c57-4bfc-9937-5ab799112996', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'7bc7e527-478d-49fd-868d-5f31951586f5', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7475b0c3-f204-4f95-a22f-80591fe76bc7', N'', N'ProcessUser', N'0', N'2016-10-31 11:52:39.000', N'0', N'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'75340ad3-fb80-4646-b1de-ba801688ddc2', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'5ed1681c-13d2-4c87-8675-a8d95c0b40ae', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'759c09ce-f93a-4de7-96fc-cffabc1cd1ac', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Resource', N'AppName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'76a5b31b-f855-416c-b7ce-4b9ff1cdb4bc', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'CreateUserName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'76e6629f-764f-4761-afd3-c41e0e9e4310', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'6c814946-db5c-48bd-84dd-b1c38196ad74', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77824f78-792b-4661-b7d9-653f6e0a443c', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'9c96e485-84a6-45f0-b6a7-f01dab94b0c6', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77ac794c-9142-443f-b19c-3b9d960c8ba4', N'', N'UserOrg', N'0', N'2019-10-31 21:51:45.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'86449128-d5ac-44bf-b999-f7735b7458fd', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77bd93da-2c2b-4ba8-bf05-3a1382811a6a', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77d25c9e-4773-4f95-8048-8d59398835f6', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'3dc0ec4d-bf86-4bae-9ec0-1d6c2403fb99', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77eec82a-f713-4584-872c-761fdbcdb456', N'', N'UserElement', N'0', N'2018-04-06 14:50:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77fc08e6-98ae-4d33-b294-bd9fed5b14ed', N'', N'UserElement', N'0', N'2018-04-06 14:50:36.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'797c6e5f-7f3c-4891-89b9-a054e10f6c00', N'', N'UserModule', N'0', N'2018-04-06 09:48:01.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'37bb9414-19a0-4223-9056-71f8c758a930', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7a22ccfc-5f4a-472b-850b-61b9552d7e67', N'', N'UserRole', N'0', N'2019-11-23 00:48:10.000', N'', N'229f3a49-ab27-49ce-b383-9f10ca23a9d5', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7ab6db05-1098-4134-b228-3329792dc6db', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:51:40.000', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'Resource', N'UpdateUserName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7b177a26-efdd-406b-8873-24f6565b121f', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'054e9699-7828-4b8b-a28b-d7ae45ed3306', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7c0e613e-2e8e-43e2-93af-cf38bfd56dcb', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'StockId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7d929ccc-4185-41d0-a81f-42fc0f27a85c', N'', N'RoleModule', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7d995d7b-5967-4bd0-a601-180925fe4a77', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7dcc9577-f27b-429f-8552-d223d4b48617', N'', N'UserRole', N'0', N'2019-10-31 21:59:41.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7e54557a-5f1d-494c-90c1-509525dd5c08', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7e8ce905-fa6e-490d-9d33-bde6b6529804', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:19:30.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7f25286f-246b-4143-98eb-c3e574fe7455', N'', N'ProcessUser', N'0', N'2016-09-07 17:33:39.000', N'0', N'52cc7933-a045-4dcc-8c17-1b618bfa772b', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7faeac11-cf1f-40aa-a6ad-2c7768106b9a', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'4f2737db-633f-4946-8a71-b08b9885f151', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7fd7f976-f10e-44aa-a7ba-7ca40d2e8f90', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'80310629-5e52-482c-9a0f-5c5bdfabcd9e', N'', N'RoleOrg', N'0', N'2016-09-05 00:00:00.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'832f4a8f-7791-4aa6-bcd2-20dcb6f5ef37', N'', N'UserElement', N'0', N'2016-09-02 14:53:04.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'84a52091-08a0-4a46-b661-3cd206771c29', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'854e0658-ab8a-4869-b157-9941955acdc6', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1a473afd-cbd4-41e9-9471-81f9435aaabe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'85b5f9e0-a4d2-4224-9488-c0fb98149f0b', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'88a4c966-d042-4a2e-b133-ff7eded1c5de', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'89ea1898-7649-4c3d-ae68-ace9bd9a316b', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8adae84f-6516-4d87-a476-353bc48ae597', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8af3581e-257f-4655-bac2-5b5afb85ef88', N'', N'UserOrg', N'0', N'2019-10-31 21:59:08.000', N'', N'758a34c7-5a31-438c-bdf7-02fdd846b901', N'b2083488-64e5-44cc-b8f4-929ffa6f2f72', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8b633f3c-965b-4e35-8496-c364890d7760', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8c93cb3c-b535-4ab1-af9e-b3ad50847423', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:51:40.000', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'Resource', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8e229d71-3b25-4efe-a2fe-829be732a1c6', N'', N'RoleElement', N'0', N'2020-04-25 11:49:11.133', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'5fba6316-5599-4245-822c-48ff33299868', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8f741d9e-e7f5-4b73-95f4-4b55e0cf6605', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'UpdateUserId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8fa4a52f-9c0a-43c9-9b7e-b378efb4e1df', N'', N'RoleResource', N'0', N'2018-09-10 12:54:14.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'90f19c4e-609f-4dc6-84f7-8b936be05568', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'928e8ddd-b990-471e-983d-f2dac77428d7', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'68484265-7802-4f06-b024-33e8b2f2edcf', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'92b2d699-9875-4978-af79-24c83ff4e212', N'', N'UserOrg', N'0', N'2019-10-31 21:58:43.000', N'', N'96f63f9d-e8c8-4258-963e-3327ed7d6f56', N'df442c27-68a0-428e-a309-cba23a994a9d', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'92f0b297-96c1-47d4-84dd-571374431bc0', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'84694ea5-d6e1-4a65-8a59-7b5b779688d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'93bcac7a-0ff1-488c-8d1c-3da7e44cbefc', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'95b51b38-177e-4e69-9265-d2c9fcd8b09a', N'', N'RoleElement', N'0', N'2020-04-25 11:50:18.433', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'a6b61073-9e76-40ef-88ad-15c8789e2033', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'960224e6-5910-472b-a5ef-b2aa9a8b106f', N'', N'UserRole', N'0', N'2016-09-06 17:06:15.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'962b278b-0894-4b36-b1a0-6c5c3d11d4c3', N'', N'UserElement', N'0', N'2018-04-06 14:50:17.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'965f010b-2fd6-4b34-ba23-3e44c1af2877', N'', N'RoleOrg', N'0', N'2016-09-08 16:19:18.000', N'0', N'36094f5d-07e7-40d5-91dc-ff60f98b496a', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'98136fef-6d02-4823-bc12-6e5e619e1275', N'', N'UserRole', N'0', N'2019-10-31 21:59:25.000', N'', N'758a34c7-5a31-438c-bdf7-02fdd846b901', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9a6850d8-fc90-45fe-ab34-cfe0aa1b80ee', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9a7648a6-12ac-4473-82ec-c2c845d9047e', N'', N'RoleElement', N'0', N'2019-11-06 10:31:03.000', N'', N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'054e9699-7828-4b8b-a28b-d7ae45ed3306', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9ad706e3-8e6b-4bc7-a502-371b298ef062', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'ef42721f-d223-4a00-a1d9-80b81121f21a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9ba32bd8-4406-43bf-aac5-0bb0dbd6d228', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'c35d8f5b-0d38-4f31-84f9-39e476eeab08', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9bff1b59-f0fd-41db-9c55-e3275eccfc88', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9d568d6d-d78d-47d6-8fb6-b1327cdbe83a', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9ded6370-099c-4691-aecd-1ee09542c9d5', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Disable', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9e46a946-6e81-4f61-bcba-21e4f7fac3df', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9e57e1ff-e9cf-4600-a872-ac85f7845bb0', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
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

INSERT INTO [dbo].[Relevance]  VALUES (N'a314a714-95f0-46e2-8341-5a29b9b4f321', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'ShipperId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a3876834-411d-4228-b7ba-230c29b76295', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'd352c8ee-3dff-4d28-a0de-903ae68f2533', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a3c0d154-4bcc-47a4-9c0e-c0a406686167', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'9e2c6754-f258-4b14-96a0-b9d981196a65', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a5bef7bf-ecdb-4480-ad64-b39a02269607', N'', N'UserModule', N'0', N'2018-04-06 09:48:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a6c7d18e-129f-4922-94bd-8306d1004480', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'Enable', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a8094b46-de5a-40ea-a8ee-69ea905480ef', N'', N'RoleModule', N'0', N'2016-09-05 09:21:56.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a8123b37-ba70-4aab-aef6-1938733b5210', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c0d8505c-061a-467d-862a-c94f27caa208', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a84c4bee-4bf6-4dd7-a0a4-3da64d366535', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'Remark', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a9821db0-49bd-49be-a554-afa811c99760', N'', N'RoleResource', N'0', N'2016-09-04 23:20:22.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'aa051096-a23a-431d-9053-bb954f9453a7', N'', N'RoleElement', N'0', N'2016-09-04 23:20:54.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'4bfa8ea0-6b0d-426f-8687-b654575ca780', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'aac9206e-a77b-421c-9c85-5f202fddeb31', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'TransferType', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ab84b111-fb5d-4ddd-99d5-479954d9d521', N'', N'RoleOrg', N'0', N'2016-09-08 16:19:18.000', N'0', N'36094f5d-07e7-40d5-91dc-ff60f98b496a', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ab924ba7-8a74-4804-82b0-ecbbedf4c13e', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'38109ca0-32ec-44bd-a243-017e591b532b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'abbf150f-907d-450c-836c-6ad3d6885549', N'', N'RoleModule', N'0', N'2020-04-25 11:48:19.563', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'5c55f7eb-4552-4610-a584-d72685f8d064', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'ae131c5a-084b-4932-9215-cf0f739ee969', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'GoodsType', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ae619801-1959-44fd-a75b-a8cca4d559b4', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:37.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ae95e6e1-ae92-4c2e-b8d8-c32031f35805', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'af263192-daa8-4f29-99b9-1efb96e31627', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'645b40ac-4223-44a7-aab4-66eb56cf9864', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'af47386e-142b-4afc-a42a-1ff138ac377c', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'CreateUserName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b0174f58-3f6c-431a-8bd8-0caba54fd848', N'', N'RoleElement', N'0', N'2019-11-06 10:31:03.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'054e9699-7828-4b8b-a28b-d7ae45ed3306', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'b2f1a511-26ac-4b5b-bc3a-b7fc52297b41', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'UpdateUserName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b3245529-7cad-4130-bd2d-ac1129deb2f0', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'UpdateTime', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b3b8f695-a179-489b-90b4-7814ab048a69', N'', N'UserElement', N'0', N'2018-04-06 09:48:21.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b3cb3391-4ff4-4071-910e-18c46362ab5d', N'', N'RoleElement', N'0', N'2020-03-19 22:31:02.460', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'18cc3217-28a6-49b2-9a20-080230065984', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b4c2a294-125c-4768-9214-cea3ccf39a1c', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:42.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b51345b9-325c-4a30-b147-5562c93c3ed3', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'816b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b55798b2-6768-4051-8cdc-9da72c73718d', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:51:40.000', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'Resource', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b5c0e181-5f32-4a92-846c-24ff6253b6df', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'054e9699-7828-4b8b-a28b-d7ae45ed3306', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b647148b-21be-42b8-8811-1cb03a6fc349', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'ExternalType', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b6712915-5fc8-4271-b651-6b467ec1d8a8', N'', N'RoleModule', N'0', N'2020-03-19 22:31:02.443', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'0031262c-689c-4b96-bae2-2c9d67076ade', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b672a830-c3a5-408b-a746-65608534b24c', N'', N'UserModule', N'0', N'2017-12-15 17:07:05.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b918e504-ba39-4be7-8452-76cef09191d3', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'826b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b9e63d17-35c8-4456-abab-8f43a1c99adc', N'', N'UserModule', N'0', N'2018-04-06 09:47:59.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ba5f4663-04e1-4b09-8e84-459507df2aeb', N'', N'UserOrg', N'0', N'2019-10-31 21:50:51.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bbca349a-5d29-4cce-9f7e-0d5d4ce65a54', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'OwnerId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bbdc3ea9-3f21-48b0-9d7a-39545d6183d0', N'', N'UserElement', N'0', N'2018-04-06 09:48:25.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bc39df48-cbcf-4757-af8c-b023ad195721', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'816b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bc63b763-cdb8-4516-a3c4-fabe74d7dc56', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:19:30.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'DtValue', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bd783f53-23fa-41f4-8cec-7c61fab52072', N'', N'UserOrg', N'0', N'2018-03-15 09:19:06.000', N'', N'0ceff0f8-f848-440c-bc26-d8605ac858cd', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bd82fa18-2500-4e6b-920d-dc235b57f788', N'', N'RoleModule', N'0', N'2020-04-25 11:48:19.553', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'5c55f7eb-4552-4610-a584-d72685f8d064', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bda5f089-64d6-4fb8-9012-d7f3ff36902a', N'', N'UserOrg', N'0', N'2017-10-12 13:59:09.000', N'', N'ffd92ed2-5330-4ec2-a42d-6e0e9005db3b', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'be17df2b-a4bb-4080-9d3f-465875a0bd52', N'', N'RoleModule', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bee6572d-8fb8-4e0e-af15-93aafc989717', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'68fc793f-069f-43e1-a012-42ac2d7c585c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bef744ab-2323-4552-9a09-f529911f8c59', N'', N'UserOrg', N'0', N'2019-10-31 21:58:43.000', N'', N'96f63f9d-e8c8-4258-963e-3327ed7d6f56', N'60620558-89a2-4b28-8637-52f514773725', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bfe7d15c-9b35-4735-b9a6-38ee8869b5ec', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'CreateUserId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c14addeb-1812-4a78-9152-1f7115b22d89', N'', N'UserRole', N'0', N'2016-09-05 00:00:47.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c16e961d-e3b9-4b89-8cd4-de6fd23e4709', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'Status', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c25f0741-47bc-48a5-801c-902de87b7ab6', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'CreateUserName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c2d3b7d6-b47d-4bd8-9dc6-d9134d86713f', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c3050d65-d26b-4e46-bece-a212b0cc00ec', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c3227c77-d60e-4157-9dd3-a8bcdb3af52b', N'', N'RoleModule', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c4771ac5-3375-4de9-adb8-a603398f0d62', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'2d595a2a-5de5-479e-a331-b53c799a6b10', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c50fae2a-b36f-486f-9d53-e58406590101', N'', N'ProcessUser', N'0', N'2016-10-27 16:47:52.000', N'0', N'054ff054-d8ae-4911-a596-8fb1f66b348f', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c58cb482-6ab7-49eb-b5b0-e45424b6e502', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'34730f5a-d307-457b-9041-5f7de30abfa9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c733cfbe-2f71-41e4-92a6-4ff97cf88dc4', N'', N'UserModule', N'0', N'2018-04-06 09:48:19.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c9099371-8d4e-4f5b-9686-2c60a2c1c641', N'', N'ProcessUser', N'0', N'2016-09-08 16:48:14.000', N'0', N'10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c98b3d02-a76b-4ecc-94a5-cfeffd5e29fb', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'cd500e9c-7599-42d5-94d8-0234369efd41', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'37bb9414-19a0-4223-9056-71f8c758a930', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ce7a6891-361e-44a0-b543-e2a7d8ca0fc0', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'GoodsType', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd060436e-4eac-4109-a4f2-9e5ffb3f843e', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'PurchaseNo', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd1f194c3-3b20-41ee-805b-77c94ee40785', N'', N'UserOrg', N'0', N'2020-03-19 21:20:04.110', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'543a9fcf-4770-4fd9-865f-030e562be238', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd65f9601-b07e-4c89-8c35-ddc6c3edf3b1', N'', N'UserRole', N'0', N'2019-11-23 00:48:02.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd72b9de9-998b-432c-9ccf-d961d386d778', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'b19bce90-5508-43b6-93ed-cd9ff9e356a9', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd892294d-2a2f-410e-bae9-86be3f6e3674', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'StockId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd967ed9b-a083-4398-954b-ea73edcefa32', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'ExternalNo', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'da6c0645-0bf9-4ade-9dd3-1b09e91e504c', N'', N'RoleElement', N'0', N'2016-09-05 09:22:07.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'db621de5-12e0-4ff1-9532-4cd7a696cf65', N'', N'RoleElement', N'0', N'2020-04-25 11:50:18.433', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'a6b61073-9e76-40ef-88ad-15c8789e2033', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'dbdd5bf2-5910-4644-b087-2f50711840df', N'', N'UserRole', N'0', N'2019-11-23 00:48:35.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'dc7dd8ef-c8e6-414f-8e97-31774718654c', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'de4205b7-4832-40d4-b6ae-956f7b4997ba', N'', N'RoleModule', N'0', N'2020-03-19 22:31:02.443', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'df2d90b3-4e2e-40e9-b406-220009726460', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'dfd5430b-3422-465a-be79-05a1e06deed2', N'', N'RoleElement', N'0', N'2016-09-04 23:20:54.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e12b77de-b7ce-4f38-b7a3-f3b2d285f33b', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:49.000', N'0', N'2eb423d6-6ad9-4efe-b423-872478a2a434', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e28c0dcd-168a-4b60-a514-7b6eb8026709', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e4ccd68d-b31b-4d2d-b591-665818a7bd9f', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e50d78ae-004d-4f89-95a2-bd5c6327d16c', N'', N'RoleModule', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'0031262c-689c-4b96-bae2-2c9d67076ade', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e5aa43b8-86df-43be-b5f1-9edd13dc07f8', N'', N'RoleElement', N'0', N'2020-04-25 11:49:36.487', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'4770af29-1375-4d27-ab0c-fdbeab87b710', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e619a82e-edfb-4542-94df-0b92850667ad', N'', N'RoleResource', N'0', N'2018-04-14 14:39:56.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_MODIFYACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e6bd480f-592a-46e0-9f83-2adefb12dca0', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'8966b04f-8e26-4046-8b03-0c64f9f833dd', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'ef43a7a6-4a4c-46fe-82d4-1e1055fdac6d', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'17ae4fd4-ab4e-439e-ba1d-2a53b46d112b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ef8024e8-dab3-4b85-9952-821a005c1f2b', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:51:40.000', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'Resource', N'CascadeId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f012d886-f204-4599-a00d-7b9847cc0bb7', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'92b00259-2d15-43e7-9321-adffb29e8bf2', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f125441c-f28c-4ffa-9183-c8168ab09afb', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'TypeId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f163873c-2b44-4279-8b2c-498bcd01f05b', N'', N'RoleElement', N'0', N'2020-04-25 11:49:36.490', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'4770af29-1375-4d27-ab0c-fdbeab87b710', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f25d98ff-46bc-48e7-86a0-5eca5e6d98c2', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'UpdateUserName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f3671c95-a33f-4a11-89dd-00d734d4a230', N'', N'RoleModule', N'0', N'2020-03-19 00:16:54.723', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'f714b860-447e-4d22-a206-1b545cc98fbb', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'InBondedArea', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f8d157b4-12e3-4488-9e4c-b9670e11b4c6', N'', N'RoleDataProperty', N'0', N'2019-11-23 01:05:44.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'WmsInboundOrderTbl', N'UpdateUserName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f8e65a18-a86a-47b1-be87-c437ba5e5fd9', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fa52d20f-204d-4cdd-a1e5-5b7faaac4cd7', N'', N'RoleDataProperty', N'0', N'2019-11-23 00:51:40.000', N'', N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'Resource', N'CreateUserName', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fa7c4d39-b31a-4668-8716-d40a62aa722b', N'', N'UserOrg', N'0', N'2017-10-12 13:59:49.000', N'', N'63c9c82a-e0d3-4bde-bbd2-057cda2f5283', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fa955d08-fe15-42d2-ae39-98e22e4f9b50', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'WmsInboundOrderTbl', N'OrderType', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fa9ce486-4b1f-4630-bad3-7625744cb8e8', N'', N'RoleDataProperty', N'0', N'2020-03-19 00:17:01.923', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'CascadeId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'faf837f2-8ac3-4269-8a1c-b2af432bf7b5', N'', N'RoleElement', N'0', N'2020-03-19 21:23:18.730', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'a7eea5dc-3b10-4550-9cf3-0dba9b9fc32c', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fafcaba7-57fe-44dd-9343-6112db385dce', N'', N'RoleElement', N'0', N'2020-04-25 11:49:11.133', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'5fba6316-5599-4245-822c-48ff33299868', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fdc16578-e4eb-474d-8cc8-4188693a7c12', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'6c814946-db5c-48bd-84dd-b1c38196ad74', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'feec44e3-3f88-4ac2-a4ad-a5bd3161f1bb', N'', N'UserOrg', N'0', N'2019-10-31 21:59:08.000', N'', N'758a34c7-5a31-438c-bdf7-02fdd846b901', N'66386671-0494-4e83-8346-fbcf73283f7b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fef68b50-ef7f-45a4-8f0e-38e8d8ecaaea', N'', N'RoleElement', N'0', N'2020-03-19 00:16:54.797', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'68484265-7802-4f06-b024-33e8b2f2edcf', N'', N'')
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
  [Disable] bit NOT NULL,
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
-- Records of [Resource]
-- ----------------------------
INSERT INTO [dbo].[Resource]  VALUES (N'SYS_DEL_USER', N'.0.2.', N'删除用户', N'0', N'拥有删除OpenAuth.Net系统用户信息的权限', N'根节点', NULL, N'110', N'OpenAuth.Net', NULL, NULL, N'0', N'2019-11-23 00:27:58.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 00:27:58.0000000', N'', N'')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'SYS_UPDATE_USER', N'.0.1.', N'更新用户信息', N'0', N'拥有更新OpenAuth.Net系统用户信息的权限', N'根节点', NULL, N'110', N'OpenAuth.Net', NULL, NULL, N'0', N'2019-11-23 00:27:17.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 00:27:12.0000000', N'', N'')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'SYS_VIEW_USER', N'.0.3.', N'查看用户列表', N'0', N'查看OpenAuth.Net用户列表', N'根节点', NULL, N'110', N'OpenAuth.Net', NULL, NULL, N'0', N'2019-11-23 00:44:39.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 00:44:39.0000000', N'', N'')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'XXX_ADDORDER', N'.0.6.', N'创建订单', N'0', N'在XXX平台创建订单', N'根节点', NULL, N'119', N'XXX管理平台', NULL, NULL, N'0', N'2019-11-23 00:53:24.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 00:53:24.0000000', N'', N'')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'XXX_DEL_LOG', N'.0.4.', N'删除XXX平台日志', N'0', N'删除XXX平台日志', N'根节点', NULL, N'119', N'XXX管理平台', NULL, NULL, N'0', N'2019-11-23 00:45:02.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 00:45:02.0000000', N'', N'')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'XXX_LOGIN', N'.0.7.', N'登录', N'0', N'登录XXX平台', N'根节点', NULL, N'119', N'XXX管理平台', NULL, NULL, N'0', N'2019-11-23 00:55:20.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 00:55:20.0000000', N'', N'')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'XXX_VIEW_USER', N'.0.5.', N'查看用户', N'0', N'查看XXX平台用户列表', N'根节点', NULL, N'119', N'XXX管理平台', NULL, NULL, N'0', N'2019-11-23 00:53:01.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 00:53:01.0000000', N'', N'')
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

INSERT INTO [dbo].[Role]  VALUES (N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'神', N'0', N'2018-04-14 13:16:45.000', N'', N'', N'')
GO

INSERT INTO [dbo].[Role]  VALUES (N'd27ae3cf-135f-4d57-93a6-2120ddf98650', N'测试二组', N'0', N'2019-11-23 00:46:31.000', N'', N'', N'')
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

INSERT INTO [dbo].[User]  VALUES (N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'admin', N'admin', N'0', N'0', N'', N'2017-12-11 16:18:54.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'test', N'test', N'1', N'0', N'', N'2017-12-11 16:19:00.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'758a34c7-5a31-438c-bdf7-02fdd846b901', N'test77', N'test77', N'test77', N'0', N'0', N'', N'2019-10-31 21:59:08.000', N'00000000-0000-0000-0000-000000000000', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'96f63f9d-e8c8-4258-963e-3327ed7d6f56', N'test66', N'test66', N'test66', N'0', N'0', N'', N'2019-10-31 21:58:43.000', N'00000000-0000-0000-0000-000000000000', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'de8be521-f1ec-4483-b124-0be342890507', N'test2', N'test2', N'test2', N'1', N'0', N'', N'2017-12-11 16:19:06.000', N'', N'', N'')
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
  [InStockStatus] bit NOT NULL,
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
-- Records of [WmsInboundOrderDtbl]
-- ----------------------------
INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'09a939ad-7e40-42f2-b0b3-fa9b74f94897', N'20190035RK0001', N'77.000000', N'73.210000', N'0', N'0', N'', N'10045', N'', N'32.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-06 10:37:38.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:59.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'1e547556-9549-44d5-9da3-c07d98b5943e', N'2019102203RK0003', N'10.000000', N'6.000000', N'0', N'0', N'', N'', N'', N'.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-07 01:00:35.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:00.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'2ae93007-1490-4e81-b410-957fc08e2371', N'2019102203RK0001', N'25.000000', N'22.500000', N'0', N'0', N'', N'100011', N'', N'.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-06 10:32:10.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:28:47.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'30eb475b-ed86-4106-88f0-47a5a32ec8aa', N'TEST_002', N'10.000000', N'10.000000', N'0', N'1', N'', N'CJ-334', N'', N'10.00', N'8.00', N'2.00', N'.00', N'2019-11-22', N'', N'.00', N'', N'', N'2019-11-23 01:26:54.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 01:26:54.0000000', N'', N'')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'56b5612c-e048-4650-9710-4b235731d548', N'20190035RK0001', N'62.000000', N'60.230000', N'0', N'0', N'', N'133521', N'', N'10.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-06 10:37:38.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:59.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'5e7d6ef8-351a-4600-849e-3958588161a7', N'20190035RK0001', N'55.000000', N'54.230000', N'0', N'0', N'', N'FK85122', N'', N'14.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-06 10:37:38.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:59.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'78c0a896-8341-47d4-b6d2-f241cec9fb58', N'TEST_001', N'998.500000', N'985.000000', N'0', N'1', N'', N'CJ-P-4446', N'', N'500.00', N'500.00', N'.00', N'.00', N'2019-11-22', N'2020-11-12', N'6.00', N'', N'', N'2019-11-23 01:27:49.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 01:29:38.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'95d6d2a8-0e17-426b-97f3-3c8a82bca313', N'20190035RK0001', N'15.000000', N'13.220000', N'0', N'0', N'', N'10052', N'', N'52.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-06 10:37:38.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:59.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'b195386a-4f09-4e31-9d72-8e94526f9419', N'2019102203RK0133', N'200.000000', N'199.000000', N'0', N'0', N'', N'', N'', N'.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-07 01:24:11.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:24:11.0000000', N'', N'')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'ca470c60-9231-4c13-b51b-ad90c39633ae', N'2019102203RK0187', N'22.220000', N'20.000000', N'0', N'0', N'', N'', N'', N'.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-07 01:03:27.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:48.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'd19df810-5c47-4a32-a3a5-c908da60bf8b', N'TEST_002', N'6.670000', N'6.000000', N'0', N'1', N'', N'CJ-335', N'', N'54.00', N'54.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-23 01:26:54.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 01:26:54.0000000', N'', N'')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'dc0f9da2-0e0e-4dc3-9e59-2b0d51e53211', N'2019102203RK0001', N'10.000000', N'8.000000', N'0', N'1', N'', N'100010', N'', N'.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-06 10:32:10.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:28:47.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[WmsInboundOrderDtbl]  VALUES (N'fcf051d3-5c00-4617-895f-e45891d975df', N'2019102203RK0002', N'22.520000', N'18.990000', N'0', N'1', N'', N'100020', N'', N'10.00', N'.00', N'.00', N'.00', N'', N'', N'.00', N'', N'', N'2019-11-06 10:32:45.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:28:53.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
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
  [Enable] bit NOT NULL,
  [TransferType] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [InBondedArea] bit NOT NULL,
  [ReturnBoxNum] decimal(8) NOT NULL,
  [CreateTime] datetime2(7) NOT NULL,
  [CreateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [CreateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [UpdateTime] datetime2(7) NULL,
  [UpdateUserId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [UpdateUserName] varchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [OrgId] varchar(50) COLLATE Chinese_PRC_CI_AS NULL
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
'MS_Description', N'所属部门',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl',
'COLUMN', N'OrgId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库通知单（入库订单）',
'SCHEMA', N'dbo',
'TABLE', N'WmsInboundOrderTbl'
GO


-- ----------------------------
-- Records of [WmsInboundOrderTbl]
-- ----------------------------
INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'20190035RK0001', N'20190035RK0001', N'', N'1', N'SYS_INBOUNDTYPE_SAMPLE', N'不合格', N'20190035RK0001', N'', N'', N'', N'', N'2019-11-20 00:00:00.0000000', N'', N'1', N'SYS_SHIPTYPE_FREIGHT', N'1', N'0', N'2019-11-06 10:33:17.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:59.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', NULL)
GO

INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'20190035RK0002', N'20190035RK0002', N'', N'0', N'样品入库', N'特殊药品', N'20190035RK0002', N'', N'', N'', N'', N'2019-11-14 00:00:00.0000000', N'', N'1', N'SYS_SHIPTYPE_FREIGHT', N'1', N'0', N'2019-11-06 10:34:58.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:30:07.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', NULL)
GO

INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'2019102203RK0001', N'2019102203RK0001', N'1', N'1', N'普通入库', N'普通商品', N'2019102203RK0001', N'BJ003', N'CDC001', N'SF', N'SF', N'2019-10-10 00:00:00.0000000', N'', N'1', N'SYS_SHIPTYPE_FREIGHT', N'0', N'1', N'2019-10-31 21:27:14.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:28:47.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', NULL)
GO

INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'2019102203RK0002', N'2019102203RK0002', N'1', N'1', N'普通入库', N'普通商品', N'2019102203RK0002', N'BJ003', N'CDC001', N'SF', N'SF', N'2019-10-10 00:00:00.0000000', N'', N'1', N'SYS_SHIPTYPE_NORMAL', N'1', N'20', N'2019-10-31 21:27:14.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:28:53.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', NULL)
GO

INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'2019102203RK0003', N'2019102203RK0003', N'1', N'1', N'SYS_INBOUNDTYPE_RETURN', N'普通商品', N'2019102203RK0003', N'BJ003', N'CDC001', N'SF', N'SF', N'2019-10-10 00:00:00.0000000', N'', N'1', N'SYS_SHIPTYPE_EMS', N'0', N'1', N'2019-10-31 21:27:14.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:00.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', NULL)
GO

INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'2019102203RK0133', N'2019102203RK0133', N'', N'0', N'SYS_INBOUNDTYPE_SAMPLE', N'SYS_GOODSTYPE_COMMON', N'2019102203RK0133', N'', N'', N'001', N'', N'2019-11-26 00:00:00.0000000', N'', N'1', N'SYS_SHIPTYPE_EMS', N'1', N'0', N'2019-11-07 01:24:11.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-07 01:24:11.0000000', N'', N'', NULL)
GO

INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'2019102203RK0187', N'2019102203RK0187', N'', N'1', N'SYS_INBOUNDTYPE_PURCHASE', N'SYS_GOODSTYPE_MEDINSTR', N'2019102203RK0187', N'', N'', N'', N'', NULL, N'', N'1', N'SYS_SHIPTYPE_NORMAL', N'1', N'0', N'2019-11-07 01:03:27.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', N'2019-11-23 01:29:48.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', NULL)
GO

INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'TEST_001', N'TEST_001', NULL, N'0', N'SYS_INBOUNDTYPE_PURCHASE', N'SYS_GOODSTYPE_BIOLPROD', N'TEST_001', N'001', N'BJ02', NULL, NULL, NULL, NULL, N'0', N'SYS_SHIPTYPE_NORMAL', N'0', N'0', N'2019-11-23 01:25:08.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 01:29:38.0000000', N'00000000-0000-0000-0000-000000000000', N'超级管理员', NULL)
GO

INSERT INTO [dbo].[WmsInboundOrderTbl]  VALUES (N'TEST_002', N'TEST_002', N'', N'0', N'SYS_INBOUNDTYPE_PURCHASE', N'SYS_GOODSTYPE_COMMON', N'TEST_002', N'002', N'', N'', N'', N'2019-11-12 00:00:00.0000000', N'', N'0', N'SYS_SHIPTYPE_EMS', N'1', N'0', N'2019-11-23 01:26:54.0000000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'2019-11-23 01:26:54.0000000', N'', N'', NULL)
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
-- Primary Key structure for table OpenJob
-- ----------------------------
ALTER TABLE [dbo].[OpenJob] ADD CONSTRAINT [PK_OPENJOB] PRIMARY KEY CLUSTERED ([Id])
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

