using System;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Jobs;
using OpenAuth.Repository.Domain;
using Quartz;

namespace OpenAuth.App.Extensions
{
    /// <summary>
    /// 定时任务扩展
    /// </summary>
    public static class OpenJobExt
    {
        /// <summary>
        /// 启动定时任务
        /// </summary>
        /// <param name="job"></param>
        /// <param name="scheduler">一个Quartz Scheduler</param>
        public static void Start(this OpenJob job, IScheduler scheduler)
        {
            JobBuilder jobBuilder = null;
            if (job.JobType == 1)
            {
                jobBuilder = JobBuilder.Create<HttpPostJob>();
            }
            else
            {
                var jobBuilderType = typeof(JobBuilder);
                var method = jobBuilderType.GetMethods().FirstOrDefault(
                        x => x.Name.Equals("Create", StringComparison.OrdinalIgnoreCase) &&
                             x.IsGenericMethod && x.GetParameters().Length == 0)
                    ?.MakeGenericMethod(Type.GetType(job.JobCall));
                jobBuilder = (JobBuilder) method.Invoke(null, null);
            }
            
            IJobDetail jobDetail = jobBuilder.WithIdentity(job.Id).Build();
            jobDetail.JobDataMap[Define.JOBMAPKEY] = job.Id; //传递job信息
            ITrigger trigger = TriggerBuilder.Create()
                .WithCronSchedule(job.Cron)
                .WithIdentity(job.Id)
                .StartNow()
                .Build();
            scheduler.ScheduleJob(jobDetail, trigger);
        }
        
        /// <summary>
        /// 停止一个定时任务
        /// </summary>
        /// <param name="job"></param>
        /// <param name="scheduler"></param>
        public static void Stop(this OpenJob job, IScheduler scheduler)
        {
            TriggerKey triggerKey = new TriggerKey(job.Id);
            // 停止触发器
            scheduler.PauseTrigger(triggerKey);
            // 移除触发器
            scheduler.UnscheduleJob(triggerKey);
            // 删除任务
            scheduler.DeleteJob(new JobKey(job.Id));
        }
    }
}