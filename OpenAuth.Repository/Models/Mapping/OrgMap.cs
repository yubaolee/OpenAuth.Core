using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class OrgMap : EntityTypeConfiguration<Org>
    {
        public OrgMap()
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

            this.Property(t => t.HotKey)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.ParentName)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.IconName)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.BizCode)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.CustomCode)
                .IsRequired()
                .HasMaxLength(4000);

            // Table & Column Mappings
            this.ToTable("Org");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.CascadeId).HasColumnName("CascadeId");
            this.Property(t => t.Name).HasColumnName("Name");
            this.Property(t => t.HotKey).HasColumnName("HotKey");
            this.Property(t => t.ParentId).HasColumnName("ParentId");
            this.Property(t => t.ParentName).HasColumnName("ParentName");
            this.Property(t => t.IsLeaf).HasColumnName("IsLeaf");
            this.Property(t => t.IsAutoExpand).HasColumnName("IsAutoExpand");
            this.Property(t => t.IconName).HasColumnName("IconName");
            this.Property(t => t.Status).HasColumnName("Status");
            this.Property(t => t.Type).HasColumnName("Type");
            this.Property(t => t.BizCode).HasColumnName("BizCode");
            this.Property(t => t.CustomCode).HasColumnName("CustomCode");
            this.Property(t => t.CreateTime).HasColumnName("CreateTime");
            this.Property(t => t.CreateId).HasColumnName("CreateId");
            this.Property(t => t.SortNo).HasColumnName("SortNo");
        }
    }
}
