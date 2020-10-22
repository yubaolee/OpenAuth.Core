using System.Threading.Tasks;
using Quartz;

namespace OpenAuth.App.Jobs
{
    public class SysLogJob : IJob
    {
        private SysLogApp _sysLogApp;
        private OpenJobApp _openJobApp;

        public SysLogJob(SysLogApp sysLogApp, OpenJobApp openJobApp)
        {
            _sysLogApp = sysLogApp;
            _openJobApp = openJobApp;
        }

        public Task Execute(IJobExecutionContext context)
        {
            var jobId = context.MergedJobDataMap.GetString(Define.JOBMAPKEY);
            //todo:这里可以加入自己的自动任务逻辑
            _openJobApp.RecordRun(jobId);
            return Task.Delay(1);
        }
    }
}