using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.App;
using OpenAuth.App.DTO;
using OpenAuth.Domain.Service;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class LoginTest
    {

        [TestMethod]
        public void Login()
        {
            var loginReq = new LoginRequest { UserName = "admin", Password = "123456" };
            var loginApp = new LoginApp(new LoginService(new UserRepository()));
            var response = loginApp.Login(loginReq);
            Assert.IsTrue(response.Success);
            Assert.AreEqual(response.UserName, loginReq.UserName);

            var errPassword = new LoginRequest { UserName = "admin", Password = "111111" };
            response = loginApp.Login(errPassword);
            Assert.IsFalse(response.Success);
            Assert.AreEqual(response.Message, "密码错误");
        }
    }
}
