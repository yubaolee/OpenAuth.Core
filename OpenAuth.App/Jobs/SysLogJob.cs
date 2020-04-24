using System;
using System.Threading.Tasks;
using OpenAuth.Repository.Domain;
using Quartz;

namespace OpenAuth.App.Jobs
{
    public class SysLogJob : IJob
    {
        private SysLogApp _sysLogApp;

        public SysLogJob(SysLogApp sysLogApp)
        {
            _sysLogApp = sysLogApp;
        }

        public Task Execute(IJobExecutionContext context)
        {
            _sysLogApp.Add(new SysLog
            {
                TypeName = "定时任务",
                TypeId = "AUTOJOB",
                Content = "这是一个定时任务"
            });
            Console.WriteLine("这是自动任务");
            return Task.Delay(1);
        }
    }
}