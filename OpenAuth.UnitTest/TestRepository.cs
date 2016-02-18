using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.Domain;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    /// <summary>
    /// TestRepository 的摘要说明
    /// </summary>
    [TestClass]
    public class TestRepository
    {
       
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

        //测试被EF跟踪的对象修改
        [TestMethod]
        public void TestTrackingEdit()
        {
           
            var moduleRep = new ModuleRepository();
            //var module = moduleRep.FindSingle(u => u.Id == 14);
            //module.CascadeId = DateTime.Now.ToShortTimeString();
            //如果不加u.Id !=7 则会造成异常，可理解为数据库的默认隔离级别为“读已提交”，不允许脏读！
            //var obstruct = moduleRep.Find(u =>u.Id != 7); 
            //foreach (var module1 in obstruct)
            //{
            //    module.CascadeId += module1.CascadeId;
            //}
            //moduleRep.Update(module);
            

            moduleRep.Update(u =>u.Id, new Module
            {
                Id = 15,
                Name = "test",
                CascadeId = DateTime.Now.ToShortTimeString(),
                Url = "ssss"
            });
        }
    }
}
