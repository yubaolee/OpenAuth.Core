using System;
using System.Web.Http;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.Mvc.Models;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class FormsController : BaseController
    {
        public FormApp App { get; set; }

        //
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Preview()
        {
            return View();
        }

        /// <summary>
        /// 预览表单
        /// </summary>
        /// <param name="id">The identifier.</param>
        /// <returns>System.String.</returns>
        public string PreviewData(string id)
        {
            var form = App.FindSingle(id);

            return FormUtil.GetHtml(form, "");
        }

        //添加或修改
        [System.Web.Mvc.HttpPost]
        [ValidateInput(false)]
        public string Add(Form obj)
        {
            try
            {
                App.Add(obj);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        //添加或修改
        [System.Web.Mvc.HttpPost]
        [ValidateInput(false)]
        public string Update(Form obj)
        {
            try
            {
                App.Update(obj);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载列表
        /// </summary>
        public string Load([FromUri]QueryFormListReq request)
        {
            return JsonHelper.Instance.Serialize(App.Load(request));
        }

        [System.Web.Mvc.HttpPost]
        public string Delete(string[] ids)
        {
            try
            {
                App.Delete(ids);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }
    }
}