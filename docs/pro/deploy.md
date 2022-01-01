# 部署

后端接口部署请参考：[部署API](/core/deployapi.html){:target="_blank"}，前端打包流程如下：

使用`npm run build`进行打包构建：

![20211214232752](http://img.openauth.net.cn/20211214232752.png)

::: warning 注意事项
前端部署时使用的配置文件为`.env.prod`，打包构建前请调整为自己的接口地址：

```javascript
VUE_APP_BASE_API = http://demo.openauth.net.cn:52789/api

VUE_APP_BASE_IMG_URL = demo.openauth.net.cn:52789
```

:::

构建完成后会生成dist文件夹。如下：

![20211214232928](http://img.openauth.net.cn/20211214232928.png)

该文件夹为纯静态的页面，可以使用任何自己喜欢的Web服务器进行部署，如IIS/tomcat/nginx等。个人推荐使用nginx部署。

nginx下载安装可参考：[https://blog.csdn.net/github_39088222/article/details/79482461](https://blog.csdn.net/github_39088222/article/details/79482461)

nginx.conf推荐配置如下：

```javascript
  server {
        listen       1803;
        #server_name  pro.openauth.me;
        location / {
            alias /openauth.pro/Client/dist/;
            expires      1d; 
        }
        
         access_log  /www/wwwlogs/pro.log;
    }

```