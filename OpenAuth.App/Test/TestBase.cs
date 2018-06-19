using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using NUnit.Framework;

namespace OpenAuth.App.Test
{
    public class TestBase
    {
        protected AutofacServiceProvider _autofacServiceProvider;

        [SetUp]
        public void Init()
        {
            var serviceCollection = GetService();
            serviceCollection.AddMemoryCache();
            serviceCollection.AddOptions();
            
            var httpContextMock = new Mock<HttpContext>();
            //httpContextAccessorMock.Setup(x => x.HttpContext.User.Identity.Name).Returns("Siddhartha");
          //  httpContextMock.Setup(x => x.Authentication).Returns(authenticationManagerMock.Object);
            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext).Returns(httpContextMock.Object);
            var httpContextMockObject = httpContextAccessorMock.Object;
            serviceCollection.AddScoped(x => httpContextAccessorMock);
            serviceCollection.AddScoped(x => httpContextMockObject);

            var container = AutofacExt.InitAutofac(serviceCollection);
            _autofacServiceProvider = new AutofacServiceProvider(container);
        }

        public virtual ServiceCollection GetService()
        {
            return  new ServiceCollection();
        }
    }
}
