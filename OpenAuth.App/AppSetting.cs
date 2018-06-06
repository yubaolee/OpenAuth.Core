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
