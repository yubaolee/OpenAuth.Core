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
![设置启动项](http://www.openauth.me/upload/180513155208024.jpg "设置启动项")

## 编译运行

使用visualstudio菜单栏中的【启动】按钮或快捷键F5，启动运行。
`注：首次启动时，visual studio会启动nuget还原第三方依赖包，请保持网络通畅，并等待一段时间`
