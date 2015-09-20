using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class UserDepartmentMap : EntityTypeConfiguration<UserDepartment>
    {
        public UserDepartmentMap()
        {
            // Primary Key
            this.HasKey(t => t.UserDepartmentId);

            // Properties
            this.Property(t => t.UserDepartmentId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.DepartmentId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.UserId)
                .IsRequired()
                .HasMaxLength(50);

            // Table & Column Mappings
            this.ToTable("UserDepartment");
            this.Property(t => t.UserDepartmentId).HasColumnName("UserDepartmentId");
            this.Property(t => t.DepartmentId).HasColumnName("DepartmentId");
            this.Property(t => t.UserId).HasColumnName("UserId");
        }
    }
}
