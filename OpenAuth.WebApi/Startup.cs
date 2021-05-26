using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Autofac;
using IdentityServer4.AccessTokenValidation;
using Infrastructure;
using Infrastructure.Extensions.AutofacManager;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json;
using OpenAuth.App;

using OpenAuth.App.HostedService;
using OpenAuth.Repository;
using OpenAuth.WebApi.Model;
using Swashbuckle.AspNetCore.SwaggerUI;


namespace OpenAuth.WebApi
{
    public class Startup
    {
        public IHostEnvironment Environment { get; }
        public IConfiguration Configuration { get; }

        public Startup(IConfiguration configuration, IHostEnvironment environment)
        {
            Configuration = configuration;
            Environment = environment;
        }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
           services.Configure<ApiBehaviorOptions>(options =>
           {
               options.SuppressModelStateInvalidFilter = true;
           });
            
            services.AddSingleton(provider =>
            {
                var service = provider.GetRequiredService<ILogger<StartupLogger>>();
                return new StartupLogger(service);
            });
            var logger = services.BuildServiceProvider().GetRequiredService<StartupLogger>();
            
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
                option.SwaggerDoc("v1", new OpenApiInfo
                {
                    Version = "v1",
                    Title = " OpenAuth.WebApi",
                    Description = "by yubaolee"
                });
                
                logger.LogInformation($"api doc basepath:{AppContext.BaseDirectory}");
                foreach (var name in Directory.GetFiles(AppContext.BaseDirectory, "*.*",
                    SearchOption.AllDirectories).Where(f =>Path.GetExtension(f).ToLower() == ".xml"))
                {
                    option.IncludeXmlComments(name,includeControllerXmlComments:true);
                    // logger.LogInformation($"find api file{name}");
                }

                option.OperationFilter<GlobalHttpHeaderOperationFilter>(); // 添加httpHeader参数

                if (!string.IsNullOrEmpty(identityServer))
                {
                    //接入identityserver
                    option.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
                    {
                        Type = SecuritySchemeType.OAuth2,
                        Description = "OAuth2登陆授权",
                        Flows = new OpenApiOAuthFlows
                        {
                            Implicit = new OpenApiOAuthFlow
                            {
                                AuthorizationUrl = new Uri($"{identityServer}/connect/authorize"),
                                Scopes = new Dictionary<string, string>
                                {
                                    { "openauthapi", "同意openauth.webapi 的访问权限" }//指定客户端请求的api作用域。 如果为空，则客户端无法访问
                                }
                            }
                        }
                    });
                    option.OperationFilter<AuthResponsesOperationFilter>();
                }

                
            });
            services.Configure<AppSetting>(Configuration.GetSection("AppSetting"));
            services.AddControllers(option =>
            {
                option.Filters.Add< OpenAuthFilter>();
            }).AddNewtonsoftJson(options =>
            {
                //忽略循环引用
                options.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                //不使用驼峰样式的key
                //options.SerializerSettings.ContractResolver = new DefaultContractResolver();    
                options.SerializerSettings.DateFormatString = "yyyy-MM-dd HH:mm:ss";
            });
            services.AddMemoryCache();
            services.AddCors();
//          todo:如果正式 环境请用下面的方式限制随意访问跨域
//            var origins = new []
//            {
//                "http://localhost:1803",
//                "http://localhost:52789"
//            };
//            if (Environment.IsProduction())
//            {
//                origins = new []
//                {
//                    "http://demo.openauth.me:1803",
//                    "http://demo.openauth.me:52789"
//                };
//            }
//            services.AddCors(option=>option.AddPolicy("cors", policy =>
//                policy.AllowAnyHeader().AllowAnyMethod().AllowCredentials().WithOrigins(origins)));

            //在startup里面只能通过这种方式获取到appsettings里面的值，不能用IOptions😰
            var dbType = ((ConfigurationSection)Configuration.GetSection("AppSetting:DbType")).Value;
            var connectionString = Configuration.GetConnectionString("OpenAuthDBContext");
            logger.LogInformation($"当前数据库类型：{dbType}，连接字符串：{connectionString}");
            services.AddDbContext<OpenAuthDBContext>();

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
        public void Configure(IApplicationBuilder app, IHostEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddLog4Net();
            
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
            
            app.UseRouting();
            app.UseAuthentication();
            
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
            
            //配置ServiceProvider
            AutofacContainerModule.ConfigServiceProvider(app.ApplicationServices);

          app.UseSwagger();

            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.), 
            // specifying the Swagger JSON endpoint.
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "V1 Docs");
                c.DocExpansion(DocExpansion.None);
                c.OAuthClientId("OpenAuth.WebApi");  //oauth客户端名称
                c.OAuthAppName("开源版webapi认证"); // 描述
            });

        }
    }
}
