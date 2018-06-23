using System;
using System.Collections.Generic;
using System.Text;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using OpenAuth.App.Request;

namespace OpenAuth.App.Test
{
    public class TestFlow :TestBase
    {
        [Test]
        public void Verificate()
        {
            var app = _autofacServiceProvider.GetService<FlowInstanceApp>();
            app.Verification(new VerificationReq
            {
                FlowInstanceId = "7335d82f-5c3d-43e5-a53b-7d51a7cb1f59",
                VerificationFinally = "3"
            });
        }
    }
}
