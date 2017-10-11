using System;
using System.Linq;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.Domain;
using OpenAuth.Mvc.Controllers;

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
        /// 设置表单
        /// </summary>
        /// <param name="keyValue">主键</param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetFormJson(string keyValue)
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

            var result = data.Select(u => new
            {
                id = u.Id.ToString(),
                text = u.FrmName,
                value = u.Id.ToString(),
                isexpand = true,
                complete = true,
                hasChildren = false,
                parentId = "0",
                Attribute = "Sort",
                AttributeValue = "Frm"
            });
            return Content(result.ToJson());
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 删除表单模板
        /// </summary>
        /// <param name="ids">主键值</param>
        /// <returns></returns>
        [HttpPost]
        public string RemoveForm(string[] ids)
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
