using System.Diagnostics;
using System.Linq;
using Infrastructure;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;

namespace OpenAuth.UnitTest
{
    /// <summary>
    /// 测试用户授权服务
    /// </summary>
    [TestClass]
    public class TestAuthen :TestBase
    {
        private AuthorizeApp app;

        public TestAuthen()
        {
            app = AutofacExt.GetFromFac<AuthorizeApp>();
        }

        [TestMethod]
        public void TestMethod1()
        {
            var service=  app.Create("System");

            var modules = service.Modules;
           
            var moduleTree = modules.GenerateTree(u => u.Id, u => u.ParentId).ToList();
            Debug.WriteLine(JsonHelper.Instance.Serialize(moduleTree));
        }
    }
}
