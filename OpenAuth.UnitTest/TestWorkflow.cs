using System;
using Infrastructure;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.App.Request;
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

    }
}
