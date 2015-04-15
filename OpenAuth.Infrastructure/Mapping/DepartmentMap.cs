using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Infrastructure.Mapping
{
    public class DepartmentMap : EntityTypeConfiguration<Department>
    {
        public DepartmentMap()
        {
            // Primary Key
            this.HasKey(t => t.DepartmentId);

            // Properties
            this.Property(t => t.DepartmentId)
                .IsRequired()
                .HasMaxLength(50);

            this.HasMany(d => d.Users)
                .WithMany(u => u.Departments)
                .Map(
                    m =>
                    {
                        m.MapLeftKey("DepartmentId");
                        m.MapRightKey("UserId");
                        m.ToTable("UserDepartment");
                    });

            this.HasMany(d => d.Roles)
                .WithRequired(r => r.Department);

            this.Property(t => t.ParentId)
                .HasMaxLength(50);

            this.Property(t => t.FullName)
                .HasMaxLength(50);

            this.Property(t => t.Description)
                .HasMaxLength(50);

            // Table & Column Mappings
            this.ToTable("Department");
            this.Property(t => t.DepartmentId).HasColumnName("DepartmentId");
            this.Property(t => t.ParentId).HasColumnName("ParentId");
            this.Property(t => t.FullName).HasColumnName("FullName");
            this.Property(t => t.Description).HasColumnName("Description");
            this.Property(t => t.Enabled).HasColumnName("Enabled");
            this.Property(t => t.SortCode).HasColumnName("SortCode");
            this.Property(t => t.DeleteMark).HasColumnName("DeleteMark");
        }
    }
}
