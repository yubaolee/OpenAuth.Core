using System;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.Domain;
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

        /// <summary>
        /// 创建流程实例视图
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult FlowProcessNewForm()
        {
            return View();
        }


        #region 提交数据
        /// <summary>
        /// 创建流程实例
        /// </summary>
        /// <param name="wfSchemeInfoId">流程模板信息Id</param>
        /// <param name="frmData">表单数据</param>
        /// <param name="type">0发起，3草稿</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult CreateProcess(Guid wfSchemeInfoId, string wfProcessInstanceJson, string frmData)
        {
            WFProcessInstance wfProcessInstanceEntity = wfProcessInstanceJson.ToObject<WFProcessInstance>();
            wfProcessInstanceEntity.Id = Guid.Empty;
            string text = "创建成功";
            if (wfProcessInstanceEntity.EnabledMark == 1)//发起流程
            {
                _app.CreateInstance(Guid.NewGuid(), wfSchemeInfoId, wfProcessInstanceEntity, frmData);
            }
            else if (wfProcessInstanceEntity.EnabledMark == 3)//草稿
            {
                _app.CreateRoughdraft(Guid.NewGuid(), wfSchemeInfoId, wfProcessInstanceEntity, frmData);
                text = "草稿保存成功";
            }

            return Content(text);
        }
        #endregion


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
            var data = _app.GetProcessSchemeEntity(keyValue);
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
            var data = _app.GetProcessSchemeByUserId(keyValue);
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
            var data = _app.GetProcessSchemeEntityByNodeId(keyValue, nodeId);
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
            var processInstance = _app.GetProcessInstanceEntity(keyValue);
            var processScheme = _app.GetProcessSchemeEntity(processInstance.ProcessSchemeId);
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
            var processInstance = _app.GetProcessInstanceEntity(keyValue);
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
        public ActionResult DeleteProcess(Guid keyValue)
        {
            _app.DeleteProcess(keyValue);
            return Content("删除成功。");
        }

        /// <summary>
        /// 审核流程
        /// </summary>
        /// <param name="processId">工作流实例主键Id</param>
        /// <param name="processId">审核数据</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult VerificationProcess(Guid processId, string verificationData)
        {
            _app.VerificationProcess(processId, verificationData);
            return Content("审核成功。");
        }

        #endregion
    }
}