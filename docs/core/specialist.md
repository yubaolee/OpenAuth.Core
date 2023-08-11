# 开发规范

## 新增数据库名称规范

子系统名称+业务名称+表尾，其中表尾名称规则如下：

- 基础主数据以Mst结尾；

- 普通业务表以Tbl结尾；

- 业务明细表以Dtbl结尾；

比如：

- WMS系统客户主数据表：WmsCustomerMst

- WMS系统入库订单头表：WmsInboundOrderTbl

- WMS系统入库订单明细表：WmsInboundOrderDtbl



## 数据库字段类型

主键id统一使用Domain:PrimaryKey（针对SqlServer数据库，非Sql Server根据需要定义）

状态类,标识类的字段，统一使用bit not null

表示分类的字段，统一使用PrimaryKey。数值从Category中获取。



