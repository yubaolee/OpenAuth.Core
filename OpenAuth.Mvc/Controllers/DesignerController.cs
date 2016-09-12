using System;
using System.Collections.Specialized;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Xml.Linq;
using OpenAuth.Mvc.Models;
using OptimaJet.Workflow;
using OptimaJet.Workflow.Core.Builder;
using OptimaJet.Workflow.Core.Bus;
using OptimaJet.Workflow.Core.Runtime;
using OptimaJet.Workflow.DbPersistence;
using WorkflowRuntime = OptimaJet.Workflow.Core.Runtime.WorkflowRuntime;

namespace OpenAuth.Mvc.Controllers
{
    public class DesignerController : BaseController
    {
        public ActionResult Index(string schemeName)
        {
            return View();
        }

        public ActionResult API()
        {
            Stream filestream = null;
            if (Request.Files.Count > 0)
                filestream = Request.Files[0].InputStream;

            var pars = new NameValueCollection();
            pars.Add(Request.Params);

            if (Request.HttpMethod.Equals("POST", StringComparison.InvariantCultureIgnoreCase))
            {
                var parsKeys = pars.AllKeys;
                foreach (var key in Request.Form.AllKeys)
                {
                    if (!parsKeys.Contains(key))
                    {
                        pars.Add(Request.Form);
                    }
                }
            }

            var res = WorkflowInit.Runtime.DesignerAPI(pars, filestream, true);
            if (pars["operation"].ToLower() == "downloadscheme")
                return File(Encoding.UTF8.GetBytes(res), "text/xml", "scheme.xml");
            return Content(res);
        }

    }
}


