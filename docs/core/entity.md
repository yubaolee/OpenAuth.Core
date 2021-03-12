# 数据库实体

## 跟换主键名称

系统默认的主键是以`Id`命名，如果数据库主键是其他名称，可以直接用注解进行更改：

```csharp
 [Column("CustomerId")]
 public string Id { get; set; }
```


## 添加非统一主键

系统默认的主键是以`Id`命名，如果数据库表中存在其他类型或名称的主键，可以通过继承`BaseEntity`实现。目前系统默认有两个实体基类：
 
- `StringEntity`：针对数据库主键为varchar类型的数据表,主键按guid方式生成;

- `LongEntity`：针对数据库主键为numberic(长度>=15)类型的数据表，主键按雪花算法生成；【新功能】

```csharp
    /// <summary>
    /// 数据库Id为numberic类型的数据实体使用该基类，用法同Entity
    /// 数据库Id字段为numberic(16,0)或以上长度的整型，采用雪花算法生成Id。
    /// </summary>
    public class LongEntity :BaseEntity
    {
        [Browsable(false)]
        public long Id { get; set; }
        public override bool KeyIsNull()
        {
            return Id == 0;
        }

        /// <summary>
        /// 采用雪花算法计算Id
        /// </summary>
        public override void GenerateDefaultKeyVal()
        {
            var options = new IdGeneratorOptions(){ WorkerId = 1};
            IIdGenerator IdHelper = new YitIdGenerator(options);
            Id =  IdHelper.NewLong();
        }
    }
```

#### 添加主键类型为numberic的相关业务

我们以下表为例：

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

首先创建对应的业务层代码。在`OpenAuth.App`中添加：
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


