using System;

namespace Infrastructure.MVC
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = false, Inherited = false)]
    public class NoFilterAttribute : Attribute
    {
        public NoFilterAttribute() { }
    }
}
