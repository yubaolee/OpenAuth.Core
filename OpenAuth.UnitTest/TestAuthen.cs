using System;
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
            AuthoriseService _service = new AuthoriseService(new UnitWork() );
            _service.LoadAuthControls("test");

            var orgs = _service.Orgs;
        }
    }
}
