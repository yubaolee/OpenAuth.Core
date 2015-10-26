using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class PageMap : EntityTypeConfiguration<Page>
    {
        public PageMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Name)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Url)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Icon)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.IconBig)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Vector)
                .IsRequired()
                .HasMaxLength(255);

            // Table & Column Mappings
            this.ToTable("Page");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.ModuleId).HasColumnName("ModuleId");
            this.Property(t => t.Name).HasColumnName("Name");
            this.Property(t => t.Url).HasColumnName("Url");
            this.Property(t => t.Type).HasColumnName("Type");
            this.Property(t => t.Enabled).HasColumnName("Enabled");
            this.Property(t => t.IsDefault).HasColumnName("IsDefault");
            this.Property(t => t.Icon).HasColumnName("Icon");
            this.Property(t => t.IconBig).HasColumnName("IconBig");
            this.Property(t => t.Vector).HasColumnName("Vector");
            this.Property(t => t.SortNo).HasColumnName("SortNo");
        }
    }
}
