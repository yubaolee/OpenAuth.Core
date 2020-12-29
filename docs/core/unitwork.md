# 数据库读写及事务处理

OpenAuth.Core使用Repository和Unitwork两种方式访问数据库。

## 使用场景

Repository适用于单表操作，没有事务需求的场景

Unitwork适用于多表操作（尤其是更新操作），有事务需求的场景


::: tip 什么是UnitWork
在web应用中，由于每个用户的请求都是属于不同线程的，需要保持每次请求的所有数据操作都成功的情况下提交数据，只要有一个失败的操作，则会对用户的此次请求的所有操作进行回滚，以确保用户操作的数据始终处于有效的状态。其实就两个字：**事务**
:::

## 单表操作Repository

假设数据库有一个表名称为Stock。则在OpenAuth.App中编写业务代码。比如`StockApp`

```csharp

namespace OpenAuth.App
{
    public class StockApp : BaseApp<Stock,OpenAuthDBContext>
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

        public StockApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<Stock,OpenAuthDBContext> repository,IAuth auth) : base(unitWork, repository,auth)
        {
        }
    }
}
```

## 事务操作UnitWork

默认情况下，EF每执行一次SaveChanges()方法时就会新建一个事务，然后将context中的CUD操作都在这个事务中进行。使用方式如下：

```csharp
        public void Update(AddOrUpdateStockReq obj)
        {

            UnitWork.Add<SysLog>(new SysLog
            {
                //todo:模拟新增操作
            });

            var stock = UnitWork.FirstOrDefault<Stock>(u => u.Id == obj.Id);
            stock.Name = "xxxx";
            UnitWork.Update(stock);  //更新操作

            var other = UnitWork.FirstOrDefault<OtherTable>(u => u.Id == obj.Id);
            other.Name = "xxxx";
            UnitWork.Update(other);  //其他更新操作

            UnitWork.Save();  //只有一次Save()操作

        }

```

如果在一个事务里面有多次`SaveChanges()`的情况，需要使用OpenAuth.Core提供的`ExecuteWithTransaction`处理。如下：

```csharp
        //代码详见TestTransaction.cs/NormalSubmit()
        UnitWork.ExecuteWithTransaction(() =>
        {
            var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            var user = new User
            {
                Id = account,
                Account = account,
                Name = account,
            };

            unitWork.Add(user);
            unitWork.Save();  //第一次savechanges()

            user.Account = "Trans_" + user.Account;
            unitWork.Update(user);
            unitWork.Save();  //第二次savechanges()

            //Z.EntityFramework.Plus的Update内部自动调用了SaveChanges()，算第三次
            unitWork.Update<User>(u => u.Id == account, u => new User
            {
                Account = "Trans2_" + user.Account
            });
        });
```

发生这种情况，通常是因为在各个应用层逻辑内部已经调用了`UnitWrok.Save()`,比如：

```csharp
        //详细代码请查看UserManagerApp.cs,本例简化真实逻辑，方便理解
        private RevelanceManagerApp _revelanceApp;
        public void AddOrUpdate(UpdateUserReq request)
        {
            UnitWork.ExecuteWithTransaction(() =>
            {
                User requser = request;
                requser.CreateTime = DateTime.Now;

                UnitWork.Add(requser);
                UnitWork.Save();

                string[] orgIds = request.OrganizationIds.Split(',').ToArray();
                //下面两个方法各自内部都会调用UnitWork.Save()
                _revelanceApp.DeleteBy(Define.USERORG, requser.Id);
                _revelanceApp.Assign(Define.USERORG, orgIds.ToLookup(u => requser.Id));
            });
        }

```

## 多表查询

简单的多表查询可以使用UnitWork完成。例如：

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

如果是复杂的SQL查询，建议使用下面的SQL语句查询，以获得更高的性能。

## SQL 语句查询

框架提供两个SQL语句查询的接口:
* FromSql: 返回数据库表对应的实体，必需在在DbContext中增加对应的DbSset；

* Query: 返回数据库中不存在的表实体，必需在在DbContext中增加对应的DbQuery；

### 返回数据库表

```csharp
  //UserManagerApp.cs
   var users = UnitWork.FromSql<User>("select * from user");
```

### 返回非数据库表

```csharp
  //OpenAuthDBContext中添加访问
  public virtual DbQuery<UserResp> UserResps { get; set; }

  //使用
   var users = UnitWork.Query<UserResp>("select * from user");
```

