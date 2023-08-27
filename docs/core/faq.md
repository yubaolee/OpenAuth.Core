# 常见问题处理

## 注释的使用

在Controller返回给前端的字段上，通常会有两个“注释”，如下：
```csharp
/// <summary>
/// 用户登录帐号
/// </summary>
[Description("用户登录帐号")]
public string Account { get; set; }
```
开发者在使用的时候会觉得多余。但他们的用途不同：

* /// 注释是真正的代码注释，用于方便读取代码，并为swagger提供字段解释

* Description注解：是当前端表格需要动态表头时，返回的表头中文说明


## 项目显示不可用

![](/notavailable.png)

这种情况一般是开发工具或SDK的版本号不对。严格按照下面的提示打开项目：

* v2.0及以后版本因使用.net core 3.1，必须使用visual Studio 2019及以上版本打开

* v2.0以前的版本可以使用visual Studio 2017  及.net core 2.1.4

## 系统使用Sql Server 2008数据库的问题

在使用Sql Server 2008时，会提示下面错误：

> System.Data.SqlClient.SqlException:“'OFFSET' 附近有语法错误。在 FETCH 语句中选项 NEXT 的用法无效。

因为SQL SERVER 2008 不支持FETCH分页方式，所以需要在startup.cs中修改配置：

```csharp
optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=123456;Integrated Security=True;", 
b => b.UseRowNumberForPaging());
```

即使用rownumber的分页方式。 当然最好的解决方式是升级SQL SERVER到2012或以上版本。

::: warning 注意
目前.Net的SDK已经放弃了这种方式，因此只能通过升级Sql Server的方式解决该问题
:::


## 使用mysql时，提示无法找到openauthdb.Org

在linux下面，mysql是区分数据库大小写的，但OpenAuth.Core使用EF映射数据库表是按照首字母大写来处理的。在mysql配置中里面加上：

```shell
lower_case_table_names=1
```
从而不区分大小写，即可解决该问题

## WebApi里增加一个控制器,Swagger不显示

需要在控制器上面添加注释，如：
```csharp
    /// <summary>  文件上传</summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class FilesController :ControllerBase
```

## 实体没有主键

定义一个实体，有时会出现没有主键的问题，即提示“Unable to track an instance of type xxxx because it does not have a primary key.”，这时可以强制在`OpenAuthDbContext.cs`中指定一个主键，如下：
```csharp
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<DataPrivilegeRule>()
            .HasKey(c => new { c.Id });
    }

```

## 新添加数据，马上执行【删除】，不能删除数据库记录

原因：新增记录时，没有返回新增数据的ID信息，导致删除不成功。

#### 解决方法一

重新加载列表，直接把 this.list.unshift(this.temp)换成this.getList()。如下：

```javascript
    createData() {
      // 保存提交
      this.$refs['dataForm'].validate((valid) => {
        if (valid) {
          categorys.add(this.temp).then(() => {
            this.getList();
            ...
          })
        }
      })
    },

```

#### 解决方法二

执行添加后，把Id返回给前端界面。详情请参考网友博客：[OpenAuth.net入门【5】——解决添加完数据，在未刷新列表时执行删除，数据未被真正删除的问题](https://www.cnblogs.com/wjx-blog/p/15892811.html)


