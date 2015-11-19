/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2015/11/19 21:52:04                          */
/*==============================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('Module')
            and   type = 'U')
   drop table Module
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ModuleElement')
            and   type = 'U')
   drop table ModuleElement
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ModuleElementGrant')
            and   type = 'U')
   drop table ModuleElementGrant
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ModuleRole')
            and   type = 'U')
   drop table ModuleRole
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Org')
            and   type = 'U')
   drop table Org
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Role')
            and   type = 'U')
   drop table Role
go

if exists (select 1
            from  sysobjects
           where  id = object_id('[User]')
            and   type = 'U')
   drop table [User]
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UserCfg')
            and   type = 'U')
   drop table UserCfg
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UserExt')
            and   type = 'U')
   drop table UserExt
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UserModule')
            and   type = 'U')
   drop table UserModule
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UserOrg')
            and   type = 'U')
   drop table UserOrg
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UserRole')
            and   type = 'U')
   drop table UserRole
go

/*==============================================================*/
/* Table: Module                                                */
/*==============================================================*/
create table Module (
   Id                   int                  identity,
   CascadeId            varchar(255)         not null default ' ',
   Name                 varchar(255)         not null default ' ',
   Url                  varchar(255)         not null default ' ',
   HotKey               varchar(255)         not null default ' ',
   ParentId             int                  not null default 0,
   IsLeaf               bit                  not null default 1,
   IsAutoExpand         bit                  not null default 0,
   IconName             varchar(255)         not null default ' ',
   Status               int                  not null default 1,
   ParentName           varchar(255)         not null default ' ',
   Vector               varchar(255)         not null default ' ',
   SortNo               int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Module') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Module' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '功能模块表', 
   'user', @CurrentUser, 'table', 'Module'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能模块流水号',
   'user', @CurrentUser, 'table', 'Module', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CascadeId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'CascadeId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '节点语义ID',
   'user', @CurrentUser, 'table', 'Module', 'column', 'CascadeId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能模块名称',
   'user', @CurrentUser, 'table', 'Module', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Url')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'Url'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主页面URL',
   'user', @CurrentUser, 'table', 'Module', 'column', 'Url'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'HotKey')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'HotKey'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '热键',
   'user', @CurrentUser, 'table', 'Module', 'column', 'HotKey'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ParentId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'ParentId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父节点流水号',
   'user', @CurrentUser, 'table', 'Module', 'column', 'ParentId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsLeaf')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'IsLeaf'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否叶子节点',
   'user', @CurrentUser, 'table', 'Module', 'column', 'IsLeaf'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsAutoExpand')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'IsAutoExpand'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否自动展开',
   'user', @CurrentUser, 'table', 'Module', 'column', 'IsAutoExpand'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IconName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'IconName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '节点图标文件名称',
   'user', @CurrentUser, 'table', 'Module', 'column', 'IconName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Status')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'Status'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '当前状态',
   'user', @CurrentUser, 'table', 'Module', 'column', 'Status'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ParentName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'ParentName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父节点名称',
   'user', @CurrentUser, 'table', 'Module', 'column', 'ParentName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Vector')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'Vector'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '矢量图标',
   'user', @CurrentUser, 'table', 'Module', 'column', 'Vector'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'SortNo')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Module', 'column', 'SortNo'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'Module', 'column', 'SortNo'
go

alter table Module
   add constraint PK_aos_sys_module primary key nonclustered (Id)
go

/*==============================================================*/
/* Table: ModuleElement                                         */
/*==============================================================*/
create table ModuleElement (
   Id                   int                  identity,
   DomId                varchar(255)         not null default ' ',
   Name                 varchar(255)         not null default ' ',
   Type                 int                  not null default 0,
   ModuleId             int                  not null default 0,
   Remark               varchar(4000)        not null default ' '
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('ModuleElement') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'ModuleElement' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '模块元素表(需要权限控制的按钮)', 
   'user', @CurrentUser, 'table', 'ModuleElement'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElement')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElement')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'DomId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'DomId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'DOM ID',
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'DomId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElement')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '名称',
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElement')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Type')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'Type'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '类型',
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'Type'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElement')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModuleId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'ModuleId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能模块Id',
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'ModuleId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElement')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Remark')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'Remark'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'ModuleElement', 'column', 'Remark'
go

alter table ModuleElement
   add constraint PK_MODULEELEMENT primary key (Id)
go

