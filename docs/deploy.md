部署到IIS时主要用到两个端口：

* http://localhost:56813 为项目的主界面，对应OpenAuth.Mvc项目。如下图所示：
![说明](https://gitee.com/uploads/images/2018/0328/150659_6900820e_362401.png "说明")

* http://localhost:52789/Swagger/ui/index  为项目WebApi接口部分，对应OpenAuth.WebApi项目，主要为其他项目提供数据接口及为OpenAuth.Mvc提供单点登录SSO功能。这是一个纯WebAPI项目，本身是没有界面的（所以3.0以前的版本会报找不到页面的错误），为了美观，增加了swagger的支持！
![说明](http://www.openauth.me/upload/180513155243679.png "说明")


如果WebApi不是使用的52789端口，需要在OpenAuth.Mvc的Web.config中修改下面配置：

```xml
<add key="SSOPassport" value="http://localhost:你的端口号" />
```