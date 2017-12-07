using OpenAuth.App;

namespace OpenAuth.UnitTest
{
    public class TestBase
    {
        public TestBase() 
        {
            AutofacExt.InitAutofac();
        }
    }
}