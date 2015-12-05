using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class ModuleElementMap : EntityTypeConfiguration<ModuleElement>
    {
        public ModuleElementMap()
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

            this.Property(t => t.Attr)
                .IsRequired()
                .HasMaxLength(500);

            this.Property(t => t.Script)
                .IsRequired()
                .HasMaxLength(500);

            this.Property(t => t.Icon)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Class)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Remark)
                .IsRequired()
                .HasMaxLength(200);

            // Table & Column Mappings
            this.ToTable("ModuleElement");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.DomId).HasColumnName("DomId");
            this.Property(t => t.Name).HasColumnName("Name");
            this.Property(t => t.Type).HasColumnName("Type");
            this.Property(t => t.ModuleId).HasColumnName("ModuleId");
            this.Property(t => t.Attr).HasColumnName("Attr");
            this.Property(t => t.Script).HasColumnName("Script");
            this.Property(t => t.Icon).HasColumnName("Icon");
            this.Property(t => t.Class).HasColumnName("Class");
            this.Property(t => t.Remark).HasColumnName("Remark");
        }
    }
}
