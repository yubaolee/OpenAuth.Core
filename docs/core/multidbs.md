# 配置多数据库

框架支持同时访问多个数据库。具体操作如下：

## 添加新数据库连接字符串

在配置文件appsettings.json中，添加新的连接字符串`OpenAuthDBContext2`

```csharp
 "ConnectionStrings": {
    "OpenAuthDBContext": "Data Source=.;Initial Catalog=OpenAuthPro;User=sa;Password=000000",
    "OpenAuthDBContext2": "Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000"
  }
```

## 添加新的数据上下文

在OpenAuth.Repository中添加新的数据库上下文，比如`OpenAuthDBContext2`

```csharp
public class OpenAuthDBContext2 : DbContext
    {

        private ILoggerFactory _LoggerFactory;
        private const string _connectstr = "OpenAuthDBContext2";
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseLoggerFactory (_LoggerFactory);

             string connect = _configuration.GetConnectionString(_connectstr);
            if (string.IsNullOrEmpty(connect))
            {
                throw new Exception($"未能找到租户{_connectstr}对应的连接字符串信息");
            }

            //这个地方如果用IOption，在单元测试的时候会获取不到AppSetting的值😅
            var dbtypes = _configuration.GetSection("AppSetting:DbTypes").GetChildren()
                .ToDictionary(x => x.Key, x => x.Value);
            
            var dbType = dbtypes[_connectstr];
            if (dbType == Define.DBTYPE_SQLSERVER)
            {
                optionsBuilder.UseSqlServer(connect);
                }
                else if(dbType == Define.DBTYPE_MYSQL)  //mysql
            {
                optionsBuilder.UseMySql(connect);
            }
            else
            {
                optionsBuilder.UseOracle(connect);
            }

            base.OnConfiguring (optionsBuilder);
        }
        
        public OpenAuthDBContext2(DbContextOptions<OpenAuthDBContext2> options, ILoggerFactory loggerFactory)
            : base(options)
        {
            _LoggerFactory = loggerFactory;
        }

        ... //其他代码略
    }

```

## 注入新数据库

在项目（OpenAuth.WebApi等）的启动代码`Startup.cs`中，注入刚刚添加的数据库

```csharp
 services.AddDbContext<OpenAuthDBContext2>();
```

## 编写业务代码

我们以系统日志模块为例，只需要调整以下代码，然后运行就可以发现，日志已经全部记录到新的数据库中。

```csharp
  public class SysLogApp : BaseApp<SysLog,OpenAuthDBContext2>
    {
        public SysLogApp(IUnitWork<OpenAuthDBContext2> unitWork, IRepository<SysLog,OpenAuthDBContext2> repository) : base(unitWork, repository, null)
        {
        }

        ...//剩余的代码和系统自带的模块完全一致
    }
```
