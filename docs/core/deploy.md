# 部署

::: tip 提示
因.net core内部有自托管的Web服务器，推荐使用控制台方式部署

PS:不要再问怎么部署到IIS了，都快三年没用IIS了，我也不知道啊。要不，劳驾问下百度 :cold_sweat:
:::

## 站点OpenAuth.Mvc部署

* 修改部署环境的连接字符串信息,特别注意是`appsettings.Production.json`文件：
![说明](/configmvc.png "说明")

::: warning 注意
决定系统部署后读取`appsettings.json`还是`appsettings.Production.json`是通过操作系统的环境变量`ASPNETCORE_ENVIRONMENT`来控制的。
在centos切换成正式可以用
```shell
export ASPNETCORE_ENVIRONMENT=Production
```
在Widows系统中增加对应环境变量即可

:::

* 直接在解决方案资源管理器中，选中OpenAuth.Mvc右键【发布】，出现下面的配置框，使用文件系统即可：

![说明](http://pj.openauth.me/zentao/file-read-8.png "说明")

* 发布完成后可以在输出目录看到发布详情（红色框内即为发布的文件夹）：

![说明](http://pj.openauth.me/zentao/file-read-69.png "说明")

* 发布【OpenAuth.Mvc】完成后进入文件目录【netcoreapp2.1\publish】，直接使用`dotnet  openauth.mvc.dll` 命令启动。启动成功后使用浏览器打开http://localhost:1802 即可访问，如下图所示：

![说明](/mvcmain.png "说明")


## 接口OpenAuth.WebApi部署

请查看[企业版](http://openauth.me/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)内部文档


