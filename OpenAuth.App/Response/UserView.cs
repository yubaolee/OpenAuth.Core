using System;
using Infrastructure;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Response
{
    public  class UserView
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
        /// 组织类型
        /// </summary>
        /// <returns></returns>
        public int Type { get; set; }



        /// <summary>
        /// 创建时间
        /// </summary>
        /// <returns></returns>
        public DateTime CreateTime { get; set; }


        /// <summary>
        /// 创建人名字
        /// </summary>
        /// <value>The create user.</value>
        public string CreateUser { get; set; }

        /// <summary>
        /// 所属组织名称，多个可用，分隔
        /// </summary>
        /// <value>The organizations.</value>
        public string Organizations { get; set; }

        public string OrganizationIds { get; set; }

        public static implicit operator UserView(User user)
        {
            return user.MapTo<UserView>();
        }

        public static implicit operator User(UserView view)
        {
            return view.MapTo<User>();
        }

        public UserView()
        {
            Organizations = string.Empty;
            OrganizationIds = string.Empty;
            CreateUser = string.Empty;
        }
    }
}
