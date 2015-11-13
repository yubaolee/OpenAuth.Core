using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class ModuleElementGrantMap : EntityTypeConfiguration<ModuleElementGrant>
    {
        public ModuleElementGrantMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            // Table & Column Mappings
            this.ToTable("ModuleElementGrant");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.ElementId).HasColumnName("ElementId");
            this.Property(t => t.UserId).HasColumnName("UserId");
            this.Property(t => t.RoleId).HasColumnName("RoleId");
            this.Property(t => t.GrantType).HasColumnName("GrantType");
        }
    }
}
