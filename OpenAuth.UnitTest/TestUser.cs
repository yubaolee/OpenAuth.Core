using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.App.ViewModel;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class TestUser : TestBase
    {
        private UserManagerApp _app;

        public TestUser()
        {
            _app = AutofacExt.GetFromFac<UserManagerApp>();
        }


        [TestMethod]
        public void AddUser()
        {
            try
            {
                for (int i = 0; i < 2; i++)
                {
                    var random = new Random();
                    int val = random.Next();
                    _app.AddOrUpdate(new UserView
                    {

                        Account = "test" + val,
                        Name = "test" + val,
                        CreateTime = DateTime.Now,
                        OrganizationIds = "990cb229-cc18-41f3-8e2b-13f0f0110798,08f41bf6-4388-4b1e-bd3e-2ff538b44b1b",
                        Organizations = "研发部,研发1组",
                    });
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        [TestMethod]
        public void GetUser()
        {
            var users = _app.Load(new Guid("990cb229-cc18-41f3-8e2b-13f0f0110798"), 2, 30);

            Console.WriteLine(users.total);
        }
    }
}
