## 下载代码

使用git工具下载代码，代码地址：https://gitee.com/yubaolee/OpenAuth.Core.git

## 安装sdk

下载安装微软官方SDK，代码地址：https://dotnet.microsoft.com/download

## 初始化数据库

使用数据库脚本`sql server 初始化脚本`或`mysql初始化脚本` 文件夹里面的结构脚本和数据脚本初始化数据库

## 打开项目

使用vs2017(推荐)打开 `OpenAuth.Core.sln`

## 修改连接字符串

* 修改OpenAuth.Mvc/appsettings.json连接字符串，如下：
```xml
 "OpenAuthDBContext": "Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000"
```

* 修改OpenAuth.WebApi/appsettings.json连接字符串,如下：
```xml
 "OpenAuthDBContext": "Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000"
```

## 编译运行

使用visualstudio生成解决方案。
`注：首次启动时，visual studio会启动nuget还原第三方依赖包，请保持网络通畅，并等待一段时间`

启动openauth.mvc项目。
![启动](http://demo.openauth.me:8887/upload_files/190110165027039.jpg "启动")

## 更多文档

如需更多文档请点击[这里](http://openauth.me/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)

![更多文档](http://119.84.146.233:8887/upload_files/190716002245221.jpg "更多文档")

