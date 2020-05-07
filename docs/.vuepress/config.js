module.exports = {
    title: 'OpenAuth.Core'
    ,description: '最好用的.net权限工作流框架,最好用的.net core vue前后分离框架'
    ,head: [
      ['link', { rel: 'icon', href: '/logo.png' }]
    ]
    ,themeConfig : {
      nav : [
        { text: '首页', link: 'http://openauth.me/' , target:'_blank' },
          { text: 'OpenAuth.Core', link: '/core/' },
          { text: 'OpenAuth.Net', link: '/net/' },
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
          ,"start"
          ,"deploy" 
          ,"devnew"
          ,"identity" 
          ,{
            title: '权限控制',   // 必要的
            path: 'dataprivilege',      // 可选的, 标题的跳转链接，应为绝对路径且必须存在
            sidebarDepth: 1,    // 可选的, 默认值是 1
            children: [
              'dataprivilege'
            ]
          }
          ,{
            title: '工作流',   // 必要的
            path: 'thirdparty',      // 可选的, 标题的跳转链接，应为绝对路径且必须存在
            sidebarDepth: 1,    // 可选的, 默认值是 1
            children: [
              'thirdparty'
            ]
          }
          ,"changelog" 
        ],
  
        '/net/': [
          ['','项目介绍']
          ,"start"  
          ,"devnew"
          ,"deploy" 
        ]
      }
  }
}