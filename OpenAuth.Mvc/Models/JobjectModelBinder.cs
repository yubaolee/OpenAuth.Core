using System.Threading.Tasks;
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
        public Task BindModelAsync(ModelBindingContext bindingContext)
        {
            var obj = new JObject();

            //// Specify a default argument name if none is set by ModelBinderAttribute
            //var modelName = bindingContext.BinderModelName;
            //if (string.IsNullOrEmpty(modelName))
            //{
            //    modelName = "obj";
            //}

            //// Try to fetch the value of the argument by name
            //var valueProviderResult =
            //    bindingContext.ValueProvider.GetValue(modelName);

            //这个地方会报StringValues的异常，好奇怪，只能调试源码了
            var request = bindingContext.HttpContext.Request;
            foreach (var item in request.Form)
            {
                obj[item.Key] = item.Value[0];
            }

            bindingContext.Result = ModelBindingResult.Success(obj);
            return Task.CompletedTask;
        }
    }
}