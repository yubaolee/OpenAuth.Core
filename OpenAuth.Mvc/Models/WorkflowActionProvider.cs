using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using OpenAuth.App;
using OpenAuth.Domain;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;

namespace OpenAuth.Mvc.Models
{
    public class WorkflowActionProvider :IWorkflowActionProvider
    {
        private ModuleManagerApp _app;

        public WorkflowActionProvider()
        {
            _app = AutofacExt.GetFromFac<ModuleManagerApp>();
        }
        public void ExecuteAction(string name, ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter)
        {
            if (_actions.ContainsKey(name))
            {
                _actions[name].Invoke(processInstance, actionParameter);
                return;
            }
        }

        public bool ExecuteCondition(string name, ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter)
        {
            throw new NotImplementedException();
        }

        public List<string> GetActions()
        {
            return _actions.Keys.ToList();
        }

        private static Dictionary<string, Action<ProcessInstance, string>> _actions = new Dictionary
          <string, Action<ProcessInstance, string>>
        {
            {"创建流程记录", WriteTransitionHistory},  //仅用于PreExecution，创建流程初始转换列表
            {"更新流程记录", UpdateTransitionHistory}
        };

        private static ApplyTransitionHistoryApp _applyTransitionHistoryApp = AutofacExt.GetFromFac<ApplyTransitionHistoryApp>();

        public static void WriteTransitionHistory(ProcessInstance processInstance, string parameter)
        {
            if (processInstance.IdentityIds == null)
                return;

            var currentstate = WorkflowInit.Runtime.GetLocalizedStateName(processInstance.ProcessId, processInstance.CurrentState);

            var nextState = WorkflowInit.Runtime.GetLocalizedStateName(processInstance.ProcessId, processInstance.ExecutedActivityState);

            var command = WorkflowInit.Runtime.GetLocalizedCommandName(processInstance.ProcessId, processInstance.CurrentCommand);


            var historyItem = new ApplyTransitionHistory
                {
                    Id = Guid.NewGuid(),
                    AllowedToUserNames = GetEmployeesString(processInstance.IdentityIds),
                    DestinationState = nextState,
                    ApplyId = processInstance.ProcessId,
                    InitialState = currentstate,
                    Command = command
                };
              _applyTransitionHistoryApp.Add(historyItem);
             
        }

        private static string GetEmployeesString(IEnumerable<string> identities)
        {
            var identitiesGuid = identities.Select(c => new Guid(c));
            var app = AutofacExt.GetFromFac<UserManagerApp>();

            var employees = app.GetUsers(identitiesGuid);

            var sb = new StringBuilder();
            bool isFirst = true;
            foreach (var employee in employees)
            {
                if (!isFirst)
                    sb.Append(",");
                isFirst = false;

                sb.Append(employee.Name);
            }

            return sb.ToString();
        }

        public static void UpdateTransitionHistory(ProcessInstance processInstance, string parameter)
        {
            var currentstate = WorkflowInit.Runtime.GetLocalizedStateName(processInstance.ProcessId, processInstance.CurrentState);

            var nextState = WorkflowInit.Runtime.GetLocalizedStateName(processInstance.ProcessId, processInstance.ExecutedActivityState);

            var command = WorkflowInit.Runtime.GetLocalizedCommandName(processInstance.ProcessId, processInstance.CurrentCommand);

            var isTimer = !string.IsNullOrEmpty(processInstance.ExecutedTimer);

            var historyItem = _applyTransitionHistoryApp.Get(processInstance.ProcessId, currentstate, nextState);

            if (historyItem == null)
            {
                historyItem = new ApplyTransitionHistory()
                {
                    Id = Guid.NewGuid(),
                    AllowedToUserNames = string.Empty,
                    DestinationState = nextState,
                    ApplyId = processInstance.ProcessId,
                    InitialState = currentstate
                };

                _applyTransitionHistoryApp.Add(historyItem);

            }

            historyItem.Command = !isTimer ? command : string.Format("Timer: {0}", processInstance.ExecutedTimer);
            historyItem.TransitionTime = DateTime.Now;

            if (string.IsNullOrWhiteSpace(processInstance.IdentityId))
                historyItem.UserId = null;
            else
                historyItem.UserId = new Guid(processInstance.IdentityId);

            try
            {
                _applyTransitionHistoryApp.Update(historyItem);
            }
            catch (DbEntityValidationException e)
            {
                Console.WriteLine(e);
            }

        }

        internal static void DeleteEmptyPreHistory(Guid processId)
        {
            _applyTransitionHistoryApp.DeleteByProcess(processId);
        }
    }
}