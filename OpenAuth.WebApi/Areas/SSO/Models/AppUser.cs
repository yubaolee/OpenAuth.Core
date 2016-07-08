using System;
using System.ComponentModel.DataAnnotations;

namespace OpenAuth.WebApi.Areas.SSO.Models
{
    public class AppUser
    {
        /// <summary>
        /// 登录账号
        /// </summary>
        [Key]
        [MaxLength(50)]
        public string UserName { get; set; }

        /// <summary>
        /// 登录密码
        /// </summary>
        [Required]
        [MaxLength(32)]
        public string UserPwd { get; set; }

        /// <summary>
        /// 昵称
        /// </summary>
        [Required]
        [MaxLength(50)]
        public string Nick { get; set; }

        /// <summary>
        /// 是否启用
        /// </summary>
        [Required]
        public bool IsEnable { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        [Required]
        public DateTime CreateTime { get; set; }
    }
}