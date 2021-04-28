# 快速开始

## 下载代码

使用git工具下载代码，代码地址：https://gitee.com/yubaolee/OpenAuth.Core.git

## 安装sdk

下载安装微软官方SDK，代码地址：https://dotnet.microsoft.com/download

## 项目结构
```
📦OpenAuth.Core
 ┣ 📂CodeSmith
 ┃ ┗ 📂CSharp
 ┃ ┃ ┣ 📜ApiGenerate.cst  //生成api接口
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
 ┣ 📜OpenAuth.Core.sln    //解决方案
 ┗ 📜README.md
```
## 初始化数据库

使用数据库脚本`sql server 初始化脚本`或`mysql初始化脚本` 文件夹里面的结构脚本和数据脚本初始化数据库

## 打开项目

使用Visual Studio 2019或Rider打开 `OpenAuth.Core.sln`
::: tip 提示
v2.0及以后版本因使用.net core 3.1，必须使用visual Studio 2019及以上版本打开

v2.0以前的版本可以使用visual Studio 2017
:::


## 修改配置

在 `ASP.NET Core` 应用程序启动时默认加载`appsettings.json`作为应用配置。同时还支持不同的运行环境加载对应的配置文件，如：

- 开发环境Development对应 `appsettings.Development.json`

- 部署环境Production对应 `appsettings.Production.json`

::: tip 提示

很多用户部署后提示连接数据库失败，很大原因就是没有修改`appsettings.Production.json`里面连接字符串

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
## 编译运行

使用visualstudio生成解决方案。
`注：首次启动时，visual studio会启动nuget还原第三方依赖包，请保持网络通畅，并等待一段时间`

启动openauth.mvc项目。

![启动](/startmvc.png "启动")

启动成功后使用浏览器打开[http://localhost:1802](http://localhost:1802) 即可访问，如下图所示：

![说明](/mvcmain.png "说明")


