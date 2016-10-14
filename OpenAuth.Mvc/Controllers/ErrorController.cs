using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class ErrorController : Controller
    {
        public ActionResult Http404()
        {
            return Content("貌似URL不在~~", "text/plain");
        }

        /// <summary>
        /// 演示版本禁止提交
        /// </summary>
        public string DemoError()
        {
            Response.Charset = "utf-8";
            var response = new Response
            {
                Status = false,
                Message = "演示版本，不能进行此操作"
            };
            return JsonHelper.Instance.Serialize(response);
        }

        /// <summary>
        /// 没有登录
        /// </summary>
        /// <returns>ActionResult.</returns>
        public ActionResult Http401()
        {
            return RedirectToAction("Index", "Login");
        }


        public string Http500()
        {
            Response.Charset = "utf-8";
            var response = new Response
            {
                Status = false,
                Message = "内部错误"
            };
            return JsonHelper.Instance.Serialize(response);
        }
    }
}