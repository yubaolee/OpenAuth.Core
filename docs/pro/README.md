OpenAuth.Pro是一套全新的前端界面，基于vue-element-admin，采用VUE全家桶（VUE+VUEX+VUE-ROUTER）单页面SPA开发。它使用开源版OpenAuth.Net的API接口（即：OpenAuth.WebApi）提供数据服务。二者的关系如下：

![](/architect.png)

企业版代码获取方式：[http://www.openauth.net.cn/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c](http://www.openauth.net.cn/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)

企业Vue2版本演示：[http://demo.openauth.net.cn:1803/](http://demo.openauth.net.cn:1803/)

企业H5版本演示（请使用浏览器移动模式或直接用手机打开）：[http://demo.openauth.net.cn:1804/](http://demo.openauth.net.cn:1804/)


## 工具准备

#### NodeJs

前端环境为NodeJs，下载地址：[http://nodejs.cn/download/current/](http://nodejs.cn/download/current/)。其中：

OpenAuth.Pro v4.6.4及以后的版本使用Node 18

OpenAuth.Pro v4.6.3-v4.3 使用Node 16

OpenAuth.Pro v4.3及以前的版本使用Node 14

#### visual studio code

下载最新版的vs code，用来作为OpenAuth.Pro的开发工具。


## 创建数据库

* 如果只使用开源的OpenAuth.Mvc。则新建一个空数据库：OpenAuthDB。然后在OpenAuth.Net项目文件夹【sql server 初始化脚本】中，运行`Sql Server脚本.sql`（或mysql初始化脚本）

* 如果只使用企业版的OpenAuth.WebApi,则新建一个空数据库：OpenAuthPro。使用OpenAuth.Pro前端源码文件夹【sql脚本】中，运行`Sql Server脚本.sql`（或mysql脚本）

## 启动后端

启动后端请参考：[快速开始](/core/start.html)

## 启动前端

使用Vs Code（或个人喜欢的工具）打开OpenAuth.Pro/Client文件夹，如下图：

![20211214232057](http://img.openauth.net.cn/20211214232057.png)


安装程序运行所需的第三方包。使用npm install 命令经行安装，如下图：
![20211214232207](http://img.openauth.net.cn/20211214232207.png)

::: warning 注意事项
4.6.4及以后的版本默认Node 18进行编译，如果使用的是Node 18以前的版本，请尝试把package.json中scripts改为下面内容：

```javascript
"scripts": {
    "serve": "vue-cli-service serve  --mode dev",
    "dev": "vue-cli-service serve --mode dev",
    "build": "vue-cli-service build --mode prod",
    "lint": "vue-cli-service lint"
  },
```

:::

修改配置文件`.env.dev`对应的后端接口地址，调整为自己的接口地址：

```javascript
VUE_APP_BASE_API = http://localhost:52789/api
VUE_APP_BASE_IMG_URL = http://localhost:52789
```

::: warning 注意事项
如果是发布打包，调整的文件为`.env.prod`
:::

使用npm run dev 命令运行。如下图：
![20211214232229](http://img.openauth.net.cn/20211214232229.png)

启动成功后，使用浏览器访问[http://localhost:1803/](http://localhost:1803/) 即可打开企业版界面






