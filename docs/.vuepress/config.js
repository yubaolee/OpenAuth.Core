module.exports = {
    title: 'OpenAuth.Core'
    ,description: '最好用的.net权限工作流框架,最好用的.net core vue前后分离框架'
    ,head: [
      ['link', { rel: 'icon', href: '/logo.png' }]
    ]
    ,themeConfig : {
      lastUpdated: '最后更新时间', // string | boolean
      nav : [
        { text: '首页', link: 'http://openauth.net.cn/' , target:'_blank' },
          { text: 'OpenAuth.Core(.Net Core/.Net 5)', link: '/core/' },
          { text: 'OpenAuth.Net(.Net 4.5)', link: '/net/' },
          {
            text: '项目地址',
            ariaLabel: 'Proj Menu',
            items: [
              { text: 'gitee', link: 'https://gitee.com/yubaolee/OpenAuth.Core' , target:'_blank' },
              { text: 'github', link: 'https://github.com/yubaolee/OpenAuth.Core' , target:'_blank' }
            ]
          }
      ],
      sidebar: {
        '/core/': [
          ['','项目介绍']
          ,{
            title: '后端开发',   // 必要的
            path: 'start',      // 可选的, 标题的跳转链接，应为绝对路径且必须存在
            sidebarDepth: 1,    // 可选的, 默认值是 1
            collapsable: false, 
            children: [
              "start"
              ,"specialist"
              ,"deploy" 
              ,"devnew"
              ,"multidbs"
              ,"multitenant"
              ,"unitwork"
              ,"entity"
              ,"datavalidation"
              ,"log"
              ,"identity" 
              ,"job"
              ,"cache"
              ,"unittest"
            ]
          }
          ,{
            title: '权限控制',   // 必要的
            sidebarDepth: 1,    // 可选的, 默认值是 1
            collapsable: false, 
            children: [
              'apiauth'
              ,'logininfo'
              ,'dataprivilege'
              ,'datapropertyrule'
              
            ]
          }
          ,{
            title: '工作流',   // 必要的
            sidebarDepth: 1,    // 可选的, 默认值是 1
            collapsable: false, 
            children: [
              'flowinstance',
              'flowinstancestatus',
              'thirdparty'
              
            ]
          }
          ,{
            title: '前端开发',   // 必要的
            sidebarDepth: 1,    // 可选的, 默认值是 1
            collapsable: false, 
            children: [
              'wwwarchitect'
            ]
          }
          ,{
            title: '更新日志',   // 必要的
            sidebarDepth: 1,    // 可选的, 默认值是 1
            collapsable: false, 
            children: [
              'changelog'
              ,'routineupdate'
            ]
          }
          ,"faq" 
        ],

        '/pro/': [
          ['','项目介绍']
          ,"structure"
          ,"devnew"
          ,"deploy"
          ,"router"
          ,"components"
        ],
  
        '/net/': [
          ['','项目介绍']
          ,"start"  
          ,"deploy" 
          ,"devnew"
        ]
      }
  }
}