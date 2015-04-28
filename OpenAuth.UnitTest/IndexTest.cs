using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.Domain.Model;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class IndexTest
    {
        [TestMethod]
        public void MenuTest()
        {
            string userid = "";
            IndexApp app = new IndexApp();
            MenuResponse response = app.LoadMenu(userid);
        }
    }
}
