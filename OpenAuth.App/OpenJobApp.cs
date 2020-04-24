﻿using System;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class OpenJobApp : BaseApp<OpenJob>
    {
        private RevelanceManagerApp _revelanceApp;

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
                RunCount = obj.RunCount,
                ErrorCount = obj.ErrorCount,
                NextRunTime = obj.NextRunTime,
                LastRunTime = obj.LastRunTime,
                LastErrorTime = obj.LastErrorTime,
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
            

        public OpenJobApp(IUnitWork unitWork, IRepository<OpenJob> repository,
            RevelanceManagerApp app, IAuth auth) : base(unitWork, repository,auth)
        {
            _revelanceApp = app;
        }
    }
}