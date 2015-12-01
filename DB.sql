
USE [OpenAuthDB]
GO
/****** Object:  UserDefinedDataType [dbo].[varchar(max)]    Script Date: 12/01/2015 22:43:33 ******/
CREATE TYPE [dbo].[varchar(max)] FROM [varchar](max) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[varchar(50)]    Script Date: 12/01/2015 22:43:33 ******/
CREATE TYPE [dbo].[varchar(50)] FROM [varchar](50) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[varchar(200)]    Script Date: 12/01/2015 22:43:33 ******/
CREATE TYPE [dbo].[varchar(200)] FROM [varchar](200) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[decimal (16,2)]    Script Date: 12/01/2015 22:43:33 ******/
CREATE TYPE [dbo].[decimal (16,2)] FROM [decimal](16, 2) NULL
GO
/****** Object:  Table [dbo].[UserExt]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserExt](
	[Id] [int] NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Phone_] [varchar](255) NOT NULL,
	[Mobile] [varchar](255) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Zip] [varchar](255) NOT NULL,
	[Birthday] [varchar](255) NOT NULL,
	[IdCard] [varchar](255) NOT NULL,
	[QQ] [varchar](255) NOT NULL,
	[DynamicField] [varchar](4000) NOT NULL,
	[ByteArrayId] [int] NOT NULL,
	[Remark] [varchar](4000) NOT NULL,
	[Field1] [varchar](255) NOT NULL,
	[Field2] [varchar](255) NOT NULL,
	[Field3] [varchar](255) NOT NULL,
 CONSTRAINT [PK_USEREXT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'固定电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Phone_'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'移动电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Mobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮编' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Zip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生日' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身份证号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'IdCard'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'QQ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'QQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'动态扩展字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'DynamicField'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户头像流文件ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'ByteArrayId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'静态扩展字段1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Field1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'静态扩展字段2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Field2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'静态扩展字段3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt', @level2type=N'COLUMN',@level2name=N'Field3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户扩展信息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserExt'
GO
/****** Object:  Table [dbo].[UserCfg]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserCfg](
	[Id] [int] NOT NULL,
	[Theme] [varchar](255) NOT NULL,
	[Skin] [varchar](255) NOT NULL,
	[NavBarStyle] [varchar](255) NOT NULL,
	[TabFocusColor] [varchar](255) NOT NULL,
	[NavTabIndex] [int] NOT NULL,
 CONSTRAINT [PK_USERCFG] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCfg', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户界面主题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCfg', @level2type=N'COLUMN',@level2name=N'Theme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户界面皮肤' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCfg', @level2type=N'COLUMN',@level2name=N'Skin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'导航条按钮风格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCfg', @level2type=N'COLUMN',@level2name=N'NavBarStyle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tab高亮颜色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCfg', @level2type=N'COLUMN',@level2name=N'TabFocusColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'导航缺省活动页' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCfg', @level2type=N'COLUMN',@level2name=N'NavTabIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户配置表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCfg'
GO
/****** Object:  Table [dbo].[User]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Account] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Sex] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[BizCode] [varchar](255) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateId] [int] NOT NULL,
 CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (1, N'admin', N'admin', N'管理员', 0, 0, 0, N'', CAST(0x0000A561016E8E6F AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (2, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C30A AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (3, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C4E5 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (4, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C4E8 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (5, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C4EE AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (6, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C4F5 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (7, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C4FD AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (8, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C504 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (9, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C50C AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (10, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C519 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (11, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C520 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (12, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C528 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (13, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C52F AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (14, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C537 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (15, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C53E AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (16, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C546 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (17, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C54D AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (18, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C555 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (19, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C55C AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (20, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C564 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (21, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C56B AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (22, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C573 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (23, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C57A AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (24, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C584 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (25, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C587 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (26, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C589 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (27, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C58C AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (28, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C58E AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (29, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C591 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (30, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C593 AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Account], [Password], [Name], [Sex], [Status], [Type], [BizCode], [CreateTime], [CreateId]) VALUES (31, N'user22_22_37_2237', N'user22_22_37_2237', N'新用户22_22_37_2237', 0, 0, 0, N'', CAST(0x0000A5610170C595 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[User] OFF
/****** Object:  Table [dbo].[Role]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Status] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateId] [varchar](64) NOT NULL,
	[OrgId] [int] NOT NULL,
	[OrgCascadeId] [varchar](255) NOT NULL,
	[OrgName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_ROLE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'CreateId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属部门流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'OrgId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属部门节点语义ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'OrgCascadeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属部门名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'OrgName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role'
GO
SET IDENTITY_INSERT [dbo].[Role] ON
INSERT [dbo].[Role] ([Id], [Name], [Status], [Type], [CreateTime], [CreateId], [OrgId], [OrgCascadeId], [OrgName]) VALUES (1, N'第一总部管理员', 0, 0, CAST(0x0000A561017106FF AS DateTime), N'', 1, N'0.1', N'集团总部')
SET IDENTITY_INSERT [dbo].[Role] OFF
/****** Object:  Table [dbo].[Relevance]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Relevance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstId] [int] NOT NULL,
	[SecondId] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Key] [varchar](100) NOT NULL,
	[Status] [int] NOT NULL,
	[OperateTime] [datetime] NOT NULL,
	[OperatorId] [int] NOT NULL,
 CONSTRAINT [PK_RELEVANCE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Relevance', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'第一个表主键ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Relevance', @level2type=N'COLUMN',@level2name=N'FirstId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'第二个表主键ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Relevance', @level2type=N'COLUMN',@level2name=N'SecondId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Relevance', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Relevance', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'授权时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Relevance', @level2type=N'COLUMN',@level2name=N'OperateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'授权人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Relevance', @level2type=N'COLUMN',@level2name=N'OperatorId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'多对多关系集中映射' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Relevance'
GO
SET IDENTITY_INSERT [dbo].[Relevance] ON
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (1, 1, 1, N'', N'UserOrg', 0, CAST(0x0000A561016E8ECD AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (2, 1, 0, N'', N'UserModule', 0, CAST(0x0000A561016EDC3E AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (3, 1, 2, N'', N'UserModule', 0, CAST(0x0000A561016EDC3F AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (4, 1, 1, N'', N'UserModule', 0, CAST(0x0000A561016EDC3F AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (5, 2, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C4E3 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (6, 2, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C4E4 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (7, 3, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C4E7 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (8, 3, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C4E8 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (9, 4, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C4E9 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (10, 4, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C4EC AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (11, 5, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C4F2 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (12, 5, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C4F3 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (13, 6, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C4F9 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (14, 6, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C4FB AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (15, 7, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C501 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (16, 7, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C502 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (17, 8, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C508 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (18, 8, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C50A AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (19, 9, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C514 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (20, 9, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C516 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (21, 10, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C51C AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (22, 10, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C51E AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (23, 11, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C524 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (24, 11, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C525 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (25, 12, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C52B AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (26, 12, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C52D AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (27, 13, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C533 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (28, 13, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C534 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (29, 14, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C53A AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (30, 14, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C53C AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (31, 15, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C542 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (32, 15, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C543 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (33, 16, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C549 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (34, 16, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C54B AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (35, 17, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C551 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (36, 17, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C552 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (37, 18, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C558 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (38, 18, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C55A AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (39, 19, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C560 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (40, 19, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C561 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (41, 20, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C568 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (42, 20, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C569 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (43, 21, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C56F AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (44, 21, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C570 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (45, 22, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C576 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (46, 22, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C578 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (47, 23, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C57E AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (48, 23, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C584 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (49, 24, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C586 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (50, 24, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C586 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (51, 25, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C588 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (52, 25, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C588 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (53, 26, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C58B AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (54, 26, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C58B AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (55, 27, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C58E AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (56, 27, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C58E AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (57, 28, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C590 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (58, 28, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C590 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (59, 29, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C592 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (60, 29, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C593 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (61, 30, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C595 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (62, 30, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C595 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (63, 31, 3, N'', N'UserOrg', 0, CAST(0x0000A5610170C597 AS DateTime), 0)
INSERT [dbo].[Relevance] ([Id], [FirstId], [SecondId], [Description], [Key], [Status], [OperateTime], [OperatorId]) VALUES (64, 31, 2, N'', N'UserOrg', 0, CAST(0x0000A5610170C597 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Relevance] OFF
/****** Object:  Table [dbo].[Org]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Org](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CascadeId] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[HotKey] [varchar](255) NOT NULL,
	[ParentId] [int] NOT NULL,
	[ParentName] [varchar](255) NOT NULL,
	[IsLeaf] [bit] NOT NULL,
	[IsAutoExpand] [bit] NOT NULL,
	[IconName] [varchar](255) NOT NULL,
	[Status] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[BizCode] [varchar](255) NOT NULL,
	[CustomCode] [varchar](4000) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateId] [int] NOT NULL,
	[SortNo] [int] NOT NULL,
 CONSTRAINT [PK_ORG] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点语义ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'CascadeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组织名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'热键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'HotKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父节点流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父节点名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'ParentName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否叶子节点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'IsLeaf'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否自动展开' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'IsAutoExpand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点图标文件名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'IconName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组织类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'业务对照码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'BizCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自定义扩展码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'CustomCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'CreateId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org', @level2type=N'COLUMN',@level2name=N'SortNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组织表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Org'
GO
SET IDENTITY_INSERT [dbo].[Org] ON
INSERT [dbo].[Org] ([Id], [CascadeId], [Name], [HotKey], [ParentId], [ParentName], [IsLeaf], [IsAutoExpand], [IconName], [Status], [Type], [BizCode], [CustomCode], [CreateTime], [CreateId], [SortNo]) VALUES (1, N'0.1', N'集团总部', N'', 0, N'根节点', 0, 0, N'', 0, 0, N'', N'', CAST(0x0000A561016D8B1C AS DateTime), 0, 0)
INSERT [dbo].[Org] ([Id], [CascadeId], [Name], [HotKey], [ParentId], [ParentName], [IsLeaf], [IsAutoExpand], [IconName], [Status], [Type], [BizCode], [CustomCode], [CreateTime], [CreateId], [SortNo]) VALUES (2, N'0.1.1', N'一分公司', N'', 1, N'集团总部', 0, 0, N'', 0, 0, N'', N'', CAST(0x0000A561016D8D08 AS DateTime), 0, 0)
INSERT [dbo].[Org] ([Id], [CascadeId], [Name], [HotKey], [ParentId], [ParentName], [IsLeaf], [IsAutoExpand], [IconName], [Status], [Type], [BizCode], [CustomCode], [CreateTime], [CreateId], [SortNo]) VALUES (3, N'0.1.2', N'二分公司', N'', 1, N'集团总部', 0, 0, N'', 0, 0, N'', N'', CAST(0x0000A561016D8D12 AS DateTime), 0, 0)
INSERT [dbo].[Org] ([Id], [CascadeId], [Name], [HotKey], [ParentId], [ParentName], [IsLeaf], [IsAutoExpand], [IconName], [Status], [Type], [BizCode], [CustomCode], [CreateTime], [CreateId], [SortNo]) VALUES (4, N'0.1.3', N'三分公司', N'', 1, N'集团总部', 0, 0, N'', 0, 0, N'', N'', CAST(0x0000A561016D8D13 AS DateTime), 0, 0)
INSERT [dbo].[Org] ([Id], [CascadeId], [Name], [HotKey], [ParentId], [ParentName], [IsLeaf], [IsAutoExpand], [IconName], [Status], [Type], [BizCode], [CustomCode], [CreateTime], [CreateId], [SortNo]) VALUES (5, N'0.2', N'集团总部2', N'', 0, N'根节点', 0, 0, N'', 0, 0, N'', N'', CAST(0x0000A5610170A8C2 AS DateTime), 0, 0)
INSERT [dbo].[Org] ([Id], [CascadeId], [Name], [HotKey], [ParentId], [ParentName], [IsLeaf], [IsAutoExpand], [IconName], [Status], [Type], [BizCode], [CustomCode], [CreateTime], [CreateId], [SortNo]) VALUES (6, N'0.2.1', N'一分公司2', N'', 5, N'集团总部2', 0, 0, N'', 0, 0, N'', N'', CAST(0x0000A5610170AA98 AS DateTime), 0, 0)
INSERT [dbo].[Org] ([Id], [CascadeId], [Name], [HotKey], [ParentId], [ParentName], [IsLeaf], [IsAutoExpand], [IconName], [Status], [Type], [BizCode], [CustomCode], [CreateTime], [CreateId], [SortNo]) VALUES (7, N'0.2.2', N'二分公司2', N'', 5, N'集团总部2', 0, 0, N'', 0, 0, N'', N'', CAST(0x0000A5610170AAA0 AS DateTime), 0, 0)
INSERT [dbo].[Org] ([Id], [CascadeId], [Name], [HotKey], [ParentId], [ParentName], [IsLeaf], [IsAutoExpand], [IconName], [Status], [Type], [BizCode], [CustomCode], [CreateTime], [CreateId], [SortNo]) VALUES (8, N'0.2.3', N'三分公司2', N'', 5, N'集团总部2', 0, 0, N'', 0, 0, N'', N'', CAST(0x0000A5610170AAA0 AS DateTime), 0, 0)
SET IDENTITY_INSERT [dbo].[Org] OFF
/****** Object:  Table [dbo].[ModuleElementGrant]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleElementGrant](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ElementId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[GrantType] [int] NOT NULL,
 CONSTRAINT [PK_MODULEELEMENTGRANT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElementGrant', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'元素流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElementGrant', @level2type=N'COLUMN',@level2name=N'ElementId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElementGrant', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElementGrant', @level2type=N'COLUMN',@level2name=N'RoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElementGrant', @level2type=N'COLUMN',@level2name=N'GrantType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'元素授权表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElementGrant'
GO
/****** Object:  Table [dbo].[ModuleElement]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ModuleElement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DomId] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Type] [int] NOT NULL,
	[ModuleId] [int] NOT NULL,
	[Remark] [varchar](4000) NOT NULL,
 CONSTRAINT [PK_MODULEELEMENT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElement', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DOM ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElement', @level2type=N'COLUMN',@level2name=N'DomId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElement', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElement', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能模块Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElement', @level2type=N'COLUMN',@level2name=N'ModuleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElement', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块元素表(需要权限控制的按钮)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleElement'
GO
/****** Object:  Table [dbo].[Module]    Script Date: 12/01/2015 22:43:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Module](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CascadeId] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Url] [varchar](255) NOT NULL,
	[HotKey] [varchar](255) NOT NULL,
	[ParentId] [int] NOT NULL,
	[IsLeaf] [bit] NOT NULL,
	[IsAutoExpand] [bit] NOT NULL,
	[IconName] [varchar](255) NOT NULL,
	[Status] [int] NOT NULL,
	[ParentName] [varchar](255) NOT NULL,
	[Vector] [varchar](255) NOT NULL,
	[SortNo] [int] NOT NULL,
 CONSTRAINT [PK_aos_sys_module] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能模块流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点语义ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'CascadeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能模块名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主页面URL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'Url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'热键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'HotKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父节点流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否叶子节点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'IsLeaf'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否自动展开' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'IsAutoExpand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点图标文件名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'IconName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父节点名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'ParentName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'矢量图标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'Vector'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'SortNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能模块表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module'
GO
SET IDENTITY_INSERT [dbo].[Module] ON
INSERT [dbo].[Module] ([Id], [CascadeId], [Name], [Url], [HotKey], [ParentId], [IsLeaf], [IsAutoExpand], [IconName], [Status], [ParentName], [Vector], [SortNo]) VALUES (1, N'0.1.1', N'模块管理', N'ModuleManager/Index', N' ', 2, 1, 0, N' ', 1, N' ', N' ', 0)
INSERT [dbo].[Module] ([Id], [CascadeId], [Name], [Url], [HotKey], [ParentId], [IsLeaf], [IsAutoExpand], [IconName], [Status], [ParentName], [Vector], [SortNo]) VALUES (2, N'0.1', N'基础配置', N' ', N' ', 0, 1, 0, N' ', 1, N' ', N' ', 0)
INSERT [dbo].[Module] ([Id], [CascadeId], [Name], [Url], [HotKey], [ParentId], [IsLeaf], [IsAutoExpand], [IconName], [Status], [ParentName], [Vector], [SortNo]) VALUES (3, N'0.1.2', N'用户管理', N'UserManager/Index', N'', 2, 0, 0, N'', 0, N'基础配置', N'', 0)
INSERT [dbo].[Module] ([Id], [CascadeId], [Name], [Url], [HotKey], [ParentId], [IsLeaf], [IsAutoExpand], [IconName], [Status], [ParentName], [Vector], [SortNo]) VALUES (4, N'0.1.3', N'部门管理', N'OrgManager/Index', N'', 2, 0, 0, N'', 0, N'基础配置', N'', 0)
INSERT [dbo].[Module] ([Id], [CascadeId], [Name], [Url], [HotKey], [ParentId], [IsLeaf], [IsAutoExpand], [IconName], [Status], [ParentName], [Vector], [SortNo]) VALUES (5, N'0.1.4', N'角色管理', N'RoleManager/Index', N'', 2, 0, 0, N'', 0, N'基础配置', N'', 0)
INSERT [dbo].[Module] ([Id], [CascadeId], [Name], [Url], [HotKey], [ParentId], [IsLeaf], [IsAutoExpand], [IconName], [Status], [ParentName], [Vector], [SortNo]) VALUES (6, N'0.2', N'应用功能', N'', N'', 0, 0, 0, N'', 0, N'根节点', N'', 0)
INSERT [dbo].[Module] ([Id], [CascadeId], [Name], [Url], [HotKey], [ParentId], [IsLeaf], [IsAutoExpand], [IconName], [Status], [ParentName], [Vector], [SortNo]) VALUES (7, N'0.2.1', N'报表管理', N'', N'', 6, 0, 0, N'', 0, N'应用功能', N'', 0)
SET IDENTITY_INSERT [dbo].[Module] OFF
/****** Object:  Default [DF__UserExt__Email__1CB22475]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Email]
GO
/****** Object:  Default [DF__UserExt__Phone___1DA648AE]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Phone_]
GO
/****** Object:  Default [DF__UserExt__Mobile__1E9A6CE7]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Mobile]
GO
/****** Object:  Default [DF__UserExt__Address__1F8E9120]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Address]
GO
/****** Object:  Default [DF__UserExt__Zip__2082B559]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Zip]
GO
/****** Object:  Default [DF__UserExt__Birthda__2176D992]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Birthday]
GO
/****** Object:  Default [DF__UserExt__IdCard__226AFDCB]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [IdCard]
GO
/****** Object:  Default [DF__UserExt__QQ__235F2204]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [QQ]
GO
/****** Object:  Default [DF__UserExt__Dynamic__2453463D]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [DynamicField]
GO
/****** Object:  Default [DF__UserExt__ByteArr__25476A76]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT ((0)) FOR [ByteArrayId]
GO
/****** Object:  Default [DF__UserExt__Remark__263B8EAF]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Remark]
GO
/****** Object:  Default [DF__UserExt__Field1__272FB2E8]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Field1]
GO
/****** Object:  Default [DF__UserExt__Field2__2823D721]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Field2]
GO
/****** Object:  Default [DF__UserExt__Field3__2917FB5A]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserExt] ADD  DEFAULT (' ') FOR [Field3]
GO
/****** Object:  Default [DF__UserCfg__Id__151102AD]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserCfg] ADD  DEFAULT ((0)) FOR [Id]
GO
/****** Object:  Default [DF__UserCfg__Theme__160526E6]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserCfg] ADD  DEFAULT (' ') FOR [Theme]
GO
/****** Object:  Default [DF__UserCfg__Skin__16F94B1F]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserCfg] ADD  DEFAULT (' ') FOR [Skin]
GO
/****** Object:  Default [DF__UserCfg__NavBarS__17ED6F58]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserCfg] ADD  DEFAULT (' ') FOR [NavBarStyle]
GO
/****** Object:  Default [DF__UserCfg__TabFocu__18E19391]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserCfg] ADD  DEFAULT (' ') FOR [TabFocusColor]
GO
/****** Object:  Default [DF__UserCfg__NavTabI__19D5B7CA]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[UserCfg] ADD  DEFAULT ((0)) FOR [NavTabIndex]
GO
/****** Object:  Default [DF__User__Account__0A93743A]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT (' ') FOR [Account]
GO
/****** Object:  Default [DF__User__Password__0B879873]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT (' ') FOR [Password]
GO
/****** Object:  Default [DF__User__Name__0C7BBCAC]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT (' ') FOR [Name]
GO
/****** Object:  Default [DF__User__Sex__0D6FE0E5]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [Sex]
GO
/****** Object:  Default [DF__User__Status__0E64051E]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [Status]
GO
/****** Object:  Default [DF__User__Type__0F582957]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF__User__BizCode__104C4D90]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT (' ') FOR [BizCode]
GO
/****** Object:  Default [DF__User__CreateTime__114071C9]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
/****** Object:  Default [DF__User__CreateId__12349602]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [CreateId]
GO
/****** Object:  Default [DF__Role__Name__010A0A00]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Role] ADD  DEFAULT (' ') FOR [Name]
GO
/****** Object:  Default [DF__Role__Status__01FE2E39]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Role] ADD  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  Default [DF__Role__Type__02F25272]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Role] ADD  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF__Role__CreateTime__03E676AB]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Role] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
/****** Object:  Default [DF__Role__CreateId__04DA9AE4]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Role] ADD  DEFAULT (' ') FOR [CreateId]
GO
/****** Object:  Default [DF__Role__OrgId__05CEBF1D]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Role] ADD  DEFAULT ((0)) FOR [OrgId]
GO
/****** Object:  Default [DF__Role__OrgCascade__06C2E356]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Role] ADD  DEFAULT (' ') FOR [OrgCascadeId]
GO
/****** Object:  Default [DF__Role__OrgName__07B7078F]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Role] ADD  DEFAULT (' ') FOR [OrgName]
GO
/****** Object:  Default [DF__Relevance__First__7874C3FF]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Relevance] ADD  DEFAULT ((0)) FOR [FirstId]
GO
/****** Object:  Default [DF__Relevance__Secon__7968E838]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Relevance] ADD  DEFAULT ((0)) FOR [SecondId]
GO
/****** Object:  Default [DF__Relevance__Descr__7A5D0C71]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Relevance] ADD  DEFAULT (' ') FOR [Description]
GO
/****** Object:  Default [DF__Relevance__Key__7B5130AA]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Relevance] ADD  DEFAULT (' ') FOR [Key]
GO
/****** Object:  Default [DF__Relevance__Statu__7C4554E3]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Relevance] ADD  DEFAULT ((0)) FOR [Status]
GO
/****** Object:  Default [DF__Relevance__Opera__7D39791C]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Relevance] ADD  DEFAULT (getdate()) FOR [OperateTime]
GO
/****** Object:  Default [DF__Relevance__Opera__7E2D9D55]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Relevance] ADD  DEFAULT ((0)) FOR [OperatorId]
GO
/****** Object:  Default [DF__Org__CascadeId__683E5C36]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT (' ') FOR [CascadeId]
GO
/****** Object:  Default [DF__Org__Name__6932806F]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT (' ') FOR [Name]
GO
/****** Object:  Default [DF__Org__HotKey__6A26A4A8]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT (' ') FOR [HotKey]
GO
/****** Object:  Default [DF__Org__ParentId__6B1AC8E1]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT ((0)) FOR [ParentId]
GO
/****** Object:  Default [DF__Org__ParentName__6C0EED1A]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT (' ') FOR [ParentName]
GO
/****** Object:  Default [DF__Org__IsLeaf__6D031153]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT ((1)) FOR [IsLeaf]
GO
/****** Object:  Default [DF__Org__IsAutoExpan__6DF7358C]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT ((0)) FOR [IsAutoExpand]
GO
/****** Object:  Default [DF__Org__IconName__6EEB59C5]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT (' ') FOR [IconName]
GO
/****** Object:  Default [DF__Org__Status__6FDF7DFE]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  Default [DF__Org__Type__70D3A237]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF__Org__BizCode__71C7C670]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT (' ') FOR [BizCode]
GO
/****** Object:  Default [DF__Org__CustomCode__72BBEAA9]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT (' ') FOR [CustomCode]
GO
/****** Object:  Default [DF__Org__CreateTime__73B00EE2]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
/****** Object:  Default [DF__Org__CreateId__74A4331B]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT ((0)) FOR [CreateId]
GO
/****** Object:  Default [DF__Org__SortNo__75985754]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Org] ADD  DEFAULT ((0)) FOR [SortNo]
GO
/****** Object:  Default [DF__ModuleEle__Eleme__628582E0]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElementGrant] ADD  DEFAULT ((0)) FOR [ElementId]
GO
/****** Object:  Default [DF__ModuleEle__UserI__6379A719]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElementGrant] ADD  DEFAULT ((0)) FOR [UserId]
GO
/****** Object:  Default [DF__ModuleEle__RoleI__646DCB52]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElementGrant] ADD  DEFAULT ((0)) FOR [RoleId]
GO
/****** Object:  Default [DF__ModuleEle__Grant__6561EF8B]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElementGrant] ADD  DEFAULT ((0)) FOR [GrantType]
GO
/****** Object:  Default [DF__ModuleEle__DomId__5BD88551]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElement] ADD  DEFAULT (' ') FOR [DomId]
GO
/****** Object:  Default [DF__ModuleElem__Name__5CCCA98A]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElement] ADD  DEFAULT (' ') FOR [Name]
GO
/****** Object:  Default [DF__ModuleElem__Type__5DC0CDC3]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElement] ADD  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF__ModuleEle__Modul__5EB4F1FC]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElement] ADD  DEFAULT ((0)) FOR [ModuleId]
GO
/****** Object:  Default [DF__ModuleEle__Remar__5FA91635]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[ModuleElement] ADD  DEFAULT (' ') FOR [Remark]
GO
/****** Object:  Default [DF__Module__CascadeI__4E7E8A33]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT (' ') FOR [CascadeId]
GO
/****** Object:  Default [DF__Module__Name__4F72AE6C]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT (' ') FOR [Name]
GO
/****** Object:  Default [DF__Module__Url__5066D2A5]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT (' ') FOR [Url]
GO
/****** Object:  Default [DF__Module__HotKey__515AF6DE]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT (' ') FOR [HotKey]
GO
/****** Object:  Default [DF__Module__ParentId__524F1B17]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT ((0)) FOR [ParentId]
GO
/****** Object:  Default [DF__Module__IsLeaf__53433F50]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT ((1)) FOR [IsLeaf]
GO
/****** Object:  Default [DF__Module__IsAutoEx__54376389]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT ((0)) FOR [IsAutoExpand]
GO
/****** Object:  Default [DF__Module__IconName__552B87C2]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT (' ') FOR [IconName]
GO
/****** Object:  Default [DF__Module__Status__561FABFB]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  Default [DF__Module__ParentNa__5713D034]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT (' ') FOR [ParentName]
GO
/****** Object:  Default [DF__Module__Vector__5807F46D]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT (' ') FOR [Vector]
GO
/****** Object:  Default [DF__Module__SortNo__58FC18A6]    Script Date: 12/01/2015 22:43:34 ******/
ALTER TABLE [dbo].[Module] ADD  DEFAULT ((0)) FOR [SortNo]
GO
