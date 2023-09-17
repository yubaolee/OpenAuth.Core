# 日常提交(针对dev分支)

* 2023.09.17  fix #I81YQA SqlSugar使用MySql时异常
  
* 2023.09.16  #I7A7YE 加入hiprint打印功能
  
* 2023.09.01  fix #I7XLQK checkbox控件值表单条件判断

* 2023.08.27  fix issue #I7A7XF 全面支持SqlSugar Orm。详情：[sqlsugar访问数据库](http://doc.openauth.net.cn/core/sqlsugar.html)
  
* 2023.08.18  fix #I7U1BM 左侧展开图标丢失
  
* 2023.08.16  fix #I7U14K layui-icon图标大小不一致
  
* 2023.08.13  update layui to 2.8.11

* 2023.08.01  默认.Net SDK版本升级为6.0
  
* 2023.06.01  fix #I7EKFG 关于使用oracle数据库时代码生成界面的问题
  
* 2023.05.01  fix #I5ZL3B 代码生成器，动态列排序，保存无效

* 2022.12.22  退出登录时，清空tag标签;

* 2022.12.20  修复多个模块名称相同时，只能打开一个的BUG;
  
* 2022.12.17  fix 流程发起页面，切换vform不能正常执行onCreated脚本;
  
* 2022.12.15  升级vform到2.3.6;
  
* 2022.11.26  修复[事务中使用异步方式后报错](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I63AOC);
  
* 2022.11.18  修复[拖拽表单不能关联数据库](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I61V1D);
  
* 2022.10.05  完成vue3多表代码生成器模版;

* 2022.10.01  增加vue3多表代码生成器模版;
  
* 2022.09.21  完成vue3 setup模式单表代码生成;
  
* 2022.09.15  增加vue3代码生成器模版，完成单表动态头部生成;
  
* 2022.09.12  代码生成器增加vue3参数;
  
* 2022.08.15  修复选择租户;
  
* 2022.08.14  修复左侧导航栏异常;

* 2022.08.13  完成vue3版本流程设计、流程处理及展示;
  
* 2022.08.03  完成vue3版本流程图工具、画布处理;

* 2022.07.26  完成vue3 jsplumb引入;

* 2022.06.14  完成vue3版本表单设计器;
  
* 2022.06.12  完成vue2版本表单设计器;
  
* 2022.05.12  初始化vue3+vite版本;

* 2022.01.19  增加对sql只返回string的支持;

* 2022.01.17  修复添加表单时，如果关联的数据库已存在的bug

* 2022.01.15  增加拖动表单生成数据库表

* 2022.01.03  增加plantuml支持
  
* 2022.01.01  增加API部署说明
  
* 2021.12.28  增加工作流添加自定义表单
  
* 2021.12.10  修复非动态头部生成vue界面时异常
  
* 2021.12.08  主从表以ParentId为准，而不是DetailTable
  
* 2021.12.07  sqlserver float类型对应C# double类型
  
* 2021.11.30  修复子表加载失败的问题
  
* 2021.11.14  修复代码生成器
  
* 2021.11.04  简化代码
  
* 2021.10.18  采用代码生成器的表结构控制前端显示
  
* 2021.10.03  升级EF及所有三方的版本

