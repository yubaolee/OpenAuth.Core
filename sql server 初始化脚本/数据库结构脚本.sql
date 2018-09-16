
create type PrimaryKey from varchar(50)
go

create table Application
(
	Id PrimaryKey not null
		constraint PK_APPLICATION
			primary key,
	Name varchar(255) default ' ' not null,
	AppSecret varchar(255),
	Description nvarchar(255),
	Icon varchar(255),
	Disable bit default 0 not null,
	CreateTime date default getdate() not null,
	CreateUser PrimaryKey
)
go

exec sp_addextendedproperty 'MS_Description', '应用', 'SCHEMA', 'dbo', 'TABLE', 'Application'
go

exec sp_addextendedproperty 'MS_Description', 'AppId', 'SCHEMA', 'dbo', 'TABLE', 'Application', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '应用名称', 'SCHEMA', 'dbo', 'TABLE', 'Application', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '应用密钥', 'SCHEMA', 'dbo', 'TABLE', 'Application', 'COLUMN', 'AppSecret'
go

exec sp_addextendedproperty 'MS_Description', '应用描述', 'SCHEMA', 'dbo', 'TABLE', 'Application', 'COLUMN', 'Description'
go

exec sp_addextendedproperty 'MS_Description', '应用图标', 'SCHEMA', 'dbo', 'TABLE', 'Application', 'COLUMN', 'Icon'
go

exec sp_addextendedproperty 'MS_Description', '是否可用', 'SCHEMA', 'dbo', 'TABLE', 'Application', 'COLUMN', 'Disable'
go

exec sp_addextendedproperty 'MS_Description', '创建日期', 'SCHEMA', 'dbo', 'TABLE', 'Application', 'COLUMN', 'CreateTime'
go

exec sp_addextendedproperty 'MS_Description', '创建人', 'SCHEMA', 'dbo', 'TABLE', 'Application', 'COLUMN', 'CreateUser'
go

create table Category
(
	Id PrimaryKey not null
		constraint PK_CATEGORY
			primary key nonclustered,
	Name nvarchar(255) default ' ' not null,
	Disabled bit default 0 not null,
	SortNo int default 0 not null,
	Icon varchar(255),
	Description nvarchar(500),
	TypeId PrimaryKey
)
go

exec sp_addextendedproperty 'MS_Description', '分类表，表示一个全集，比如：男', 'SCHEMA', 'dbo', 'TABLE', 'Category'
go

exec sp_addextendedproperty 'MS_Description', '分类表ID（可作为分类的标识）', 'SCHEMA', 'dbo', 'TABLE', 'Category', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '名称', 'SCHEMA', 'dbo', 'TABLE', 'Category', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '是否可用', 'SCHEMA', 'dbo', 'TABLE', 'Category', 'COLUMN', 'Disabled'
go

exec sp_addextendedproperty 'MS_Description', '排序号', 'SCHEMA', 'dbo', 'TABLE', 'Category', 'COLUMN', 'SortNo'
go

exec sp_addextendedproperty 'MS_Description', '分类图标', 'SCHEMA', 'dbo', 'TABLE', 'Category', 'COLUMN', 'Icon'
go

exec sp_addextendedproperty 'MS_Description', '分类描述', 'SCHEMA', 'dbo', 'TABLE', 'Category', 'COLUMN', 'Description'
go

exec sp_addextendedproperty 'MS_Description', '分类类型ID', 'SCHEMA', 'dbo', 'TABLE', 'Category', 'COLUMN', 'TypeId'
go

create table CategoryType
(
	Id PrimaryKey not null
		constraint PK_CATEGORYTYPE
			primary key nonclustered,
	Name nvarchar(255) default ' ' not null,
	CreateTime datetime default getdate() not null
)
go

exec sp_addextendedproperty 'MS_Description', '分类类型', 'SCHEMA', 'dbo', 'TABLE', 'CategoryType'
go

exec sp_addextendedproperty 'MS_Description', '分类表ID', 'SCHEMA', 'dbo', 'TABLE', 'CategoryType', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '名称', 'SCHEMA', 'dbo', 'TABLE', 'CategoryType', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '创建时间', 'SCHEMA', 'dbo', 'TABLE', 'CategoryType', 'COLUMN', 'CreateTime'
go

