using System;
using System.Collections.Generic;
using System.Text;

namespace OpenAuth.App.Request
{
    public class ChangePasswordReq
    {
        public string Account { get; set; }
        public string Password { get; set; }
    }
}
