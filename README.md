![LOGO](https://gitee.com/uploads/images/2018/0425/163228_7077c3fd_362401.png "1.png")


本项目为OpenAuth.Net基于.net core 2.1的跨平台版本，**数据库初始脚本、数据库设计结构**及使用.net 4.5的同学请移步：https://gitee.com/yubaolee/OpenAuth.Net

**官方网站** http://www.openauth.me

**官方文档**  http://doc.openauth.me 

## 关于OpenAuth.Net企业版的说明：

目前OpenAuth.Net以全部开源的方式向大众开放,对于有经验的开发者，官方文档足以满足日常开发。为了能让项目走的更远，特推出VIP服务，提供VIP专属QQ群，第一时间提供开发进度、内部文档、1V1专属咨询服务等。

为了进一步扩大会员用户的权益，官方将于近期针对VIP2用户推出专属版本，该版本基于OpenAuth.Core的API接口，前端采用VUE全家桶（VUE+VUEX+VUE-ROUTER）及ElementUI界面，全面拥抱单页面SPA开发，[如何获取请查看这里](http://www.openauth.me/questions/detail?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)，快加入VIP大家庭 **与有理想的.NET开发者一起成长**

## 官方QQ交流群  

1. ***618473076*** **社区VIP专属QQ群，第一时间提供开发进度、使用手册、1V1专属咨询服务等，如何加入VIP请移步社区置顶帖**

1. 484498493【已满】

1. 626433139【已满】

1. [![快速加群](https://img.shields.io/badge/qq%E7%BE%A4-566344079-blue.svg)](http://shang.qq.com/wpa/qunwpa?idkey=aa850ac69f1f43ab4be39ecddd6030a937e9236d95966a707fcb667491049fdc)

## 演示直达

* http://demo.openauth.me:1802

## 当前版本

`core 1.0`

* 基于.Net Core 2.1开发；

* 采用NUnit测试，去掉OpenAuth.UnitTest项目；

* 前后端完全分离。`我们不限制规则，只用主流的技术构建强大的框架`；

* 前端采用 vue + layui + ztree + gooflow + leipiformdesign

* 后端采用 asp.net mvc core 2.1  + EF core+ autofac + json.net

* 代码生成工具 CodeSmith

* 设计工具 PowerDesigner + Enterprise Architect

## 秀外

![输入图片说明](https://gitee.com/uploads/images/2018/0328/173337_6e017075_362401.png "表单设计")
![输入图片说明](https://gitee.com/uploads/images/2018/0328/150758_26ef9d61_362401.png "流程设计")

## 慧中

教科书级的分层思想，哪怕苛刻的你阅读的是大神级精典大作（如：《企业应用架构模式》《重构与模式》《ASP.NET设计模式》等），你也可以参考本项目。不信？有图为证，Resharper自动生成的项目引用关系，毫无PS痕迹！

![输入图片说明](https://gitee.com/uploads/images/2015/1113/233705_271ecb3a_362401.jpeg "在这里输入图片标题")

## 权限资源

符合国情的RBAC（基于角色的访问控制），可以直接应用到你的系统。

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
1. OpenAuth.WebApi SSO服务及为第三方提供接口服务

## 使用
管理员可直接在登录界面用System登录；

普通应用账号使用用户列表的用户登录，初始密码与用户名相同；

## 后续
功能方面.net core版本将与.net同步更新


