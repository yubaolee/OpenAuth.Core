## v6.1 

- **新特性**

  - [新增] 全网最好用的打印解决方案。详情：[智能打印](http://doc.openauth.net.cn/pro/printerplan.html)；
  - [新增] 全面支持SqlSugar Orm。详情：[sqlsugar访问数据库](http://doc.openauth.net.cn/core/sqlsugar.html)；
  - [新增] 全面更新mvc版本，升级layui版本至最新v2.8.11；
  - [新增] 升级.Net版本6.0，所有三方组件全面更新；

- **突破性变化**

  - [新增] 流程可以选择直接上级和部门负责人；

- **问题修复**


- **其他更改**


- **不做实现**

---

## v5.1 

- **新特性**

  - [新增] 支持同时配置多个类型数据库的连接字符串，详见：http://doc.openauth.me/core/multidbs.html
  - [新增] 新增Oracle数据库驱动;
  - [新增] 新增流程召回功能；
  - [新增] 调整APP层文件结构，按功能划分；

- **突破性变化**

  - [调整] 优化生成实体，在生成实体后自动在OpenAuthDBContext中新增DbSet
  - [调整] 配置文件中可以配置连接字符串对应的数据库类型


- **问题修复**

  - [修复] 修复[#I3BUF5](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I3BUF5)

- **其他更改**

  - [调整] 升级雪花漂移算法到最新版本

- **不做实现**

---

## v5.0.1 

- **新特性**

  - [新增] 缓存增加Redis支持
  - [新增] 增加多租户支持 [#I3ES5E](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I3ES5E)
  - [新增] 增加雪花算法生成实体ID
  - [新增] 增加对数据库自动增加主键的支持

- **突破性变化**

  - [调整] 单元测试直接读取OpenAuth.WebApi的配置文件

- **问题修复**

  - [修复] 修复单元测试异常
  - [修复] 修复定时任务不能正常执行
  - [修复] 修复工作流分支判定

- **其他更改**

  - [改进] 启动时显示当前连接字符串
  - [改进] 调整工程文件`netcoreapp5.0`为`net5.0`
  - [改进] 调整代码生成器相关的代码
- **文档变化**

  - [新增] 增加多租户文档 [http://doc.openauth.me/core/multitenant.html](http://doc.openauth.me/core/multitenant.html)


- **不做实现**


---