/*==============================================================*/
/* Table: ModuleElementGrant                                    */
/*==============================================================*/
create table ModuleElementGrant (
   Id                   int                  identity,
   ElementId            int                  not null default 0,
   UserId               int                  not null default 0,
   RoleId               int                  not null default 0,
   GrantType            int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('ModuleElementGrant') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'ModuleElementGrant' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '元素授权表', 
   'user', @CurrentUser, 'table', 'ModuleElementGrant'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElementGrant')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElementGrant')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ElementId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'ElementId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '元素流水号',
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'ElementId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElementGrant')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'UserId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'UserId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户流水号',
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'UserId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElementGrant')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RoleId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'RoleId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色流水号',
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'RoleId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleElementGrant')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'GrantType')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'GrantType'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '权限类型',
   'user', @CurrentUser, 'table', 'ModuleElementGrant', 'column', 'GrantType'
go

alter table ModuleElementGrant
   add constraint PK_MODULEELEMENTGRANT primary key (Id)
go

/*==============================================================*/
/* Table: ModuleRole                                            */
/*==============================================================*/
create table ModuleRole (
   Id                   int                  identity,
   RoleId               int                  not null default 0,
   ModuleId             int                  not null default 0,
   Type                 int                  not null default 0,
   OperateTime          datetime             not null default getdate(),
   OperatorId           int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('ModuleRole') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'ModuleRole' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '功能模块-角色关联表', 
   'user', @CurrentUser, 'table', 'ModuleRole'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RoleId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'RoleId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色流水号',
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'RoleId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModuleId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'ModuleId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能模块流水号',
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'ModuleId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Type')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'Type'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '权限类型',
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'Type'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OperateTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'OperateTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '授权时间',
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'OperateTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ModuleRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OperatorId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'OperatorId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '授权人流水号',
   'user', @CurrentUser, 'table', 'ModuleRole', 'column', 'OperatorId'
go

alter table ModuleRole
   add constraint PK_MODULEROLE primary key (Id)
go

/*==============================================================*/
/* Table: Org                                                   */
/*==============================================================*/
create table Org (
   Id                   int                  identity,
   CascadeId            varchar(255)         not null default ' ',
   Name                 varchar(255)         not null default ' ',
   HotKey               varchar(255)         not null default ' ',
   ParentId             int                  not null default 0,
   ParentName           varchar(255)         not null default ' ',
   IsLeaf               bit                  not null default 1,
   IsAutoExpand         bit                  not null default 0,
   IconName             varchar(255)         not null default ' ',
   Status               int                  not null default 1,
   Type                 int                  not null default 0,
   BizCode              varchar(255)         not null default ' ',
   CustomCode           varchar(4000)        not null default ' ',
   CreateTime           datetime             not null default getdate(),
   CreateId             int                  not null default 0,
   SortNo               int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Org') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Org' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '组织表', 
   'user', @CurrentUser, 'table', 'Org'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', 'Org', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CascadeId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'CascadeId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '节点语义ID',
   'user', @CurrentUser, 'table', 'Org', 'column', 'CascadeId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '组织名称',
   'user', @CurrentUser, 'table', 'Org', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'HotKey')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'HotKey'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '热键',
   'user', @CurrentUser, 'table', 'Org', 'column', 'HotKey'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ParentId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'ParentId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父节点流水号',
   'user', @CurrentUser, 'table', 'Org', 'column', 'ParentId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ParentName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'ParentName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父节点名称',
   'user', @CurrentUser, 'table', 'Org', 'column', 'ParentName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsLeaf')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'IsLeaf'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否叶子节点',
   'user', @CurrentUser, 'table', 'Org', 'column', 'IsLeaf'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsAutoExpand')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'IsAutoExpand'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否自动展开',
   'user', @CurrentUser, 'table', 'Org', 'column', 'IsAutoExpand'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IconName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'IconName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '节点图标文件名称',
   'user', @CurrentUser, 'table', 'Org', 'column', 'IconName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Status')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'Status'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '当前状态',
   'user', @CurrentUser, 'table', 'Org', 'column', 'Status'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Type')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'Type'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '组织类型',
   'user', @CurrentUser, 'table', 'Org', 'column', 'Type'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'BizCode')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'BizCode'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '业务对照码',
   'user', @CurrentUser, 'table', 'Org', 'column', 'BizCode'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CustomCode')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'CustomCode'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '自定义扩展码',
   'user', @CurrentUser, 'table', 'Org', 'column', 'CustomCode'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CreateTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'CreateTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'Org', 'column', 'CreateTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CreateId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'CreateId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建人ID',
   'user', @CurrentUser, 'table', 'Org', 'column', 'CreateId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Org')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'SortNo')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Org', 'column', 'SortNo'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'Org', 'column', 'SortNo'
go

alter table Org
   add constraint PK_ORG primary key (Id)
go

