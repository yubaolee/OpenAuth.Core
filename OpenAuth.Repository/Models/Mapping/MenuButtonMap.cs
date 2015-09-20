using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class MenuButtonMap : EntityTypeConfiguration<MenuButton>
    {
        public MenuButtonMap()
        {
            // Primary Key
            this.HasKey(t => t.MenuButtonId);

            // Properties
            this.Property(t => t.MenuButtonId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.MenuId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.ButtonId)
                .IsRequired()
                .HasMaxLength(50);

            // Table & Column Mappings
            this.ToTable("MenuButton");
            this.Property(t => t.MenuButtonId).HasColumnName("MenuButtonId");
            this.Property(t => t.MenuId).HasColumnName("MenuId");
            this.Property(t => t.ButtonId).HasColumnName("ButtonId");
        }
    }
}
