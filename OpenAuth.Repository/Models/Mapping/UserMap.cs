using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
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
