using System;
using Infrastructure;
using NUnit.Framework;
using OpenAuth.App.SSO;
using OpenAuth.WebApi.Areas.SSO.Controllers;

namespace OpenAuth.WebApi.Test
{
    public class CheckControllerTest
    {
        private CheckController _checkController;

        public CheckControllerTest(CheckController checkController)
        {
            _checkController = checkController;
        }

        [Test]
        public void Login()
        {
           var result = _checkController.Login(new PassportLoginRequest
            {
                Account = "System",
                AppKey = "openauth",
                Password = "123456"
            });

            Console.WriteLine(JsonHelper.Instance.Serialize(result));
        }
    }
}
