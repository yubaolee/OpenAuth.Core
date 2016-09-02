using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class WorkFlowDesignerController : Controller
    {
        //
        // GET: /WorkFlowDesigner/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Open()
        {
            return View();
        }

        public ActionResult Open_Tree()
        {
            return View();
        }


        public string GetJSON()
        {
            //string flowid = Request.QueryString["flowid"];
            //string type = Request.QueryString["type"];
            //if (!flowid.IsGuid())
            //{
            //    return "{}";
            //}
            //var flow = new Business.Platform.WorkFlow().Get(flowid.ToGuid());
            //if (flow == null)
            //{
                return "{}";
            //}
            //else
            //{
            //    return "0" == type ? flow.RunJSON : flow.DesignJSON;
            //}
        }

        public ActionResult Set_Flow()
        {
            return View();
        }

        public string GetTables()
        {
            Response.Charset = "utf-8";
            //string connID = Request.QueryString["connid"];
            //if (!connID.IsGuid())
            //{
                return "[]";
            //}
            //List<string> tables = new Business.Platform.DBConnection().GetTables(connID.ToGuid());
            //System.Text.StringBuilder sb = new System.Text.StringBuilder("[", 1000);
            //foreach (string table in tables)
            //{
            //    sb.Append("{\"name\":");
            //    sb.AppendFormat("\"{0}\"", table);
            //    sb.Append("},");
            //}
            //return sb.ToString().TrimEnd(',') + "]";
        }

        public string GetFields()
        {
            string table = Request.QueryString["table"];
            string connid = Request.QueryString["connid"];

            //if (table.IsNullOrEmpty() || !connid.IsGuid())
            //{
                return "[]";
            //}
            //Dictionary<string, string> fields = new Business.Platform.DBConnection().GetFields(connid.ToGuid(), table);
            //System.Text.StringBuilder sb = new System.Text.StringBuilder("[", 1000);

            //foreach (var field in fields)
            //{
            //    sb.Append("{");
            //    sb.AppendFormat("\"name\":\"{0}\",\"note\":\"{1}\"", field.Key, field.Value);
            //    sb.Append("},");
            //}
            //return sb.ToString().TrimEnd(',') + "]";
        }


        public ActionResult Set_Step()
        {
            return View();
        }

        public ActionResult Set_SubFlow()
        {
            return View();
        }

        public ActionResult Set_Line()
        {
            return View();
        }

        public ActionResult Opation()
        {
            return View();
        }

        public ActionResult Save()
        {
            return View();
        }

        public ActionResult Install()
        {
            return View();
        }

        public ActionResult UnInstall()
        {
            return View();
        }

        public ActionResult SaveAs()
        {
            return View();
        }

    }
}
