# SqlSugar访问数据库

SqlSugar 是一款老牌.NET开源ORM框架，相对于EntityFramework复杂的Linq表达式，它拥有灵活的动态查询，如果你喜欢直接码Sql，那么它是你的不二之选。OpenAuth.Net 6.0及以后版本默认支持使用SqlSugar方式访问数据库。目前大多数模块都已使用SqlSugar的方式，这里以资源管理为例：

```csharp
public class ResourceApp:SqlSugarBaseApp<Resource>
    {
        public void Add(AddOrUpdateResReq resource)
        {
            ...
            Repository.Insert(obj);
        }

        public void Update(AddOrUpdateResReq obj)
        {
            Repository.Update(u => new Resource
            {
                Name = obj.Name,
                //todo:要修改的字段赋值
            },u => u.Id == obj.Id);
        }
       
        public void Delete(string[] ids)
        {
            Repository.DeleteByIds(ids);
        }

        public ResourceApp(ISqlSugarClient client, IAuth auth) : base(client, auth)
        {
        }

    }
```


## 使用方法

如上所示代码，只需要继承`SqlSugarBaseApp`即可使用SqlSugar强大功能。其中

Repository：实现的是SqlSugar的仓储模式，详细Api请查看：[SqlSugar使用仓储](https://www.donet5.com/Home/Doc?typeId=1228)。在OpenAuth.Net中：
```csharp
public class ResourceApp:SqlSugarBaseApp<Resource>
    {
        public void Add(AddOrUpdateResReq resource)
        {
            ...
            Repository.Insert(obj);
        }
    }
```

SugarClient：即SqlSugar最基础的数据库读写用法。详细Api请查看：[SqlSugar入门必看](https://www.donet5.com/Home/Doc?typeId=1181)。在OpenAuth.Net中：
```csharp
public class ResourceApp:SqlSugarBaseApp<Resource>
    {
        public List<Resource> Load()
        {
            ...
            return SugarClient.Queryable<Resource>().ToList();
        }
    }
```

