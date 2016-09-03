using System;
using System.Collections.Generic;
using OpenAuth.App;
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
            throw new NotImplementedException();
        }

        public bool ExecuteCondition(string name, ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter)
        {
            throw new NotImplementedException();
        }

        public List<string> GetActions()
        {
            return new List<string>{"ok"};
        }
    }
}