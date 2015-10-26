using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class PageElementMap : EntityTypeConfiguration<PageElement>
    {
        public PageElementMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.DomId)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Name)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Remark)
                .IsRequired()
                .HasMaxLength(4000);

            // Table & Column Mappings
            this.ToTable("PageElement");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.DomId).HasColumnName("DomId");
            this.Property(t => t.Name).HasColumnName("Name");
            this.Property(t => t.Type).HasColumnName("Type");
            this.Property(t => t.ModuleId).HasColumnName("ModuleId");
            this.Property(t => t.Remark).HasColumnName("Remark");
        }
    }
}
