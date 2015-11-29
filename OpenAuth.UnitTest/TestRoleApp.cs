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
    public class TestRoleApp
    {

        private RoleManagerApp _app = new RoleManagerApp(new RoleRepository(), 
            new OrgRepository(),
            new UserRoleRepository());
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
            var role = new Role
            {
                Name = "即将删除" + _time,
                CreateTime = DateTime.Now,
                OrgId = 1
            };
            _app.AddOrUpdate(role);
            Console.WriteLine("new role:" + role.Id);
            _app.Delete(role.Id);
            
        }



        [TestMethod]
        public void TestLoad()
        {
            var users = _app.Load(1,1, 10);
            
        }

        [TestMethod]
        public void TestEdit()
        {
            var role = Add();
            role.Name = "修改后的名称" + _time;
            _app.AddOrUpdate(role);
            Console.WriteLine(role.Name);
        }


        private Role Add()
        {
            var role = new Role
            {
                Name = "test_" + _time,
                CreateTime = DateTime.Now,
                OrgId = 1
            };
            _app.AddOrUpdate(role);
            return role;
        }
    }
}
