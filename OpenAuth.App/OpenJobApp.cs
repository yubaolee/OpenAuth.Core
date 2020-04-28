using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using Microsoft.Extensions.Logging;
using OpenAuth.App.Interface;
using OpenAuth.App.Jobs;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;
using Quartz;


namespace OpenAuth.App
{
    public class OpenJobApp : BaseApp<OpenJob>
    {
        private SysLogApp _sysLogApp;
        private IScheduler _scheduler;
        private ILogger<OpenJobApp> _logger;

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryOpenJobListReq request)
        {
            var result = new TableData();
            var objs = Repository.Find(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Id.Contains(request.key));
            }

            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit);
            result.count = objs.Count();
            return result;
        }

        public void Add(AddOrUpdateOpenJobReq req)
        {
            var obj = req.MapTo<OpenJob>();
            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            Repository.Add(obj);
        }

        public void Update(AddOrUpdateOpenJobReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            UnitWork.Update<OpenJob>(u => u.Id == obj.Id, u => new OpenJob
            {
                JobName = obj.JobName,
                JobType = obj.JobType,
                JobCall = obj.JobCall,
                JobCallParams = obj.JobCallParams,
                Cron = obj.Cron,
                Status = obj.Status,
                Remark = obj.Remark,
                UpdateTime = DateTime.Now,
                UpdateUserId = user.Id,
                UpdateUserName = user.Name
                //todo:补充或调整自己需要的字段
            });
        }

        #region 定时任务运行相关操作
        
        /// <summary>
        /// 返回系统的job接口
        /// </summary>
        /// <returns></returns>
        public List<string> QueryLocalHandlers()
        {
            var types = AppDomain.CurrentDomain.GetAssemblies()
                .SelectMany(a => a.GetTypes().Where(t => t.GetInterfaces()
                    .Contains(typeof(IJob))))
                .ToArray();
            return types.Select(u => u.FullName).ToList();
        }
        
        public void ChangeJobStatus(ChangeJobStatusReq req)
        {
            var job = Repository.FindSingle(u => u.Id == req.Id);
            if (job == null)
            {
                throw new Exception("任务不存在");
            }
            
            

            if (req.Status == 0) //停止
            {
                TriggerKey triggerKey = new TriggerKey(job.Id);
                // 停止触发器
                _scheduler.PauseTrigger(triggerKey);
                // 移除触发器
                _scheduler.UnscheduleJob(triggerKey);
                // 删除任务
                _scheduler.DeleteJob(new JobKey(job.Id));
            }
            else  //启动
            {
                var jobBuilderType = typeof(JobBuilder);
                var method = jobBuilderType.GetMethods().FirstOrDefault(
                        x => x.Name.Equals("Create", StringComparison.OrdinalIgnoreCase) &&
                             x.IsGenericMethod && x.GetParameters().Length == 0)
                    ?.MakeGenericMethod(Type.GetType(job.JobCall));

                var jobBuilder = (JobBuilder)method.Invoke(null, null);
                
                IJobDetail jobDetail = jobBuilder.WithIdentity(job.Id).Build();
                jobDetail.JobDataMap[Define.JOBMAPKEY] = job.Id;  //传递job信息
                ITrigger trigger = TriggerBuilder.Create()
                    .WithCronSchedule(job.Cron)
                    .WithIdentity(job.Id)
                    .StartNow()
                    .Build();
                _scheduler.ScheduleJob(jobDetail, trigger);
            }
            
            
            var user = _auth.GetCurrentUser().User;

            job.Status = req.Status;
            job.UpdateTime = DateTime.Now;
            job.UpdateUserId = user.Id;
            job.UpdateUserName = user.Name;
            Repository.Update(job);
        }
        
        /// <summary>
        /// 记录任务运行结果
        /// </summary>
        /// <param name="jobId"></param>
        public void RecordRun(string jobId)
        {
            var job = Repository.FindSingle(u =>u.Id == jobId);
            if (job == null)
            {
                _sysLogApp.Add(new SysLog
                {
                    TypeName = "定时任务",
                    TypeId = "AUTOJOB",
                    Content = $"未能找到定时任务：{jobId}"
                });
                return;
            }

            job.RunCount++;
            job.LastRunTime = DateTime.Now;
            Repository.Update(job);
            
            _sysLogApp.Add(new SysLog
            {
                CreateName = "Quartz",
                CreateId = "Quartz",
                TypeName = "定时任务",
                TypeId = "AUTOJOB",
                Content = $"运行了自动任务：{job.JobName}"
            });
            _logger.LogInformation($"运行了自动任务：{job.JobName}");
        }

        #endregion


        public OpenJobApp(IUnitWork unitWork, IRepository<OpenJob> repository,
            IAuth auth, SysLogApp sysLogApp, IScheduler scheduler, ILogger<OpenJobApp> logger) : base(unitWork, repository, auth)
        {
            _sysLogApp = sysLogApp;
            _scheduler = scheduler;
            _logger = logger;
        }
        
    }
}