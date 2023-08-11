# 日志操作

## 普通日志

框架默认使用Log4Net作为记录日志的方式，可以在Program.cs中配置日志参数或调整为其他日志。日志默认按日期生成日志文件，并存放在`log\`目录下。简单用法如下：

```csharp
    //具体代码参考OpenAuth.App/OpenJobApp.cs，此处简化真实逻辑，方便理解
    public void RecordRun(string jobId)
    {
        //其他代码略
        _logger.LogInformation($"运行了自动任务：{job.JobName}");
    }

    public OpenJobApp(IUnitWork unitWork, IRepository<OpenJob> repository,
        IAuth auth,  ILogger<OpenJobApp> logger) : base(unitWork, repository, auth)
    {
        _logger = logger;
    }
```

## 数据库日志

如果想使用数据库记录业务日志（如系统默认的用户操作日志等），可以使用`SysLogApp`模块功能。日志可以在站点【消息日志】->【系统日志】中查看到记录的日志信息。简单用法如下：

```csharp
    //具体代码参考OpenAuth.App/OpenJobApp.cs，此处简化真实逻辑，方便理解
    public void RecordRun(string jobId)
    {
        //其他代码略
        _sysLogApp.Add(new SysLog
            {
                CreateName = "Quartz",
                CreateId = "Quartz",
                TypeName = "定时任务",
                TypeId = "AUTOJOB",
                Content = $"运行了自动任务：{job.JobName}"
            });
    }

     public OpenJobApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<OpenJob,OpenAuthDBContext> repository,
            IAuth auth, SysLogApp sysLogApp) : base(unitWork, repository, auth)
        {
            _sysLogApp = sysLogApp;
        }
```

## EF打印Sql日志

在调试数据库时，需要打印真正执行的SQL信息。最简单的方式是使用下面方法输出到控制台：

```csharp
    public partial class OpenAuthDBContext : DbContext
    {

        public static readonly ILoggerFactory MyLoggerFactory
            = LoggerFactory.Create(builder => { builder.AddConsole(); });
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.EnableSensitiveDataLogging (true);  //允许打印参数
            optionsBuilder.UseLoggerFactory (MyLoggerFactory);

            base.OnConfiguring (optionsBuilder);
        }
    }
```

## EF输出Sql到log4net

框架目前直接配置`appsettings.Development.json`即可完成输出sql语句到log4net对应的日志文件中。如下：

```
  "Logging": {
    "LogLevel": {
      "Microsoft.EntityFrameworkCore.Database.Command": "Information"  //EF输出SQL语句
    }
  }
```

正式发布环境下，如无特殊需求，建议在`appsettings.Production.json`配置中关闭该输出

## 在Swagger中输出日志

框架集成mini profiler工具，在swagger中或其他客户端调用WebApi接口时，可以直接在swagger中显示日志信息（需要刷新）。如下图：

![](/miniprofiler1.png)

点击`sql`列的时间，查看详细的sql执行情况

![](/miniprofiler2.png)

如果需要订制日志信息，查看更详细的日志情况，可以自己调整代码实现。以登录接口为例，添加以下代码：

```csharp
[HttpPost]
[AllowAnonymous]
public LoginResult Login(PassportLoginRequest request)
{
    var result = new LoginResult();
    using (MiniProfiler.Current.Step("步骤一"))
    {
        result = _authUtil.Login(request.AppKey, request.Account, request.Password);
    }

    using (MiniProfiler.Current.Step("步骤二"))
    {
        //代码略
    }

    using (MiniProfiler.Current.Step("步骤三"))
    {
        //代码略
    }
    return result;
}
```
这时调用该API后即可看到具体步骤一、步骤二、步骤三的执行时间情况了


