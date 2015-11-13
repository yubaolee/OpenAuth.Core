

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class UserRole
	{

		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }


		/// <summary>
		/// 角色流水号
		/// </summary>
		/// <returns></returns>
		public int RoleId { get; set; }


		/// <summary>
		/// 用户流水号
		/// </summary>
		/// <returns></returns>
		public int UserId { get; set; }


		/// <summary>
		/// 授权时间
		/// </summary>
		/// <returns></returns>
		public System.DateTime OperateTime { get; set; }


		/// <summary>
		/// 授权人流水号
		/// </summary>
		/// <returns></returns>
		public int OperatorId { get; set; }



		public UserRole()
		{
		 
	this.Id= 0;
		  
	this.RoleId= 0;
		  
	this.UserId= 0;
		  
	this.OperateTime= DateTime.Now;
		  
	this.OperatorId= 0;
		  
}
		
	

	}
} 