using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class UserCfg
    {
        public int Id { get; set; }
        public string Theme { get; set; }
        public string Skin { get; set; }
        public string NavBarStyle { get; set; }
        public string TabFocusColor { get; set; }
        public int NavTabIndex { get; set; }
    }
}