create table FlowInstance
(
	Id PrimaryKey not null
		constraint PK_FLOWINSTANCE
			primary key nonclustered,
	InstanceSchemeId PrimaryKey not null,
	Code varchar(200),
	CustomName varchar(200),
	ActivityId PrimaryKey,
	ActivityType int,
	ActivityName varchar(200),
	PreviousId PrimaryKey,
	SchemeContent varchar(max),
	SchemeId PrimaryKey,
	DbName varchar(50),
	FrmData text,
	FrmType int default 0 not null,
	FrmContentData text,
	FrmContentParse text,
	FrmId PrimaryKey,
	SchemeType varchar(50),
	Disabled int default 0 not null,
	CreateDate datetime default getdate() not null,
	CreateUserId PrimaryKey,
	CreateUserName varchar(50),
	FlowLevel int default 0 not null,
	Description varchar(200),
	IsFinish int default 0 not null,
	MakerList varchar(1000)
)
go

exec sp_addextendedproperty 'MS_Description', '工作流流程实例表', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance'
go

exec sp_addextendedproperty 'MS_Description', '主键Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '流程实例模板Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'InstanceSchemeId'
go

exec sp_addextendedproperty 'MS_Description', '实例编号', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'Code'
go

exec sp_addextendedproperty 'MS_Description', '自定义名称', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'CustomName'
go

exec sp_addextendedproperty 'MS_Description', '当前节点ID', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'ActivityId'
go

exec sp_addextendedproperty 'MS_Description', '当前节点类型（0会签节点）', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'ActivityType'
go

exec sp_addextendedproperty 'MS_Description', '当前节点名称', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'ActivityName'
go

exec sp_addextendedproperty 'MS_Description', '前一个ID', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'PreviousId'
go

exec sp_addextendedproperty 'MS_Description', '流程模板内容', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'SchemeContent'
go

exec sp_addextendedproperty 'MS_Description', '流程模板ID', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'SchemeId'
go

exec sp_addextendedproperty 'MS_Description', '数据库名称', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'DbName'
go

exec sp_addextendedproperty 'MS_Description', '表单数据', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'FrmData'
go

exec sp_addextendedproperty 'MS_Description', '表单类型', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'FrmType'
go

exec sp_addextendedproperty 'MS_Description', '表单中的控件属性描述', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'FrmContentData'
go

exec sp_addextendedproperty 'MS_Description', '表单控件位置模板', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'FrmContentParse'
go

exec sp_addextendedproperty 'MS_Description', '表单ID', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'FrmId'
go

exec sp_addextendedproperty 'MS_Description', '流程类型', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'SchemeType'
go

exec sp_addextendedproperty 'MS_Description', '有效标志', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'Disabled'
go

exec sp_addextendedproperty 'MS_Description', '创建时间', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'CreateDate'
go

exec sp_addextendedproperty 'MS_Description', '创建用户主键', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'CreateUserId'
go

exec sp_addextendedproperty 'MS_Description', '创建用户', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'CreateUserName'
go

exec sp_addextendedproperty 'MS_Description', '等级', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'FlowLevel'
go

exec sp_addextendedproperty 'MS_Description', '实例备注', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'Description'
go

exec sp_addextendedproperty 'MS_Description', '是否完成', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'IsFinish'
go

exec sp_addextendedproperty 'MS_Description', '执行人', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstance', 'COLUMN', 'MakerList'
go

create table FlowInstanceOperationHistory
(
	Id PrimaryKey not null
		constraint PK_FLOWINSTANCEOPERATIONHISTOR
			primary key nonclustered,
	InstanceId PrimaryKey not null,
	Content nvarchar(200),
	CreateDate datetime default getdate() not null,
	CreateUserId PrimaryKey,
	CreateUserName varchar(50)
)
go

exec sp_addextendedproperty 'MS_Description', '工作流实例操作记录', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceOperationHistory'
go

exec sp_addextendedproperty 'MS_Description', '主键Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceOperationHistory', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '实例进程Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceOperationHistory', 'COLUMN', 'InstanceId'
go

exec sp_addextendedproperty 'MS_Description', '操作内容', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceOperationHistory', 'COLUMN', 'Content'
go

exec sp_addextendedproperty 'MS_Description', '创建时间', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceOperationHistory', 'COLUMN', 'CreateDate'
go

exec sp_addextendedproperty 'MS_Description', '创建用户主键', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceOperationHistory', 'COLUMN', 'CreateUserId'
go

