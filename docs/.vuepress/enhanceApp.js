/*
 * @Author: yubaolee <yubaolee@163.com> | ahfu~ <954478625@qq.com>
 * @Date: 2024-06-19 20:41:42
 * @LastEditTime: 2024-06-19 20:42:39
 * @Description: 
 * @
 * @Copyright (c) 2024 by yubaolee | ahfu~ , All Rights Reserved. 
*/
// .vuepress/enhanceApp.js
export default ({ router }) => {
  if (process.env.NODE_ENV === 'production' && typeof window !== 'undefined') {
    // 百度统计代码
    var _hmt = _hmt || []
    ;(function () {
      var hm = document.createElement('script')
      hm.src = 'https://hm.baidu.com/hm.js?93a7b9a145222f9b7109d643a0c58f8d'
      var s = document.getElementsByTagName('script')[0]
      s.parentNode.insertBefore(hm, s)
    })()

    // 路由切换时触发百度统计
    router.afterEach(function (to) {
      if (window._hmt) {
        window._hmt.push(['_trackPageview', to.fullPath])
      }
    })
  }
}
