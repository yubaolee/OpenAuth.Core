using System;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;

namespace OpenAuth.Mvc.Controllers
{
    public class WorkflowSchemasController : BaseController
    {
        private WorkflowSchemasManagerApp _app;

        public WorkflowSchemasController()
        {
            _app = AutofacExt.GetFromFac<WorkflowSchemasManagerApp>();
        }
        public ActionResult Index()
        {
            return View();
        }

        public string Load(int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(pageCurrent, pageSize));
        }

        [HttpPost]
        public string Del(string[] ids)
        {
            try
            {
                _app.Del(ids);
            }
            catch (Exception e)
            {
                 Result.Status = false;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

    }
}


