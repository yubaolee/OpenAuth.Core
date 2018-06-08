using System;
using System.Collections.Generic;
using System.Text;

namespace OpenAuth.App
{
    /// <summary>
    /// 配置项
    /// </summary>
    public class AppSetting
    {
        public AppSetting()
        {
            //TODO:在openauth.app中竟然获取不到appsettings.josn的值
            //2018-06-09 在家里电脑竟然可以获取到值了？？什么鬼？😭
            SSOPassport = "http://localhost:52789";  
            Version = "";
        }
        /// <summary>
        /// SSO地址
        /// </summary>
        public string SSOPassport { get; set; }

        /// <summary>
        /// 版本信息
        /// 如果为demo,则屏蔽Post请求
        /// </summary>
        public string Version { get; set; }
    }
}
