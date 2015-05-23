using System.Data.Entity;
using OpenAuth.Domain.Model;
using OpenAuth.Repository.Mapping;

namespace OpenAuth.Repository
{
    public partial class OpenAuthDBContext : DbContext
    {
        static OpenAuthDBContext()
        {
            Database.SetInitializer<OpenAuthDBContext>(null);
        }

        public OpenAuthDBContext()
            : base("Name=OpenAuthDBContext")
        {
        }

        public DbSet<Button> Buttons { get; set; }
        public DbSet<DataPermission> DataPermissions { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<Menu> Menus { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new ButtonMap());
            modelBuilder.Configurations.Add(new DataPermissionMap());
            modelBuilder.Configurations.Add(new DepartmentMap());
            modelBuilder.Configurations.Add(new MenuMap());
            modelBuilder.Configurations.Add(new RoleMap());
            modelBuilder.Configurations.Add(new UserMap());
        }
    }
}
