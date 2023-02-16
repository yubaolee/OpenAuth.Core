using System;
using System.Linq;

using Infrastructure;
using Infrastructure.Extensions;
using Infrastructure.Utilities;

using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

using OpenAuth.Repository.Domain;
using OpenAuth.Repository.QueryObj;

namespace OpenAuth.Repository
{

    public partial class OpenAuthDBContext : DbContext
    {

        private ILoggerFactory _LoggerFactory;
        private IHttpContextAccessor _httpContextAccessor;
        private IConfiguration _configuration;
        private IOptions<AppSetting> _appConfiguration;

        public OpenAuthDBContext(DbContextOptions<OpenAuthDBContext> options, ILoggerFactory loggerFactory,
            IHttpContextAccessor httpContextAccessor, IConfiguration configuration, IOptions<AppSetting> appConfiguration)
            : base(options)
        {
            _LoggerFactory = loggerFactory;
            _httpContextAccessor = httpContextAccessor;
            _configuration = configuration;
            _appConfiguration = appConfiguration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.EnableSensitiveDataLogging(true);  //允许打印参数
            optionsBuilder.UseLoggerFactory(_LoggerFactory);
            InitTenant(optionsBuilder);
            base.OnConfiguring(optionsBuilder);
        }

        //初始化多租户信息，根据租户id调整数据库
        private void InitTenant(DbContextOptionsBuilder optionsBuilder)
        {

            var tenantId = _httpContextAccessor.GetTenantId();
            string connect = _configuration.GetConnectionString(tenantId);
            if(string.IsNullOrEmpty(connect))
            {
                throw new Exception($"未能找到租户{tenantId}对应的连接字符串信息");
            }

            //这个地方如果用IOption，在单元测试的时候会获取不到AppSetting的值😅
            var dbtypes = _configuration.GetSection("AppSetting:DbTypes").GetChildren()
                .ToDictionary(x => x.Key, x => x.Value);

            var dbType = dbtypes[tenantId];
            if(dbType == Define.DBTYPE_SQLSERVER)
            {
                optionsBuilder.UseSqlServer(connect);
            }
            else if(dbType == Define.DBTYPE_MYSQL)  //mysql
            {
                optionsBuilder.UseMySql(connect, new MySqlServerVersion(new Version(8, 0, 11)));
            }
            else if(dbType == Define.DBTYPE_PostgreSQL)  //PostgreSQL
            {
                optionsBuilder.UseNpgsql(connect);
            }
            else
            {
                optionsBuilder.UseOracle(connect, options => options.UseOracleSQLCompatibility("11"));
            }

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DataPrivilegeRule>()
                .HasKey(c => new { c.Id });
            modelBuilder.Entity<SysTableColumn>().HasNoKey();
            modelBuilder.Entity<QueryStringObj>().HasNoKey();
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
        public virtual DbSet<SysOrg> Orgs { get; set; }
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
        public virtual DbSet<BuilderTable> BuilderTables { get; set; }
        public virtual DbSet<BuilderTableColumn> BuilderTableColumns { get; set; }
        //非数据库表格
        public virtual DbSet<QueryStringObj> QueryStringObjs { get; set; }
        public virtual DbSet<SysTableColumn> SysTableColumns { get; set; }

    }
}
