# 权限控制

## 数据权限

关于数据权限控制，可以详细查看博文：[通用权限设计与实现](https://www.cnblogs.com/yubaolee/p/DataPrivilege.html)
## 字段权限

::: warning 注意
字段权限只针对【非系统模块】有效，即在添加新模块的时候，需要设置模块属性“是否系统”为false。
:::

## 使用场景

字段权限控制分为两种：

1. 直接不返回字段的值。用于敏感数据不向客户端反馈。

1. 返回字段的值，但界面不显示。常常用于数据需要和后端交互，但不想在界面显示，比如各种Id。这种直接在返回实体增加`[Browsable(false)]`注解即可。

## 如何做？

### 后端代码处理

针对场景1，在做返回处理的时候，需要过滤数据库查询字段，如下：（本文以Resource表为例）

```csharp
var columnFields = loginContext.GetTableColumns("Resource");
if (columnFields == null || columnFields.Count == 0)
{
	throw new Exception("请在代码生成界面配置Resource表的字段属性");
}

var propertyStr = string.Join(',', columnFields.Select(u => u.ColumnName));
result.columnFields = columnFields;
result.data = resources.OrderBy(u => u.TypeId)
	.Skip((request.page - 1) * request.limit)
	.Take(request.limit).Select($"new ({propertyStr})");
result.count = await resources.CountAsync();
return result;
```

::: warning 注意
企业版表结构是通过【代码生成】功能获取获取表结构并存储在`buildertable`表中，因此需要先在【代码生成】功能添加要控制的表字段。然后使用loginContext.GetTableColumns获取可访问的字段。
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


