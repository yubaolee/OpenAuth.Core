using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.Domain;
using OpenAuth.Mvc.Controllers;
using OpenAuth.Mvc.WebCtrls.Tree;

namespace OpenAuth.Mvc.Areas.FlowManage.Controllers
{

    public class FormDesignController : BaseController
    {
        public WFFormService WfFrmMainBll { get; set; }

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
        /// 预览表单
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult FormPreview()
        {
            return View();
        }
        /// <summary>
        /// 创建表单
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult FrmBuider()
        {
            return View();
        }
        #endregion

        #region 获取数据

        public string Load(int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(WfFrmMainBll.Load(pageCurrent, pageSize));
        }

        /// <summary>
        /// 返回表单列表树
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns>返回树形Json</returns>
        [HttpGet]
        public ActionResult GetTreeJson()
        {
            var data = WfFrmMainBll.GetAllList();
            var treeList = new List<TreeEntity>();
            foreach (var item in data)
            {
                TreeEntity tree = new TreeEntity
                {
                    id = item.Id.ToString(),
                    text = item.FrmName,
                    value = item.Id.ToString(),
                    isexpand = true,
                    complete = true,
                    hasChildren = false,
                    parentId = "0",
                    Attribute = "Sort",
                    AttributeValue = "Frm"
                };

                treeList.Add(tree);
            }
            return Content(treeList.TreeToJson());
        }
        /// <summary>
        /// 设置表单
        /// </summary>
        /// <param name="keyValue">主键</param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetFormJson(Guid keyValue)
        {
            var data = WfFrmMainBll.GetForm(keyValue);
            return Content(data.ToJson());
        }

        /// <summary>
        /// 获取表单数据all
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetAllListJson()
        {
            var data = WfFrmMainBll.GetAllList();
            return Content(data.ToJson());
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 删除表单模板
        /// </summary>
        /// <param name="ids">主键值</param>
        /// <returns></returns>
        [HttpPost]
        public string RemoveForm(Guid[] ids)
        {
            WfFrmMainBll.RemoveForm(ids);
            return Result.ToJson();
        }
        ///// <summary>
        ///// 保存用户表单（新增、修改）
        ///// </summary>
        ///// <param name="keyValue">主键值</param>
        ///// <param name="userEntity">用户实体</param>
        ///// <returns></returns>
        [HttpPost]
        public string SaveForm(string keyValue, WFFrmMain userEntity)
        {
            try
            {
                var user = AuthUtil.GetCurrentUser();
                userEntity.ModifyUserId = user.User.Account;
                userEntity.ModifyUserName = user.User.Name;
                WfFrmMainBll.SaveForm(keyValue, userEntity);
            }
            catch (Exception e)
            {
                Result.Status = false;
                Result.Message = e.Message;
            }
            return Result.ToJson();
        }
        #endregion
    }
}
