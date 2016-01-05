using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    /// <summary>
    /// TestOrgApp 的摘要说明
    /// </summary>
    [TestClass]
    public class TestUserApp
    {

        private UserManagerApp _app = new UserManagerApp(new UserRepository(), 
            new OrgRepository(), new RelevanceRepository());
        private string _time = DateTime.Now.ToString("HH_mm_ss_ms");


        [TestMethod]
        public void TestAdd()
        {
            for (int i = 0; i < 30; i++)
            {
                Add();
            }
           

        }

        [TestMethod]
        public void TestDel()
        {
            var user = new UserView
            {
                Account = "user" + _time,
                Name = "即将被删除的账号" + _time,
                OrganizationIds = "3,2"

            };
            _app.AddOrUpdate(user);
            Console.WriteLine("new user:" + user.Id);
            _app.Delete(user.Id);
            
        }



        [TestMethod]
        public void TestLoad()
        {
            var users = _app.Load(1,1, 10);
            
        }

        [TestMethod]
        public void TestEdit()
        {
            var user = Add();
            user.Name = "修改后的名称" + _time;
            _app.AddOrUpdate(user);
            Console.WriteLine(user.Name);
        }

        [TestMethod]
        public void TestFind()
        {
            var user = _app.Find(21);
            Console.WriteLine(user.Name);
        }


        private UserView Add()
        {
            var user = new UserView
            {
                Account = "user" + _time,
                Name = "新用户" + _time,
                OrganizationIds = "3,2"

            };
            _app.AddOrUpdate(user);
            Console.WriteLine(user.Name + " \t用户ID：" + user.Id);
            return user;
        }
    }
}
