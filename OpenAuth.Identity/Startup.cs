using System;
using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using OpenAuth.App;
using OpenAuth.Repository;

namespace OpenAuth.IdentityServer
{
    public class Startup
    {
        public IHostingEnvironment Environment { get; }
        public Startup(IConfiguration configuration, IOptions<AppSetting> appConfiguration, IHostingEnvironment environment)
        {
            Configuration = configuration;
            _appConfiguration = appConfiguration;
            Environment = environment;
        }

        public IConfiguration Configuration { get; }
        public IOptions<AppSetting> _appConfiguration;

        public IServiceProvider ConfigureServices(IServiceCollection services)
        {
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
            //services.AddIdentity<ApplicationUser, Role>().AddUserStore<CustomUserStore>()
            //    .AddDefaultTokenProviders();
            //services.AddTransient<IRoleStore<Role>, CustomRoleStore>();

            var builder = services.AddIdentityServer()
                .AddInMemoryIdentityResources(Config.GetIdentityResources())
                .AddInMemoryApiResources(Config.GetApis())
                .AddInMemoryClients(Config.GetClients(Environment.IsProduction()))
                .AddProfileService<CustomProfileService>();

            services.AddCors();

            //全部用测试环境，正式环境请参考https://www.cnblogs.com/guolianyu/p/9872661.html
            //if (Environment.IsDevelopment())
            //{
            builder.AddDeveloperSigningCredential();
            //}
            //else
            //{
            //    throw new Exception("need to configure key material");
            //}

            services.Configure<AppSetting>(Configuration.GetSection("AppSetting"));
            services.AddMvc().AddControllersAsServices().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
            services.AddMemoryCache();
            services.AddCors();
            //在startup里面只能通过这种方式获取到appsettings里面的值，不能用IOptions😰
            var dbType = ((ConfigurationSection)Configuration.GetSection("AppSetting:DbType")).Value;
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

            return new AutofacServiceProvider(AutofacExt.InitAutofac(services));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            //todo:测试可以允许任意跨域，正式环境要加权限
            app.UseCors(builder => builder.AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader());

            app.UseStaticFiles();
            app.UseIdentityServer();
            app.UseMvcWithDefaultRoute();
        }
    }
}
