using System;

namespace OpenAuth.WebApi.Areas.SSO.Models
{
    [Serializable]
    public class UserAuthSession
    {
        public string Token { get; set; }

        public string AppKey { get; set; }

        public string UserName { get; set; }
        
        public string IpAddress { get; set; }

        public DateTime InvalidTime { get; set; }

        public DateTime CreateTime { get; set; }
    }
}