exec sp_addextendedproperty 'MS_Description', '创建用户', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceOperationHistory', 'COLUMN', 'CreateUserName'
go

create table FlowInstanceTransitionHistory
(
	Id PrimaryKey not null
		constraint PK_FLOWINSTANCETRANSITIONHISTO
			primary key nonclustered,
	InstanceId PrimaryKey not null,
	FromNodeId PrimaryKey,
	FromNodeType int,
	FromNodeName varchar(200),
	ToNodeId PrimaryKey,
	ToNodeType int,
	ToNodeName varchar(200),
	TransitionSate int default 0 not null,
	IsFinish int default 0 not null,
	CreateDate datetime default getdate() not null,
	CreateUserId PrimaryKey,
	CreateUserName varchar(50)
)
go

exec sp_addextendedproperty 'MS_Description', '工作流实例流转历史记录', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory'
go

exec sp_addextendedproperty 'MS_Description', '主键Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '实例Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'InstanceId'
go

exec sp_addextendedproperty 'MS_Description', '开始节点Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'FromNodeId'
go

exec sp_addextendedproperty 'MS_Description', '开始节点类型', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'FromNodeType'
go

exec sp_addextendedproperty 'MS_Description', '开始节点名称', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'FromNodeName'
go

exec sp_addextendedproperty 'MS_Description', '结束节点Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'ToNodeId'
go

exec sp_addextendedproperty 'MS_Description', '结束节点类型', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'ToNodeType'
go

exec sp_addextendedproperty 'MS_Description', '结束节点名称', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'ToNodeName'
go

exec sp_addextendedproperty 'MS_Description', '转化状态', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'TransitionSate'
go

exec sp_addextendedproperty 'MS_Description', '是否结束', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'IsFinish'
go

exec sp_addextendedproperty 'MS_Description', '转化时间', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'CreateDate'
go

exec sp_addextendedproperty 'MS_Description', '操作人Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'CreateUserId'
go

exec sp_addextendedproperty 'MS_Description', '操作人名称', 'SCHEMA', 'dbo', 'TABLE', 'FlowInstanceTransitionHistory', 'COLUMN', 'CreateUserName'
go

create table FlowScheme
(
	Id PrimaryKey not null
		constraint PK_FLOWSCHEME
			primary key nonclustered,
	SchemeCode varchar(50),
	SchemeName varchar(200),
	SchemeType varchar(50),
	SchemeVersion varchar(50),
	SchemeCanUser varchar(max),
	SchemeContent varchar(max),
	FrmId PrimaryKey,
	FrmType int default 0 not null,
	AuthorizeType int default 0 not null,
	SortCode int default 0 not null,
	DeleteMark int default 0 not null,
	Disabled int default 0 not null,
	Description varchar(200),
	CreateDate datetime default getdate() not null,
	CreateUserId PrimaryKey,
	CreateUserName varchar(50),
	ModifyDate datetime,
	ModifyUserId PrimaryKey,
	ModifyUserName varchar(50)
)
go

exec sp_addextendedproperty 'MS_Description', '工作流模板信息表', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme'
go

exec sp_addextendedproperty 'MS_Description', '主键Id', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '流程编号', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'SchemeCode'
go

exec sp_addextendedproperty 'MS_Description', '流程名称', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'SchemeName'
go

exec sp_addextendedproperty 'MS_Description', '流程分类', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'SchemeType'
go

exec sp_addextendedproperty 'MS_Description', '流程内容版本', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'SchemeVersion'
go

exec sp_addextendedproperty 'MS_Description', '流程模板使用者', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'SchemeCanUser'
go

exec sp_addextendedproperty 'MS_Description', '流程内容', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'SchemeContent'
go

exec sp_addextendedproperty 'MS_Description', '表单ID', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'FrmId'
go

exec sp_addextendedproperty 'MS_Description', '表单类型', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'FrmType'
go

exec sp_addextendedproperty 'MS_Description', '模板权限类型：0完全公开,1指定', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'AuthorizeType'
go

exec sp_addextendedproperty 'MS_Description', '排序码', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'SortCode'
go

exec sp_addextendedproperty 'MS_Description', '删除标记', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'DeleteMark'
go

exec sp_addextendedproperty 'MS_Description', '有效', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'Disabled'
go

exec sp_addextendedproperty 'MS_Description', '备注', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'Description'
go

exec sp_addextendedproperty 'MS_Description', '创建时间', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'CreateDate'
go

