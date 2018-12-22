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
            SSOPassport = "http://localhost:52789";  
            Version = "";
            DbType = Define.DBTYPE_SQLSERVER;
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

        /// <summary>
        /// 数据库类型 SqlServer、MySql
        /// </summary>
        public string DbType { get; set; }
    }
}
