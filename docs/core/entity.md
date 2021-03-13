# 数据库实体

## 跟换主键名称

系统默认的主键是以`Id`命名，如果数据库主键是其他名称，可以直接用注解进行更改：

```csharp
 [Column("CustomerId")]
 public string Id { get; set; }
```

## 如何添加主键类型为numberic的业务代码

如果数据库表中存在其他类型的主键，可以通过继承`BaseEntity`实现。目前系统默认有三个实体基类：
 
- `StringEntity`：针对数据库主键为varchar类型的数据表,主键按guid方式生成;

- `LongEntity`：针对数据库主键为numberic(15)的数据表，主键按雪花算法生成；【新功能，官方推荐使用方式👍】

- `IntAutoGenEntity`：针对数据库主键为numberic且为数据库自动生成的类型表，通常为SqlServer的自动增长类型和Oracle的Sequence生成；【新功能】

这三个基类可以覆盖90%以上的业务场景。如果这两个不能满足需求，可以自己按需求扩展。参考代码如下：

```csharp
    /// <summary>
    /// 数据库Id为int类型的数据实体使用该基类，用法同Entity
    /// </summary>
    public class IntEntity :BaseEntity
    {
        [Browsable(false)]
        public int Id { get; set; }
        public override bool KeyIsNull()
        {
            return Id == 0;
        }

        /// <summary>
        /// 需要自己有个生成随机ID的算法，可参考LongEntity中的雪花算法
        /// </summary>
        public override void GenerateDefaultKeyVal()
        {
            Id =  RandomInt();
        }
    }
```

## 具体如何做

我们以一个主键为numeric(16)的表（表名为LongTable）为例：

```SQL
create table LongTable
(
    Id  numeric(16) not null
        constraint LongTable_pk
         primary key nonclustered,
    Name varchar(50)
)
go

```

1. 首先创建对应的业务实体。在`OpenAuth.Repository.Domain`中添加：

```csharp
namespace OpenAuth.Repository.Domain
{
    [Table("LongTable")]
    public class LongTable :LongEntity
    {
        public string Name { get; set; }
    }
}
```

2. 修改`OpenAuth.Repository.OpenAuthDBContext`,增加成员变量：

```csharp
        public virtual DbSet<LongTable> IntTables { get; set; }
```

3. 最后创建对应的业务层代码。在`OpenAuth.App`中添加：

```csharp
namespace OpenAuth.App
{
    /// <summary>
    /// 主键为numberic类型的业务，使用BaseLongApp基类
    /// </summary>
    public class LongTableApp :BaseLongApp<LongTable, OpenAuthDBContext>
    {
        public void Add(LongTable application)
        {
            Repository.Add(application);
        }

        public void Update(LongTable application)
        {
            Repository.Update(application);
        }


        public async Task<List<LongTable>> GetList(QueryAppListReq request)
        {
            var applications =  UnitWork.Find<LongTable>(null) ;
           
            return applications.ToList();
        }

        public LongTableApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<LongTable,OpenAuthDBContext> repository,IAuth auth) 
            : base(unitWork, repository, auth)
        {
        }
    }
}
```

然后就可以像其他应用服务一样使用这个服务

::: warning 注意
最新版才支持，以前的版本（2.0或以前的版本）可以参考BaseEntity进行改造

:::