exec sp_addextendedproperty 'MS_Description', '创建用户主键', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'CreateUserId'
go

exec sp_addextendedproperty 'MS_Description', '创建用户', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'CreateUserName'
go

exec sp_addextendedproperty 'MS_Description', '修改时间', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'ModifyDate'
go

exec sp_addextendedproperty 'MS_Description', '修改用户主键', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'ModifyUserId'
go

exec sp_addextendedproperty 'MS_Description', '修改用户', 'SCHEMA', 'dbo', 'TABLE', 'FlowScheme', 'COLUMN', 'ModifyUserName'
go

create table Form
(
	Id PrimaryKey not null
		constraint PK_FORM
			primary key nonclustered,
	Name varchar(200),
	Fields int default 0 not null,
	ContentData text,
	ContentParse text,
	Content text,
	SortCode int default 0 not null,
	Delete int default 0 not null,
	DbName varchar(50),
	Enabled int not null,
	Description varchar(200),
	CreateDate datetime default getdate() not null,
	CreateUserId varchar(50),
	CreateUserName varchar(50),
	ModifyDate datetime,
	ModifyUserId varchar(50),
	ModifyUserName varchar(50)
)
go

exec sp_addextendedproperty 'MS_Description', '表单模板表', 'SCHEMA', 'dbo', 'TABLE', 'Form'
go

exec sp_addextendedproperty 'MS_Description', '表单模板Id', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '表单名称', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '字段个数', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'Fields'
go

exec sp_addextendedproperty 'MS_Description', '表单中的控件属性描述', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'ContentData'
go

exec sp_addextendedproperty 'MS_Description', '表单控件位置模板', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'ContentParse'
go

exec sp_addextendedproperty 'MS_Description', '表单原html模板未经处理的', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'Content'
go

exec sp_addextendedproperty 'MS_Description', '排序码', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'SortCode'
go

exec sp_addextendedproperty 'MS_Description', '删除标记', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'Delete'
go

exec sp_addextendedproperty 'MS_Description', '数据库名称', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'DbName'
go

exec sp_addextendedproperty 'MS_Description', '有效', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'Enabled'
go

exec sp_addextendedproperty 'MS_Description', '备注', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'Description'
go

exec sp_addextendedproperty 'MS_Description', '创建时间', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'CreateDate'
go

exec sp_addextendedproperty 'MS_Description', '创建用户主键', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'CreateUserId'
go

exec sp_addextendedproperty 'MS_Description', '创建用户', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'CreateUserName'
go

exec sp_addextendedproperty 'MS_Description', '修改时间', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'ModifyDate'
go

exec sp_addextendedproperty 'MS_Description', '修改用户主键', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'ModifyUserId'
go

exec sp_addextendedproperty 'MS_Description', '修改用户', 'SCHEMA', 'dbo', 'TABLE', 'Form', 'COLUMN', 'ModifyUserName'
go

create table Module
(
	Id PrimaryKey not null
		constraint PK_MODULE
			primary key,
	CascadeId varchar(255) default ' ' not null,
	Name varchar(255) default ' ' not null,
	Url varchar(255) default ' ' not null,
	HotKey varchar(255) default ' ' not null,
	IsLeaf bit default 1 not null,
	IsAutoExpand bit default 0 not null,
	IconName varchar(255) default ' ' not null,
	Status int default 1 not null,
	ParentName varchar(255) default ' ' not null,
	Vector varchar(255) default ' ' not null,
	SortNo int default 0 not null,
	ParentId PrimaryKey,
	Code varchar(50)
)
go

exec sp_addextendedproperty 'MS_Description', '功能模块表', 'SCHEMA', 'dbo', 'TABLE', 'Module'
go

exec sp_addextendedproperty 'MS_Description', '功能模块流水号', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '节点语义ID', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'CascadeId'
go

exec sp_addextendedproperty 'MS_Description', '功能模块名称', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '主页面URL', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'Url'
go

exec sp_addextendedproperty 'MS_Description', '热键', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'HotKey'
go

exec sp_addextendedproperty 'MS_Description', '是否叶子节点', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'IsLeaf'
go

exec sp_addextendedproperty 'MS_Description', '是否自动展开', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'IsAutoExpand'
go

exec sp_addextendedproperty 'MS_Description', '节点图标文件名称', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'IconName'
go

exec sp_addextendedproperty 'MS_Description', '当前状态', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'Status'
go

