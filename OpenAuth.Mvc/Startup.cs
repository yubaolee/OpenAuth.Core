using System.IO;
using Autofac;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using OpenAuth.App;
using OpenAuth.App.HostedService;
using OpenAuth.Mvc.Models;
using OpenAuth.Repository;

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
                    });
            }

            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                //关闭GDPR规范
                options.CheckConsentNeeded = context => false;
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
            var dbType = ((ConfigurationSection) Configuration.GetSection("AppSetting:DbType")).Value;
            if (dbType == Define.DBTYPE_SQLSERVER)
            {
                services.AddDbContext<OpenAuthDBContext>(options =>
                    options.UseSqlServer(Configuration.GetConnectionString("OpenAuthDBContext")));
            }
            else  //mysql
            {
                services.AddDbContext<OpenAuthDBContext>(options =>
                    options.UseMySql(Configuration.GetConnectionString("OpenAuthDBContext")));
            }

            services.AddHttpClient();
            
            services.AddDataProtection().PersistKeysToFileSystem(new DirectoryInfo(Configuration["DataProtection"]));
            
            //设置定时启动的任务
            services.AddHostedService<QuartzService>();
          
        }
        
        public void ConfigureContainer(ContainerBuilder builder)
        {
            AutofacExt.InitAutofac(builder);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostEnvironment env)
        {
            app.UseAuthentication();
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseStaticFiles();

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
