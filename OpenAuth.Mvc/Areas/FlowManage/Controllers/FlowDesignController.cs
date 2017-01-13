using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Infrastructure;
using LeaRun.Util.WebControl;
using OpenAuth.App;
using OpenAuth.Domain;
using OpenAuth.Domain.Service;

namespace OpenAuth.Mvc.Areas.FlowManage.Controllers
{

    /// <summary>
    /// 流程设计
    /// <para>李玉宝新增于2017-01-12 19:41:56</para>
    /// </summary>
    public class FlowDesignController :Controller
    {
        private WorkflowService wfFlowInfoBLL;
        private UserManagerApp userBLL;

        public FlowDesignController()
        {
            wfFlowInfoBLL = AutofacExt.GetFromFac<WorkflowService>();
            userBLL = AutofacExt.GetFromFac<UserManagerApp>();
        }

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
        public ActionResult GetFormJson(string keyValue)
        {
            var schemeinfo = wfFlowInfoBLL.GetEntity(keyValue);
            var schemecontent = wfFlowInfoBLL.GetSchemeEntity(schemeinfo.Id, schemeinfo.SchemeVersion);
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
            var schemecontent = wfFlowInfoBLL.GetSchemeEntity(keyValue, SchemeVersion);
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
        [ValidateAntiForgeryToken]
        public ActionResult RemoveForm(string keyValue)
        {
            wfFlowInfoBLL.RemoveForm(keyValue);
            return Content("删除成功。"); 
        }
        /// <summary>
        /// 保存用户表单（新增、修改）
        /// </summary>
        /// <param name="keyValue">主键值</param>
        /// <param name="userEntity">用户实体</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveForm(string keyValue, string InfoEntity, string ContentEntity, string shcemeAuthorizeData)
        {
            WFSchemeInfo entyity = InfoEntity.ToObject<WFSchemeInfo>();
            WFSchemeContent contententity = ContentEntity.ToObject<WFSchemeContent>();
            wfFlowInfoBLL.SaveForm(keyValue, entyity, contententity);
            return Content("操作成功。");
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
            wfFlowInfoBLL.UpdateState(keyValue, State);
            return Content("操作成功。");
        }
        #endregion

        #region 获取权限数据
   
        /// <summary>
        /// 用户列表树 
        /// </summary>
        /// <returns>返回树形Json</returns>
        [HttpGet]
        public ActionResult GetUserCheckTreeJson()
        {
            var data = userBLL.Load(Guid.Empty, 1, 10);
            var treeList = new List<TreeEntity>();
            string companyid = "";
            string departmentid = "";
            foreach (DataRow item in data.rows)
            {
                TreeEntity tree = new TreeEntity();
                if (companyid != item["OrganizeId"].ToString())
                {
                    TreeEntity tree1 = new TreeEntity();
                    companyid = item["OrganizeId"].ToString();
                    tree1.id = item["OrganizeId"].ToString();
                    tree1.text = item["OrganizeName"].ToString();
                    tree1.value = item["OrganizeId"].ToString();
                    tree1.isexpand = true;
                    tree1.complete = true;
                    tree1.hasChildren = true;
                    tree1.Attribute = "Sort";
                    tree1.AttributeValue = "Organize";
                    tree1.parentId = "0";
                    tree1.img = "fa fa-home";
                    treeList.Add(tree1);
                }
                if (departmentid != item["DepartmentId"].ToString() && !string.IsNullOrEmpty(item["DepartmentId"].ToString()))
                {
                    TreeEntity tree1 = new TreeEntity();
                    departmentid = item["DepartmentId"].ToString();
                    tree1.id = item["DepartmentId"].ToString();
                    tree1.text = item["DepartmentName"].ToString();
                    tree1.value = item["DepartmentId"].ToString();
                    tree1.isexpand = false;
                    tree1.complete = true;
                    tree1.hasChildren = true;
                    tree1.Attribute = "Sort";
                    tree1.AttributeValue = "Department";
                    tree1.parentId = item["OrganizeId"].ToString();
                    tree1.img = "fa fa-umbrella";
                    treeList.Add(tree1);
                }
                tree.id = item["UserId"].ToString();
                tree.text = item["RealName"].ToString();
                tree.value = item["UserId"].ToString();
                tree.isexpand = true;
                tree.complete = true;
                tree.hasChildren = false;
                tree.parentId = string.IsNullOrEmpty(item["DepartmentId"].ToString()) ? item["OrganizeId"].ToString() : item["DepartmentId"].ToString();
                tree.showcheck = true;
                tree.img = "fa fa-user";
                tree.Attribute = "mytype";
                tree.AttributeValue = "User";
                treeList.Add(tree);
            }
            return Content(treeList.TreeToJson());
        }
        #endregion
    }
}
