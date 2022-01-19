using System;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Test
{
    [TestFixture]
    public class TestForm :TestBase
    {
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "admin" });
            services.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");

            services.AddScoped(x => httpContextAccessorMock.Object);

            return services;
        }


        [Test]
        public void Load()
        {
            var app = _autofacServiceProvider.GetService<FormApp>();
            var result = app.Load(new QueryFormListReq
            {
                page = 1,
                limit = 10
            });
            Console.WriteLine(JsonHelper.Instance.Serialize(result));
        }
        
        [Test]
        public void Update()
        {
            var app = _autofacServiceProvider.GetService<FormApp>();
             app.Update(new Form()
            {
                Id = "5815ff07-b457-47a2-8a19-c9080c3575d8",
                ContentData = "{\"list\":[{\"type\":\"input\",\"icon\":\"icon-input\",\"name\":\"单行文本\",\"options\":{\"width\":\"100%\",\"defaultValue\":\"\",\"required\":false,\"dataType\":\"string\",\"pattern\":\"\",\"placeholder\":\"\",\"disabled\":false,\"remoteFunc\":\"func_1642332330000_92043\"},\"key\":\"1642332330000_92043\",\"model\":\"Name\",\"rules\":[{\"type\":\"string\",\"message\":\"Name格式不正确\"}]},{\"type\":\"textarea\",\"icon\":\"icon-diy-com-textarea\",\"name\":\"多行文本\",\"options\":{\"width\":\"100%\",\"defaultValue\":\"\",\"required\":false,\"disabled\":false,\"pattern\":\"\",\"placeholder\":\"\",\"remoteFunc\":\"func_1642332331000_66846\"},\"key\":\"1642332331000_66846\",\"model\":\"Price\",\"rules\":[]},{\"type\":\"number\",\"icon\":\"icon-number\",\"name\":\"计数器\",\"options\":{\"width\":\"\",\"required\":false,\"defaultValue\":0,\"min\":0,\"max\":0,\"step\":1,\"disabled\":false,\"controlsPosition\":\"\",\"remoteFunc\":\"func_1642332332000_75553\"},\"key\":\"1642332332000_75553\",\"model\":\"number_1642332332000_75553\",\"rules\":[]},{\"type\":\"text\",\"icon\":\"icon-wenzishezhi-\",\"name\":\"文字\",\"options\":{\"defaultValue\":\"This is a text\",\"customClass\":\"\",\"remoteFunc\":\"func_1642332335000_15010\"},\"key\":\"1642332335000_15010\",\"model\":\"text_1642332335000_15010\",\"rules\":[]},{\"type\":\"textarea\",\"icon\":\"icon-diy-com-textarea\",\"name\":\"多行文本\",\"options\":{\"width\":\"100%\",\"defaultValue\":\"\",\"required\":false,\"disabled\":false,\"pattern\":\"\",\"placeholder\":\"\",\"remoteFunc\":\"func_1642332496000_1253\"},\"key\":\"1642332496000_1253\",\"model\":\"textarea_1642332496000_1253\",\"rules\":[]}],\"config\":{\"labelWidth\":100,\"labelPosition\":\"right\",\"size\":\"small\"}}",
                DbName = "stock",
                OrgId = "08f41bf6-4388-4b1e-bd3e-2ff538b44b1b",
                FrmType = 2
            });
        }
    }
}
