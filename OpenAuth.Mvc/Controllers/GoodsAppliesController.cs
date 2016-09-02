using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.Domain;
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

        public dynamic Get(Guid id)
        {
                var apply = _app.Get(id);
                CreateWorkflowIfNotExists(id);
            
            return new
            {
                Apply=apply
            };
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
    }
}