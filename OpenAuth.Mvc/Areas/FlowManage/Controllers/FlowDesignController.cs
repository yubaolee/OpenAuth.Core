using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Infrastructure;
using LeaRun.Util.WebControl;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Service;
using OpenAuth.Mvc.Controllers;

namespace OpenAuth.Mvc.Areas.FlowManage.Controllers
{

    /// <summary>
    /// 流程设计
    /// <para>李玉宝新增于2017-01-12 19:41:56</para>
    /// </summary>
    public class FlowDesignController :BaseController
    {
        public WFSchemeService WfFlowInfoBll { get; set; }

        #region 视图功能
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
        /// 预览
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult PreviewIndex()
        {
            return View();
        }


        /// <summary>
        /// 表单
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Form()
        {
            return View();
        }
        /// <summary>
        /// 节点设置
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult FlowNodeForm()
        {
            return View();
        }
        /// <summary>
        /// 连接线设置
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult FlowLineForm()
        {
            return View();
        }
        /// <summary>
        /// 流程创建
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult FlowSchemeBuider()
        {
            return View();
        }
        #endregion

        #region 获取数据

        /// <summary>
        /// 设置流程
        /// </summary>
        /// <param name="keyValue">主键</param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetFormJson(Guid keyValue)
        {
            var schemeinfo = WfFlowInfoBll.GetEntity(keyValue);
            var schemecontent = WfFlowInfoBll.GetSchemeEntity(schemeinfo.Id, schemeinfo.SchemeVersion);
            var JsonData = new
            {
                schemeinfo = schemeinfo,
                schemecontent = schemecontent
            };
            return Content(JsonData.ToJson());
        }
        /// <summary>
        /// 获取工作流流程模板内容
        /// </summary>
        /// <param name="keyValue"></param>
        /// <param name="SchemeVersion"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetSchemeContentJson(Guid keyValue, string SchemeVersion)
        {
            var schemecontent = WfFlowInfoBll.GetSchemeEntity(keyValue, SchemeVersion);
            return Content(schemecontent.ToJson());
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 删除表单模板
        /// </summary>
        /// <param name="keyValue">主键值</param>
        /// <returns></returns>
        [HttpPost]
        public string RemoveForm(Guid[] ids)
        {
            WfFlowInfoBll.RemoveForm(ids);
            return Result.ToJson();
        }
        /// <summary>
        /// 保存用户表单（新增、修改）
        /// </summary>
        /// <param name="keyValue">主键值</param>
        /// <param name="userEntity">用户实体</param>
        /// <returns></returns>
        [HttpPost]
        public string SaveForm(string keyValue, string InfoEntity, string ContentEntity, string shcemeAuthorizeData)
        {
            WFSchemeInfo entyity = InfoEntity.ToObject<WFSchemeInfo>();
            WFSchemeContent contententity = ContentEntity.ToObject<WFSchemeContent>();
            WfFlowInfoBll.SaveForm(keyValue, entyity, contententity);
            return Result.ToJson();
        }
        /// <summary>
        /// （启用、禁用）
        /// </summary>
        /// <param name="keyValue">主键值</param>
        /// <param name="State">状态：1-启动；0-禁用</param>
        /// <returns></returns>
        [HttpPost]
        
        public ActionResult SubmitUpdateState(string keyValue, int State)
        {
            WfFlowInfoBll.UpdateState(keyValue, State);
            return Content("操作成功。");
        }

        public string Load(int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(WfFlowInfoBll.Load(pageCurrent, pageSize));
        }
        #endregion

       
    }
}
