using System;
using Microsoft.Extensions.Configuration;

namespace Infrastructure.Helpers
{
    public class ConfigHelper
    {
        public static IConfigurationRoot GetConfigRoot()
        {
            var configurationBuilder = new ConfigurationBuilder();
            configurationBuilder.SetBasePath(System.IO.Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddJsonFile(
                    $"appsettings.{Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Development"}.json",
                    optional: true)
                .AddEnvironmentVariables();

            var configuration = configurationBuilder.Build();
            return configuration;
        }
    }
}