using System.Reflection;
using System.Web.Mvc;
using Autofac;
using Autofac.Configuration;
using Autofac.Integration.Mvc;
using OpenAuth.App;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Service;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    public class AutofacExt
    {
        private static IContainer _container;

        public static void InitDI()
        {
            var builder = new ContainerBuilder();

            //注册数据库基础操作和工作单元
            builder.RegisterGeneric(typeof(BaseRepository<>)).As(typeof(IRepository<>)).PropertiesAutowired();
            builder.RegisterType(typeof(UnitWork)).As(typeof(IUnitWork)).PropertiesAutowired();

            //注册app层
            builder.RegisterAssemblyTypes(Assembly.GetAssembly(typeof(UserManagerApp))).PropertiesAutowired();

            _container = builder.Build();
            DependencyResolver.SetResolver(new AutofacDependencyResolver(_container));
        }

        public static T GetFromFac<T>()
        {
            return _container.Resolve<T>();
        }
    }
}