# 发布部署

直接使用Visual Studio的发布功能，发布到对应的文件夹

* OpenAuth.Mvc发布

![](/dotnetdeploy.png)

* OpenAuth.WebApi发布

![](/dotnetapideploy.png)



然后把对应的发布文件部署到IIS下。成功后直接访问：

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
