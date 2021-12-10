# 路由操作

## 不通过模块管理添加页面


在有些场景下，不想通过系统的【模块管理】功能添加页面，如注册、帮助中心、站点介绍等，可以在路由表中直接添加。
打开`src\router\index.js`，在数组常量`constantRouterMap`中添加自己的路由信息：

```javascript
{
      path: '/regster',
      name: 'regster',
      hidden: true, //是否在左侧导航栏隐藏
      meta: {
        title: '仓储中心',
        icon: 'guide',
        sortNo: 0
      },
      component: () => import('@/views/regster/index')  //路由对应的页面视图
}

```

因为登录页面没有登录的用户信息，会被系统的权限体系拦截从而跳转到登录页面。需要添加到白名单中。
打开`src\permission.js`,在`whiteList`中加入刚刚的路由信息：


```javascript
const whiteList = ['/regster', ...] // 不重定向白名单

```

添加完成后，启动站点，直接浏览器访问`http://localhost:1803/#/regster`即可：




