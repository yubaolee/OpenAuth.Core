using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class RelevanceManagerController : BaseController
    {
        private RevelanceManagerApp _app;

        public RelevanceManagerController()
        {
            _app = AutofacExt.GetFromFac<RevelanceManagerApp>();
        }

        [HttpPost]
        public string Assign(string type, Guid firstId, Guid[] secIds)
        {
            try
            {
                _app.Assign(type, firstId, secIds);
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }
        [HttpPost]
        public string UnAssign(string type, Guid firstId, Guid[] secIds)
        {
            try
            {
                _app.UnAssign(type, firstId, secIds);
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }
    }
}