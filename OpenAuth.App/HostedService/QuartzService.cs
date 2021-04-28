using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Quartz;

namespace OpenAuth.App.HostedService
{
    public class QuartzService : IHostedService, IDisposable
    {
        private readonly ILogger<QuartzService> _logger;
        private IScheduler _scheduler;
        private OpenJobApp _openJobApp;

        public QuartzService(ILogger<QuartzService> logger, IScheduler scheduler, OpenJobApp openJobApp)
        {
            _logger = logger;
            _scheduler = scheduler;
            _openJobApp = openJobApp;
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            _scheduler.Start();
            _openJobApp.StartAll();
            return Task.CompletedTask;
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            _scheduler.Shutdown();
            _logger.LogInformation("关闭定时job");
            return Task.CompletedTask;
        }

        public void Dispose()
        {
           
        }
    }
}