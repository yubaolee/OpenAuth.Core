using System;
using System.Data;
using System.Linq;
using Infrastructure;
using Microsoft.Data.SqlClient;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using MySqlConnector;
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
            var users = unitWork.ExecProcedure<SysUser>("sp_alluser");
            Console.WriteLine(JsonHelper.Instance.Serialize(users));
        }
        
        
        /// <summary>
        /// 测试Mysql执行存储过程
        /// </summary>
        [Test]
        public void ExecProcedureWithParam()
        {
            var unitWork = _autofacServiceProvider.GetService<IUnitWork<OpenAuthDBContext>>();
            var param = new MySqlParameter("keyword", SqlDbType.NVarChar);
            param.Value = "test%";
            var users = unitWork.ExecProcedure<SysUser>("sp_alluser", new []{param});
            Console.WriteLine(JsonHelper.Instance.Serialize(users));
        }
        
    }
}