using System;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;

namespace OpenAuth.Mvc.Areas.FlowManage.Controllers
{

    public class FlowProcessController :Controller
    {
        private WFRuntimeService wfProcessBll ;

        public FlowProcessController(WFRuntimeService service)
        {
            wfProcessBll = service;
        }
        #region 视图功能
        /// <summary>
        /// 流程监控
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult MonitoringIndex()
        {
            return View();
        }
        /// <summary>
        /// 流程指派
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult DesignationIndex()
        {
            return View();
        }
        /// <summary>
        /// 流程进度查看
        /// </summary>
        /// <returns></returns>\
        [HttpGet]
        public ActionResult ProcessLookFrom()
        {
            return View();
        }
        /// <summary>
        /// 流程指派
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult ProcessDesignate()
        {
            return View();
        }
        #endregion

        #region 获取数据(公用)

        /// <summary>
        /// 获取进程模板Json
        /// </summary>
        /// <param name="keyValue"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetProcessSchemeJson(Guid keyValue)
        {
            var data = wfProcessBll.GetProcessSchemeEntity(keyValue);
            return Content(data.ToJson());
        }
        /// <summary>
        /// 已办流程进度查看，根据当前访问人的权限查看表单内容
        /// </summary>
        /// <param name="keyValue"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetProcessSchemeEntityByUserId(Guid keyValue)
        {
            var data = wfProcessBll.GetProcessSchemeByUserId(keyValue);
            return Content(data.ToJson());
        }
        /// <summary>
        /// 已办流程进度查看，根据当前节点的权限查看表单内容
        /// </summary>
        /// <param name="keyValue"></param>
        /// <param name="isPermission"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetProcessSchemeEntityByNodeId(Guid keyValue, string nodeId)
        {
            var data = wfProcessBll.GetProcessSchemeEntityByNodeId(keyValue, nodeId);
            return Content(data.ToJson());
        }
        /// <summary>
        /// 获取进程信息
        /// </summary>
        /// <param name="keyValue"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetProcessInfoJson(Guid keyValue)
        {
            var processInstance = wfProcessBll.GetProcessInstanceEntity(keyValue);
            var processScheme = wfProcessBll.GetProcessSchemeEntity(processInstance.ProcessSchemeId);
            var JsonData = new
            {
                processInstance = processInstance,
                processScheme = processScheme
            };
            return Content(JsonData.ToJson());
        }
        /// <summary>
        /// 获取进程实例
        /// </summary>
        /// <param name="keyValue"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetProcessInstanceJson(Guid keyValue)
        {
            var processInstance = wfProcessBll.GetProcessInstanceEntity(keyValue);
            return Content(processInstance.ToJson());
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 删除工作流实例进程
        /// </summary>
        /// <param name="keyValue">主键值</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteProcess(Guid keyValue)
        {
            wfProcessBll.DeleteProcess(keyValue);
            return Content("删除成功。");
        }
       
        /// <summary>
        /// 审核流程
        /// </summary>
        /// <param name="processId">工作流实例主键Id</param>
        /// <param name="processId">审核数据</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult VerificationProcess(Guid processId, string verificationData)
        {
            wfProcessBll.VerificationProcess(processId, verificationData);
            return Content("审核成功。");
        }

        #endregion
    }
}
