# 项目结构

![20211215221811](http://img.openauth.net.cn/20211215221811.png)

整个vue的入口是main.js，这个可以在webpack.base.conf.js中调整配置，代码如下：
```javascript
entry: {
   app: './src/main.js'
}
```
通过打包之后，编译后的代码全部会注入到index.html的<div id="app"></div>里面。