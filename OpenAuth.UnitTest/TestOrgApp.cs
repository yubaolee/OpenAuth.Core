using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.Domain;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    /// <summary>
    /// TestOrgApp 的摘要说明
    /// </summary>
    [TestClass]
    public class TestOrgApp
    {

        private TestContext testContextInstance;
        private OrgManagerApp _app = new OrgManagerApp(new OrgRepository());

        

        [TestMethod]
        public void TestAddOrg()
        {
            int rootId = _app.AddOrUpdate(new Org
            {
                Name = "集团总部",
                ParentId = 0
            });
            Assert.IsTrue(rootId != 0);
           int  id = _app.AddOrUpdate(new Org
            {
                Name = "一分公司",
                ParentId = rootId
            });
            id = _app.AddOrUpdate(new Org
            {
                Name = "二分公司",
                ParentId = rootId
            });
            id = _app.AddOrUpdate(new Org
            {
                Name = "三分公司",
                ParentId = rootId
            });

            Assert.IsTrue(id != 0);
        }

        [TestMethod]
        public void TestDelOrg()
        {
            int rootId = _app.AddOrUpdate(new Org
            {
                Name = "即将被删除",
                ParentId = 0
            });
            Assert.IsTrue(rootId != 0);

            int id = _app.AddOrUpdate(new Org
            {
                Name = "即将被删除1",
                ParentId = rootId
            });
            id = _app.AddOrUpdate(new Org
            {
                Name = "即将被删除2",
                ParentId = id
            });

            _app.DelOrg(rootId);
        }



        [TestMethod]
        public void TestLoadOrg()
        {
            var orgs = _app.GetAll();
            foreach (var org in orgs)
            {
                Console.WriteLine(org.Name);
            }
        }

        [TestMethod]
        public void TestEdit()
        {
            //var org = _app.GetAll().FirstOrDefault();
            //org.Name = DateTime.Now.ToShortTimeString();
            //_app.AddOrUpdate(org);

            var org1 = new Org
            {
                Id = 1,
                Name = DateTime.Now.ToShortTimeString()
            };
            _app.AddOrUpdate(org1);
        }
    }
}
