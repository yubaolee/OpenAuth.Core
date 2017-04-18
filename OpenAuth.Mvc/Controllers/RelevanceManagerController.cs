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
        public RevelanceManagerApp App { get; set; }

        [HttpPost]
        public string Assign(string type, Guid firstId, Guid[] secIds)
        {
            try
            {
                App.Assign(type, firstId, secIds);
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
                App.UnAssign(type, firstId, secIds);
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