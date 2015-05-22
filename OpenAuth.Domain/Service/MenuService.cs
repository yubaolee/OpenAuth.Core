using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Model;

namespace OpenAuth.Domain.Service
{
    public class MenuService
    {
        private IUserRepository _userRepository;

        public MenuService(IUserRepository repository)
        {
            _userRepository = repository;
        }

        public List<Menu> GetMenuFor(string userId)
        {
            var menus = new List<Menu>();
            var user = _userRepository.FindById(userId);
            if (user != null)
            {
                foreach (var role in user.Roles)
                {
                    foreach (var menu in role.RoleMenus.Where(menu => !menus.Exists(e =>e.MenuId == menu.MenuId)))
                    {
                        menus.Add(menu);
                    }
                }
            }
            return menus;
        }
    }
}
