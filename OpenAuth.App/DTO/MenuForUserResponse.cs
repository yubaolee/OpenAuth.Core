using System.Collections.Generic;
using OpenAuth.Domain.Model;

namespace OpenAuth.App.DTO
{
    public class MenuForUserResponse
    {
        private IList<Menu> _menus = new List<Menu>();

        public IList<Menu> Menus
        {
            get { return _menus; }
        }
    }
}
