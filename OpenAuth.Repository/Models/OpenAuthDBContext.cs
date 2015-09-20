using System.Data.Entity;
using OpenAuth.Domain;
using OpenAuth.Repository.Models.Mapping;

namespace OpenAuth.Repository.Models
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
        public DbSet<MenuButton> MenuButtons { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<RoleMenu> RoleMenus { get; set; }
        public DbSet<RoleMenuButton> RoleMenuButtons { get; set; }
        public DbSet<sysdiagram> sysdiagrams { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserDepartment> UserDepartments { get; set; }
        public DbSet<UserRole> UserRoles { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new ButtonMap());
            modelBuilder.Configurations.Add(new DataPermissionMap());
            modelBuilder.Configurations.Add(new DepartmentMap());
            modelBuilder.Configurations.Add(new MenuMap());
            modelBuilder.Configurations.Add(new MenuButtonMap());
            modelBuilder.Configurations.Add(new RoleMap());
            modelBuilder.Configurations.Add(new RoleMenuMap());
            modelBuilder.Configurations.Add(new RoleMenuButtonMap());
            modelBuilder.Configurations.Add(new sysdiagramMap());
            modelBuilder.Configurations.Add(new UserMap());
            modelBuilder.Configurations.Add(new UserDepartmentMap());
            modelBuilder.Configurations.Add(new UserRoleMap());
        }
    }
}
