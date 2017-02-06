using System;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;

namespace OpenAuth.Mvc.Areas.FlowManage.Controllers
{

    /// <summary>
    /// 流程执行
    /// <para>李玉宝新增于2017-01-23 9:21:39</para>
    /// </summary>
    public class FlowLaunchController : Controller
    {
        private WFProcessInstanceService wfProcessBll;

        public FlowLaunchController()
        {
            wfProcessBll = AutofacExt.GetFromFac<WFProcessInstanceService>();
        }
        #region 视图功能
        //
        // GET: /FlowManage/FlowLaunch/
        /// <summary>
        /// 管理
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 创建流程实例视图
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult FlowProcessNewForm()
        {
            return View();
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 创建流程实例
        /// </summary>
        /// <param name="wfSchemeInfoId">流程模板信息Id</param>
        /// <param name="frmData">表单数据</param>
        /// <param name="type">0发起，3草稿</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateProcess(Guid wfSchemeInfoId, string wfProcessInstanceJson, string frmData)
        {
            WFProcessInstance wfProcessInstanceEntity = wfProcessInstanceJson.ToObject<WFProcessInstance>();
            wfProcessInstanceEntity.Id = Guid.Empty;
            string text = "创建成功";
            if (wfProcessInstanceEntity.EnabledMark == 1)//发起流程
            {
                wfProcessBll.CreateInstance(Guid.NewGuid(), wfSchemeInfoId, wfProcessInstanceEntity, frmData);
            }
            else if (wfProcessInstanceEntity.EnabledMark == 3)//草稿
            {
                wfProcessBll.CreateRoughdraft(Guid.NewGuid(), wfSchemeInfoId, wfProcessInstanceEntity, frmData);
                text = "草稿保存成功";
            }

            return Content(text);
        } 
        #endregion
    }
}
