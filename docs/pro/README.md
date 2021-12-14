:::

![LOGO](https://gitee.com/uploads/images/2018/0425/163228_7077c3fd_362401.png "1.png")

OpenAuth.Pro是一套全新的前端界面，基于vue-element-admin，采用VUE全家桶（VUE+VUEX+VUE-ROUTER）单页面SPA开发。它使用开源版OpenAuth.Core的API接口（即：OpenAuth.WebApi）提供数据服务。二者的关系如下：

![](/architect.png)


## 工具准备

#### NodeJs

使用NodeJS v14版本。下载地址:[http://nodejs.cn/download/current/](http://nodejs.cn/download/current/)

#### visual studio code

下载最新版的vs code，用来作为OpenAuth.Pro的开发工具。


## 创建数据库

* 如果只使用开源的OpenAuth.Mvc。则新建一个空数据库：OpenAuthDB。然后在OpenAuth.Core项目文件夹【sql server 初始化脚本】中，运行‘Sql Server脚本.sql’（或mysql初始化脚本）

* 如果只使用企业版的OpenAuth.WebApi,则新建一个空数据库：OpenAuthPro。然后在OpenAuth.Pro项目文件夹【sql脚本】中，运行‘Sql Server脚本.sql’（或mysql脚本）

## 启动

使用Vs Code（或个人喜欢的工具）打开OpenAuth.Pro/Client文件夹，如下图：

![20211214232057](https://img.openauth.net.cn/20211214232057.png)


安装程序运行所需的第三方包。使用npm install 命令经行安装，如下图：
![20211214232207](https://img.openauth.net.cn/20211214232207.png)

使用npm run dev 命令运行。如下图：
![20211214232229](https://img.openauth.net.cn/20211214232229.png)

启动成功后，使用浏览器访问[http://localhost:1803/](http://localhost:1803/) 即可打开企业版界面




