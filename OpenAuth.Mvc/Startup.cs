using System;
using System.IO;
using System.Linq;
using Autofac;
using Infrastructure;
using Infrastructure.Extensions.AutofacManager;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using OpenAuth.App;
using OpenAuth.App.HostedService;
using OpenAuth.Mvc.Models;
using OpenAuth.Repository;
using SqlSugar;

namespace OpenAuth.Mvc
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //在startup中需要强制创建log4net
            var loggerFactory = LoggerFactory.Create(builder =>
            {
                builder.AddLog4Net();
            });
            ILogger logger = loggerFactory.CreateLogger<Startup>();
            var identityServer = ((ConfigurationSection)Configuration.GetSection("AppSetting:IdentityServerUrl")).Value;
            if (!string.IsNullOrEmpty(identityServer))
            {
             System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();

             services.AddAuthentication(options =>
                 {
                     options.DefaultScheme = "Cookies";
                     options.DefaultChallengeScheme = "oidc";
                 })
                 .AddCookie("Cookies")
                    .AddOpenIdConnect("oidc", options =>
                    {
                        options.Authority = identityServer;
                        options.RequireHttpsMetadata = false;

                        options.ClientId = "OpenAuth.Mvc";
                        options.SaveTokens = true;
                        options.TokenValidationParameters = new TokenValidationParameters
                        {
                            NameClaimType = "name",
                            RoleClaimType = "role",
                        };
                        
                        options.NonceCookie.SameSite = SameSiteMode.Unspecified;
                        options.CorrelationCookie.SameSite = SameSiteMode.Unspecified;
                    });
            }

            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                //关闭GDPR规范
                options.CheckConsentNeeded = (HttpContext context) => false;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });

            
            services.AddControllersWithViews(option =>
            {
                option.Filters.Add< OpenAuthFilter>();
                option.ModelBinderProviders.Insert(0, new JsonBinderProvider());
            });

            services.AddMemoryCache();
            services.AddOptions();

            services.AddRouting(options => options.LowercaseUrls = false);

            //映射配置文件
            services.Configure<AppSetting>(Configuration.GetSection("AppSetting"));

            //在startup里面只能通过这种方式获取到appsettings里面的值，不能用IOptions😰
            var dbtypes = ((ConfigurationSection)Configuration.GetSection("AppSetting:DbTypes")).GetChildren()
                .ToDictionary(x => x.Key, x => x.Value);
            var connectionString = Configuration.GetConnectionString("OpenAuthDBContext");
            logger.LogInformation($"系统配置的数据库类型：{JsonHelper.Instance.Serialize(dbtypes)}，连接字符串：{connectionString}");

            services.AddDbContext<OpenAuthDBContext>();

            services.AddHttpClient();
            
            var sqlsugarTypes = UtilMethods.EnumToDictionary<SqlSugar.DbType>();
            var dbType = sqlsugarTypes.FirstOrDefault(it =>
                dbtypes.ToDictionary(u => u.Key, v => v.Value.ToLower()).ContainsValue(it.Key));

            services.AddScoped<ISqlSugarClient>(s =>
            {
                var sqlSugar = new SqlSugarClient(new ConnectionConfig()
                {
                    DbType = dbType.Value,
                    ConnectionString = connectionString,
                    IsAutoCloseConnection = true
                }, db => { db.Aop.OnLogExecuting = (sql, pars) => { logger.LogInformation(sql); }; });

                 if(dbType.Value != SqlSugar.DbType.PostgreSQL){
                    return sqlSugar;
                }

                // 配置bool类型转换为smallint
                sqlSugar.Aop.OnExecutingChangeSql = (sql, parameters) =>
                {
                    foreach (var param in parameters)
                    {
                        if (param.Value is bool boolValue)
                        {
                            param.DbType = System.Data.DbType.Int16;
                            // 将 bool 转换为 smallint
                            param.Value = boolValue ? (short)1 : (short)0;
                        }
                    }
                    // 返回修改后的 SQL 和参数
                    return new System.Collections.Generic.KeyValuePair<string, SugarParameter[]>(sql, parameters);
                };
                return sqlSugar;
            });
            
            //设置定时启动的任务
            services.AddHostedService<QuartzService>();
        }
        
        public void ConfigureContainer(ContainerBuilder builder)
        {
            AutofacExt.InitAutofac(builder);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddLog4Net();
            
            app.UseAuthentication();
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // 生产环境开启HSTS
                // app.UseHsts();
            }

            app.UseStaticFiles();
            
            //配置ServiceProvider
            AutofacContainerModule.ConfigServiceProvider(app.ApplicationServices);

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
            
        }
    }
}
