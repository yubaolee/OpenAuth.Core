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

        public TestWorkflow()
        {
            _app = AutofacExt.GetFromFac<FlowSchemeApp>();
            _runApp = AutofacExt.GetFromFac<FlowInstanceApp>();
        }

        /// <summary>
        /// 测试流程
        /// <para>李玉宝于2017-01-20 9:59:11</para>
        /// </summary>
        [TestMethod]
        public void Verify()
        {
            _runApp.Verification(new VerificationReq
            {
                FlowInstanceId = "132333fe-d8db-4373-b101-b0ac574d3b1a",
                VerificationFinally = "3"
            });
        }

    }
}
