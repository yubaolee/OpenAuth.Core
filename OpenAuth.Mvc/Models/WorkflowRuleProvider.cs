using System;
using System.Collections.Generic;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;

namespace OpenAuth.Mvc.Models
{
    public class WorkflowRuleProvider :IWorkflowRuleProvider
    {
        public List<string> GetRules()
        {
            return new List<string>
            {
                "管理员",
                "普通用户"
            };
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