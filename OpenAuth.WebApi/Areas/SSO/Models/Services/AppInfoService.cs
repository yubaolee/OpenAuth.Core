using System;

namespace OpenAuth.WebApi.Areas.SSO.Models.Services
{
    public class AppInfoService : ServiceContext
    {
        public AppInfo Get(string appKey)
        {
            //可以从数据库读取
            return new AppInfo
            {
                AppKey = "670b14728ad9902aecba32e22fa4f6bd",
                AppSecret = "670b14728ad9902aecba32e22fa4f6bd",
                Icon = "/Content/img/default-app.png",
                IsEnable = true,
                Remark = "OpenAuth.net",
                ReturnUrl = "http://localhost:53050",
                Title = "OpenAuth.Net",
                CreateTime = DateTime.Now,
            };
        }
    }
}