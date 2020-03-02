using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Reflection;
using Autofac.Extensions.DependencyInjection;
using IdentityServer4.AccessTokenValidation;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Options;
using OpenAuth.App;
using OpenAuth.Repository;
using OpenAuth.WebApi.Model;
using Swashbuckle.AspNetCore.Swagger;

namespace OpenAuth.WebApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration, IOptions<AppSetting> appConfiguration)
        {
            Configuration = configuration;
            _appConfiguration = appConfiguration;
        }

        public IConfiguration Configuration { get; }
        public IOptions<AppSetting> _appConfiguration;

        // This method gets called by the runtime. Use this method to add services to the container.
        public IServiceProvider ConfigureServices(IServiceCollection services)
        {
            var identityServer = ((ConfigurationSection)Configuration.GetSection("AppSetting:IdentityServerUrl")).Value;
            if (!string.IsNullOrEmpty(identityServer))
            {
                services.AddAuthorization();

                services.AddAuthentication(IdentityServerAuthenticationDefaults.AuthenticationScheme)
                    .AddJwtBearer(options =>
                    {
                        options.Authority = identityServer;
                        options.RequireHttpsMetadata = false;  // 指定是否为HTTPS
                        options.Audience = "openauthapi";
                    });
            }
          

            services.AddSwaggerGen(option =>
            {
                option.SwaggerDoc("v1", new Swashbuckle.AspNetCore.Swagger.Info
                {
                    Version = "v1",
                    Title = " OpenAuth.WebApi",
                    Description = "by yubaolee"
                });

                foreach (var name in Directory.GetFiles(AppContext.BaseDirectory, "*.XML",
                    SearchOption.AllDirectories))
                {
                    option.IncludeXmlComments(name);
                }

                option.OperationFilter<GlobalHttpHeaderOperationFilter>(); // 添加httpHeader参数

                if (!string.IsNullOrEmpty(identityServer))
                {
                    //接入identityserver
                    option.AddSecurityDefinition("oauth2", new OAuth2Scheme
                    {
                        Flow = "implicit", // 只需通过浏览器获取令牌（适用于swagger）
                        AuthorizationUrl = $"{identityServer}/connect/authorize",//获取登录授权接口
                        Scopes = new Dictionary<string, string> {
                            { "openauthapi", "同意openauth.webapi 的访问权限" }//指定客户端请求的api作用域。 如果为空，则客户端无法访问
                        }
                    });
                    option.OperationFilter<AuthResponsesOperationFilter>();
                }

                
            });
            services.Configure<AppSetting>(Configuration.GetSection("AppSetting"));
            services.AddMvc(config =>
            {
                config.Filters.Add<OpenAuthFilter>();
            }).AddControllersAsServices().SetCompatibilityVersion(CompatibilityVersion.Latest);
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

            services.AddHttpClient();

            services.AddDataProtection().PersistKeysToFileSystem(new DirectoryInfo(Configuration["DataProtection"]));


            return new AutofacServiceProvider(AutofacExt.InitAutofac(services));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            //可以访问根目录下面的静态文件
            var staticfile = new StaticFileOptions {FileProvider = new PhysicalFileProvider(AppContext.BaseDirectory) };
            app.UseStaticFiles(staticfile);

            //todo:测试可以允许任意跨域，正式环境要加权限
            app.UseCors(builder => builder.AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader());


            app.UseAuthentication();
            
            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "api/{controller=Home}/{action=Index}/{id?}");
            });

            app.UseSwagger();

            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.), 
            // specifying the Swagger JSON endpoint.
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "V1 Docs");
                c.DocExpansion(DocExpansion.None);
                c.OAuthClientId("OpenAuth.WebApi");  //oauth客户端名称
                c.OAuthAppName("客户端为OpenAuth.WebApi"); // 描述
            });

        }
    }
}
