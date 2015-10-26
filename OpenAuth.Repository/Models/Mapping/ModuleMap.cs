using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class ModuleMap : EntityTypeConfiguration<Module>
    {
        public ModuleMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.CascadeId)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Name)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Url)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.HotKey)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.IconName)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.ParentName)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Vector)
                .IsRequired()
                .HasMaxLength(255);

            // Table & Column Mappings
            this.ToTable("Module");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.CascadeId).HasColumnName("CascadeId");
            this.Property(t => t.Name).HasColumnName("Name");
            this.Property(t => t.Url).HasColumnName("Url");
            this.Property(t => t.HotKey).HasColumnName("HotKey");
            this.Property(t => t.ParentId).HasColumnName("ParentId");
            this.Property(t => t.IsLeaf).HasColumnName("IsLeaf");
            this.Property(t => t.IsAutoExpand).HasColumnName("IsAutoExpand");
            this.Property(t => t.IconName).HasColumnName("IconName");
            this.Property(t => t.Status).HasColumnName("Status");
            this.Property(t => t.ParentName).HasColumnName("ParentName");
            this.Property(t => t.Vector).HasColumnName("Vector");
            this.Property(t => t.SortNo).HasColumnName("SortNo");
        }
    }
}
