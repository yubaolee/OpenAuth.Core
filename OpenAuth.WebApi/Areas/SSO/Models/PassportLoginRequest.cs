using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace OpenAuth.WebApi.Areas.SSO.Models
{

    public class PassportLoginRequest
    {
        [DisplayName("邮箱地址")]
        public string UserName { get; set; }

        [Required]
        [DisplayName("登录密码")]
        public string Password { get; set; }

        [Display(Name = "应用标识")]
        public string AppKey { get; set; }

        public void Trim()
        {
            UserName = UserName.Trim();
            Password = Password.Trim();
            AppKey = AppKey.Trim();
        }
    }
}