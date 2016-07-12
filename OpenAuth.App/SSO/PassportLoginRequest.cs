namespace OpenAuth.App.SSO
{

    public class PassportLoginRequest
    {
        public string UserName { get; set; }

        public string Password { get; set; }

        public string AppKey { get; set; }

        public void Trim()
        {
            UserName = UserName.Trim();
            Password = Password.Trim();
            if(!string.IsNullOrEmpty(AppKey)) AppKey = AppKey.Trim();
        }
    }
}