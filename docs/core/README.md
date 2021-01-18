![LOGO](/logocore.png "1.png")

OpenAuth.Core是基于 **.Net Core/.Net 5** 的开源权限工作流快速开发框架。框架汲取Martin Fowler企业级应用开发思想及全新技术组合（IdentityServer、EF core、Quartz、AutoFac、WebAPI、Swagger、Mock、NUnit、VUE、Element-ui等），核心模块包括：组织机构、角色用户、权限授权、表单设计、工作流等。

## 技术栈

![](https://img.shields.io/badge/release-2.0-blue)
![](https://img.shields.io/badge/.net%20core-3.1.100-blue)
![](https://img.shields.io/badge/IdentityServer4-3.0.1-blue)
![](https://img.shields.io/badge/quartz-3.0.7-blue)
![](https://img.shields.io/badge/Autofac-5.1.2-blue)
![](https://img.shields.io/badge/NUnit-3.12-blue)
![](https://img.shields.io/badge/SwaggerUI-OAS%203.0-blue)
![](https://img.shields.io/badge/Moq-4.13-blue)
![](https://img.shields.io/badge/log4net-2.0.8-blue)

![](https://img.shields.io/badge/vue-2.6.10-brightgreen)
![](https://img.shields.io/badge/element--ui-2.10.1-brightgreen)
![](https://img.shields.io/badge/node-%3E%3D4.0-brightgreen)
![](https://img.shields.io/badge/npm-3.0.0-brightgreen)
![](https://img.shields.io/badge/layui-2.5.6-brightgreen)

## 核心看点

* 支持.net core sdk 3.1.100 及.Net 5（[一分钟从.net core 3.1切换至.Net 5](https://www.cnblogs.com/yubaolee/p/Net3ToNet5.html)）

* 超强的自定义权限控制功能，请参考：[通用权限设计与实现](https://www.cnblogs.com/yubaolee/p/DataPrivilege.html)

* 完整的字段权限控制，可以控制字段可见及API是否返回字段值

* 可拖拽的表单设计  

* 可视化流程设计  

* 基于Quartz.Net的定时任务控制,可随时启/停，可视化配置Cron表达式功能

* 基于CodeSmith的代码生成功能，可快速生成带有头/明细结构的页面

* 支持sqlserver、mysql数据库，理论上支持所有数据库

* 支持同时访问多数据源

* 集成IdentityServer4，实现基于OAuth2的登录体系

* 建立三方对接规范，已有系统可以无缝对接流程引擎

* 前端采用 vue + layui + elementUI + ztree + gooflow + leipiformdesign

* 后端采用 .net core +EF core+ autofac + quartz +IdentityServer4 + nunit + swagger

* 设计工具 PowerDesigner + Enterprise Architect

## 开源版和企业版关系

企业版是一套全新的前端界面，基于vue-element-admin，采用VUE全家桶（VUE+VUEX+VUE-ROUTER）单页面SPA开发。它使用开源版OpenAuth.Core的API接口（即：OpenAuth.WebApi）提供数据服务。二者的关系如下：

![](/architect.png)

## 开源版和企业版不同点

|    开源版    | 高级/企业版           |
| ------------- |:-------------:| 
| 单站点Asp.Net Core Mvc方式     | 前后端完全分离的Asp.Net Core WebAPI + vue方式 | 
| 基于最新版LayUI界面     | 基于最新版ElementUI界面  | 
| 基于Quartz的定时任务控制    | 基于Quartz的定时任务控制，`且支持可视化CRON表达式设计`      |   
| 基于leipiformdesign的动态表单设计   | 在开源版的基础上，`实现可拖拽的表单设计且独立成vue组件`      |   
| 基于gooflow的流程设计   | 基于当今世界最流行的jsplumb开发的流程设计      |   
| 灵活的数据权限控制   | 在开源版的基础上，`实现可视化的权限控制配置`   |   
| 提供基于CodeSmith的代码生成功能   | 在开源的基础上，`增加快速生成带有头/明细结构的页面`   |   
| --   | 多租户  |  
| --   | 附件管理  |  
| --   | 提供数据库结构PowerDesigner设计文件  |   






