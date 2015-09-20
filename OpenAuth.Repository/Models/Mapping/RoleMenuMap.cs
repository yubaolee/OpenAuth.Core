using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class RoleMenuMap : EntityTypeConfiguration<RoleMenu>
    {
        public RoleMenuMap()
        {
            // Primary Key
            this.HasKey(t => t.RoleMenuId);

            // Properties
            this.Property(t => t.RoleMenuId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.RoleId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.MenuId)
                .IsRequired()
                .HasMaxLength(50);

            // Table & Column Mappings
            this.ToTable("RoleMenu");
            this.Property(t => t.RoleMenuId).HasColumnName("RoleMenuId");
            this.Property(t => t.RoleId).HasColumnName("RoleId");
            this.Property(t => t.MenuId).HasColumnName("MenuId");
        }
    }
}
