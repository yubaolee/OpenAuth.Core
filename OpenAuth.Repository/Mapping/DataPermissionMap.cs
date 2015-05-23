using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain.Model;

namespace OpenAuth.Repository.Mapping
{
    public class DataPermissionMap : EntityTypeConfiguration<DataPermission>
    {
        public DataPermissionMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Id)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.RoleId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.ResourceId)
                .HasMaxLength(50);

            // Table & Column Mappings
            this.ToTable("DataPermission");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.RoleId).HasColumnName("RoleId");
            this.Property(t => t.ResourceId).HasColumnName("ResourceId");
            this.Property(t => t.ObjectId).HasColumnName("ObjectId");

            // Relationships
            this.HasRequired(t => t.Role)
                .WithMany(t => t.DataPermissions)
                .HasForeignKey(d => d.RoleId);

        }
    }
}
