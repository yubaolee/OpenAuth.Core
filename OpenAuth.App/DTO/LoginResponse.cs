using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OpenAuth.App.DTO
{
    public class LoginResponse : Response
    {
        public string UserId { get; set; }
        public string UserName { get; set; }
    }
}
