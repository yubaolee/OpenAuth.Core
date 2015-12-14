using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class DicIndexMap : EntityTypeConfiguration<DicIndex>
    {
        public DicIndexMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Name)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Key)
                .IsRequired()
                .HasMaxLength(100);

            this.Property(t => t.Description)
                .IsRequired()
                .HasMaxLength(200);

            // Table & Column Mappings
            this.ToTable("DicIndex");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.Name).HasColumnName("Name");
            this.Property(t => t.Key).HasColumnName("Key");
            this.Property(t => t.SortNo).HasColumnName("SortNo");
            this.Property(t => t.CategoryId).HasColumnName("CategoryId");
            this.Property(t => t.Description).HasColumnName("Description");
        }
    }
}
