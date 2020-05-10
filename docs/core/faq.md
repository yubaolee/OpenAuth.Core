# 常见问题处理

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
OpenAuth.Core 2.0及以后版本因为使用了.net core 3.1，该SDK已经放弃了这种方式，因此只能通过升级Sql Server的方式解决该问题
:::


## 使用mysql时，提示无法找到openauthdb.Org

在linux下面，mysql是区分数据库大小写的，但OpenAuth.Core使用EF映射数据库表是按照首字母大写来处理的。在mysql配置中里面加上：

```shell
lower_case_table_names=1
```
从而不区分大小写，即可解决该问题

