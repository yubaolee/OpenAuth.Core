using System;
using System.Diagnostics;
using Infrastructure;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.Repository.Domain;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class TestOrg : TestBase
    {
        private OrgManagerApp _app;

        public TestOrg()
        {
            _app = AutofacExt.GetFromFac<OrgManagerApp>();
        }

        [TestMethod]
        public void LoadChildren()
        {
            var data= _app.LoadAllChildren("fb086c51-4b41-4aa7-b54f-fb79632aaaf9");
            Debug.WriteLine(JsonHelper.Instance.Serialize(data));
        }


        [TestMethod]
        public void Add()
        {
            try
            {
                for (int i = 0; i < 2; i++)
                {
                    var random = new Random();
                    int val = random.Next();
                    _app.Add(new Org
                    {
                        Id = string.Empty,
                        Name = "test" + val,
                        CreateTime = DateTime.Now,
                        ParentId = null,
                        ParentName = "",
                        SortNo = 1
                    });
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
}
