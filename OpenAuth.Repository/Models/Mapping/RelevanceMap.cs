using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class RelevanceMap : EntityTypeConfiguration<Relevance>
    {
        public RelevanceMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Description)
                .IsRequired()
                .HasMaxLength(100);

            this.Property(t => t.Key)
                .IsRequired()
                .HasMaxLength(100);

            // Table & Column Mappings
            this.ToTable("Relevance");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.FirstId).HasColumnName("FirstId");
            this.Property(t => t.SecondId).HasColumnName("SecondId");
            this.Property(t => t.Description).HasColumnName("Description");
            this.Property(t => t.Key).HasColumnName("Key");
            this.Property(t => t.Status).HasColumnName("Status");
            this.Property(t => t.OperateTime).HasColumnName("OperateTime");
            this.Property(t => t.OperatorId).HasColumnName("OperatorId");
        }
    }
}
