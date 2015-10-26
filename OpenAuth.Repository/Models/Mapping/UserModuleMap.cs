using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class UserModuleMap : EntityTypeConfiguration<UserModule>
    {
        public UserModuleMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            // Table & Column Mappings
            this.ToTable("UserModule");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.UserId).HasColumnName("UserId");
            this.Property(t => t.ModuleId).HasColumnName("ModuleId");
            this.Property(t => t.Type).HasColumnName("Type");
            this.Property(t => t.OperateTime).HasColumnName("OperateTime");
            this.Property(t => t.OperatorId).HasColumnName("OperatorId");
        }
    }
}
