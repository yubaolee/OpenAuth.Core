## 下载代码

使用git工具下载代码，代码地址：https://gitee.com/yubaolee/OpenAuth.Core.git

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

使用visualstudio菜单栏中的【启动】按钮或快捷键F5，启动运行。
`注：首次启动时，visual studio会启动nuget还原第三方依赖包，请保持网络通畅，并等待一段时间`
