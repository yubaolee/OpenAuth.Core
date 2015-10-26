using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class RoleMap : EntityTypeConfiguration<Role>
    {
        public RoleMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Name)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.CreateId)
                .IsRequired()
                .HasMaxLength(64);

            this.Property(t => t.CreateOrgCascadeId)
                .IsRequired()
                .HasMaxLength(255);

            // Table & Column Mappings
            this.ToTable("Role");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.Name).HasColumnName("Name");
            this.Property(t => t.Status).HasColumnName("Status");
            this.Property(t => t.Type).HasColumnName("Type");
            this.Property(t => t.CreateTime).HasColumnName("CreateTime");
            this.Property(t => t.CreateId).HasColumnName("CreateId");
            this.Property(t => t.CreateOrgId).HasColumnName("CreateOrgId");
            this.Property(t => t.CreateOrgCascadeId).HasColumnName("CreateOrgCascadeId");
        }
    }
}
