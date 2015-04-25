using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;
using OpenAuth.Domain.Model;

namespace OpenAuth.Infrastructure.Mapping
{
    public class ButtonMap : EntityTypeConfiguration<Button>
    {
        public ButtonMap()
        {
            // Primary Key
            this.HasKey(t => t.ButtonId);

            // Properties
            this.Property(t => t.ButtonId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.FullName)
                .HasMaxLength(50);

            this.Property(t => t.Img)
                .HasMaxLength(50);

            this.Property(t => t.Event)
                .HasMaxLength(200);

            this.Property(t => t.Control_ID)
                .HasMaxLength(50);

            this.Property(t => t.Category)
                .HasMaxLength(50);

            this.Property(t => t.Description)
                .HasMaxLength(200);

            // Table & Column Mappings
            this.ToTable("Button");
            this.Property(t => t.ButtonId).HasColumnName("ButtonId");
            this.Property(t => t.FullName).HasColumnName("FullName");
            this.Property(t => t.Img).HasColumnName("Img");
            this.Property(t => t.Event).HasColumnName("Event");
            this.Property(t => t.Control_ID).HasColumnName("Control_ID");
            this.Property(t => t.Category).HasColumnName("Category");
            this.Property(t => t.Description).HasColumnName("Description");
            this.Property(t => t.Enabled).HasColumnName("Enabled");
            this.Property(t => t.SortCode).HasColumnName("SortCode");
        }
    }
}
