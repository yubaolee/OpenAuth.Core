# 单元测试

为了方便项目调试，框架的所有层均支持单元测试。代码基于NUnit框架编写。测试内如大概如下：

* OpenAuth.Reposiroty: 直接测试数据库是否可以正常读写，测试级别DbContext。在该项目的`TestBase.cs`中配置连接字符串；

* OpenAuth.App: 测试所有业务逻辑，测试级别为各种xxxApp/xxxService等。可以模拟用户登录和前端Cookie提交的信息。在该项目的`TestBase.cs`中配置连接字符串；

* OpenAuth.Mvc: 测试MVC的访问，可以模拟用户登录和前端Cookie提交的信息。使用OpenAuth.App中的测试连接字符串；

* OpenAuth.WebApi: 测试接口WebApi访问，可以模拟用户登录和前端Cookie提交的信息。使用OpenAuth.App中的测试连接字符串；

所有的测试代码均在每个项目的`Test`文件夹中编写。比如`OpenAuth.App\Test\TestAccessObjs.cs`：

```csharp
/// <summary>
/// 测试为部门分配用户
/// </summary>
[Test]
public void AssignOrgUsers()
{
    var app = _autofacServiceProvider.GetService<RevelanceManagerApp>();
    var userApp = _autofacServiceProvider.GetService<UserManagerApp>();

    app.AssignOrgUsers(new AssignOrgUsers
    {
        OrgId = "8e31553c-cab8-4eb3-90b5-5f8ff1d21801",
        UserIds = new []{"96f63f9d-e8c8-4258-963e-3327ed7d6f56"}
    });

    //获取机构的所有用户
    var result = userApp.Load(new QueryUserListReq
    {
        orgId = "8e31553c-cab8-4eb3-90b5-5f8ff1d21801",
        page = 1,
        limit = 10
    });
    
    Console.WriteLine(JsonHelper.Instance.Serialize(result));
}
```

::: warning 注意

每个单元测试类都会继承`TestBase`，该类有一个虚函数`GetService`，默认只注入了缓存Cache，配置Option。如果在测试的过程中需要模拟登录用户，cookie等信息，需要在测试类中重写该方法。比如一个典型的重写如下：

```csharp
public override ServiceCollection GetService()
{
    var services = new ServiceCollection();

    //模拟帐号test3记录在缓存中，并与tokentest关联
    var cachemock = new Mock<ICacheContext>();
    cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "test3" });
    services.AddScoped(x => cachemock.Object);

    //模拟客户端请求的token值为`tokentest`
    var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
    httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");
    services.AddScoped(x => httpContextAccessorMock.Object);

    //模拟httpclientfactory
    var mockHttpFac = new Mock<IHttpClientFactory>();
    services.AddScoped(x => mockHttpFac.Object);

    return services;
}
```

:::


