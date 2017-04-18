using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.Domain;
using OpenAuth.Mvc.Controllers;
using System;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.FlowManage.Controllers
{
    /// <summary>
    /// 通用申请流程处理
    /// <para>李玉宝新增于2016-09-08 19:21:59</para>
    /// </summary>
    public class FlowInstancesController : BaseController
    {
        public WFProcessInstanceService App { get; set; }

        #region 视图

        public ActionResult Index()
        {
            return View();
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
        /// 审核流程
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult VerificationForm()
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

        #endregion 视图

        #region 提交数据

        /// <summary>
        /// 创建流程实例
        /// </summary>
        /// <param name="wfSchemeInfoId">流程模板信息Id</param>
        /// <param name="frmData">表单数据</param>
        /// <param name="type">0发起，3草稿</param>
        /// <returns></returns>
        [HttpPost]
        public string CreateProcess(Guid wfSchemeInfoId, string wfProcessInstanceJson, string frmData)
        {
            WFProcessInstance wfProcessInstanceEntity = wfProcessInstanceJson.ToObject<WFProcessInstance>();
            wfProcessInstanceEntity.Id = Guid.Empty;

            App.CreateInstance(Guid.NewGuid(), wfSchemeInfoId, wfProcessInstanceEntity, frmData);

            return Result.ToJson();
        }

        /// <summary>
        /// 审核流程
        /// </summary>
        /// <param name="processId">工作流实例主键Id</param>
        /// <param name="verificationData">审核数据</param>
        /// <returns></returns>
        [HttpPost]
        public string VerificationProcess(Guid processId, string verificationData)
        {
            App.VerificationProcess(processId, verificationData);
            return Result.ToJson();
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
                    App.DeleteProcess(id);
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

        #endregion 提交数据

        #region 获取数据(公用)

        /// <summary>
        /// 获取进程模板Json
        /// </summary>
        /// <param name="keyValue"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetProcessSchemeJson(Guid keyValue)
        {
            var data = App.GetProcessSchemeEntity(keyValue);
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
            var data = App.GetProcessSchemeByUserId(keyValue);
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
            var data = App.GetProcessSchemeEntityByNodeId(keyValue, nodeId);
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
            var processInstance = App.GetProcessInstanceEntity(keyValue);
            var processScheme = App.GetProcessSchemeEntity(processInstance.ProcessSchemeId);
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
            var processInstance = App.GetProcessInstanceEntity(keyValue);
            return Content(processInstance.ToJson());
        }

        public string Load(string type, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(App.Load(AuthUtil.GetCurrentUser().User.Id.ToString(), type, pageCurrent, pageSize));
        }

        #endregion 获取数据(公用)
    }
}