using System.Linq;
using System.Web;
using Infrastructure;
using OpenAuth.App.ViewModel;
using OpenAuth.App.SSO;
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

        public LoginUserVM GetLoginUser()
        {
            if (!AuthUtil.CheckLogin())
            {
                throw new HttpException(401,"未登录");
            }

            return AuthUtil.GetCurrentUser();
        }

        public LoginUserVM GetLoginUser(string username)
        {
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
                moduleView.Elements =
                    _service.ModuleElements.Where(u => u.ModuleId == moduleView.Id).OrderBy(u => u.Sort).ToList();
            }

            return user;
        }
    }
}