* 2021.09.22 fix issue [OpenAuth.Pro前端，可编辑数量为单数时只显示单数减一的字段数](https://gitee.com/yubaolee/OpenAuth.Core/issues/I4BBIG)；

* 2021.09.11 发布3.3版；

* 2021.09.08 fix issue [删除角色后用户还有角色模块访问权限](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I494N1)；

* 2021.09.05 完成主从表生成；

* 2021.09.02 完成单个表格vue的生成；

* 2021.08.31 使用全新的头部渲染；

* 2021.08.23 可以动态控制复杂界面显示编辑权限，采用代码生成的表定义来控制；

* 2021.07.09 流程审批时增加可编辑表单处理；

* 2021.07.02 fix issue 兼容oracle 11g；

* 2021.06.22 系统消息按时间倒序排列；

* 2021.06.18 使用雪花算法做Id时出现异常；

* 2021.06.15 修复加载消息列表异常；

* 2021.06.13 增加系统消息；

* 2021.06.02 删除已过期文件，优化注释；

* 2021.05.26 流程处理增加消息通知；

* 2021.05.24 集成miniprofiler，可以监控API运行情况。[查看使用说明](http://doc.openauth.net.cn/core/log.html#%E5%9C%A8swagger%E4%B8%AD%E8%BE%93%E5%87%BA%E6%97%A5%E5%BF%97 )；

* 2021.05.23 [模块管理页面加载时默认显示第一条](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I3RUOR)；

* 2021.05.21 新增编辑流程功能（草稿和驳回状态）；

* 2021.05.17 [增加配置启动端口](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I3QUV1)；

* 2021.05.14 调整样式，添加刷新页面，tag标签保留功能；

* 2021.05.12 [修复拖动表单上传异常](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I3QN22)；

* 2021.05.09 增加自定义模态验证异常返回信息；

* 2021.05.08 合并PR：[增加API访问审计;禁用.net自动模态验证,采用系统全局异常捕获机制](https://gitee.com/dotnetchina/OpenAuth.Net/pulls/12)；

* 2021.05.07 swagger增加分组的功能；

* 2021.05.06 fix issue [会签节点异常,提示'-1' was not present in the dictionary](https://gitee.com/dotnetchina/OpenAuth.Net/issues/I3PE3R)；

* 2021.05.01 fix issue [CodeSmith生成的后端代码报错](https://gitee.com/yubaolee/OpenAuth.Core/issues/I3OXJZ)；

* 2021.04.28 增加站点启动时自动运行状态为【正在运行】的定时任务；

* 2021.04.27 增加存储过程调用的支持；

* 2021.04.26 fix issue [生成的更新字段不包含默认的CreateUser等](https://gitee.com/yubaolee/OpenAuth.Core/issues/I3O5S3) ；

* 2021.04.25 增加流程执行时可以选择用户或角色（而不是设计时选择）；

* 2021.04.21 不同的租户，可以连不同类型数据库；

* 2021.04.16 增加Oracle驱动支持；

* 2021.04.15 调整项目文件结构，代码生成器按新的结构生成；

* 2021.04.14 增加流程启动、撤销功能；

* 2021.04.13 增加新的流程状态-草稿；

* 2021.04.01 优化代码生成器，可以根据主键类型自动匹配父类；

* 2021.03.29 优化雪花算法；

* 2021.03.22 全面删除svg图标，使用iconfont，并增加图标选择；

* 2021.03.18 fix https://gitee.com/dotnetchina/OpenAuth.Net/issues/I3BUF5；

* 2021.03.17 驳回状态可以在待处理列表中展示并处理；

* 2021.03.13 增加雪花算法支持、增加自动增长型Id的支持；

* 2021.03.09 增加redis缓存支持；

* 2021.03.03 代码生成器加上删除时添加弹出提醒的代码；

* 2021.03.02 修复流程分支判定；

* 2021.03.01 修复流程分支不能判断字符串的问题；

* 2021.02.20 新增三级菜单名称前Icon小图标

* 2021.02.18 增加三级菜单支持

* 2021.01.17 调整非法租户逻辑；

* 2021.01.14 fix issue [#I2D0CX](https://gitee.com/yubaolee/OpenAuth.Core/issues/I2D0CX)；

* 2021.01.10 完成对多租户的支持；

* 2021.01.06 fix issue [#I2C4K0](https://gitee.com/yubaolee/OpenAuth.Core/issues/I2C4K0)；

* 2021.01.03 启动时显示连接字符串；

* 2020.12.28 新增多数据源；

* 2020.12.27 优化EF输出SQL语句；

* 2020.12.26 对同时多个HTTP修改请求进行加锁处理；

* 2020.12.21 增加附件管理；

* 2020.12.19 上传图片支持生成缩略图；

* 2020.12.17 增加异步测试、事务测试；

* 2020.12.16 完成UnitWork异步化；

* 2020.12.11 Repository增加异步读写接口；

* 2020.12.09 fix issue [#I1RFOQ](https://gitee.com/yubaolee/OpenAuth.Core/issues/I1RFOQ)；

* 2020.12.02 所有数据加载调整为异步模式；

* 2020.11.15 修复layui选择组织机构时，数据回写的BUG；

* 2020.11.03 修复layui icon选择BUG；

* 2020.10.20 修复代码生成器mysql创建主键字段；

* 2020.10.13 调整代码生成器生成vue views的路径调整为小写；

* 2020.09.23 发布企业版代码生成器功能；

* 2020.09.10 完成所有后端生成实体、生成业务功能、生成API；

* 2020.08.12 完成代码生成器--自动创建WebApi Controller功能的开发；

* 2020.08.10 完成代码生成器--自动创建实体功能的开发；

* 2020.08.06 增加代码生成器创建接口，为在线代码生成器做准备；

* 2020.08.04 修复企业版字典分类页面样式异常；增加获取数据库结构接口；

* 2020.08.01 获取实体属性时，按小写判断实体是否存在。修复:[I1PN8N](https://gitee.com/yubaolee/OpenAuth.Core/issues/I1PN8N) [I1PN5O](https://gitee.com/yubaolee/OpenAuth.Core/issues/I1PN5O) [I1PMYX](https://gitee.com/yubaolee/OpenAuth.Core/issues/I1PMYX)