exec sp_addextendedproperty 'MS_Description', '父节点名称', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'ParentName'
go

exec sp_addextendedproperty 'MS_Description', '矢量图标', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'Vector'
go

exec sp_addextendedproperty 'MS_Description', '排序号', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'SortNo'
go

exec sp_addextendedproperty 'MS_Description', '父节点流水号', 'SCHEMA', 'dbo', 'TABLE', 'Module', 'COLUMN', 'ParentId'
go

create table ModuleElement
(
	Id PrimaryKey not null
		constraint PK_MODULEELEMENT
			primary key,
	DomId varchar(255) default ' ' not null,
	Name varchar(255) default ' ' not null,
	Attr varchar(500) default ' ' not null,
	Script varchar(500) default ' ' not null,
	Icon varchar(255) default ' ' not null,
	Class varchar(255) default ' ' not null,
	Remark varchar(200) default ' ' not null,
	Sort int default 0 not null,
	ModuleId PrimaryKey not null,
	TypeName nvarchar(20),
	TypeId PrimaryKey
)
go

exec sp_addextendedproperty 'MS_Description', '模块元素表(需要权限控制的按钮)', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement'
go

exec sp_addextendedproperty 'MS_Description', '流水号', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', 'DOM ID', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'DomId'
go

exec sp_addextendedproperty 'MS_Description', '名称', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '元素附加属性', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'Attr'
go

exec sp_addextendedproperty 'MS_Description', '元素调用脚本', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'Script'
go

exec sp_addextendedproperty 'MS_Description', '元素图标', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'Icon'
go

exec sp_addextendedproperty 'MS_Description', '元素样式', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'Class'
go

exec sp_addextendedproperty 'MS_Description', '备注', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'Remark'
go

exec sp_addextendedproperty 'MS_Description', '排序字段', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'Sort'
go

exec sp_addextendedproperty 'MS_Description', '功能模块Id', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'ModuleId'
go

exec sp_addextendedproperty 'MS_Description', '分类名称', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'TypeName'
go

exec sp_addextendedproperty 'MS_Description', '分类ID', 'SCHEMA', 'dbo', 'TABLE', 'ModuleElement', 'COLUMN', 'TypeId'
go

create table Org
(
	Id PrimaryKey not null
		constraint PK_ORG
			primary key,
	CascadeId varchar(255) default ' ' not null,
	Name varchar(255) default ' ' not null,
	HotKey varchar(255) default ' ' not null,
	ParentName varchar(255) default ' ' not null,
	IsLeaf bit default 1 not null,
	IsAutoExpand bit default 0 not null,
	IconName varchar(255) default ' ' not null,
	Status int default 1 not null,
	BizCode varchar(255) default ' ' not null,
	CustomCode varchar(4000) default ' ' not null,
	CreateTime datetime default getdate() not null,
	CreateId int default 0 not null,
	SortNo int default 0 not null,
	ParentId PrimaryKey,
	TypeName nvarchar(20),
	TypeId PrimaryKey
)
go

exec sp_addextendedproperty 'MS_Description', '组织表', 'SCHEMA', 'dbo', 'TABLE', 'Org'
go

exec sp_addextendedproperty 'MS_Description', '流水号', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '节点语义ID', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'CascadeId'
go

exec sp_addextendedproperty 'MS_Description', '组织名称', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '热键', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'HotKey'
go

exec sp_addextendedproperty 'MS_Description', '父节点名称', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'ParentName'
go

exec sp_addextendedproperty 'MS_Description', '是否叶子节点', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'IsLeaf'
go

exec sp_addextendedproperty 'MS_Description', '是否自动展开', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'IsAutoExpand'
go

exec sp_addextendedproperty 'MS_Description', '节点图标文件名称', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'IconName'
go

exec sp_addextendedproperty 'MS_Description', '当前状态', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'Status'
go

exec sp_addextendedproperty 'MS_Description', '业务对照码', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'BizCode'
go

exec sp_addextendedproperty 'MS_Description', '自定义扩展码', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'CustomCode'
go

exec sp_addextendedproperty 'MS_Description', '创建时间', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'CreateTime'
go

exec sp_addextendedproperty 'MS_Description', '创建人ID', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'CreateId'
go

exec sp_addextendedproperty 'MS_Description', '排序号', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'SortNo'
go

exec sp_addextendedproperty 'MS_Description', '父节点流水号', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'ParentId'
go

