using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.Domain;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    /// <summary>
    /// TestModuleApp 的摘要说明
    /// </summary>
    [TestClass]
    public class TestModuleApp
    {
        

        private TestContext testContextInstance;
        private ModuleManagerApp _app = new ModuleManagerApp(new ModuleRepository(), new RelevanceRepository());
        private string _time = DateTime.Now.ToString("HH_mm_ss_ms");
      

        //初始化导航
        [TestMethod]
        public void InitNav()
        {
            var root = new Module()
            {
                Name = "基础设置",
                ParentId = 0
            };
            _app.AddOrUpdate(root);

            var module = new Module
            {
                Name = "模块管理",
                Url = "ModuleManager/Index",
                ParentId = root.Id
            };
            _app.AddOrUpdate(module);
            module = new Module
            {
                Name = "用户管理",
                Url = "UserManager/Index",
                ParentId = root.Id
            };
            _app.AddOrUpdate(module);
            module = new Module
            {
                Name = "角色管理",
                Url = "RoleManager/Index",
                ParentId = root.Id
            };
            _app.AddOrUpdate(module);
            module = new Module
            {
                Name = "机构管理",
                Url = "OrgManager/Index",
                ParentId = root.Id
            };
            _app.AddOrUpdate(module);
        }

        [TestMethod]
        public void TestAddModule()
        {
            var root = Add();
            for (int i = 0; i < 30; i++)
            {
                Add(root.Id);
            }
        }

        [TestMethod]
        public void TestDelModule()
        {
            var root = Add(0);
            _app.Delete(root.Id);
        }



        [TestMethod]
        public void TestEdit()
        {
            //var module = _app.Find(7);
            //_app.AddOrUpdate(module);

            var module1 = new Module
            {
                Id = 14,
                Name = DateTime.Now.ToString()
            };
            _app.AddOrUpdate(module1);
        }

        [TestMethod]
        public void TestLoad()
        {
            var modules = _app.LoadByParent(0);
            foreach (var module in modules)
            {
                
                Console.WriteLine(module.Name);
            }
        }

        public Module Add(int parent = 0)
        {
            var module = new Module()
            {
                Name = "test_" + _time,
                ParentId = parent,
                IconName = null,
                HotKey = null
            };
            _app.AddOrUpdate(module);
            return module;
        }
    }
}
