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
        public string Account { get; set; }
        
        /// <summary>
        /// </summary>
        /// <returns></returns>
        public string Password { get; set; }


        /// <summary>
        /// 组织名称
        /// </summary>
        /// <returns></returns>
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
        /// 所属组织Id，多个可用，分隔
        /// </summary>
        /// <value>The organizations.</value>
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
