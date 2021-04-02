## v5.1 （未发布版本）

- **新特性**

  - [新增] 增加流程实例可以选择用户，而不是通过流程设计的方式[#I1W8AV](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I1W8AV)

- **突破性变化**

  - [调整] 优化生成实体，在生成实体后自动在OpenAuthDBContext中新增DbSet

- **问题修复**

  - [修复] 修复[#I3BUF5](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I3BUF5)

- **其他更改**

  - [调整] 升级雪花漂移算法到最新版本

- **不做实现**

---

## v5.0.1 （当前版本）

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