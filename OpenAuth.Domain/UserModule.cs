

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class UserModule
	{

		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }


		/// <summary>
		/// 用户流水号
		/// </summary>
		/// <returns></returns>
		public int UserId { get; set; }


		/// <summary>
		/// 所属功能模块流水号
		/// </summary>
		/// <returns></returns>
		public int ModuleId { get; set; }


		/// <summary>
		/// 组织类型
		/// </summary>
		/// <returns></returns>
		public int Type { get; set; }


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



		public UserModule()
		{
		 
	this.Id= 0;
		  
	this.UserId= 0;
		  
	this.ModuleId= 0;
		  
	this.Type= 0;
		  
	this.OperateTime= DateTime.Now;
		  
	this.OperatorId= 0;
		  
}
		
	

	}
} 