using System.ComponentModel.DataAnnotations;
using Infrastructure;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Request
{
    /// <summary>
    /// 添加或修改用户信息的请求
    /// </summary>
    public  class UpdateUserReq
    {
        /// <summary>
        /// 用户ID
        /// </summary>
        /// <returns></returns>
        public string Id { get; set; }


        /// <summary>
        /// </summary>
        /// <returns></returns>
        [Required(ErrorMessage = "账号肯定不能为空啊~~")]
        public string Account { get; set; }
        
        /// <summary>
        /// </summary>
        /// <returns></returns>
        public string Password { get; set; }


        /// <summary>
        /// 用户姓名
        /// </summary>
        /// <returns></returns>
        [Required(ErrorMessage="姓名不能为空")]
        public string Name { get; set; }


        /// <summary>
        /// </summary>
        /// <returns></returns>
        public int Sex { get; set; }


        /// <summary>
        /// 当前状态
        /// </summary>
        /// <returns></returns>
        public int Status { get; set; }
        
        /// <summary>
        /// 直接上级
        /// </summary>
        public string ParentId { get; set; }


        /// <summary>
        /// 所属组织Id，多个可用，分隔
        /// </summary>
        /// <value>The organizations.</value>
        [Required(ErrorMessage = "请为用户分配机构")]
        public string OrganizationIds { get; set; }

        public static implicit operator UpdateUserReq(User user)
        {
            return user.MapTo<UpdateUserReq>();
        }

        public static implicit operator User(UpdateUserReq view)
        {
            return view.MapTo<User>();
        }

        public UpdateUserReq()
        {
            OrganizationIds = string.Empty;
        }
    }
}
