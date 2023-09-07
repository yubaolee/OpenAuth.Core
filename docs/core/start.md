# 快速开始

## 下载代码

gitee上面两个版本，仅SDK的版本不同，代码完全相同。其中：

* [OpenAuth.Net](https://gitee.com/dotnetchina/OpenAuth.Net) 默认SDK版本为.Net 6，推荐使用该版本。如果你使用vs2019作为开发工具，请注意查看：[VS2019打开6.0及以后版本](http://doc.openauth.net.cn/core/faq.html#vs2019%E6%89%93%E5%BC%806-0%E5%8F%8A%E4%BB%A5%E5%90%8E%E7%89%88%E6%9C%AC)

* [OpenAuth.Core](https://gitee.com/yubaolee/OpenAuth.Core) 的SDK版本为.Net Core 3.1.100，历史原因暂且保留，未来的某天会关闭它

.Net目前SDK升级特别方便，只需花费3分钟时间既可升级到.Net 6/7/8...等。请参考：[3分钟的时间把.net core 3.1的升级到.NET 5](https://www.cnblogs.com/yubaolee/p/Net3ToNet5.html)，所以不要纠结SDK版本问题。

## 安装sdk

下载安装微软官方SDK，代码地址：https://dotnet.microsoft.com/download

## 项目结构

OpenAuth.Net文件夹结构及功能说明如下：

```
📦OpenAuth.Net
 ┣ 📂CodeSmith
 ┃ ┗ 📂CSharp
 ┃ ┃ ┗ 📜WebGenerate.cst  //生成Web页面
 ┣ 📂Infrastructure       //基础工具类
 ┣ 📂mysql初始化脚本       
 ┣ 📂OpenAuth.App         //应用逻辑代码
 ┣ 📂OpenAuth.Identity    //IdentityServer4服务器，提供OAuth服务
 ┣ 📂OpenAuth.Mvc         //开源版Web站点
 ┣ 📂OpenAuth.Repository  //数据库访问相关代码
 ┣ 📂OpenAuth.WebApi      //WebApi接口站点
 ┣ 📂sql server 初始化脚本
 ┣ 📜.gitattributes
 ┣ 📜.gitignore
 ┣ 📜LICENSE
 ┣ 📜OpenAuth.Net.sln    //解决方案
 ┗ 📜README.md
```

其中调用关系为：

@startuml
hide footbox
skinparam handwritten true


actor 用户
boundary index.cshtml
control XXController
entity OpenAuth.App
entity OpenAuth.Repository
database OpenAuthDB

box "OpenAuth.Mvc" #LightBlue
	participant index.cshtml
	participant XXController
end box
participant OpenAuth.App
participant OpenAuth.Repository
participant OpenAuthDB 

用户 -> index.cshtml : 用户浏览页面
index.cshtml -> XXController : 前端通过ajax调用数据
XXController -> OpenAuth.App : 调用逻辑层
OpenAuth.App -> OpenAuth.Repository : 逻辑层调用仓储进行数据读写
OpenAuth.Repository -> OpenAuthDB : 仓储层进行数据库操作

@enduml

我们以【资源管理】功能为例，该功能涉及的文件如下：

![20220407153729](http://img.openauth.net.cn/20220407153729.png)

## 初始化数据库

使用数据库脚本`sql server 初始化脚本`或`mysql初始化脚本` 文件夹里面的结构脚本和数据脚本初始化数据库

::: warning 注意
如果使用企业版的OpenAuth.WebApi,则新建一个空数据库：OpenAuthPro。使用OpenAuth.Pro前端源码文件夹【sql脚本】中，运行`Sql Server脚本.sql`（或mysql脚本）
:::

## 打开项目

使用Visual Studio或Rider打开 `OpenAuth.Net.sln`
::: tip 提示
如果开发使用的电脑安装有多个版本的SDK（如同时有.net core 3.1 和.Net 5/6/7..），可以在根目录新建一个`global.json`文件来指定.net版本，文件内容如下：

```
{
  "sdk": {
    "version": "3.1.100"
  }
}
```

:::


## 修改配置

在 `ASP.NET Core` 应用程序启动时默认加载`appsettings.json`作为应用配置。同时还支持不同的运行环境加载对应的配置文件，如：

- 开发环境Development对应 `appsettings.Development.json`

- 部署环境Production对应 `appsettings.Production.json`

::: tip 提示

- 很多用户部署后提示连接数据库失败，很大原因就是没有修改`appsettings.Production.json`里面连接字符串

- 有些用户找不到`appsettings.Production.json`在哪？visual studio中点击`appsettings.json`左边的三角标识即可看到

:::

#### 修改单数据库连接字符串

* 修改OpenAuth.Mvc/appsettings.json连接字符串，如下：
```json
  "ConnectionStrings": {
    "OpenAuthDBContext": "Data Source=.;Initial Catalog=OpenAuthPro;User=sa;Password=000000"
  },
  "AppSetting": {
    "DbTypes": {
        "OpenAuthDBContext":"SqlServer" //数据库类型：SqlServer、MySql、Oracle
    }
```

#### 修改多数据库连接字符串

```json
  "ConnectionStrings": {
    "OpenAuthDBContext": "Data Source=.;Initial Catalog=OpenAuthPro;User=sa;Password=000000"
    "OpenAuthDBContext2": "DATA SOURCE=192.168.0.118:1521/YUBAO;PASSWORD=000000;Validate Connection=true;PERSIST SECURITY INFO=True;USER ID=yubaolee;" //racle
    "OpenAuthDBContext3": "server=127.0.0.1;user id=root;database=openauthpro;password=000000" //my sql
  },
  "AppSetting": {
    "DbTypes": {
        "OpenAuthDBContext":"SqlServer" //数据库类型：SqlServer、MySql、Oracle
       ,"OpenAuthDBContext2":"Oracle"
       ,"OpenAuthDBContext3":"MySql"
    }, 
```
## 编译运行MVC

使用visualstudio生成解决方案。
`注：首次启动时，visual studio会启动nuget还原第三方依赖包，请保持网络通畅，并等待一段时间`

启动openauth.mvc项目。

![启动](/startmvc.png "启动")

启动成功后使用浏览器打开[http://localhost:1802](http://localhost:1802) 即可访问，如下图所示：

![说明](/mvcmain.png "说明")


## 编译运行WebApi

使用visualstudio生成解决方案。
`注：首次启动时，visual studio会启动nuget还原第三方依赖包，请保持网络通畅，并等待一段时间`

启动openauth.webapi项目。

![20220102000528](http://img.openauth.net.cn/20220102000528.png)

启动成功后使用浏览器打开[http://localhost:52789/swagger/index.html](http://localhost:52789/swagger/index.html) 即可访问，如下图所示：

![20220101233542](http://img.openauth.net.cn/20220101233542.png)


