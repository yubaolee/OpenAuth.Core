using Microsoft.EntityFrameworkCore;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Repository
{
    public partial class OpenAuthDBContext : DbContext
    {

        public OpenAuthDBContext(DbContextOptions<OpenAuthDBContext> options)
            : base(options)
        {}
        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DataPrivilegeRule>()
                .HasKey(c => new { c.Id });
        }

        public virtual DbSet<Application> Applications { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
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
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UploadFile> UploadFiles { get; set; }

        public virtual DbSet<FrmLeaveReq> FrmLeaveReqs { get; set; }

        public virtual DbSet<SysLog> SysLogs { get; set; }

        public virtual DbSet<SysMessage> SysMessages { get; set; }
        
        public virtual DbSet<DataPrivilegeRule> DataPrivilegeRules { get; set; }
        
        public virtual DbSet<WmsInboundOrderDtbl> WmsInboundOrderDtbls { get; set; }
        public virtual DbSet<WmsInboundOrderTbl> WmsInboundOrderTbls { get; set; }
        public virtual DbSet<OpenJob> OpenJobs { get; set; }
        
        //非数据库表格
        public virtual DbQuery<SysTableColumn> SysTableColumns { get; set; }

    }
}
