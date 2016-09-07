using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;

namespace OpenAuth.Mvc.Models
{
    /// <summary>
    /// 判断角色
    /// </summary>
    public class WorkflowRuleProvider : IWorkflowRuleProvider
    {
        private RoleManagerApp _app;

        public WorkflowRuleProvider()
        {
            _app = AutofacExt.GetFromFac<RoleManagerApp>();
        }

        /// <summary>
        /// 加载角色列表，供流程设计的时候进行选择
        /// </summary>
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

        /// <summary>
        /// Checks the specified process instance.
        /// <para>李玉宝于2016-09-05 16:43:07</para>
        /// </summary>
        /// <param name="processInstance">The process instance.</param>
        /// <param name="runtime">The runtime.</param>
        /// <param name="identityId">用户ID</param>
        /// <param name="ruleName">Name of the rule.</param>
        /// <param name="parameter">The parameter.</param>
        /// <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
        public bool Check(ProcessInstance processInstance, WorkflowRuntime runtime, string identityId, string ruleName,
            string parameter)
        {
            var userRole = _app.LoadForUser(Guid.Parse(identityId));
            foreach (var role in userRole)
            {
                if (role.Name == ruleName)
                    return true;
            }
            return false;
        }

        public IEnumerable<string> GetIdentities(ProcessInstance processInstance, WorkflowRuntime runtime, string ruleName, string parameter)
        {
            var userids = _app.GetUsersInRole(ruleName);
            if (userids == null) return null;
            var userstrs = new List<string>();
            foreach (var userid in userids)
            {
                userstrs.Add(userid.ToString());
            }
            
            return userstrs;
        }
    }
}