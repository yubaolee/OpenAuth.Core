/*
 * @Author: yubaolee <yubaolee@163.com> | ahfu~ <954478625@qq.com>
 * @Date: 2023-08-12 10:48:24
 * @LastEditTime: 2024-06-19 20:48:12
 * @Description: 
 * @
 * @Copyright (c) 2023 by yubaolee | ahfu~ , All Rights Reserved. 
*/

module.exports = {
  title: 'OpenAuth.Net',
  description: '最好用的.net权限工作流框架,最好用的.net vue前后分离框架',
  head: [
    ['link', {
      rel: 'icon',
      href: '/logo.png'
    }],['script',{},
      `var _hmt = _hmt || [];
      (function () {
      var hm = document.createElement('script')
      hm.src = 'https://hm.baidu.com/hm.js?93a7b9a145222f9b7109d643a0c58f8d'
      var s = document.getElementsByTagName('script')[0]
      s.parentNode.insertBefore(hm, s)
    })();
      `]
  ],
  extendMarkdown: (md) => {
    md.set({
      breaks: true
    })
    md.use(require('markdown-it-plantuml'))
  },
  themeConfig: {
    lastUpdated: '最后更新时间', // string | boolean
    nav: [{
        text: '首页',
        link: 'http://openauth.net.cn/',
        target: '_blank'
      },
      {
        text: '在线文档',
        ariaLabel: 'Proj Menu',
        items: [{
            text: 'OpenAuth.Net开源后端',
            link: '/core/',
            target: '_blank'
          },
          {
            text: 'OpenAuth.Pro(企业vue2/vue3)',
            link: '/pro/',
            target: '_blank'
          }
        ],
      },
      {
        text: '项目地址',
        ariaLabel: 'Proj Menu',
        items: [{
            text: 'gitee',
            link: 'https://gitee.com/dotnetchina/OpenAuth.Net',
            target: '_blank'
          },
          {
            text: 'github',
            link: 'https://github.com/yubaolee/OpenAuth.Core',
            target: '_blank'
          },
        ],
      },
      {
        text: '战略合作',
        ariaLabel: 'Proj Menu',
        items: [{
            text: 'Variant Form - 可视化低代码表单',
            link: 'https://www.vform666.com/',
            target: '_blank'
          },
          {
            text: 'SqlSugar',
            link: 'https://www.donet5.com/',
            target: '_blank'
          }
        ],
      },
    ],
    sidebar: {
      '/core/': [
        ['', '项目介绍'],
        {
          title: '后端开发', // 必要的
          path: 'start', // 可选的, 标题的跳转链接，应为绝对路径且必须存在
          sidebarDepth: 1, // 可选的, 默认值是 1
          collapsable: false,
          children: ['start', 'specialist', 'deploy', 'deployapi', 'devnew', 'multidbs', 'multitenant', 'unitwork','sqlsugar', 'entity', 'datavalidation', 'log', 'identity', 'job', 'cache', 'unittest'],
        },
        {
          title: '权限控制', // 必要的
          sidebarDepth: 1, // 可选的, 默认值是 1
          collapsable: false,
          children: ['moduleauth','apiauth', 'logininfo', 'dataprivilege', 'datapropertyrule'],
        },
        'form',
        {
          title: '工作流', // 必要的
          sidebarDepth: 1, // 可选的, 默认值是 1
          collapsable: false,
          children: ['flowinstance', 'flowinstancestatus', 'thirdparty'],
        },
        {
          title: '前端开发', // 必要的
          sidebarDepth: 1, // 可选的, 默认值是 1
          collapsable: false,
          children: ['wwwarchitect'],
        },
        {
          title: '更新日志', // 必要的
          sidebarDepth: 1, // 可选的, 默认值是 1
          collapsable: false,
          children: ['changelog', 'routineupdate'],
        },
        'faq',
      ],

      '/pro/': [
        ['', '项目介绍'],
        'deploy',
        'structure',
        'devnew',
        {
          title: '基础开发', // 必要的
          sidebarDepth: 1, // 可选的, 默认值是 1
          collapsable: false,
          children: ['router','openurl','keepalive'],
        },
        'datapropertyrule',
        'printerplan',
        {
          title: '表单设计', // 必要的
          sidebarDepth: 1, // 可选的, 默认值是 1
          collapsable: false,
          children: ['startform','dragform','dragformdetail'],
        },
        {
          title: '工作流', // 必要的
          sidebarDepth: 1, // 可选的, 默认值是 1
          collapsable: false,
          children: ['startflow','form'],
        },
        'components',
        'faq',
      ],

      '/net/': [
        ['', '项目介绍'], 'start', 'deploy', 'devnew'
      ],
    },
  },
}