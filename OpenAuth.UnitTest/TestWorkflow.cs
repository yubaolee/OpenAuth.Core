using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.Domain.Service;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class TestWorkflow :TestBase
    {
        private WorkflowService _app;

        public TestWorkflow()
        {
            _app = AutofacExt.GetFromFac<WorkflowService>();
        }
        [TestMethod]
        public void AddForm()
        {
            var datas = _app.GetList();
        }
    }
}
