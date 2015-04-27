using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;
using OpenAuth.Domain.Model;

namespace OpenAuth.Infrastructure.Mapping
{
    public class RoleMap : EntityTypeConfiguration<Role>
    {
        public RoleMap()
        {
            // Primary Key
            this.HasKey(t => t.RoleId);

            // Properties
            this.Property(t => t.RoleId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.ParentId)
                .HasMaxLength(50);

            this.Property(t => t.FullName)
                .HasMaxLength(50);

            this.Property(t => t.Category)
                .HasMaxLength(50);

            this.Property(t => t.Description)
                .HasMaxLength(200);

            this.Property(t => t.DepartmentId)
                .HasMaxLength(50);

            //角色包含的用户；
            this.HasMany(d => d.Users)
              .WithMany(u => u.Roles)
              .Map(
                  m =>
                  {
                      m.MapLeftKey("RoleId");
                      m.MapRightKey("UserId");
                      m.ToTable("UserRole");
                  });

            //角色包含的菜单
            this.HasMany(m => m.RoleMenus)
                .WithMany(r => r.Roles)
                .Map(m =>
                {
                    m.MapLeftKey("RoleId");
                    m.MapRightKey("MenuId");
                    m.ToTable("RoleMenu");
                });


            // Table & Column Mappings
            this.ToTable("Role");
            this.Property(t => t.RoleId).HasColumnName("RoleId");
            this.Property(t => t.ParentId).HasColumnName("ParentId");
            this.Property(t => t.FullName).HasColumnName("FullName");
            this.Property(t => t.Category).HasColumnName("Category");
            this.Property(t => t.Description).HasColumnName("Description");
            this.Property(t => t.Enabled).HasColumnName("Enabled");
            this.Property(t => t.SortCode).HasColumnName("SortCode");
            this.Property(t => t.DeleteMark).HasColumnName("DeleteMark");
            this.Property(t => t.DepartmentId).HasColumnName("DepartmentId");

        }
    }
}
