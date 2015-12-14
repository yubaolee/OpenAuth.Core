using System.Data.Entity;
using System.Data.Entity.Infrastructure;
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

        public DbSet<Category> Categories { get; set; }
        public DbSet<DicDetail> DicDetails { get; set; }
        public DbSet<DicIndex> DicIndexes { get; set; }
        public DbSet<Module> Modules { get; set; }
        public DbSet<ModuleElement> ModuleElements { get; set; }
        public DbSet<Org> Orgs { get; set; }
        public DbSet<Param> Params { get; set; }
        public DbSet<Relevance> Relevances { get; set; }
        public DbSet<Resource> Resources { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserCfg> UserCfgs { get; set; }
        public DbSet<UserExt> UserExts { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new CategoryMap());
            modelBuilder.Configurations.Add(new DicDetailMap());
            modelBuilder.Configurations.Add(new DicIndexMap());
            modelBuilder.Configurations.Add(new ModuleMap());
            modelBuilder.Configurations.Add(new ModuleElementMap());
            modelBuilder.Configurations.Add(new OrgMap());
            modelBuilder.Configurations.Add(new ParamMap());
            modelBuilder.Configurations.Add(new RelevanceMap());
            modelBuilder.Configurations.Add(new ResourceMap());
            modelBuilder.Configurations.Add(new RoleMap());
            modelBuilder.Configurations.Add(new UserMap());
            modelBuilder.Configurations.Add(new UserCfgMap());
            modelBuilder.Configurations.Add(new UserExtMap());
        }
    }
}