exec sp_addextendedproperty 'MS_Description', '分类名称', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'TypeName'
go

exec sp_addextendedproperty 'MS_Description', '分类ID', 'SCHEMA', 'dbo', 'TABLE', 'Org', 'COLUMN', 'TypeId'
go

create table Relevance
(
	Id PrimaryKey not null
		constraint PK_RELEVANCE
			primary key,
	Description nvarchar(100) default ' ' not null,
	Key varchar(100) default ' ' not null,
	Status int default 0 not null,
	OperateTime datetime default getdate() not null,
	OperatorId PrimaryKey,
	FirstId PrimaryKey not null,
	SecondId PrimaryKey not null
)
go

exec sp_addextendedproperty 'MS_Description', '多对多关系集中映射', 'SCHEMA', 'dbo', 'TABLE', 'Relevance'
go

exec sp_addextendedproperty 'MS_Description', '流水号', 'SCHEMA', 'dbo', 'TABLE', 'Relevance', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '描述', 'SCHEMA', 'dbo', 'TABLE', 'Relevance', 'COLUMN', 'Description'
go

exec sp_addextendedproperty 'MS_Description', '映射标识', 'SCHEMA', 'dbo', 'TABLE', 'Relevance', 'COLUMN', 'Key'
go

exec sp_addextendedproperty 'MS_Description', '状态', 'SCHEMA', 'dbo', 'TABLE', 'Relevance', 'COLUMN', 'Status'
go

exec sp_addextendedproperty 'MS_Description', '授权时间', 'SCHEMA', 'dbo', 'TABLE', 'Relevance', 'COLUMN', 'OperateTime'
go

exec sp_addextendedproperty 'MS_Description', '授权人', 'SCHEMA', 'dbo', 'TABLE', 'Relevance', 'COLUMN', 'OperatorId'
go

exec sp_addextendedproperty 'MS_Description', '第一个表主键ID', 'SCHEMA', 'dbo', 'TABLE', 'Relevance', 'COLUMN', 'FirstId'
go

exec sp_addextendedproperty 'MS_Description', '第二个表主键ID', 'SCHEMA', 'dbo', 'TABLE', 'Relevance', 'COLUMN', 'SecondId'
go

create table Resource
(
	Id PrimaryKey not null
		constraint PK_RESOURCE
			primary key,
	CascadeId varchar(255) default ' ' not null,
	Name varchar(255) default ' ' not null,
	SortNo int default 0 not null,
	Description nvarchar(500) default ' ' not null,
	ParentName nvarchar(50),
	ParentId PrimaryKey,
	AppId PrimaryKey,
	AppName nvarchar(50),
	TypeName nvarchar(20),
	TypeId PrimaryKey,
	Disable bit default 0 not null
)
go

exec sp_addextendedproperty 'MS_Description', '资源表', 'SCHEMA', 'dbo', 'TABLE', 'Resource'
go

exec sp_addextendedproperty 'MS_Description', '资源标识', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '节点语义ID', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'CascadeId'
go

exec sp_addextendedproperty 'MS_Description', '名称', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '排序号', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'SortNo'
go

exec sp_addextendedproperty 'MS_Description', '描述', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'Description'
go

exec sp_addextendedproperty 'MS_Description', '父节点名称', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'ParentName'
go

exec sp_addextendedproperty 'MS_Description', '父节点流ID', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'ParentId'
go

exec sp_addextendedproperty 'MS_Description', '资源所属应用ID', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'AppId'
go

exec sp_addextendedproperty 'MS_Description', '所属应用名称', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'AppName'
go

exec sp_addextendedproperty 'MS_Description', '分类名称', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'TypeName'
go

exec sp_addextendedproperty 'MS_Description', '分类ID', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'TypeId'
go

exec sp_addextendedproperty 'MS_Description', '是否可用', 'SCHEMA', 'dbo', 'TABLE', 'Resource', 'COLUMN', 'Disable'
go

create table Role
(
	Id PrimaryKey not null
		constraint PK_ROLE
			primary key,
	Name varchar(255) default ' ' not null,
	Status int default 1 not null,
	CreateTime datetime default getdate() not null,
	CreateId PrimaryKey,
	TypeName nvarchar(20),
	TypeId PrimaryKey
)
go

exec sp_addextendedproperty 'MS_Description', '角色表', 'SCHEMA', 'dbo', 'TABLE', 'Role'
go

