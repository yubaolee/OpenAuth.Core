![LOGO](https://gitee.com/uploads/images/2018/0425/163228_7077c3fd_362401.png "1.png")

OpenAuth.Net是一个开源的权限工作流快速开发框架。框架基于Martin Fowler企业级应用开发思想及全新技术组合（Asp.Net MVC、EF、AutoFac、WebAPI、Swagger、Json.Net等），核心模块包括：组织机构、角色用户、权限授权、表单设计、工作流等。它的架构精良易于扩展，是中小企业的首选。

## 特性

采用经典DDD架构,每一行代码都经过深思熟虑，符合SOLID规则！

符合国情的RBAC（基于角色的访问控制），可以直接应用到你的系统。

1. 菜单权限  经理和业务员登陆系统拥有的功能菜单是不一样的
1. 按钮权限  经理能够审批，而业务员不可以
1. 数据权限  A业务员看不到B业务员的单据
1. 字段权限  某些人查询客户信息时看不到客户的手机号或其它字段

**用户**应用系统的具体操作者，我这里设计用户是可以直接给用户分配菜单/按钮，也可以通过角色分配权限。

**角色**为了对许多拥有相似权限的用户进行分类管理，定义了角色的概念，以上所有的权限资源都可以分配给角色，角色和用户N:N的关系。

**机构**树形的公司部门结构，国内公司用的比较多，它实际上就是一个用户组，机构和用户设计成N:N的关系，也就是说有时候一个用户可以从属于两个部门，这种情况在我们客户需求中的确都出现过。

## 技术栈
* 前端 vue + layui + ztree + gooflow + leipiformdesign
* 后端 asp.net mvc + Web API + EF + autofac + swagger + json.net
* 代码生成工具 CodeSmith
* 设计工具 PowerDesigner + Enterprise Architect

## 系统工程结构：
1. OpenAuth.Repository 系统仓储层，用于数据库操作
1. OpenAuth.App 应用层，为界面提供接口
1. OpenAuth.Mvc Web站点
1. OpenAuth.UnitTest 单元测试
1. Infrastructure 通用工具集合
1. OpenAuth.WebApi SSO服务及为第三方提供接口服务

## 使用

从[快速开始](getstart.md)开始你的神奇之旅吧！


