using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class UserCfgMap : EntityTypeConfiguration<UserCfg>
    {
        public UserCfgMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Theme)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Skin)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.NavBarStyle)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.TabFocusColor)
                .IsRequired()
                .HasMaxLength(255);

            // Table & Column Mappings
            this.ToTable("UserCfg");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.Theme).HasColumnName("Theme");
            this.Property(t => t.Skin).HasColumnName("Skin");
            this.Property(t => t.NavBarStyle).HasColumnName("NavBarStyle");
            this.Property(t => t.TabFocusColor).HasColumnName("TabFocusColor");
            this.Property(t => t.NavTabIndex).HasColumnName("NavTabIndex");
        }
    }
}
