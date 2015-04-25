using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;
using OpenAuth.Domain.Model;

namespace OpenAuth.Infrastructure.Mapping
{
    public class RoleMenuButtonMap : EntityTypeConfiguration<RoleMenuButton>
    {
        public RoleMenuButtonMap()
        {
            // Primary Key
            this.HasKey(t => t.RoleMenuButtonId);

            // Properties
            this.Property(t => t.RoleMenuButtonId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.RoleId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.MenuId)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.ButtonId)
                .IsRequired()
                .HasMaxLength(50);

            // Table & Column Mappings
            this.ToTable("RoleMenuButton");
            this.Property(t => t.RoleMenuButtonId).HasColumnName("RoleMenuButtonId");
            this.Property(t => t.RoleId).HasColumnName("RoleId");
            this.Property(t => t.MenuId).HasColumnName("MenuId");
            this.Property(t => t.ButtonId).HasColumnName("ButtonId");

            // Relationships
            this.HasRequired(t => t.Button)
                .WithMany(t => t.RoleMenuButtons)
                .HasForeignKey(d => d.ButtonId);
            this.HasRequired(t => t.Menu)
                .WithMany(t => t.RoleMenuButtons)
                .HasForeignKey(d => d.MenuId);
            this.HasRequired(t => t.Role)
                .WithMany(t => t.RoleMenuButtons)
                .HasForeignKey(d => d.RoleId);

        }
    }
}
