using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Infrastructure.Mapping
{
    public class MenuMap : EntityTypeConfiguration<Menu>
    {
        public MenuMap()
        {
            // Primary Key
            this.HasKey(t => t.MenuId);

            // Properties
            this.Property(t => t.MenuId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.ParentId)
                .HasMaxLength(50);

            this.Property(t => t.FullName)
                .HasMaxLength(50);

            this.Property(t => t.Description)
                .HasMaxLength(200);

            this.Property(t => t.Img)
                .HasMaxLength(50);

            this.Property(t => t.NavigateUrl)
                .HasMaxLength(200);

            this.Property(t => t.FormName)
                .HasMaxLength(200);

            this.Property(t => t.Target)
                .HasMaxLength(50);

            // Table & Column Mappings
            this.ToTable("Menu");
            this.Property(t => t.MenuId).HasColumnName("MenuId");
            this.Property(t => t.ParentId).HasColumnName("ParentId");
            this.Property(t => t.FullName).HasColumnName("FullName");
            this.Property(t => t.Description).HasColumnName("Description");
            this.Property(t => t.Img).HasColumnName("Img");
            this.Property(t => t.Category).HasColumnName("Category");
            this.Property(t => t.NavigateUrl).HasColumnName("NavigateUrl");
            this.Property(t => t.FormName).HasColumnName("FormName");
            this.Property(t => t.Target).HasColumnName("Target");
            this.Property(t => t.IsUnfold).HasColumnName("IsUnfold");
            this.Property(t => t.Enabled).HasColumnName("Enabled");
            this.Property(t => t.SortCode).HasColumnName("SortCode");
        }
    }
}
