

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class PageElementGrant
	{

		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }


		/// <summary>
		/// 页面元素流水号
		/// </summary>
		/// <returns></returns>
		public int ElementId { get; set; }


		/// <summary>
		/// 用户流水号
		/// </summary>
		/// <returns></returns>
		public int UserId { get; set; }


		/// <summary>
		/// 角色流水号
		/// </summary>
		/// <returns></returns>
		public int RoleId { get; set; }


		/// <summary>
		/// 岗位流水号
		/// </summary>
		/// <returns></returns>
		public int PostId { get; set; }


		/// <summary>
		/// 权限类型
		/// </summary>
		/// <returns></returns>
		public int GrantType { get; set; }



		public PageElementGrant()
		{
		 
	this.Id= 0;
		  
	this.ElementId= 0;
		  
	this.UserId= 0;
		  
	this.RoleId= 0;
		  
	this.PostId= 0;
		  
	this.GrantType= 0;
		  
}
		
	

	}
} 