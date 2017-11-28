using System;
using System.Diagnostics;
using System.Linq;
using Infrastructure;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.Domain.Service;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    /// <summary>
    /// 测试用户授权服务
    /// </summary>
    [TestClass]
    public class TestAuthen
    {
        [TestMethod]
        public void TestMethod1()
        {
            AuthoriseFactory factory = new AuthoriseFactory( );
            var service=  factory.Create("System");

            var modules = service.Modules;
           
            var moduleTree = modules.GenerateTree(u => u.Id, u => u.ParentId).ToList();
            Debug.WriteLine(JsonHelper.Instance.Serialize(moduleTree));
        }
    }
}
