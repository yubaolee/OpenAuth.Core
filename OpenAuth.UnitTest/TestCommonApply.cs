using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;
using OptimaJet.Workflow.Core.Persistence;
using OptimaJet.Workflow.Core.Runtime;

namespace OpenAuth.UnitTest
{
    /// <summary>
    /// 测试通用申请流程
    /// </summary>
    [TestClass]
    public class TestCommonApply : TestBase
    {
        private CommonApplyApp _app;

        public TestCommonApply()
        {
            _app = AutofacExt.GetFromFac<CommonApplyApp>();
            Mvc.AutofacExt.InitAutofac();
        }

        [TestMethod]
        public void Addd()
        {
            var commonApply = new CommonApply
            {
                Id = Guid.Empty,
                WorkflowName = "新建模板",
                State = "",
                StateName = "",
                Name = "测试"+DateTime.Now.ToLongTimeString()
            };
            _app.AddOrUpdate(commonApply);

            CreateWorkflowIfNotExists(commonApply.Id, commonApply.WorkflowName);
        }


        private void CreateWorkflowIfNotExists(Guid id, string schemecode)
        {
            if (WorkflowInit.Runtime.IsProcessExists(id))
                return;

            using (var sync = new WorkflowSync(WorkflowInit.Runtime, id))
            {
                WorkflowInit.Runtime.CreateInstance(schemecode, id);

                sync.StatrtWaitingFor(new List<ProcessStatus> { ProcessStatus.Initialized, ProcessStatus.Initialized });

                sync.Wait(new TimeSpan(0, 0, 10));
            }
        }
    }
}
