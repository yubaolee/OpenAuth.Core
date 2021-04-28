using System;
using System.Linq;
using Infrastructure;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.Repository.Test
{
    /// <summary>
    /// 测试UnitWork
    /// </summary>
    class TestUnitWork : TestBase
    {
        /// <summary>
        /// 测试存储过程
        /// </summary>
        [Test]
        public void ExecProcedure()
        {
            var unitWork = _autofacServiceProvider.GetService<IUnitWork<OpenAuthDBContext>>();
            var users = unitWork.ExecProcedure<User>("sp_alluser");
            Console.WriteLine(JsonHelper.Instance.Serialize(users));
        }
        
    }
}