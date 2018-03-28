using System;
using Infrastructure;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.Repository.Domain;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class TestForm : TestBase
    {
        private FormApp _app;

        public TestForm()
        {
            _app = AutofacExt.GetFromFac<FormApp>();
        }


        [TestMethod]
        public void Update()
        {
            try
            {
                var form = _app.FindSingle("048b8074-1a68-4dc4-af15-dbc0914f5745");
                var newform = form.MapTo<Form>();
                _app.Update(newform);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
 
    }
}
