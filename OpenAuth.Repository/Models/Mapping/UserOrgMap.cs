using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class UserOrgMap : EntityTypeConfiguration<UserOrg>
    {
        public UserOrgMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Id)
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.None);

            // Table & Column Mappings
            this.ToTable("UserOrg");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.OrgId).HasColumnName("OrgId");
            this.Property(t => t.UserId).HasColumnName("UserId");
            this.Property(t => t.OperateTime).HasColumnName("OperateTime");
            this.Property(t => t.OperatorId).HasColumnName("OperatorId");
        }
    }
}
