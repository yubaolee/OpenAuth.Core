using System;
using System.Threading.Tasks;
using System.Web.Mvc;
using Infrastructure.Helper;
using Newtonsoft.Json;
using OpenAuth.App;
using OpenAuth.Domain.Interface;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        private LoginApp _loginApp;

        public AccountController()
        {
            _loginApp = (LoginApp) DependencyResolver.Current.GetService(typeof (LoginApp));
        }
        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                //直接生成登陆用户，在实际的项目中采用数据库形式
                try
                {
                    _loginApp.Login(model.UserName, model.Password);
                    SessionHelper.AddSessionUser(model);
                    return RedirectToLocal(returnUrl);
                }
                catch (Exception exception)
                {
                    ModelState.AddModelError("", exception.Message);
                }
            }

            // 如果我们进行到这一步时某个地方出错，则重新显示表单
            return View(model);
        }

        //
        // POST: /Account/LogOff
        public ActionResult LogOff()
        {
            SessionHelper.Clear();
            return RedirectToAction("Login", "Account");
        }

        public ActionResult List()
        {
            return View();
        }
      



        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

    }
}