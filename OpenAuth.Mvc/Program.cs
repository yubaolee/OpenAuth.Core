using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace OpenAuth.Mvc
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureLogging((hostingContext, logging) =>
                {
                    logging.ClearProviders(); //去掉默认的日志
                    logging.AddFilter("System", LogLevel.Error);
                    logging.AddFilter("Microsoft", LogLevel.Error);
                    logging.AddLog4Net();
                })
               .UseServiceProviderFactory(new AutofacServiceProviderFactory())   //将默认ServiceProviderFactory指定为AutofacServiceProviderFactory
                .ConfigureWebHostDefaults(webBuilder =>
            {
                webBuilder.UseUrls("http://*:1802").UseStartup<Startup>();
            });

    }
}