exec sp_addextendedproperty 'MS_Description', 'Id', 'SCHEMA', 'dbo', 'TABLE', 'Role', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '角色名称', 'SCHEMA', 'dbo', 'TABLE', 'Role', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '当前状态', 'SCHEMA', 'dbo', 'TABLE', 'Role', 'COLUMN', 'Status'
go

exec sp_addextendedproperty 'MS_Description', '创建时间', 'SCHEMA', 'dbo', 'TABLE', 'Role', 'COLUMN', 'CreateTime'
go

exec sp_addextendedproperty 'MS_Description', '创建人ID', 'SCHEMA', 'dbo', 'TABLE', 'Role', 'COLUMN', 'CreateId'
go

exec sp_addextendedproperty 'MS_Description', '分类名称', 'SCHEMA', 'dbo', 'TABLE', 'Role', 'COLUMN', 'TypeName'
go

exec sp_addextendedproperty 'MS_Description', '分类ID', 'SCHEMA', 'dbo', 'TABLE', 'Role', 'COLUMN', 'TypeId'
go

create table Stock
(
	Id PrimaryKey not null
		constraint PK_STOCK
			primary key,
	Name nvarchar(500) default ' ' not null,
	Number int default 0 not null,
	Price decimal(10,1) default 0 not null,
	Status int default 0 not null,
	Viewable varchar(50) default ' ' not null,
	User varchar(50) default ' ' not null,
	Time datetime default getdate() not null,
	OrgId PrimaryKey
)
go

exec sp_addextendedproperty 'MS_Description', '出入库信息表', 'SCHEMA', 'dbo', 'TABLE', 'Stock'
go

exec sp_addextendedproperty 'MS_Description', '数据ID', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '产品名称', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '产品数量', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'Number'
go

exec sp_addextendedproperty 'MS_Description', '产品单价', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'Price'
go

exec sp_addextendedproperty 'MS_Description', '出库/入库', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'Status'
go

exec sp_addextendedproperty 'MS_Description', '可见范围', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'Viewable'
go

exec sp_addextendedproperty 'MS_Description', '操作人', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'User'
go

exec sp_addextendedproperty 'MS_Description', '操作时间', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'Time'
go

exec sp_addextendedproperty 'MS_Description', '组织ID', 'SCHEMA', 'dbo', 'TABLE', 'Stock', 'COLUMN', 'OrgId'
go

create table Test
(
	Id varchar(50) default newid() not null
		constraint PK_Test
			primary key nonclustered,
	data_1 varchar(255) default '',
	data_2 varchar(255) default '',
	data_3 varchar(255) default '',
	checkboxs_0 int default 0 not null,
	data_7 varchar(255) default '',
	data_8 varchar(255) default '',
	data_9 text default '',
	data_10 text default '',
	data_11 varchar(255) default ''
)
go

create table User
(
	Id PrimaryKey not null
		constraint PK_USER
			primary key,
	Account varchar(255) default ' ' not null,
	Password varchar(255) default ' ' not null,
	Name varchar(255) default ' ' not null,
	Sex int default 0 not null,
	Status int default 0 not null,
	BizCode varchar(255) default ' ' not null,
	CreateTime datetime default getdate() not null,
	CrateId PrimaryKey,
	TypeName nvarchar(20),
	TypeId PrimaryKey
)
go

exec sp_addextendedproperty 'MS_Description', '用户基本信息表', 'SCHEMA', 'dbo', 'TABLE', 'User'
go

exec sp_addextendedproperty 'MS_Description', '流水号', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '用户登录帐号', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'Account'
go

exec sp_addextendedproperty 'MS_Description', '密码', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'Password'
go

exec sp_addextendedproperty 'MS_Description', '用户姓名', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'Name'
go

exec sp_addextendedproperty 'MS_Description', '性别', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'Sex'
go

exec sp_addextendedproperty 'MS_Description', '用户状态', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'Status'
go

exec sp_addextendedproperty 'MS_Description', '业务对照码', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'BizCode'
go

exec sp_addextendedproperty 'MS_Description', '经办时间', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'CreateTime'
go

exec sp_addextendedproperty 'MS_Description', '创建人', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'CrateId'
go

exec sp_addextendedproperty 'MS_Description', '分类名称', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'TypeName'
go

exec sp_addextendedproperty 'MS_Description', '分类ID', 'SCHEMA', 'dbo', 'TABLE', 'User', 'COLUMN', 'TypeId'
go

