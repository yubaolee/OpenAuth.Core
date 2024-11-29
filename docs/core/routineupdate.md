# 日常提交(针对dev分支)

* 2024.11.28  升级到.Net 9

* 2024.11.16  添加dockerfile,为.net 9做准备

* 2024.10.10  增加知会功能。详情：[知会](http://doc.openauth.net.cn/core/flowinstance.html#%E7%9F%A5%E4%BC%9A)；

* 2024.09.29  新增增加签逻辑。详情：[加签](http://doc.openauth.net.cn/core/flowinstance.html#%E5%8A%A0%E7%AD%BE)；

* 2024.07.20  mvc项目去掉vue，采用原生layui；

* 2024.07.11  fix #IABKQN；

* 2024.06.27  删除CodeSmith生成WebApi；

* 2024.06.20  fix IABKQN 输入框输入收清除其他下拉框或选择框的内容；

* 2024.06.10  update layui to 2.9.13

* 2024.05.31  fix #I9STI2 项目菜单新增和保存报错

* 2024.04.24  fix #I9HQWU 已审核过的用户，后面不需要再次审核；

* 2024.04.18  fix #I9G05U 流程设计时，选择角色时，没有显示角色名称

* 2024.04.05  fix #I9E72C 不能获取pgSql数据库结构

* 2024.03.08  修复Oracle脚本使用驼峰命名异常的问题

* 2024.02.26  全面调整流程添加逻辑；
  
* 2024.02.24  角色分配模块时，可以级联
  
* 2024.02.22  fix #I9302C Vue3表单设计无法展示自定义页面
  
* 2024.02.17  vue3模块增加配置是否缓存
  
* 2024.02.03  fix #I90F8B 生成的主从表页面, 在从表那里增加全屏, 或者是隐藏列表的按钮
  
* 2024.01.15  fix #I8WCQ8 定时任务添加本地任务时，不应该显示HTTPPOST
  
* 2024.01.09  修复前端缓存时间
  
* 2024.01.06  update layui to 2.9.3
  
* 2023.12.30  模块增加配置是否缓存。请参考[界面缓存](http://doc.openauth.net.cn/pro/keepalive.html)；

* 2023.12.27  登录账号旁边实时显示未读消息条数
  
* 2023.12.23  完善人员显示直接上级及部门显示负责人
  
* 2023.12.19  流程设计可以选择部门负责人

* 2023.11.25  hiprint自动连接打印客户端失败的报错
  
* 2023.11.20  打印导出PDF时，数据为空
  
* 2023.10.04  全面完成智能打印板块功能开发。请参考[智能打印](http://doc.openauth.net.cn/pro/printerplan.html)；
  
* 2023.10.02  fix #I82FO6 完成业务功能配置打印方案

* 2023.09.29  完成功能模块添加打印按钮

* 2023.09.28  #I82FO6 完成模块配置打印方案的设置
  
* 2023.09.27  增加PDManer数据结构
  
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

* 很久很久以前的需求，麻烦看提交记录了😊😊😊




