using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;
using OpenAuth.Domain.Model;

namespace OpenAuth.Infrastructure.Mapping
{
    public class UserMap : EntityTypeConfiguration<User>
    {
        public UserMap()
        {
            // Primary Key
            this.HasKey(t => t.UserId);

            // Properties
            this.Property(t => t.UserId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.Account)
                .HasMaxLength(50);

            this.Property(t => t.Password)
                .HasMaxLength(50);

            this.Property(t => t.RealName)
                .HasMaxLength(50);

            this.Property(t => t.RoleId)
                .HasMaxLength(50);

            this.HasMany(u => u.Departments)
                .WithMany(d => d.Users)
                .Map(m =>
                {
                    m.MapLeftKey("UserId");
                    m.MapRightKey("DepartmentId");
                    m.ToTable("UserDepartment");
                });

            this.HasMany(u => u.Roles)
                .WithMany(r => r.Users)
                .Map(m =>
                {
                    m.MapLeftKey("UserId");
                    m.MapRightKey("RoleId");
                    m.ToTable("UserRole");
                });

            //д╛хо╫ги╚
            this.HasOptional(u => u.DefaultRole)
                .WithMany()
                .HasForeignKey(u =>u.RoleId);

            // Table & Column Mappings
            this.ToTable("User");
            this.Property(t => t.UserId).HasColumnName("UserId");
            this.Property(t => t.Account).HasColumnName("Account");
            this.Property(t => t.Password).HasColumnName("Password");
            this.Property(t => t.RealName).HasColumnName("RealName");
            this.Property(t => t.RoleId).HasColumnName("RoleId");
            this.Property(t => t.Enabled).HasColumnName("Enabled");
            this.Property(t => t.DeleteMark).HasColumnName("DeleteMark");

            
        }
    }
}
