using System;

namespace OpenAuth.App.SSO
{
    [Serializable]
    public class UserAuthSession
    {
        public string Token { get; set; }

        public string AppKey { get; set; }

        /// <summary>
        /// 用户账号
        /// </summary>
        public string Account { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        public string Name { get; set; }
        
        public string IpAddress { get; set; }

        public DateTime CreateTime { get; set; }
    }
}