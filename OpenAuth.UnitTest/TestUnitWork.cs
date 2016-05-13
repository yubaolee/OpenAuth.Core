using System;
using System.Diagnostics;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    /// <summary>
    /// TestUnitWork 的摘要说明
    /// </summary>
    [TestClass]
    public class TestUnitWork
    {
        IUnitWork _unit = new UnitWork();
        /// <summary>
        /// 测试UnitWork用于联表查询
        /// </summary>
        [TestMethod]
        public void GetDynamic()
        {
            var usersInOrg = from user in _unit.Find<User>(null)
                join relevance in _unit.Find<Relevance>(u => u.Key == "UserOrg") on user.Id equals relevance.FirstId
                join org in _unit.Find<Org>(null) on relevance.SecondId equals org.Id
                select new
                {
                    user.Name,
                    OrgName = org.Name
                };

            foreach (var user in usersInOrg)
            {
                Debug.WriteLine("{0} :{1}", user.Name, user.OrgName);
            }
        }
    }
}
