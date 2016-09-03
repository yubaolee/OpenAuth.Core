using System;
using System.Collections.Generic;
using OpenAuth.App;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;

namespace OpenAuth.Mvc.Models
{
    public class WorkflowRuleProvider : IWorkflowRuleProvider
    {
        private RoleManagerApp _app;

        public WorkflowRuleProvider()
        {
            _app = AutofacExt.GetFromFac<RoleManagerApp>();
        }

        public List<string> GetRules()
        {
            var roles = _app.Load(Guid.Empty, 1, 100).list;
            var rolestrs = new List<string>();
            foreach (var role in roles)
            {
                rolestrs.Add(role.Name);
            }
            return rolestrs;
        }

        public bool Check(ProcessInstance processInstance, WorkflowRuntime runtime, string identityId, string ruleName,
            string parameter)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<string> GetIdentities(ProcessInstance processInstance, WorkflowRuntime runtime, string ruleName, string parameter)
        {
            throw new NotImplementedException();
        }
    }
}