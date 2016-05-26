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
        public string Assign(string type, int firstId, string secIds)
        {
            try
            {
                var secIdList = JsonHelper.Instance.Deserialize<int[]>(secIds);
                _app.Assign(type, firstId, secIdList);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
        [HttpPost]
        public string UnAssign(string type, int firstId, string secIds)
        {
            try
            {
                var secIdList = JsonHelper.Instance.Deserialize<int[]>(secIds);
                _app.UnAssign(type, firstId, secIdList);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
    }
}