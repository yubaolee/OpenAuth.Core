using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("ModuleElement")]
    public partial class ModuleElement :Entity
    {
        public ModuleElement()
        {
            this.DomId = string.Empty;
            this.Name = string.Empty;
            this.Attr = string.Empty;
            this.Script = string.Empty;
            this.Icon = string.Empty;
            this.Class = string.Empty;
            this.Remark = string.Empty;
            this.Sort = 0;
            this.ModuleId = string.Empty;
            this.TypeName = string.Empty;
            this.TypeId = string.Empty;
        }
        public string DomId { get; set; }
        public string Name { get; set; }
        public string Attr { get; set; }
        public string Script { get; set; }
        public string Icon { get; set; }
        public string Class { get; set; }
        public string Remark { get; set; }
        public int Sort { get; set; }
        public string ModuleId { get; set; }
        public string TypeName { get; set; }
        public string TypeId { get; set; }
    }
}
