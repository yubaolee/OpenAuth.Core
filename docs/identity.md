OpenAuth.core支持两种登录认证方式：自定义认证和基于IdentityServer的OAuth认证。

这两种方式通过配置webapi或mvc的appsettings.json可以自由切换:

```javascript
"IdentityServerUrl": "http://localhost:12796", //IdentityServer服务器地址。如果为空，则不启用OAuth认证
```

当IdentityServerUrl为空时，采用普通的token认证，这时不需要OpenAuth.Identity启动支持。

当IdentityServerUrl配置了地址时，则采用Identity认证方式，这时必须启动OpenAuth.Identity。

具体在OpenAuth.Mvc/WebAPI中如何控制登录访问并进行权限控制，请点击[这里](http://openauth.me/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)