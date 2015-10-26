using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class ModuleRoleMap : EntityTypeConfiguration<ModuleRole>
    {
        public ModuleRoleMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Id)
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.None);

            // Table & Column Mappings
            this.ToTable("ModuleRole");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.RoleId).HasColumnName("RoleId");
            this.Property(t => t.ModuleId).HasColumnName("ModuleId");
            this.Property(t => t.Type).HasColumnName("Type");
            this.Property(t => t.OperateTime).HasColumnName("OperateTime");
            this.Property(t => t.OperatorId).HasColumnName("OperatorId");
        }
    }
}
