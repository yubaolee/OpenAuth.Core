# API权限控制

在使用OpenAuth.WebApi过程中，系统会对所有的Api进行权限控制。如果没有登录就访问Api接口，会提示下面信息：

```javascript
{
  "message": "认证失败，请提供认证信息",
  "code": 401
}

```
如果想正常调用，必需先调用登录接口`/api/Check/Login`拿到登录`token`，如下：

```javascript
{
  "returnUrl": "http://localhost:56813",
  "token": "e4a5aa00",
  "result": null,
  "message": "操作成功",
  "code": 200
}
```

把token值放置在http header X-Token中，即可正常调用其他接口。如下：

```javascript

GET /api/Applications/Load?page=1&limit=10 HTTP/1.1
Host: localhost:52789
X-Token: e4a5aa00

```

## 不登录直接访问

有些场景我们需要不进行登录直接访问接口，可以直接在接口上面加[AllowAnonymous]注解即可。如下：

```csharp
[HttpGet]
[AllowAnonymous]
public async Task<TableData> Load([FromQuery]QueryWmsInboundOrderDtblListReq request)
{
    return await _app.Load(request);
}
```

