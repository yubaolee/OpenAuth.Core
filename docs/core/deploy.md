# 部署MVC

::: tip 提示
因.net core内部有自托管的Web服务器，推荐使用控制台方式部署。本内容基于控制台命令的方式。如果部署到IIS请自行百度:cold_sweat:
:::

## 生成发布文件

* 修改部署环境的连接字符串信息,特别注意是`appsettings.Production.json`文件：
![说明](/configmvc.png "说明")

::: warning 注意
决定系统部署后读取`appsettings.json`还是`appsettings.Production.json`是通过操作系统的环境变量`ASPNETCORE_ENVIRONMENT`来控制的。
在centos切换成正式可以用
```shell
export ASPNETCORE_ENVIRONMENT=Production
```

或者修改/etc/profile配置，在结尾添加：
```shell
ASPNETCORE_ENVIRONMENT=Production
export ASPNETCORE_ENVIRONMENT
```
然后刷新：
```shell
source /etc/profile
```

在Widows系统中增加对应环境变量即可

:::

* 直接在解决方案资源管理器中，选中OpenAuth.Mvc右键【发布】，出现下面的配置框，使用文件系统即可：

![说明](http://pj.openauth.net.cn/zentao/file-read-8.png "说明")

* 发布完成后可以在输出目录看到发布详情（红色框内即为发布的文件夹）：

![说明](http://pj.openauth.net.cn/zentao/file-read-69.png "说明")

## 部署OpenAuth.Mvc

将发布后的文件拷贝到服务器文件夹。直接使用`dotnet  openauth.mvc.dll` 命令启动。启动成功后使用浏览器打开http://localhost:1802 即可访问，如下图所示：

![说明](/mvcmain.png "说明")


## jenkins部署OpenAuth.Mvc

OpenAuth.Net采用的是gitee托管源码，只需使用Gitee WebHook构建触发器。配置如下：

![说明](/giteesource.png "说明")

做好上面的配置后，代码提交时就会触发jenkins工作。剩下的就是编写自己的构建脚本。增加构建步骤，选择执行Shell。并输入以下脚本：

```shell
#!/bin/bash
kill -9 $(ps -ef|grep OpenAuth.Mvc.dll|grep -v grep|awk '{print $2}')

#项目启动之后才不会被Jenkins杀掉。
export BUILD_ID=dontKillMe
pwd
echo $PATH
dotnet restore # 还原nuget包

cd ./OpenAuth.Mvc
dotnet build # 编译

rm -rf /data/openauthmvc #最终站点路径
mkdir /data/openauthmvc
dotnet publish -c:Release -o /data/openauthmvc # 生成发布文件到/data/openauthmvc。如果服务器上有多个.NET版本，加上目标版本号，如：-f net6.0 

nohup dotnet /data/openauthmvc/OpenAuth.Mvc.dll &

echo '============================end build======================================='
```



