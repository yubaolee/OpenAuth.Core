using System;
using System.Linq;
using System.Web;
using Infrastructure;
using OpenAuth.App.ViewModel;
using System.Web.Security;
using OpenAuth.Domain.Service;

namespace OpenAuth.App
{
    public class LoginApp
    {
        private AuthoriseService _service;

        public LoginApp(AuthoriseService service)
        {
            _service = service;
        }

        public void Login(string userName, string password)
        {
            _service.Check(userName, password);
            FormsAuthentication.SetAuthCookie(userName, true);

        }

        /// <summary>
        /// 开发者登陆
        /// </summary>
        public void LoginByDev()
        {
            _service.SetSysUser();
            FormsAuthentication.SetAuthCookie("System", true);
         
        }

        public LoginUserVM GetLoginUser()
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                throw new HttpException(401,"未登录");
            }
            string username = HttpContext.Current.User.Identity.Name;
            _service.GetUserAccessed(username);
            var user = new LoginUserVM
            {
                User = _service.User,
                AccessedOrgs = _service.Orgs,
                Modules = _service.Modules.MapToList<ModuleView>(),
                Resources = _service.Resources,
            };

            foreach (var moduleView in user.Modules)
            {
                moduleView.Elements = _service.ModuleElements.Where(u => u.ModuleId == moduleView.Id).OrderBy(u => u.Sort).ToList();
            }

            return user;
        }
    }
}