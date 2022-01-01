:::

OpenAuth.Pro是一套全新的前端界面，基于vue-element-admin，采用VUE全家桶（VUE+VUEX+VUE-ROUTER）单页面SPA开发。它使用开源版OpenAuth.Core的API接口（即：OpenAuth.WebApi）提供数据服务。二者的关系如下：

![](/architect.png)

企业版代码获取方式：[http://www.openauth.net.cn/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c](http://www.openauth.net.cn/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)

## 工具准备

#### NodeJs

使用NodeJS v14版本。下载地址:[http://nodejs.cn/download/current/](http://nodejs.cn/download/current/)

#### visual studio code

下载最新版的vs code，用来作为OpenAuth.Pro的开发工具。


## 创建数据库

* 如果只使用开源的OpenAuth.Mvc。则新建一个空数据库：OpenAuthDB。然后在OpenAuth.Core项目文件夹【sql server 初始化脚本】中，运行`Sql Server脚本.sql`（或mysql初始化脚本）

* 如果只使用企业版的OpenAuth.WebApi,则新建一个空数据库：OpenAuthPro。然后在OpenAuth.Pro项目文件夹【sql脚本】中，运行`Sql Server脚本.sql`（或mysql脚本）

## 启动

使用Vs Code（或个人喜欢的工具）打开OpenAuth.Pro/Client文件夹，如下图：

![20211214232057](http://img.openauth.net.cn/20211214232057.png)


安装程序运行所需的第三方包。使用npm install 命令经行安装，如下图：
![20211214232207](http://img.openauth.net.cn/20211214232207.png)

使用npm run dev 命令运行。如下图：
![20211214232229](http://img.openauth.net.cn/20211214232229.png)

启动成功后，使用浏览器访问[http://localhost:1803/](http://localhost:1803/) 即可打开企业版界面

::: warning 注意事项
开发环境配置文件为`.env.dev`，调试前请调整为自己的接口地址：

```javascript
VUE_APP_BASE_API = http://localhost:52789/api
VUE_APP_BASE_IMG_URL = http://localhost:52789
```




