using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Newtonsoft.Json.Linq;

namespace OpenAuth.Mvc.Models
{
    /// <summary>
    /// 将前端传来的FormData数据转为Jobject类型
    /// 注：前端如果是application/json，可以直接转JOjbect！
    /// </summary>
    public class JobjectModelBinder :IModelBinder
    {
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            //todo:需要判断前端是否是FormData
            var obj = new JObject();
            var request = controllerContext.HttpContext.Request;
            foreach (var key in request.Form)
            {
                obj[key] = JObject.Parse(key.Value);
            }
            return obj;
        }

        public Task BindModelAsync(ModelBindingContext bindingContext)
        {
            throw new System.NotImplementedException();
        }
    }
}