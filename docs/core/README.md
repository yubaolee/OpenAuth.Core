![LOGO](/logocore.png "1.png")

OpenAuth.Net是基于 **.Net Core/.Net 5/6/7..** 的开源权限工作流快速开发框架。框架汲取Martin Fowler企业级应用开发思想及全新技术组合（IdentityServer、EF、SqlSugar、Quartz、AutoFac、WebAPI、Swagger、Mock、NUnit、VUE2、VUE3、Element-ui、Element-plus等），核心模块包括：组织机构、角色用户、权限授权、表单设计、工作流等。

如果你想了解企业版的内容，请访问：[http://doc.openauth.net.cn/pro](http://doc.openauth.net.cn/pro/)

::: tip 提示

gitee上面两个版本，仅SDK的版本不同，代码完全相同。其中：

* [OpenAuth.Net](https://gitee.com/dotnetchina/OpenAuth.Net) 的SDK版本为5.0.100，推荐使用该版本

* [OpenAuth.Core](https://gitee.com/yubaolee/OpenAuth.Core) 的SDK版本为.Net Core 3.1.100，历史原因暂且保留，未来的某天会关闭它

.Net目前SDK升级特别方便，只需花费3分钟时间既可升级到.Net 6/7/8...等。请参考：[3分钟的时间把.net core 3.1的升级到.NET 5](https://www.cnblogs.com/yubaolee/p/Net3ToNet5.html)，所以不要纠结SDK版本问题。
:::


## 技术栈

![](https://img.shields.io/badge/release-2.0-blue) ![](https://img.shields.io/badge/.net%20core-3.1.100-blue) ![](https://img.shields.io/badge/.Net-5.0-blue) ![](https://img.shields.io/badge/IdentityServer4-3.0.1-blue) ![](https://img.shields.io/badge/quartz-3.0.7-blue) ![](https://img.shields.io/badge/Autofac-5.1.2-blue) ![](https://img.shields.io/badge/NUnit-3.12-blue) ![](https://img.shields.io/badge/SwaggerUI-OAS%203.0-blue) ![](https://img.shields.io/badge/Moq-4.13-blue) ![](https://img.shields.io/badge/log4net-2.0.8-blue) ![](https://img.shields.io/badge/AutoMapper-9.0-blue)
![](https://img.shields.io/badge/vue-2.6.10-brightgreen) ![](https://img.shields.io/badge/element--ui-2.10.1-brightgreen) ![](https://img.shields.io/badge/node-%3E%3D14.0-brightgreen) ![](https://img.shields.io/badge/npm-6.14-brightgreen) ![](https://img.shields.io/badge/layui-2.5.6-brightgreen)

## 核心看点

* 支持.net core sdk 3.1.100 及.Net 5/6/7..（[一分钟从.net core 3.1切换至.Net 5](https://www.cnblogs.com/yubaolee/p/Net3ToNet5.html)）

* 超强的自定义权限控制功能，请参考：[通用权限设计与实现](https://www.cnblogs.com/yubaolee/p/DataPrivilege.html)

* 完整的字段权限控制，可以控制字段可见及API是否返回字段值

* 可拖拽的表单设计  

* 可视化流程设计  

* 基于Quartz.Net的定时任务控制,可随时启/停，可视化配置Cron表达式功能

* 基于CodeSmith的代码生成功能，可快速生成带有头/明细结构的页面

* 支持sqlserver、mysql、Oracle、PostgreSQL(已集成驱动,但无Oracle脚本，可以利用工具把其他数据库的数据导过来），理论上支持所有数据库

* 支持同时访问多数据源

* 支持多租户

* 集成IdentityServer4，实现基于OAuth2的登录体系

* 建立三方对接规范，已有系统可以无缝对接流程引擎

* 前端采用 vue + layui + elementUI + ztree + gooflow + leipiformdesign

* 后端采用 .net core/.Net 5/6/7.. +EF core+ autofac + quartz +IdentityServer4 + nunit + swagger

* 设计工具 PowerDesigner + Enterprise Architect





