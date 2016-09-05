using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;
using OptimaJet.Workflow.Core.Runtime;
using ProcessStatus = OptimaJet.Workflow.Core.Persistence.ProcessStatus;

namespace OpenAuth.Mvc.Controllers
{
    public class GoodsAppliesController : BaseController
    {
        private GoodsApplyApp _app;

        public GoodsAppliesController()
        {
            _app = AutofacExt.GetFromFac<GoodsApplyApp>();
        }

        public ActionResult Index()
        {
            return View();
        }

        public string Load(Guid parentId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(AuthUtil.GetCurrentUser().User.Id, parentId, pageCurrent, pageSize));
        }

        [HttpPost]
        public string Edit(GoodsApply apply)
        {
            try
            {
                apply.UserId = AuthUtil.GetCurrentUser().User.Id;
                _app.AddOrUpdate(apply);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        public ActionResult Detail(Guid id)
        {
            try
            {
                GoodsApplyVM apply = _app.Get(id);
                CreateWorkflowIfNotExists(id);
                apply.Commands = GetCommands(id);
                return View(apply);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }

            return View();
        }

        public string Delete(Guid id)
        {
            try
            {
                _app.Del(id);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
                throw;
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        [HttpPost]
        public string ExeCmd(Guid id, string cmd)
        {
            try
            {
                ExecuteCommand(id, cmd, null);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
                throw;
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }


        private void CreateWorkflowIfNotExists(Guid id)
        {
            if (WorkflowInit.Runtime.IsProcessExists(id))
                return;

            using (var sync = new WorkflowSync(WorkflowInit.Runtime, id))
            {
                WorkflowInit.Runtime.CreateInstance("SimpleWF", id);

                sync.StatrtWaitingFor(new List<ProcessStatus> { ProcessStatus.Initialized, ProcessStatus.Initialized });

                sync.Wait(new TimeSpan(0, 0, 10));
            }
        }

        /// <summary>
        /// 获取当前登陆用户可执行的命令
        /// </summary>
        /// <param name="id">流程实体ID</param>
        private CommandModel[] GetCommands(Guid id)
        {
            var result = new List<CommandModel>();
            var commands = WorkflowInit.Runtime.GetAvailableCommands(id, AuthUtil.GetCurrentUser().User.Id.ToString());
            foreach (var workflowCommand in commands)  //去除相同的
            {
                if (result.Count(c => c.Key == workflowCommand.CommandName) == 0)
                    result.Add(new CommandModel() { Key = workflowCommand.CommandName, Value = workflowCommand.LocalizedName, Classifier = workflowCommand.Classifier });
            }
            return result.ToArray();
        }

        /// <summary>
        /// 执行指令
        /// </summary>
        /// <param name="id">流程实例ID</param>
        /// <param name="commandName">命令名称</param>
        /// <param name="goodsApply">申请实体</param>
        private void ExecuteCommand(Guid id, string commandName, GoodsApply goodsApply)
        {
            var currentUser =AuthUtil.GetCurrentUser().User.Id.ToString();

            var commands = WorkflowInit.Runtime.GetAvailableCommands(id, currentUser);

            var command =
                commands.FirstOrDefault(
                    c => c.CommandName.Equals(commandName, StringComparison.CurrentCultureIgnoreCase));

            if (command == null)
                return;

            WorkflowInit.Runtime.ExecuteCommand(id, currentUser, currentUser, command);
        }
    }
}