![LOGO](https://gitee.com/uploads/images/2018/0425/163228_7077c3fd_362401.png "1.png")

**logo图标含义** OpenAuth中OA字母的结合体；整体像鱼，授人以渔；你非说像咸鱼，那也是积极向上的咸鱼；中心是个笑脸，微笑面对生活(✿◡‿◡)。

本项目为OpenAuth.Net基于.net core（最新sdk版本:.net core 3.1.100)的跨平台版本，使用.net 4.5的同学请移步：https://gitee.com/yubaolee/OpenAuth.Net

**官方网站** http://www.openauth.me

**官方文档**  http://doc.openauth.me 


## 官方QQ交流群  

1. 484498493【已满】

1. 626433139【已满】

1. [![快速加群](https://img.shields.io/badge/qq%E7%BE%A4-566344079-blue.svg)](http://shang.qq.com/wpa/qunwpa?idkey=aa850ac69f1f43ab4be39ecddd6030a937e9236d95966a707fcb667491049fdc)

## 演示直达

* VUE版版本演示地址： http://demo.openauth.me:1803

* LayUI版本演示地址： http://demo.openauth.me:1802

## 核心看点

* 支持.net core sdk 3.1.100

* 超强的自定义权限控制功能，可灵活配置用户、角色可访问的数据权限

* 完整的字段权限控制，可以控制字段可见及API是否返回字段值

* 可拖拽的表单设计  

* 可视化流程设计  

* 基于CodeSmith的代码生成功能，可快速生成带有头/明细结构的页面

* 支持sqlserver、mysql数据库，理论上支持所有数据库

* 集成IdentityServer4，实现基于OAuth2的登录体系

* 建立三方对接规范，已有系统可以无缝对接流程引擎

* 前端采用 vue + layui + ztree + gooflow + leipiformdesign

* 后端采用 EF core+ autofac + json.net + swagger

* 设计工具 PowerDesigner + Enterprise Architect


## 秀外
![输入图片说明](https://gitee.com/uploads/images/2018/0328/173337_6e017075_362401.png "表单设计")
![输入图片说明](https://gitee.com/uploads/images/2018/0328/150758_26ef9d61_362401.png "流程设计")

## 慧中

教科书级的分层思想，哪怕苛刻的你阅读的是大神级精典大作（如：《企业应用架构模式》《重构与模式》《ASP.NET设计模式》等），你也可以参考本项目。不信？有图为证，Resharper自动生成的项目引用关系，毫无PS痕迹！

![输入图片说明](https://gitee.com/uploads/images/2015/1113/233705_271ecb3a_362401.jpeg "在这里输入图片标题")

## 权限资源

符合国情的RBAC（基于角色的访问控制），可以直接应用到你的系统。具体说明请查看：[通用权限设计与实现](https://www.cnblogs.com/yubaolee/p/DataPrivilege.html)

1. 菜单权限  经理和业务员登陆系统拥有的功能菜单是不一样的
2. 按钮权限  经理能够审批，而业务员不可以
3. 数据权限  A业务员看不到B业务员的单据
4. 字段权限  某些人查询客户信息时看不到客户的手机号或其它字段

**用户**应用系统的具体操作者，我这里设计用户是可以直接给用户分配菜单/按钮，也可以通过角色分配权限。

**角色**为了对许多拥有相似权限的用户进行分类管理，定义了角色的概念，以上所有的权限资源都可以分配给角色，角色和用户N:N的关系。

**机构**树形的公司部门结构，国内公司用的比较多，它实际上就是一个用户组，机构和用户设计成N:N的关系，也就是说有时候一个用户可以从属于两个部门，这种情况在我们客户需求中的确都出现过。

## 系统工程结构：
1. Infrastructure 通用工具集合
1. OpenAuth.Repository 系统仓储层，用于数据库操作
1. OpenAuth.App 应用层，为界面提供接口
1. OpenAuth.Mvc Web站点
1. OpenAuth.WebApi 为vue版或其他三方系统提供接口服务
1. OpenAuth.Identity 基于IdentityServer4的单点登录服务

## 使用
管理员可直接在登录界面用System登录；

普通应用账号使用用户列表的用户登录，初始密码与用户名相同；

## 后续
生命不息，更新不止


