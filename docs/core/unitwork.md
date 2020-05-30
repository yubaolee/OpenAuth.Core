# 如何进行数据库操作

OpenAuth.Core使用Repository和Unitwork两种方式访问数据库。

## 使用场景

Repository适用于单表操作，没有事务需求的场景

Unitwork适用于多表操作（尤其是更新操作），有事务需求的场景


::: tip 什么是UnitWork
在web应用中，由于每个用户的请求都是属于不同线程的，需要保持每次请求的所有数据操作都成功的情况下提交数据，只要有一个失败的操作，则会对用户的此次请求的所有操作进行回滚，以确保用户操作的数据始终处于有效的状态。其实就两个字：**事务**
:::

## 示例

### Repository

假设数据库有一个表名称为Stock。则在OpenAuth.App中编写业务代码。比如`StockApp`

```csharp

namespace OpenAuth.App
{
    public class StockApp : BaseApp<Stock>
    {
        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryStockListReq request)
        {
            var result = new TableData();
            var objs = Repository.Find(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Id.Contains(request.key));
            }

            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit);
            result.count = objs.Count();
            return result;
        }

        public void Add(AddOrUpdateStockReq req)
        {
            var obj = req.MapTo<Stock>();
            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            Repository.Add(obj);
        }

        public void Update(AddOrUpdateStockReq obj)
        {
            Repository.Update(u => u.Id == obj.Id, u => new Stock
            {
                //todo:补充或调整自己需要的字段
            });
        }

        public StockApp(IUnitWork unitWork, IRepository<Stock> repository,IAuth auth) : base(unitWork, repository,auth)
        {
        }
    }
}
```

### UnitWork

比如上面示例中的Update函数，现在需要增加系统日志和更新一些表的记录。则代码如下：

```csharp
        public void Update(AddOrUpdateStockReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            UnitWork.Update<Stock>(u => u.Id == obj.Id, u => new Stock
            {
                //todo:补充或调整自己需要的字段
            });

            UnitWork.Add<SysLog>(new SysLog
            {
                //todo:补充或调整自己需要的字段
            });

            //如果还需要更新其他表
            UnitWork.Update<OtherTable>(u => u.Id == obj.Id, u => new Stock
            {
                //todo:补充或调整自己需要的字段
            });

            UnitWork.Save();

        }

```

UnitWork还经常在连表查询中使用。

```csharp
        /// <summary>
        /// 加载用户的部门
        /// </summary>
        public List<Org> LoadForUser(string userId)
        {
            var result = from userorg in UnitWork.Find<Relevance>(null)
                join org in UnitWork.Find<Org>(null) on userorg.SecondId equals org.Id
                where userorg.FirstId == userId && userorg.Key == Define.USERORG
                select org;
            return result.ToList();
        }
```