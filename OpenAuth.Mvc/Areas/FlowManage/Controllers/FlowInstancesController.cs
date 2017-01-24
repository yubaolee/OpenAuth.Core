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
    public class FlowInstancesController : BaseController
    {
        private WFProcessInstanceService _app;
        public FlowInstancesController()
        {
            _app = AutofacExt.GetFromFac<WFProcessInstanceService>();
        }

        #region 视图

        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 审核流程
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult VerificationForm()
        {
            return View();
        }

        #endregion

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
                return Result.ToJson();
            }
            catch (Exception e)
            {
                Result.Status = false;
                Result.Message = e.Message;
                return Result.ToJson();
            }
        }


    }
}