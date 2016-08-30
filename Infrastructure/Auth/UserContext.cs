namespace Infrastructure.Auth
{
    /// <summary>
    /// 当前登录用户相关
    /// </summary>
    public class UserContext
    {
        public static dynamic CurrentUser
        {
            get
            {
                IAuthenticationService authenticationService = DIContainer.ResolvePerHttpRequest<IAuthenticationService>();
                var currentUser = authenticationService.GetAuthenticatedUser();
                if (currentUser != null)
                    return currentUser;
                return null;
            }
        }
    }
}
