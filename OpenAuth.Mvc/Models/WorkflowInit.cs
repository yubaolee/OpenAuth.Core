using System;
using System.Configuration;
using System.Xml.Linq;
using OpenAuth.App;
using OptimaJet.Workflow.Core.Builder;
using OptimaJet.Workflow.Core.Bus;
using OptimaJet.Workflow.Core.Persistence;
using OptimaJet.Workflow.Core.Runtime;
using OptimaJet.Workflow.DbPersistence;

namespace OpenAuth.Mvc.Models
{
    public static class WorkflowInit
    {
        private static volatile WorkflowRuntime _runtime;
        private static readonly object _sync = new object();

        public static WorkflowRuntime Runtime
        {
            get
            {
                if (_runtime == null)
                {
                    lock (_sync)
                    {
                        if (_runtime == null)
                        {
                            var connectionString = ConfigurationManager.ConnectionStrings["WorkFlow"].ConnectionString;
                            var builder = new WorkflowBuilder<XElement>(
                                new MSSQLProvider(connectionString), 
                                new OptimaJet.Workflow.Core.Parser.XmlWorkflowParser(),
                                new MSSQLProvider(connectionString)
                                ).WithDefaultCache();

                            _runtime = new WorkflowRuntime(new Guid("{8D38DB8F-F3D5-4F26-A989-4FDD40F32D9D}"))
                                .WithBuilder(builder)
                                //  .WithRuleProvider(new WorkflowRuleProvider())
                                // .WithActionProvider(new WorkflowActionProvider())
                                .WithPersistenceProvider(new MSSQLProvider(connectionString))
                                .WithTimerManager(new TimerManager())
                                .WithBus(new NullBus())
                                .SwitchAutoUpdateSchemeBeforeGetAvailableCommandsOn()
                                .Start();
                            _runtime.ProcessStatusChanged += _runtime_ProcessStatusChanged;
                        }
                    }
                }

                return _runtime;
            }
        }

        private static void _runtime_ProcessStatusChanged(object sender, ProcessStatusChangedEventArgs e)
        {
            if (e.NewStatus != ProcessStatus.Idled && e.NewStatus != ProcessStatus.Finalized)
                return;

            if (string.IsNullOrEmpty(e.SchemeCode))
                return;

            //¸ü¸ÄÉêÇëµÄ×´Ì¬
            var nextState = WorkflowInit.Runtime.GetLocalizedStateName(e.ProcessId, e.ProcessInstance.CurrentState);

            var _app = AutofacExt.GetFromFac<GoodsApplyApp>();
            var goodsapply = _app.Get(e.ProcessId);
            if (goodsapply != null)
            {
                goodsapply.StateName = nextState;
            }
            _app.ChangeState(goodsapply.Id, e.ProcessInstance.CurrentState, nextState);
           
        }
    }
}