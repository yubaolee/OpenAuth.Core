# 快速开始

## 下载代码

使用git工具下载代码，代码地址：https://gitee.com/yubaolee/OpenAuth.Net.git

## 修改连接字符串

* 修改OpenAuth.Mvc/Web.config连接字符串，如下：
```xml
 <add name="OpenAuthDBContext" connectionString="Data Source=.;Initial Catalog=OpenAuthDB;Persist Security Info=True;User ID=sa;Password=000000;MultipleActiveResultSets=True" providerName="System.Data.SqlClient" />
```

* 修改OpenAuth.WebApi/Web.config连接字符串,如下：
```xml
 <add name="OpenAuthDBContext" connectionString="Data Source=.;Initial Catalog=OpenAuthDB;Persist Security Info=True;User ID=sa;Password=000000;MultipleActiveResultSets=True" providerName="System.Data.SqlClient" />
```

## 设置启动项

在vs解决方案视图中，右键解决方案“OpenAuth”属性，调整启动项，如下：
![设置启动项](/dotnetstart.png "设置启动项")

::: warning 提别提醒

很多人启动的时候会遇到下面这个异常

![](/starterror.png)

99.9999%的人是因为没有启动OpenAuth.WebApi项目造成的。务必按上面进行启动项设置🙂
:::

## 编译运行

使用Visual Studio菜单栏中的【启动】按钮或快捷键F5，启动运行。
`注：首次启动时，visual studio会启动nuget还原第三方依赖包，请保持网络通畅，并等待一段时间`

启动成功后，可以在浏览器访问两个网址：

* [http://localhost:56813](http://localhost:56813) 为项目的主界面，对应OpenAuth.Mvc项目。如下图所示：
![说明](https://gitee.com/uploads/images/2018/0328/150659_6900820e_362401.png "说明")

* [http://localhost:52789/Swagger/ui/index](http://localhost:52789/Swagger/ui/index)  为项目WebApi接口部分，对应OpenAuth.WebApi项目，主要为其他项目提供数据接口及为OpenAuth.Mvc提供单点登录SSO功能。这是一个纯WebAPI项目，本身是没有界面的（所以3.0以前的版本会报找不到页面的错误），为了美观，增加了swagger的支持！
![](/donetswagger.png)


::: warning 提别提醒

如果WebApi不是使用的52789端口，需要在OpenAuth.Mvc的Web.config中修改下面配置：

```xml
<add key="SSOPassport" value="http://localhost:你的端口号" />
```
:::



## 更多文档

如需更多文档请点击[这里](http://openauth.me/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)

![更多文档](http://demo.openauth.me:8887/upload_files/200415002234330.png "更多文档")