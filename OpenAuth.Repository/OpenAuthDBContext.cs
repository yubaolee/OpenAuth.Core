using System;
using Infrastructure;
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
            string tenantId = "OpenAuthDBContext";
            
            if (_httpContextAccessor != null && _httpContextAccessor.HttpContext != null)
            {
                //读取多租户ID
                var httpTenantId = _httpContextAccessor.HttpContext.Request.Query[Define.TENANT_ID];
                if (string.IsNullOrEmpty(httpTenantId))
                {
                    httpTenantId = _httpContextAccessor.HttpContext.Request.Headers[Define.TENANT_ID];
                }
                
                //如果没有租户id，或租户用的是默认的OpenAuthDBContext,则不做任何调整
                if (!string.IsNullOrEmpty(httpTenantId))
                {
                    tenantId = httpTenantId;
                }
            }
            
            string connect = _configuration.GetConnectionString(tenantId);
            if (string.IsNullOrEmpty(connect))
            {
                throw new Exception($"未能找到租户{tenantId}对应的连接字符串信息");
            }

            //这个地方如果用IOption，在单元测试的时候会获取不到AppSetting的值😅
           var dbType = _configuration.GetSection("AppSetting")["DbType"];
           if (dbType == Define.DBTYPE_SQLSERVER)
           {
               optionsBuilder.UseSqlServer(connect);
            }
            else  //mysql
           {
               optionsBuilder.UseMySql(connect);
           }

        }

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
        public virtual DbSet<BuilderTable> BuilderTables { get; set; }
        public virtual DbSet<BuilderTableColumn> BuilderTableColumns { get; set; }
        //非数据库表格
        public virtual DbQuery<SysTableColumn> SysTableColumns { get; set; }

    }
}
