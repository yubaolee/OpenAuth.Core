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
        private readonly AuthoriseFactory _factory;

        public AuthorizeApp(AuthoriseFactory service)
        {
            _factory = service;
        }

        public UserWithAccessedCtrls GetAccessedControls(string username)
        {
            var service = _factory.Create(username);
            var user = new UserWithAccessedCtrls
            {
                User = service.User,
                Orgs = service.Orgs,
                Modules = service.Modules.OrderBy(u => u.SortNo).ToList().MapToList<ModuleView>(),
                Resources = service.Resources,
                Roles = service.Roles
            };

            foreach (var moduleView in user.Modules)
            {
                moduleView.Elements =
                    service.ModuleElements.Where(u => u.ModuleId == moduleView.Id).OrderBy(u => u.Sort).ToList();
            }

           user.ModuleWithChildren = user.Modules.GenerateTree(c => c.Id, c => c.ParentId);

            return user;
        }
    }
}