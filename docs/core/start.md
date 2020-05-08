# 快速开始

## 下载代码

使用git工具下载代码，代码地址：https://gitee.com/yubaolee/OpenAuth.Core.git

## 安装sdk

下载安装微软官方SDK，代码地址：https://dotnet.microsoft.com/download

## 初始化数据库

使用数据库脚本`sql server 初始化脚本`或`mysql初始化脚本` 文件夹里面的结构脚本和数据脚本初始化数据库

## 打开项目

使用Visual Studio 2019或Rider打开 `OpenAuth.Core.sln`
::: tip 提示
v2.0及以后版本因使用.net core 3.1，必须使用visual Studio 2019及以上版本打开

v2.0以前的版本可以使用visual Studio 2017
:::


## 修改连接字符串

* 修改OpenAuth.Mvc/appsettings.json连接字符串，如下：
```json
 "OpenAuthDBContext": "Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000"
 "DbType": "SqlServer" //数据库类型：SqlServer、MySql
```

* 修改OpenAuth.WebApi/appsettings.json连接字符串,如下：
```json
 "OpenAuthDBContext": "Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000"
 "DbType": "SqlServer" //数据库类型：SqlServer、MySql
```

## 编译运行

使用visualstudio生成解决方案。
`注：首次启动时，visual studio会启动nuget还原第三方依赖包，请保持网络通畅，并等待一段时间`

启动openauth.mvc项目。

![启动](/startmvc.png "启动")


