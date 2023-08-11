# 打开指定URL

上一章节通过添加模块或直接在路由表中添加固定路由实现路由控制。在有些场景下，需要代码中直接打开一个外部指定URL的地址（不通过系统的【模块管理】功能添加到导航栏），如下图：

![20220331231338](http://img.openauth.net.cn/20220331231338.png)

可以直接使用下面代码实现：

```javascript
    openUrl() {
      let obj = {}
      obj['openauth'] = { //这里的openauth可以改成你希望在浏览器地址栏中看到的url
        name: '官网',
        url: 'http://www.openauth.net.cn',
      }
      this.$store.dispatch('setIframeTagViews', obj, { root: true })

      this.$router.push({ path: '/iframePage/openauth' })
    },
```





