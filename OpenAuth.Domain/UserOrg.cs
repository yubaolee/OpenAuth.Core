

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class UserOrg
	{

		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }


		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public int OrgId { get; set; }


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



		public UserOrg()
		{
		 
	this.Id= 0;
		  
	this.OrgId= 0;
		  
	this.UserId= 0;
		  
	this.OperateTime= DateTime.Now;
		  
	this.OperatorId= 0;
		  
}
		
	

	}
} 