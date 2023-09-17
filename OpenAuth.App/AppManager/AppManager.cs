using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;
using SqlSugar;

namespace OpenAuth.App
{
    /// <summary>
    /// 应用管理
    /// </summary>
    public class AppManager : SqlSugarBaseApp<Application>
    {
        public AppManager(ISqlSugarClient client) : base(client, null)
        {
        }
        public void Add(Application application)
        {
            if (string.IsNullOrEmpty(application.Id))
            {
                application.Id = Guid.NewGuid().ToString();
            }

            Repository.Insert(application);
        }

        public void Update(Application application)
        {
            Repository.Update(application);
        }
        
        public async Task<List<Application>> GetList(QueryAppListReq request)
        {
            var applications = Repository.GetListAsync();

            return await applications;
        }


        public Application GetByAppKey(string modelAppKey)
        {
            return Repository.GetFirst(u => u.AppSecret == modelAppKey);
        }
        
    }
}