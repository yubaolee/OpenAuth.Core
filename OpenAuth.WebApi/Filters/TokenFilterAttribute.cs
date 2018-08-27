using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using OpenAuth.App.Interface;

namespace OpenAuth.WebApi.Filters
{
    public class TokenFilterAttribute : ActionFilterAttribute
    {
        public const string Token = "X-Token";

        private IAuth _auth;

        public TokenFilterAttribute(IAuth auth)
        {
            _auth = auth;
        }


        public new void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var token = "";
            var request = filterContext.HttpContext.Request;
            if (string.IsNullOrEmpty(request.Headers[Token]))
            {
                filterContext.Result = new JsonResult(new Response
                {
                    Code = 500,
                    Message = "token不能为空"
                });
                return;
            }

            token = request.Headers[Token];

            //验证
            if (_auth.CheckLogin(token, request.Path) == false)
            {
                filterContext.Result = new JsonResult(new Response
                {
                    Code = 500,
                    Message = "token非法"
                });
            }

        }
    }
}
