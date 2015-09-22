using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using OpenAuth.Mvc.Models;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Infrastructure.Helper;
using Newtonsoft.Json;
using OpenAuth.App;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Mvc.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        private LoginApp _loginApp;
        private IUserRepository _userRepository;

        public AccountController(IUserRepository repository)
        {
            _userRepository = repository;
            _loginApp = new LoginApp(_userRepository);
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
                var user = new User {Account = "admin"};
                if (user != null)
                {
                    
                    return RedirectToLocal(returnUrl);
                }
                else
                {
                    ModelState.AddModelError("", "Invalid username or password.");
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
        public string LoadUsers()
        {
            return JsonConvert.SerializeObject(_userRepository.LoadUsers());
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