
# OAuth集成

OpenAuth.core支持两种登录认证方式：自定义认证和基于IdentityServer的OAuth认证。

这两种方式通过配置webapi或mvc的appsettings.json可以自由切换:

```json
"IdentityServerUrl": "http://localhost:12796", //IdentityServer服务器地址。如果为空，则不启用OAuth认证
```

1. 当IdentityServerUrl为空时，采用普通的token认证，这时不需要OpenAuth.Identity启动支持。

2. 当IdentityServerUrl配置了地址时，则采用Identity认证方式。


## OpenAuth.Mvc

当启用了Identity时，系统启动后界面如下：

  ![MVC启用identity](/mvcidentity.png "mvcidentity")

  这时点击登录超链接，会跳转到OpenAuth.Identity登录界面。效果如下：

  ![](/identity.png)

## OpenAuth.WebApi OAuth

当启用了Identity时，客户端调用API需要先通过OpenAuth.IdentityServer服务器的OAuth验证，才能调用接口。对于OpenAuth.Net调用API的客户端有两种：

#### SwaggerUI

当我们启动了OpenAuth.WebApi，在浏览器打开[http://localhost:52789/swagger/index.html](http://localhost:52789/swagger/index.html)时，其实是Swagger框架给我们生成的一个调动客户端，对于启用了Identity的服务，Swagger会有一个Authorise的操作按钮：

![20220119180445](http://img.openauth.net.cn/20220119180445.png)

![20220119180503](http://img.openauth.net.cn/20220119180503.png)

点击登录超链接，会跳转到OpenAuth.Identity登录界面。登录成功后会自动跳转回来。提示授权成功：

![20220119180546](http://img.openauth.net.cn/20220119180546.png)

这时所有的接口都可以直接访问，访问时会在http头上自动加认证信息：

![20220119180608](http://img.openauth.net.cn/20220119180608.png)

![20220119180630](http://img.openauth.net.cn/20220119180630.png)

#### OpenAuth.Pro

在使用企业版vue界面访问OpenAuth.WebApi时，已经在文件`.env.dev`中配置好相关选项，可以直接使用，无需其他处理。

```python

VUE_APP_OIDC_AUTHORITY = http://localhost:12796   #Identity服务器地址
VUE_APP_OIDC_CLIENTID = OpenAuth.Pro   #客户端名称
VUE_APP_OIDC_REDIRECTURI = http://localhost:1803/#/oidc-callback  #登录回调
VUE_APP_OIDC_POSTLOGOUTREDIRECTURI = http://localhost:1803 #退出登录回调
VUE_APP_OIDC_RESPONSETYPE = code  #认证方式
VUE_APP_OIDC_SCOPE = openid profile openauthapi  #认证范围
VUE_APP_OIDC_AUTOMATICSILENTRENEW = true
VUE_APP_OIDC_SILENTREDIRECTURI = http://localhost:1803/silent-renew-oidc.html

```

#### OpenAuth.WebApi默认认证方式

当IdentityServerUrl配置为空时，采用普通的token认证，客户端在访问的时候必须先调用登录接口,然后把获取到的token值添加到http header的X-Token中,才能调用对应的API接口。

