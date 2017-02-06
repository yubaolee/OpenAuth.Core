using System;
using Infrastructure;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.Domain;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class TestWorkflow :TestBase
    {
        private WFSchemeService _app;
        private WFProcessInstanceService _runApp;

        public TestWorkflow()
        {
            _app = AutofacExt.GetFromFac<WFSchemeService>();
            _runApp = AutofacExt.GetFromFac<WFProcessInstanceService>();
        }
        [TestMethod]
        public void AddForm()
        {
            var datas = _app.GetList();
        }

        /// <summary>
        /// 测试流程
        /// <para>李玉宝于2017-01-20 9:59:11</para>
        /// </summary>
        [TestMethod]
        public void AddProcessInstance()
        {
            string name = "请假" + DateTime.Now.ToString("yy-mm-dd_HH_mm_ss");
            string str ="{\"Code\":\"请病假\",\"CustomName\":\""+name+"\",\"wfLevel1\":\"1\",\"wfLevel2\":\"2\",\"wfLevel3\":\"3\",\"Description\":\"&nbsp;\",\"EnabledMark\":1,\"wfLevel\":\"2\"}";
            string frmData ="{\"4fcd4c6f-eb6b-6a6d-eb4e-7948763c5bba\":\"\",\"88061dda-642e-bcdb-909b-cea2bbe5ad69\":\"&nbsp;\"}";
            _runApp.CreateInstance(Guid.Empty, Guid.Parse("5f0ca3df-390a-4bd7-aecb-5304bf2d191c"), str.ToObject<WFProcessInstance>(), frmData);
        }

    }
}
