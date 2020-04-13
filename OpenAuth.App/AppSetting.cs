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
            UploadPath = "";
            IdentityServerUrl = "";
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

        /// <summary> 附件上传路径</summary>
        public string UploadPath { get; set; }

        //identity授权的地址
        public string IdentityServerUrl { get; set; }

        //是否是Identity授权方式
        public bool IsIdentityAuth => !string.IsNullOrEmpty(IdentityServerUrl);
    }
}
