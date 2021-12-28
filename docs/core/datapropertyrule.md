# 字段权限

::: warning 注意
字段权限只针对【非系统模块】有效，即在添加新模块的时候，需要设置模块属性“是否系统”为false。
:::

## 使用场景

字段权限控制分为两种：

1. 直接不返回字段的值。用于敏感数据不像客户端反馈。

1. 返回字段的值，但界面不显示。常常用于数据需要和后端交互，但不想在界面显示，比如各种Id。这种直接在返回实体增加`[Browsable(false)]`注解即可。

## 如何做？

### 后端代码处理

在做返回处理的时候，需要做以下特殊处理（本文以Resource表为例）

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

### 前端代码处理

在做表格的时候需要使用动态列。以`Views/Resources/index.cshtml`为例，如下：

```HTML
 <table class="layui-table" id="mainList"
           lay-data="{height: 'full-80', page:true, id:'mainList'}"
           lay-filter="list" lay-size="sm">
    </table>
```

在用户自定义的脚本`wwwroot/userJs/resources.js`中，动态加载列：

```javascript
    //加载表头
    $.getJSON('/Resources/Load',
	    { page: 1, limit: 1 },
	    function (data) {
		     var columns = data.columnFields.filter(u => u.IsList ===true).map(function (e) {
			    return {
                    field: e.ColumnName,
                    title: e.Comment
			    };
		    });
		    columns.unshift({
			    type: 'checkbox',
			    fixed: 'left'
		    });
		    table.render({
			    elem: '#mainList',
			    page: true,
                url: '/Resources/Load',
			    cols: [columns]
			    , response: {
				    statusCode: 200 //规定成功的状态码，默认：0
			    }
		    });
        });
```
### 运行界面配置

完成代码编写后，在【基础配置】--【角色管理】--【为角色分配模块】最后为角色分配【可见字段】中分配权限

![](/roleassignproperty.png)


