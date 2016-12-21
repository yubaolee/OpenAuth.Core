using System;
using System.Configuration;
using System.Xml.Linq;
using OpenAuth.App;
using OpenAuth.Domain;
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
                                );
                            builder.SetCache(new DefaultParcedProcessCache());

                            _runtime = new WorkflowRuntime(new Guid("{8D38DB8F-F3D5-4F26-A989-4FDD40F32D9D}"))
                                .WithBuilder(builder)
                                .WithRuleProvider(new WorkflowRuleProvider())
                                 .WithActionProvider(new WorkflowActionProvider())
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

            //创建流程状态转换记录
            WorkflowActionProvider.DeleteEmptyPreHistory(e.ProcessId);
            _runtime.PreExecuteFromCurrentActivity(e.ProcessId);

            //更新通知列表
            UpdateInbox(e);

            //更改申请的状态
            UpdateApplyState(e);
        }

        /// <summary>
        /// 更新申请状态
        /// </summary>
        private static void UpdateApplyState(ProcessStatusChangedEventArgs e)
        {
            var nextState = WorkflowInit.Runtime.GetLocalizedStateName(e.ProcessId, e.ProcessInstance.CurrentState);

            var _app = AutofacExt.GetFromFac<CommonApplyApp>();
            _app.ChangeState(e.ProcessId, e.ProcessInstance.CurrentState, nextState);
        }

        /// <summary>
        /// 更新通知列表
        /// </summary>
        private static void UpdateInbox(ProcessStatusChangedEventArgs e)
        {
            var inboxApp = AutofacExt.GetFromFac<WorkflowInboxApp>();
            inboxApp.DeleteAllByProcess(e.ProcessId);

            if (e.NewStatus != ProcessStatus.Finalized)
            {
                var newActors = Runtime.GetAllActorsForDirectCommandTransitions(e.ProcessId);
                foreach (var newActor in newActors)
                {
                    var newInboxItem = new Relevance()
                    {
                        Id = Guid.NewGuid(),
                        SecondId = new Guid(newActor),
                        FirstId = e.ProcessId,
                        Key = "ProcessUser"
                    };

                    inboxApp.Add(newInboxItem);
                }
            }
        }
    }
}