using Microsoft.EntityFrameworkCore;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Repository
{
    public partial class OpenAuthDBContext : DbContext
    {
        

        public virtual DbSet<Application> Applications { get; set; }
        public virtual DbSet<Category> Categorys { get; set; }
        public virtual DbSet<CategoryType> CategoryTypes { get; set; }
        public virtual DbSet<FlowInstance> FlowInstances { get; set; }
        public virtual DbSet<FlowInstanceOperationHistory> FlowInstanceOperationHistorys { get; set; }
        public virtual DbSet<FlowInstanceTransitionHistory> FlowInstanceTransitionHistorys { get; set; }
        public virtual DbSet<FlowScheme> FlowSchemes { get; set; }
        public virtual DbSet<Form> Forms { get; set; }
        public virtual DbSet<Module> Modules { get; set; }
        public virtual DbSet<ModuleElement> ModuleElements { get; set; }
        public virtual DbSet<Org> Orgs { get; set; }
        public virtual DbSet<Relevance> Relevances { get; set; }
        public virtual DbSet<Resource> Resources { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<Stock> Stocks { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000;Integrated Security=True");
            }
        }

    }
}