/*==============================================================*/
/* Table: Role                                                  */
/*==============================================================*/
create table Role (
   Id                   int                  identity,
   Name                 varchar(255)         not null default ' ',
   Status               int                  not null default 1,
   Type                 int                  not null default 0,
   CreateTime           datetime             not null default getdate(),
   CreateId             varchar(64)          not null default ' ',
   OrgId                int                  not null default 0,
   OrgCascadeId         varchar(255)         not null default ' ',
   OrgName              varchar(255)         not null default ' '
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Role') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Role' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '角色表', 
   'user', @CurrentUser, 'table', 'Role'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', 'Role', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色名称',
   'user', @CurrentUser, 'table', 'Role', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Status')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'Status'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '当前状态',
   'user', @CurrentUser, 'table', 'Role', 'column', 'Status'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Type')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'Type'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色类型',
   'user', @CurrentUser, 'table', 'Role', 'column', 'Type'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CreateTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'CreateTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'Role', 'column', 'CreateTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CreateId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'CreateId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建人ID',
   'user', @CurrentUser, 'table', 'Role', 'column', 'CreateId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OrgId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'OrgId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '所属部门流水号',
   'user', @CurrentUser, 'table', 'Role', 'column', 'OrgId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OrgCascadeId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'OrgCascadeId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '所属部门节点语义ID',
   'user', @CurrentUser, 'table', 'Role', 'column', 'OrgCascadeId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OrgName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Role', 'column', 'OrgName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '所属部门名称',
   'user', @CurrentUser, 'table', 'Role', 'column', 'OrgName'
go

alter table Role
   add constraint PK_ROLE primary key (Id)
go

/*==============================================================*/
/* Table: [User]                                                */
/*==============================================================*/
create table [User] (
   Id                   int                  identity,
   Account              varchar(255)         not null default ' ',
   Password             varchar(255)         not null default ' ',
   Name                 varchar(255)         not null default ' ',
   Sex                  int                  not null default 0,
   Status               int                  not null default 0,
   Type                 int                  not null default 0,
   BizCode              varchar(255)         not null default ' ',
   CreateTime           datetime             not null default getdate(),
   CreateId             int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('[User]') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', '[User]' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '用户基本信息表', 
   'user', @CurrentUser, 'table', '[User]'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', '[User]', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Account')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'Account'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户登录帐号',
   'user', @CurrentUser, 'table', '[User]', 'column', 'Account'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Password')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'Password'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '密码',
   'user', @CurrentUser, 'table', '[User]', 'column', 'Password'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户姓名',
   'user', @CurrentUser, 'table', '[User]', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Sex')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'Sex'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '性别',
   'user', @CurrentUser, 'table', '[User]', 'column', 'Sex'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Status')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'Status'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户状态',
   'user', @CurrentUser, 'table', '[User]', 'column', 'Status'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Type')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'Type'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户类型',
   'user', @CurrentUser, 'table', '[User]', 'column', 'Type'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'BizCode')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'BizCode'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '业务对照码',
   'user', @CurrentUser, 'table', '[User]', 'column', 'BizCode'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CreateTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'CreateTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '经办时间',
   'user', @CurrentUser, 'table', '[User]', 'column', 'CreateTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('[User]')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CreateId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', '[User]', 'column', 'CreateId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '经办人流水号',
   'user', @CurrentUser, 'table', '[User]', 'column', 'CreateId'
go

alter table [User]
   add constraint PK_USER primary key (Id)
go

/*==============================================================*/
/* Table: UserCfg                                               */
/*==============================================================*/
create table UserCfg (
   Id                   int                  not null default 0,
   Theme                varchar(255)         not null default ' ',
   Skin                 varchar(255)         not null default ' ',
   NavBarStyle          varchar(255)         not null default ' ',
   TabFocusColor        varchar(255)         not null default ' ',
   NavTabIndex          int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('UserCfg') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'UserCfg' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '用户配置表', 
   'user', @CurrentUser, 'table', 'UserCfg'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserCfg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户ID',
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserCfg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Theme')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'Theme'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户界面主题',
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'Theme'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserCfg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Skin')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'Skin'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户界面皮肤',
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'Skin'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserCfg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'NavBarStyle')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'NavBarStyle'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '导航条按钮风格',
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'NavBarStyle'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserCfg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'TabFocusColor')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'TabFocusColor'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Tab高亮颜色',
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'TabFocusColor'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserCfg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'NavTabIndex')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'NavTabIndex'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '导航缺省活动页',
   'user', @CurrentUser, 'table', 'UserCfg', 'column', 'NavTabIndex'
go

alter table UserCfg
   add constraint PK_USERCFG primary key (Id)
go

