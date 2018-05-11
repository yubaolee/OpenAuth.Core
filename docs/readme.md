![LOGO](https://gitee.com/uploads/images/2018/0425/163228_7077c3fd_362401.png "1.png")

**logo图标含义** OpenAuth中OA字母的结合体；整体像鱼，授人以渔；你非说像咸鱼，那也是积极向上的咸鱼；中心是个笑脸，微笑面对生活(✿◡‿◡)。

## 项目简介：

项目采用经典DDD架构(用沃恩.弗农大神的话，其实这是DDD-Lite）思想进行开发，简洁而不简单，实用至上，并且所写每一行代码都经过深思熟虑，符合SOLID规则！

当然，如果你想学习完整的DDD框架，可以参考我的另一个项目（[BestQ&A--开源中国推荐项目/集`CQRS` `AES`等DDD高级特性于一体的问答系统](http://git.oschina.net/yubaolee/BestQA)）

**官方网站** http://www.openauth.me

**项目详细描述**  http://www.cnblogs.com/yubaolee/p/OpenAuth.html 

## 官方QQ交流群  

1. ***618473076*** **社区VIP专属QQ群，第一时间提供开发进度、使用手册、1V1专属咨询服务等，如何加入VIP请移步社区置顶帖**

1. 484498493【已满】

1. 626433139【已满】

1. 566344079

## 演示直达

* http://demo.openauth.me:1802

## 当前版本

`4.0 颠覆版(2018-)`

* 版本重构，最重要的一个版本；

* 前后端完全分离，结构更加清晰。`我们不限制规则，只用主流的技术构建强大的框架`；

* 前端采用 vue + layui + ztree + gooflow + leipiformdesign

* 后端采用 asp.net mvc + Web API + EF + autofac + swagger + json.net

* 代码生成工具 CodeSmith

* 设计工具 PowerDesigner + Enterprise Architect

`3.0 alpha版(2017-2-7)`

* 采用全新工作流，实现自定义表单处理；


## 秀外

![输入图片说明](https://gitee.com/uploads/images/2018/0328/150659_6900820e_362401.png "首页")
![输入图片说明](https://gitee.com/uploads/images/2018/0313/001504_5dda4a47_362401.png "列表页面")
![输入图片说明](https://gitee.com/uploads/images/2018/0328/173337_6e017075_362401.png "表单设计")
![输入图片说明](https://gitee.com/uploads/images/2018/0328/150758_26ef9d61_362401.png "流程设计")
![输入图片说明](https://gitee.com/uploads/images/2017/0209/162617_c1250da6_362401.png "在这里输入图片标题")

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
1. OpenAuth.Domain 系统领域层
2. OpenAuth.Repository 系统仓储层，用于数据库操作
3. OpenAuth.App 应用层，为界面提供接口
4. OpenAuth.Mvc Web站点
5. OpenAuth.UnitTest 单元测试
6. Infrastructure 通用工具集合
7. OpenAuth.WebApi SSO服务及为第三方提供接口服务

## 使用
管理员可直接在登录界面用System登录；

普通应用账号使用用户列表的用户登录，初始密码与用户名相同；

## 后续
更多`狂野`的功能，正在玩命加载中，敬请期待...
更多文档正在整理中....


