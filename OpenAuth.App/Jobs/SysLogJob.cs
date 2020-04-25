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
            var jobdata = (OpenJob)context.Get(Define.JOBMAPKEY);
            _sysLogApp.Add(new SysLog
            {
                TypeName = "定时任务",
                TypeId = "AUTOJOB",
                Content = $"运行了自动任务：{jobdata.JobName}"
            });
            Console.WriteLine("这是自动任务");
            return Task.Delay(1);
        }
    }
}