/*==============================================================*/
/* Table: UserExt                                               */
/*==============================================================*/
create table UserExt (
   Id                   int                  not null,
   Email                varchar(255)         not null default ' ',
   Phone_               varchar(255)         not null default ' ',
   Mobile               varchar(255)         not null default ' ',
   Address              varchar(255)         not null default ' ',
   Zip                  varchar(255)         not null default ' ',
   Birthday             varchar(255)         not null default ' ',
   IdCard               varchar(255)         not null default ' ',
   QQ                   varchar(255)         not null default ' ',
   DynamicField         varchar(4000)        not null default ' ',
   ByteArrayId          int                  not null default 0,
   Remark               varchar(4000)        not null default ' ',
   Field1               varchar(255)         not null default ' ',
   Field2               varchar(255)         not null default ' ',
   Field3               varchar(255)         not null default ' '
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('UserExt') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'UserExt' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '用户扩展信息表', 
   'user', @CurrentUser, 'table', 'UserExt'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户ID',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Email')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Email'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '电子邮件',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Email'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Phone_')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Phone_'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '固定电话',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Phone_'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Mobile')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Mobile'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '移动电话',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Mobile'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Address')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Address'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '联系地址',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Address'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Zip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Zip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '邮编',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Zip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Birthday')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Birthday'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '生日',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Birthday'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IdCard')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'IdCard'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '身份证号',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'IdCard'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'QQ')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'QQ'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'QQ',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'QQ'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'DynamicField')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'DynamicField'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '动态扩展字段',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'DynamicField'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ByteArrayId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'ByteArrayId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户头像流文件ID',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'ByteArrayId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Remark')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Remark'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Remark'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Field1')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Field1'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '静态扩展字段1',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Field1'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Field2')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Field2'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '静态扩展字段2',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Field2'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserExt')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Field3')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Field3'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '静态扩展字段3',
   'user', @CurrentUser, 'table', 'UserExt', 'column', 'Field3'
go

alter table UserExt
   add constraint PK_USEREXT primary key (Id)
go

/*==============================================================*/
/* Table: UserModule                                            */
/*==============================================================*/
create table UserModule (
   Id                   int                  identity,
   UserId               int                  not null default 0,
   ModuleId             int                  not null default 0,
   Type                 int                  not null default 0,
   OperateTime          datetime             not null default getdate(),
   OperatorId           int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('UserModule') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'UserModule' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '功能模块-用户关联表', 
   'user', @CurrentUser, 'table', 'UserModule'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserModule')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserModule')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'UserId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'UserId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户流水号',
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'UserId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserModule')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModuleId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'ModuleId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能模块流水号',
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'ModuleId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserModule')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Type')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'Type'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '权限类型',
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'Type'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserModule')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OperateTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'OperateTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '授权时间',
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'OperateTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserModule')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OperatorId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'OperatorId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '授权人',
   'user', @CurrentUser, 'table', 'UserModule', 'column', 'OperatorId'
go

alter table UserModule
   add constraint PK_USERMODULE primary key (Id)
go

/*==============================================================*/
/* Table: UserOrg                                               */
/*==============================================================*/
create table UserOrg (
   Id                   int                  identity,
   OrgId                int                  not null default 0,
   UserId               int                  not null default 0,
   OperateTime          datetime             not null default getdate(),
   OperatorId           int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('UserOrg') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'UserOrg' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '用户-部门关联表', 
   'user', @CurrentUser, 'table', 'UserOrg'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserOrg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserOrg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OrgId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'OrgId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '部门流水号',
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'OrgId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserOrg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'UserId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'UserId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户流水号',
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'UserId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserOrg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OperateTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'OperateTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '授权时间',
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'OperateTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserOrg')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OperatorId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'OperatorId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '授权人流水号',
   'user', @CurrentUser, 'table', 'UserOrg', 'column', 'OperatorId'
go

alter table UserOrg
   add constraint PK_USERORG primary key (Id)
go

/*==============================================================*/
/* Table: UserRole                                              */
/*==============================================================*/
create table UserRole (
   Id                   int                  identity,
   RoleId               int                  not null default 0,
   UserId               int                  not null default 0,
   OperateTime          datetime             not null default getdate(),
   OperatorId           int                  not null default 0
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('UserRole') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'UserRole' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '用户-角色关联表', 
   'user', @CurrentUser, 'table', 'UserRole'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'Id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '流水号',
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'Id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RoleId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'RoleId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色ID',
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'RoleId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'UserId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'UserId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户流水号',
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'UserId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OperateTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'OperateTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '授权时间',
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'OperateTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('UserRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OperatorId')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'OperatorId'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '授权人流水号',
   'user', @CurrentUser, 'table', 'UserRole', 'column', 'OperatorId'
go

alter table UserRole
   add constraint PK_USERROLE primary key (Id)
go

