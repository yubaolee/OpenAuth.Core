using System.Linq;
using Infrastructure;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain.Service;

namespace OpenAuth.App
{
    /// <summary>
    ///  加载用户所有可访问的资源/机构/模块
    /// <para>李玉宝新增于2016-07-19 10:53:30</para>
    /// </summary>
    public class AuthorizeApp
    {
        private readonly AuthoriseService _service;

        public AuthorizeApp(AuthoriseService service)
        {
            _service = service;
        }

        public UserWithAccessedCtrls GetAccessedControls(string username)
        {
            _service.LoadAuthControls(username);
            var user = new UserWithAccessedCtrls
            {
                User = _service.User,
                Orgs = _service.Orgs,
                Modules = _service.Modules.MapToList<ModuleView>(),
                Resources = _service.Resources,
                Roles = _service.Roles
            };

            foreach (var moduleView in user.Modules)
            {
                moduleView.Elements =
                    _service.ModuleElements.Where(u => u.ModuleId == moduleView.Id).OrderBy(u => u.Sort).ToList();
            }

           user.ModuleWithChildren = user.Modules.GenerateTree(c => c.Id, c => c.ParentId);

            return user;
        }
    }
}