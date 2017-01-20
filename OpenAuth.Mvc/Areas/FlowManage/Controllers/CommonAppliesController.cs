using System;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.Mvc.Controllers;

namespace OpenAuth.Mvc.Areas.FlowManage.Controllers
{
    /// <summary>
    /// 通用申请流程处理
    /// <para>李玉宝新增于2016-09-08 19:21:59</para>
    /// </summary>
    public class CommonAppliesController : Controller
    {
        private WFProcessInstanceService _app;

        public CommonAppliesController()
        {
            _app = AutofacExt.GetFromFac<WFProcessInstanceService>();
        }

        public ActionResult Index()
        {
            return View();
        }

        public string Load(string type, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(AuthUtil.GetCurrentUser().User.Id.ToString(), type, pageCurrent, pageSize));
        }

        /// <summary>
        /// 进度查看
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult ProcessLookForm()
        {
            return View();
        }

        /// <summary>
        /// 删除申请
        /// </summary>
        public string Delete(Guid[] ids)
        {
            try
            {
                foreach (var id in ids)
                {
                _app.DeleteProcess(id);

                }
            }
            catch (Exception ex)
            {
                
                throw;
            }

            return string.Empty;
        }


    }
}