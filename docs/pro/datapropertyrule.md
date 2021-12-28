# 字段权限

::: warning 注意
企业版后端逻辑同开源版一样，请参考：[/core/datapropertyrule](/core/datapropertyrule.html)本文只介绍企业版前端部分
:::

### 前端代码处理

在做表格的时候需要使用动态列。以`views/Resources/index.vue`为例，如下：

```HTML
<auth-table  ref="mainTable" :table-fields="headerList"></auth-table>
```

用户加载后台数据时，自动加载表格字段结构，并存储在`headerList`实现字段权限控制，如下：

```javascript
    //加载表头
    resources.getList(this.listQuery).then((response) => {
        this.list = response.data
        response.columnFields.forEach((item) => {
          // 首字母小写
          item.columnName = item.columnName.substring(0, 1).toLowerCase() + item.columnName.substring(1)
        })
        this.headerList = response.columnFields
      })
```
### 运行界面配置

完成代码编写后，在【基础配置】--【角色管理】--【为角色分配模块】最后为角色分配【可见字段】中分配权限

![20211228210554](http://img.openauth.net.cn/20211228210554.png)


