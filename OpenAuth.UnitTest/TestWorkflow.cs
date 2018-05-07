using System;
using Infrastructure;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class TestWorkflow :TestBase
    {
        private FlowSchemeApp _app;
        private FlowInstanceApp _runApp;
        private AuthorizeApp authenApp;

        public TestWorkflow()
        {
            _app = AutofacExt.GetFromFac<FlowSchemeApp>();
            _runApp = AutofacExt.GetFromFac<FlowInstanceApp>();
            authenApp = AutofacExt.GetFromFac<AuthorizeApp>();
        }

        /// <summary>
        /// 测试流程
        /// <para>李玉宝于2017-01-20 9:59:11</para>
        /// </summary>
        [TestMethod]
        public void Verify()
        {
            authenApp.Create("System");
            _runApp.Verification(new VerificationReq
            {
                FlowInstanceId = "7335d82f-5c3d-43e5-a53b-7d51a7cb1f59",
                VerificationFinally = "3"
            });
        }

        [TestMethod]
        public void GetInstance()
        {
            var instance = _runApp.Get("51a80784-55a6-405e-b296-935287122806");
            var result = new Response<FlowVerificationResp>
            {
                Result = instance.MapTo<FlowVerificationResp>()
            };

            Console.WriteLine(JsonHelper.Instance.Serialize(result.Result.FrmPreviewHtml));
        }

        [TestMethod]
        public void TestUpdate()
        { //测试数据没有任何修改时EF报错的问题
            var instance = _runApp.Get("d73e4412-9c49-4511-a30e-0d2f844afcee");
            _runApp.Update(instance);
        }

    }
}
