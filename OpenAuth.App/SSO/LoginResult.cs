using Infrastructure;

namespace OpenAuth.App.SSO
{
    public class LoginResult :Response<string>
    {
        public string ReturnUrl;
        public string Token;
    }
}