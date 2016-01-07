using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using OpenAuth.Domain;

namespace OpenAuth.Repository.Models.Mapping
{
    public class UserExtMap : EntityTypeConfiguration<UserExt>
    {
        public UserExtMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Email)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Phone)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Mobile)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Address)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Zip)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Birthday)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.IdCard)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Qq)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.DynamicField)
                .IsRequired()
                .HasMaxLength(4000);

            this.Property(t => t.Remark)
                .IsRequired()
                .HasMaxLength(4000);

            this.Property(t => t.Field1)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Field2)
                .IsRequired()
                .HasMaxLength(255);

            this.Property(t => t.Field3)
                .IsRequired()
                .HasMaxLength(255);

            // Table & Column Mappings
            this.ToTable("UserExt");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.Email).HasColumnName("Email");
            this.Property(t => t.Phone).HasColumnName("Phone_");
            this.Property(t => t.Mobile).HasColumnName("Mobile");
            this.Property(t => t.Address).HasColumnName("Address");
            this.Property(t => t.Zip).HasColumnName("Zip");
            this.Property(t => t.Birthday).HasColumnName("Birthday");
            this.Property(t => t.IdCard).HasColumnName("IdCard");
            this.Property(t => t.Qq).HasColumnName("QQ");
            this.Property(t => t.DynamicField).HasColumnName("DynamicField");
            this.Property(t => t.ByteArrayId).HasColumnName("ByteArrayId");
            this.Property(t => t.Remark).HasColumnName("Remark");
            this.Property(t => t.Field1).HasColumnName("Field1");
            this.Property(t => t.Field2).HasColumnName("Field2");
            this.Property(t => t.Field3).HasColumnName("Field3");
        }
    }
}
