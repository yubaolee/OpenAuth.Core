using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Model
{
    public partial class User
    {
        //加载用户的导航菜单项
        public IEnumerable<Menu> LoadMenus()
        {
            var menus = new List<Menu>();

            foreach (var role in Roles)
            {
                foreach (var menu in role.RoleMenus.Where(menu => !menus.Exists(e => e.Id == menu.Id)))
                {
                    menus.Add(menu);
                }
            }

            return menus;
        }
    }
}
