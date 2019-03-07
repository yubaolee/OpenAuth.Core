using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Logging;

namespace OpenAuth.WebApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args).ConfigureLogging((hostingContext, logging) =>
                {
                    logging.ClearProviders();  //去掉默认的日志
                   logging.AddFilter("System", LogLevel.Warning);
                    logging.AddFilter("Microsoft", LogLevel.Warning);
                    logging.AddLog4Net();
                })
                .UseUrls("http://*:52789")
                .UseStartup<Startup>();
    }
}
