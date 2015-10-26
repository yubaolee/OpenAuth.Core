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
    /// TestOrgApp 的摘要说明
    /// </summary>
    [TestClass]
    public class TestOrgApp
    {
        public TestOrgApp()
        {
            //
            //TODO:  在此处添加构造函数逻辑
            //
        }

        private TestContext testContextInstance;
        private OrgManagerApp _app = new OrgManagerApp(new OrgRepository());

        /// <summary>
        ///获取或设置测试上下文，该上下文提供
        ///有关当前测试运行及其功能的信息。
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region 附加测试特性
        //
        // 编写测试时，可以使用以下附加特性: 
        //
        // 在运行类中的第一个测试之前使用 ClassInitialize 运行代码
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // 在类中的所有测试都已运行之后使用 ClassCleanup 运行代码
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // 在运行每个测试之前，使用 TestInitialize 来运行代码
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // 在每个测试运行完之后，使用 TestCleanup 来运行代码
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        [TestMethod]
        public void TestAddOrg()
        {
            int id = _app.AddOrg(new Org
            {
                Name = "集团总部",
                ParentId = 0
            });
            Assert.IsTrue(id != 0);
            id = _app.AddOrg(new Org
            {
                Name = "一分公司",
                ParentId = id
            });

            Assert.IsTrue(id != 0);
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
    }
}
