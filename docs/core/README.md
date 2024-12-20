
![LOGO](/logocore.png "1.png")

OpenAuth.Net是基于最新版.Net的开源权限工作流快速开发框架。源于Martin Fowler企业级应用开发思想及最新技术组合（SqlSugar、EF、Quartz、AutoFac、WebAPI、Swagger、Mock、NUnit、Vue2/3、Element-ui/plus、IdentityServer等）。核心模块包括：组织机构、角色用户、权限授权、表单设计、工作流等。

开源版本演示：[http://demo.openauth.net.cn:1802/](http://demo.openauth.net.cn:1802/)

如果你想了解企业版的内容，请访问：[http://doc.openauth.net.cn/pro](http://doc.openauth.net.cn/pro/)

::: tip 提示

gitee上面两个版本。其中：

* [OpenAuth.Net](https://gitee.com/dotnetchina/OpenAuth.Net) 默认SDK版本为.Net 9.0.100，如果需要切换到.Net其他版本请参考：[切换sdk版本](http://doc.openauth.net.cn/core/changesdk.html)

* [OpenAuth.Core](https://gitee.com/yubaolee/OpenAuth.Core) 的SDK版本为.Net Core 3.1.100，已停止维护，不推荐使用。

.Net目前SDK升级特别方便。请参考：[3分钟的时间把.net core 3.1的升级到.NET 5](https://www.cnblogs.com/yubaolee/p/Net3ToNet5.html)，所以不要纠结SDK版本问题。
:::


## 技术栈

![](https://img.shields.io/badge/release-6.0-blue) ![](https://img.shields.io/badge/SqlSugar-5.1.4-blue) ![](https://img.shields.io/badge/IdentityServer4-3.0.1-blue) ![](https://img.shields.io/badge/quartz-3.0.7-blue) ![](https://img.shields.io/badge/Autofac-5.2-blue) ![](https://img.shields.io/badge/NUnit-3.13.1-blue) ![](https://img.shields.io/badge/SwaggerUI-OAS%203.0-blue) ![](https://img.shields.io/badge/Moq-4.13-blue) ![](https://img.shields.io/badge/log4net-2.0.12-blue)

![](https://img.shields.io/badge/vue-2.6.10-brightgreen) ![](https://img.shields.io/badge/vue-3.3.4-brightgreen) ![](https://img.shields.io/badge/vite-4.4.9-brightgreen) ![](https://img.shields.io/badge/element--ui-2.10.1-brightgreen) ![](https://img.shields.io/badge/element--plus-2.3.9-brightgreen) ![](https://img.shields.io/badge/node-%3E%3D4.0-brightgreen) ![](https://img.shields.io/badge/npm-9.7.1-brightgreen) ![](https://img.shields.io/badge/layui-2.8.6-brightgreen)

## 核心看点

* 支持最新版.Net 9.0.100
  
* 同时支持EntityFramework、SqlSugar两款最流行的ORM框架

* 超强的自定义权限控制功能，请参考：[通用权限设计与实现](https://www.cnblogs.com/yubaolee/p/DataPrivilege.html)

* 完整的字段权限控制，可以控制字段可见及API是否返回字段值

* 可拖拽的表单设计。详情：[可拖拽表单](http://doc.openauth.net.cn/pro/dragform.html)

* 可视化流程设计。[可视化流程设计](http://doc.openauth.net.cn/pro/startflow.html)  
  
* 全网最好用的打印解决方案。详情:[智能打印](http://doc.openauth.net.cn/pro/printerplan.html)

* 基于Quartz.Net的定时任务控制,可随时启/停，可视化配置Cron表达式功能

* 基于CodeSmith的代码生成功能，可快速生成带有头/明细结构的页面

* 支持sqlserver、mysql、Oracle、PostgreSql数据库，理论上支持所有数据库

* 支持同时访问多数据源

* 支持多租户

* 集成IdentityServer4，实现基于OAuth2的登录体系

* 建立三方对接规范，已有系统可以无缝对接流程引擎

* 前端采用 vue + layui + element-ui + ztree + gooflow + leipiformdesign

* 后端采用 .net +EF + sqlsugar + autofac + quartz +IdentityServer4 + nunit + swagger

* 设计工具 PowerDesigner +PDManer + Enterprise Architect





